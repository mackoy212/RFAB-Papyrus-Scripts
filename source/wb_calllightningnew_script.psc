Scriptname WB_CallLightningNew_Script extends ActiveMagicEffect  

; -----

Keyword Property MagicDamageShock Auto

Float Property WB_RandomDelayMin Auto
Float Property WB_RandomDelayMax Auto

Spell Property WB_S_D100_FingersOfTheMountain_Spell_LightningStrike_PC Auto

Float Property WB_ChanceOfThunder Auto
Sound Property WB_DestructionShock_Marker_CallLightning_Thunder1 Auto
Sound Property WB_DestructionShock_Marker_CallLightning_Thunder2 Auto

Keyword Property WB_IsFingerProc Auto

Spell Property LightningCloakDmg Auto
Spell Property crAtronachCloakShockDmg Auto

; -----

Actor TheCaster
Actor TheTarget

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheCaster = akCaster
	TheTarget = akTarget

EndEvent

; -----

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool  abHitBlocked)

	If akAggressor != TheTarget && akSource.HasKeyword(MagicDamageShock) && !akSource.HasKeyword(WB_IsFingerProc) && (akSource != LightningCloakDmg && akSource != crAtronachCloakShockDmg)
		RegisterForSingleUpdate(Utility.RandomFloat(WB_RandomDelayMin, WB_RandomDelayMax))
	EndIf

EndEvent

; -----

Event OnUpdate()

	If !TheTarget.IsInInterior()
		WB_S_D100_FingersOfTheMountain_Spell_LightningStrike_PC.Cast(TheCaster, TheTarget)
		If Utility.RandomInt(0,1) == 0
			WB_DestructionShock_Marker_CallLightning_Thunder1.Play(TheTarget)
		Else
			WB_DestructionShock_Marker_CallLightning_Thunder2.Play(TheTarget)
		EndIf
	EndIf

EndEvent

; -----