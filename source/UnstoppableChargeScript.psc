ScriptName UnstoppableChargeScript Extends activemagiceffect

Spell Property SpellAdd Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  akCaster.AddSpell(SpellAdd, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  akCaster.RemoveSpell(SpellAdd)
EndEvent
