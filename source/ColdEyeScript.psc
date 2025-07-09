scriptName ColdEyeScript extends activemagiceffect

actor Caster
Float Property Range Auto
Float Property Chance Auto
Float Property Dur Auto
EffectShader Property Visual Auto

function OnHit(objectreference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if akProjectile == none && akAggressor.GetDistance(Caster) <= Range && Utility.RandomFloat(1, 100) <= Chance
		 (akAggressor as actor).EnableAI(false)
		 Visual.Play(akAggressor, Dur)
		 utility.Wait(Dur)
		 (akAggressor as actor).EnableAI(true)
	endIf
endFunction

function OnEffectStart(actor akTarget, actor akCaster)

	Caster = akCaster
endFunction
