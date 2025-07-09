scriptName APT_SunCloackReflectScript extends activemagiceffect

spell property SpellToCast auto

Bool isready = true
actor Caster

function OnHit(objectreference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if isready
		isready = false
		Caster.docombatspellapply(SpellToCast, akAggressor)
		self.RegisterForSingleUpdate(0.250000)
	endIf
endFunction

function OnEffectStart(actor akTarget, actor akCaster)

	Caster = akCaster
endFunction

function OnUpdate()

	isready = true
endFunction
