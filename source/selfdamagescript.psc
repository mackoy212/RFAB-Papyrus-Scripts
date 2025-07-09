ScriptName selfdamagescript Extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Float dmg = self.GetMagnitude()
	akCaster.DamageAV("Health", dmg)
EndEvent