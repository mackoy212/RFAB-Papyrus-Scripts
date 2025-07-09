ScriptName FZR_ApplySpellOnHit Extends ActiveMagicEffect

Spell Property SpellToApply Auto

Actor Caster
Actor Target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Caster = akCaster
	Target = akTarget
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If (akSource as Weapon) && !(akSource as Enchantment) && (akAggressor == Caster as ObjectReference)
		if (akSource as Weapon) == Caster.GetEquippedWeapon(0) || (akSource as Weapon) == Caster.GetEquippedWeapon(1)
			GoToState("Busy")
			SpellToApply.Cast(Caster, Target)
			RegisterForSingleUpdate(1.0)
		endif
	EndIf
EndEvent

Event OnUpdate()
	GoToState("")
EndEvent

state Busy
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	EndEvent
endState
