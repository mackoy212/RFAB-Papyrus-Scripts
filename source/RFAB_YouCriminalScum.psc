Scriptname RFAB_YouCriminalScum extends ActiveMagicEffect

RFAB_MCM_Alias Property Data Auto

RFAB_BlessingMenu Property BlessingMenu Auto

GlobalVariable Property PlayerIsRighteous Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if (Data.IsBlessingMessageOn)
		Debug.Messagebox("Ваша праведность утрачена. Аэдра отвернулись от вас...")
	endif
	BlessingMenu.RemoveGoodBlessings(akTarget)
	PlayerIsRighteous.SetValueInt(0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if (Data.IsBlessingMessageOn)
		Debug.Messagebox("Ваша праведность восстановлена. Аэдра вернулись к вам...")
	endif
	akTarget.AddSpell(BlessingMenu.PlayerBlessing)
	PlayerIsRighteous.SetValueInt(1)
EndEvent