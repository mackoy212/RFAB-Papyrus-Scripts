ScriptName EtherilazeScript Extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)
  game.DisablePlayerControls(false, true, false, false, false, false, true, false, 0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
  game.EnablePlayerControls(true, true, true, true, true, true, true, true, 0)
EndEvent
