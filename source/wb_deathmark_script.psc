Scriptname WB_DeathMark_Script extends ActiveMagicEffect  

; -----

ImagespaceModifier Property WB_ConjurationAtronach_Imod_AtronachMark Auto
Sound Property WB_ConjurationDaedric_Marker_AtronachMark Auto

; -----

Float RealDamage
Actor TheTarget

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	Utility.Wait(0.1)
	RealDamage = (akTarget.GetActorValue("Health") - 1.0)
	akTarget.DamageActorValue("Health", RealDamage)

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	If akTarget.IsDead()
		WB_ConjurationAtronach_Imod_AtronachMark.Apply()
		WB_ConjurationDaedric_Marker_AtronachMark.Play(TheTarget)
	Else
		akTarget.RestoreActorValue("Health",RealDamage)
	EndIf

EndEvent

; -----