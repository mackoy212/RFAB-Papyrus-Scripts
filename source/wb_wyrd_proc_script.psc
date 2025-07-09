Scriptname WB_Wyrd_Proc_Script extends activemagiceffect  

; -----

Float Property WB_DamageFraction Auto
FormList Property WB_IllusionBlue_FormList_Wyrd Auto
Float Property WB_DamageMultCap Auto

; -----

Float RealDamage

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Utility.Wait(0.1)
	Float DamageMult = WB_DamageFraction * WB_IllusionBlue_FormList_Wyrd.GetSize()
	If DamageMult > WB_DamageMultCap
		DamageMult = WB_DamageMultCap
	EndIf
	RealDamage = akTarget.GetActorValue("Health") * DamageMult
	akTarget.DamageActorValue("Health",RealDamage)
	WB_IllusionBlue_FormList_Wyrd.Revert()

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.RestoreActorValue("Health",RealDamage)

EndEvent

; -----