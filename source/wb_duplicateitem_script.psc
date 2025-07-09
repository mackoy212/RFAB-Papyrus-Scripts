Scriptname WB_DuplicateItem_Script extends activemagiceffect  

; -----

Explosion Property WB_AlterationAlt_Explosion_DuplicateItem Auto

; -----


; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	ObjectReference TheItem = Game.GetPlayerGrabbedRef()
	Debug.Notification("Gold = " + TheItem.GetGoldValue())
	TheItem.SendStealAlarm(akCaster)
	TheItem.PlaceAtMe(WB_AlterationAlt_Explosion_DuplicateItem)
	akCaster.AddItem(TheItem)
	akCaster.AddItem(TheItem.GetBaseObject())

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)


EndEvent

; -----

Event OnUpdate()


EndEvent

; -----