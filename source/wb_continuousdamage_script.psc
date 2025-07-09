Scriptname WB_ContinuousDamage_Script extends activemagiceffect  

; -----

Float Property WB_UpdateRate Auto
Float Property WB_DamagePerSecond Auto
String Property WB_ResistType Auto

; -----

Float RealDamage
Actor TheTarget

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	RealDamage = (WB_DamagePerSecond * WB_UpdateRate) * ((100 - TheTarget.GetActorValue(WB_ResistType))/100)
	If RealDamage > 0
		OnUpdate()
		RegisterForUpdate(WB_UpdateRate)
	EndIf

EndEvent

; -----

Event OnUpdate()

	TheTarget.DamageActorValue("Health", RealDamage)

EndEvent

; -----