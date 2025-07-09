Scriptname RFAB_DoomStoneMenu extends Quest  

Spell[] Property DoomStones Auto

String[] Property DoomStoneNames Auto Hidden
{��� �������}
String[] Property StandingStoneNames Auto Hidden
{��� ������ � ����}

Actor Player

int _PlayerDoomStoneID
Int Property PlayerDoomStoneID
	int Function Get()
		return _PlayerDoomStoneID
	EndFunction
EndProperty 

string IniPath = "Data/SKSE/Plugins/[RFAB] DoomStones.ini"

Event OnInit()
	DoomStoneNames = new string[14]
    DoomStoneNames[0] = "����"
    DoomStoneNames[1] = "���"
    DoomStoneNames[2] = "���"
    DoomStoneNames[3] = "����"
    DoomStoneNames[4] = "����"
    DoomStoneNames[5] = "����"
    DoomStoneNames[6] = "����"
    DoomStoneNames[7] = "������"
    DoomStoneNames[8] = "�������"
    DoomStoneNames[9] = "������"
    DoomStoneNames[10] = "��������"
    DoomStoneNames[11] = "����"
    DoomStoneNames[12] = "�����"
    DoomStoneNames[13] = "������ ��� ����� ���������"

	StandingStoneNames = new string[13]
    StandingStoneNames[0] = "������ �����"
    StandingStoneNames[1] = "������ ����"
    StandingStoneNames[2] = "������ ����"
    StandingStoneNames[3] = "������ ����"
    StandingStoneNames[4] = "������ ����"
    StandingStoneNames[5] = "������ ����"
    StandingStoneNames[6] = "������ �����"
    StandingStoneNames[7] = "������ �������"
    StandingStoneNames[8] = "������ ��������"
    StandingStoneNames[9] = "������ �������"
    StandingStoneNames[10] = "������ ���������"
    StandingStoneNames[11] = "������ ����"
    StandingStoneNames[12] = "������ �����"

    Player = Game.GetPlayer()
EndEvent

int Function Open()
	int	Result = ShowMenu()
	if Result != -1
		SetDoomStoneById(Result)
	endIf
	return Result
EndFunction

int Function GetDoomStoneId()
    int i = 0
    while i < DoomStones.Length
    	if Player.HasSpell(DoomStones[i])
    		return i
    	endif
    	i += 1
    endwhile
    return 13
EndFunction

int Function GetDoomStoneIdByName(string asName)
    int i = 0
    while i < DoomStoneNames.Length
    	if asName == StandingStoneNames[i]
    		return i
    	endif
    	i += 1
    endwhile
    return -1
EndFunction

Function SetDoomStoneById(int aiIndex)
	Player.AddSpell(DoomStones[aiIndex])
	RemoveAllDoomStonesExcept(aiIndex)
	_PlayerDoomStoneID = aiIndex
EndFunction

Function RemoveAllDoomStonesExcept(int aiIndex)
    int i = 0
    while i < DoomStones.Length
    	if i != aiIndex
    		Player.RemoveSpell(DoomStones[i])
    	endif
    	i += 1
    endwhile
EndFunction

string[] Function GetTextsByKey(string asKey)
	string[] Result = Utility.CreateStringArray(DoomStoneNames.Length)
	int i = 0 
	while i < DoomStoneNames.Length
		Result[i] = PapyrusIniManipulator.PullStringFromIni(IniPath, DoomStoneNames[i], asKey)
		i += 1
	endwhile
	return ReplaceArraysEnters(Result)
EndFunction

string Function GetTextByKey(string asDoomStoneName, string asKey)
	string Result = PapyrusIniManipulator.PullStringFromIni(IniPath, asDoomStoneName, asKey)
	return ReplaceEnters(Result)
EndFunction

string[] Function ReplaceArraysEnters(string[] asArray)
	string[] Result = Utility.CreateStringArray(asArray.Length)
	int i = 0
	while i < asArray.Length
		Result[i] = ReplaceEnters(asArray[i])
		i += 1
	endwhile
	return Result
EndFunction

string Function ReplaceEnters(string asString)
	return PapyrusUtil.StringJoin(StringUtil.Split(asString, "|"), "\n") 
EndFunction

int Function ShowMenu()
	if UI.IsMenuOpen("CustomMenu")
		UI.CloseCustomMenu()
		return -1
	else
		UI.OpenCustomMenu("RFAB_DoomStoneMenu", 0)

		UI.Invoke("CustomMenu", "_root.RFAB_MessageBoxMC.InitMessageBox")
		UI.Invoke("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons")
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetImmersiveText", GetTextsByKey("Immersive"))
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetBonusText", GetTextsByKey("Bonus"))
		return GetMenuResultId()
	endIf
EndFunction

int Function GetMenuResultId()
	while UI.IsMenuOpen("CustomMenu") && UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") < 9
		Utility.Wait(0.2)
	endWhile
	if UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 9
		int result = UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
		UI.CloseCustomMenu()
		return result
	else
		UI.CloseCustomMenu()
		return -1
	endif
EndFunction