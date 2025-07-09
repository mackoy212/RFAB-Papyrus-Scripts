Scriptname WB_Sacrifice_Script extends ActiveMagicEffect  

; -----

Float Property WB_Cap Auto
Float Property WB_Div Auto
Explosion Property WB_RestorationHeal_Explosion_SacrificeToDivinity Auto

; -----

ObjectReference TheItem
Float BonusAmount

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheItem = Game.GetPlayerGrabbedRef()
	If TheItem
		Float ItemValue = TheItem.GetGoldValue()
		TheItem.PlaceAtMe(WB_RestorationHeal_Explosion_SacrificeToDivinity)
		TheItem.Delete()
		BonusAmount = (1 - (1 / (1 + (ItemValue / WB_Div)))) * WB_Cap
		akTarget.ModActorValue("Health", BonusAmount)
		akTarget.ModActorValue("Magicka", BonusAmount)
		akTarget.ModActorValue("Stamina", BonusAmount)
	EndIf

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.ModActorValue("Health", -BonusAmount)
	akTarget.ModActorValue("Magicka", -BonusAmount)
	akTarget.ModActorValue("Stamina", -BonusAmount)

EndEvent

; -----