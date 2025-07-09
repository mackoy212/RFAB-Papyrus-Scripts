Scriptname tbmChrysamereBlockScript extends activemagiceffect  
{Reflects all hostile spells at the attacker.}

Float BlockTimer = 0.0

Float Property BlockWindow = 1.0 Auto  
{Gap between two blocked spells to subtract large stamina value.}

Float Property BlockTick = 0.25 Auto  
{Time between two stamina subtractions / block casts.}

Float Property StaminaLossLarge = 35.0 Auto  
{Value initially subtracted for blocking a spell.}

Float Property StaminaLossLittle = 2.0 Auto
{Stamina lost for continuously blocking a streaming spell.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	BlockTimer = Utility.GetCurrentRealTime()
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Spell testSpell = akSource As Spell

	If (testSpell)
		if (testSpell.IsHostile())
			Actor owner = GetTargetActor()
		
			float lastBlock = BlockTimer
			float currentTime = Utility.GetCurrentRealTime()
			float timeDiff = currentTime - lastBlock
			
			float staminaTaken = StaminaLossLarge
			If (timeDiff < BlockWindow)
				staminaTaken = StaminaLossLittle
			EndIf

			If (owner.GetActorValue("RightItemCharge") >= staminaTaken)
				owner.DamageActorValue("RightItemCharge", staminaTaken)
				
				BlockTimer = currentTime
			
				testSpell.Cast(GetTargetActor(), akAggressor)
				Utility.Wait(blockTick)
				owner.InterruptCast()
			EndIf
		Endif
	EndIf
EndEvent

