Scriptname WB_ShalidorsMirror_Script extends ActiveMagicEffect  

; -----

GlobalVariable Property WB_Alteration_TranasasReversal_Global_XP Auto
GlobalVariable Property WB_General_Global_XP Auto
Actor Property PlayerRef Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Float TargetMagickaPct = akTarget.GetActorValuePercentage("Magicka")
	Float TargetStaminaPct = akTarget.GetActorValuePercentage("Stamina")

	; preventing division by zero error if magicka is completely empty
	If TargetMagickaPct == 0.0
		akTarget.RestoreActorValue("Magicka",1.0)
		TargetMagickaPct = akTarget.GetActorValuePercentage("Magicka")
	EndIf

	; preventing division by zero error if stamina is completely empty
	If TargetStaminaPct == 0.0
		akTarget.RestoreActorValue("Stamina",1.0)
		TargetStaminaPct = akTarget.GetActorValuePercentage("Stamina")
	EndIf

	Float TargetMagickaTotal = akTarget.GetActorValue("Magicka") / TargetMagickaPct
	Float TargetStaminaTotal = akTarget.GetActorValue("Stamina") / TargetStaminaPct

	Float MagickaDelta
	Float StaminaDelta

	If TargetMagickaPct < TargetStaminaPct
		; more stamina than magicka
		MagickaDelta = TargetMagickaTotal * (TargetStaminaPct - TargetMagickaPct)
		StaminaDelta = TargetStaminaTotal * (TargetStaminaPct - TargetMagickaPct)
		akTarget.DamageActorValue("Stamina",StaminaDelta)
		akTarget.RestoreActorValue("Magicka",MagickaDelta)
	Else
		; more magicka than stamina
		MagickaDelta = TargetMagickaTotal * (TargetMagickaPct - TargetStaminaPct)
		StaminaDelta = TargetStaminaTotal * (TargetMagickaPct - TargetStaminaPct)
		akTarget.DamageActorValue("Magicka",MagickaDelta)
		akTarget.RestoreActorValue("Stamina",StaminaDelta)
	EndIf

	If akCaster == PlayerRef
		Game.AdvanceSkill("Alteration", (MagickaDelta + StaminaDelta) * WB_Alteration_TranasasReversal_Global_XP.GetValue() * WB_General_Global_XP.GetValue())
	EndIf

EndEvent

; -----