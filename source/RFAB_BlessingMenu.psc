Scriptname RFAB_BlessingMenu extends Quest  

FormList Property BlessingShrines Auto

Spell Property UnholySpell Auto
Spell Property PlayerBlessing Auto Hidden

string IniPath = "Data/SKSE/Plugins/[RFAB] Blessings.ini"

Function ChangeBlessing(Spell akNewBlessing, Actor akTarget)
	RemoveAllBlessings(akTarget)
	akTarget.AddSpell(akNewBlessing, false)
	ShowNotification(akNewBlessing)
	if (akTarget == Game.GetPlayer())
		PlayerBlessing = akNewBlessing
	endif
EndFunction

Function RemoveAllBlessings(Actor akTarget)
	int i = 0
	while (i < BlessingShrines.GetSize())
		TempleBlessingScript kShrine = BlessingShrines.GetAt(i) as TempleBlessingScript
		akTarget.RemoveSpell(kShrine.TempleBlessing)
		i += 1
	endwhile
EndFunction

Function RemoveGoodBlessings(Actor akTarget)
	int i = 0
	while (i < BlessingShrines.GetSize())
		TempleBlessingScript kShrine = BlessingShrines.GetAt(i) as TempleBlessingScript
		if (kShrine.IsGoodGod)
			akTarget.RemoveSpell(kShrine.TempleBlessing)
		endif
		i += 1
	endwhile
EndFunction

bool Function IsUnholy(Actor akTarget)
	return PO3_SKSEFunctions.HasActiveSpell(akTarget, UnholySpell)
EndFunction

Function ShowNotification(Spell akBlessing)
	string sBlessingName = akBlessing.GetName()
	string sFirstWord = StringUtil.Split(sBlessingName, " ")[0]
	string sNotification = "Получено " + RFAB_PapyrusFunctions.ToLowerCase(sFirstWord) + StringUtil.Substring(sBlessingName, StringUtil.GetLength(sFirstWord))
	Debug.Notification(sNotification)
EndFunction

string Function GetDescription(string asGodName)
	return ReplaceEnters(GetText(asGodName, "Immersive Text") + "\n\n" + GetText(asGodName, "Bonus Text"))
EndFunction

string Function GetText(string asGodName, string asKey)
	return PapyrusIniManipulator.PullStringFromIni(IniPath, asGodName, asKey)
EndFunction

string Function ReplaceEnters(string asString)
	return PapyrusUtil.StringJoin(StringUtil.Split(asString, "|"), "\n") 
EndFunction