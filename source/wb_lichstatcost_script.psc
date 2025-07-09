Scriptname WB_LichStatCost_Script extends ActiveMagicEffect  

; -----

GlobalVariable Property WB_Conjuration_ConjureLich_Global_Cost Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Float RealDamage = WB_Conjuration_ConjureLich_Global_Cost.GetValue()
	Float ItemCharge

	ItemCharge = akCaster.GetActorValue("LeftItemCharge")
	If ItemCharge >= 1.0
		If ItemCharge < RealDamage
			akCaster.DamageActorValue("LeftItemCharge",ItemCharge)
		Else
			akCaster.DamageActorValue("LeftItemCharge",RealDamage)
		EndIf
	EndIf

	ItemCharge = akCaster.GetActorValue("RightItemCharge")
	If ItemCharge >= 1.0
		If ItemCharge < RealDamage
			akCaster.DamageActorValue("RightItemCharge",ItemCharge)
		Else
			akCaster.DamageActorValue("RightItemCharge",RealDamage)
		EndIf
	EndIf

EndEvent

; -----

