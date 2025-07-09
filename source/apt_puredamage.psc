scriptName APT_PureDamage extends activemagiceffect

String property ValueDamage auto

function OnEffectStart(Actor akTarget, Actor akCaster)
	Float mag = self.GetMagnitude()
	akTarget.DamageAV(ValueDamage, mag as Float)

endFunction