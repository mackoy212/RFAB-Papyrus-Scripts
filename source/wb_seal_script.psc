Scriptname WB_Seal_Script extends ActiveMagicEffect  

; -----

Spell Property WB_S_Sealed_Spell Auto
Float Property WB_UpdateRate Auto
Sound Property WB_Sound Auto
Float Property WB_Mult Auto
String Property WB_Stat Auto
ImagespaceModifier Property WB_Restoration_Imod_Seal Auto

; -----

Actor CasterActor
Actor TargetActor
Float HealthThreshold

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TargetActor = akTarget
	CasterActor = akCaster
	HealthThreshold = akTarget.GetActorValuePercentage(WB_Stat) * WB_Mult
	OnUpdate()

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akCaster.DispelSpell(WB_S_Sealed_Spell)

EndEvent

; -----

Event OnUpdate()

	If TargetActor.GetActorValuePercentage(WB_Stat) <= HealthThreshold
		WB_S_Sealed_Spell.Cast(CasterActor, TargetActor)
		WB_Sound.Play(TargetActor)
		WB_Restoration_Imod_Seal.Apply()
	Else
		RegisterForSingleUpdate(WB_UpdateRate)
	EndIf

EndEvent

; -----