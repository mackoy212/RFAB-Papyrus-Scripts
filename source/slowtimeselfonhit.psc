scriptName SlowTimeSelfOnHit extends ActiveMagicEffect

Spell property HSpell auto

Function OnEffectStart(Actor akTarget, Actor akCaster)

	HSpell.Cast(game.GetPlayer() as ObjectReference, none)

endFunction