Scriptname OnEffectStartCastSpell extends ActiveMagicEffect

Spell property SpellToCast auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    SpellToCast.Cast(akCaster, none)
EndEvent