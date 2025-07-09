Scriptname WB_Stendarr_Script extends activemagiceffect  

; -----

Float Property WB_HPMult Auto
Message Property WB_RestorationHeal_Message_StendarrsBrilliance Auto

; -----

Float HPDelta

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Float TargetHP = akTarget.GetActorValue("Health")
	akTarget.RestoreActorValue("Health", 9999)
	HPDelta = ((akTarget.GetActorValue("Health") - TargetHP) * WB_HPMult)
	If HPDelta > 0
		akTarget.ModActorValue("Health", HPDelta)
		WB_RestorationHeal_Message_StendarrsBrilliance.Show(HPDelta)
	Else
		Dispel()
	EndIf

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	If HPDelta > 0
		akTarget.ModActorValue("Health", -HPDelta)
	EndIf

EndEvent

; -----