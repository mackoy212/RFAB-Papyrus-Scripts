scriptName TempleBlessingScript extends Form

RFAB_BlessingMenu Property BlessingMenu Auto
Spell property TempleBlessing Auto
bool Property IsGoodGod = true Auto

Spell property Cure auto
Spell property TempleDispel auto

Event OnActivate(ObjectReference akRef)
	Actor kUser = akRef as Actor
	if BlessingMenu.IsUnholy(kUser) && IsGoodGod
		Debug.Notification("Алтарь никак не реагирует на мои молитвы...")
		return
	endif

	string sName = ((self as Form) as ObjectReference).GetDisplayName()
	string sGodDescription = BlessingMenu.GetDescription(sName)
	if SkyMessage.Show(sGodDescription, "Помолиться у алтаря", "Ничего не делать", getIndex = true) == 0
		TempleDispel.Cast(kUser, kUser)
		Cure.Cast(kUser, kUser)
		Utility.Wait(0.25)
		BlessingMenu.ChangeBlessing(TempleBlessing, kUser)
	endif
EndEvent