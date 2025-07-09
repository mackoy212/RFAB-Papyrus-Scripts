ScriptName LordStoneCapResist Extends activemagiceffect

Float GetResistCap

Event OnEffectStart(Actor akTarget, Actor akCaster)
  GetResistCap = game.GetGameSettingFloat("fPlayerMaxResistance")
  game.SetGameSettingFloat("fPlayerMaxResistance", 75)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
  game.SetGameSettingFloat("fPlayerMaxResistance", GetResistCap as float)
EndEvent