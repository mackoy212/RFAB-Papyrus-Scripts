Scriptname WB_Fracture_Script extends ActiveMagicEffect  

; -----

Keyword Property MagicDamageFrost Auto
Keyword Property WB_IsFracture Auto

Explosion Property WB_DestructionFrost_Explosion_Fracture Auto
Spell Property WB_S_D025_Fracture_Spell Auto

Float Property WB_UpdateDelay Auto

Activator Property FXEmptyActivator Auto

; -----

Actor TheTarget
Actor TheCaster
ObjectReference TheBox

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	TheCaster = akCaster
	TheBox = akTarget.PlaceAtMe(FXEmptyActivator)

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	TheBox.Delete()

EndEvent


; -----

Auto State FrostIncoming

	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)

		If akEffect.HasKeyword(MagicDamageFrost) && !akEffect.HasKeyword(WB_IsFracture) && akCaster != TheTarget
			GoToState("FrostBlocked")
			TheTarget.PlaceAtMe(WB_DestructionFrost_Explosion_Fracture)
			WB_S_D025_Fracture_Spell.RemoteCast(TheBox,TheCaster,TheTarget)
			Dispel()
		EndIf

	EndEvent

EndState

; -----

State FrostBlocked

EndState

; -----