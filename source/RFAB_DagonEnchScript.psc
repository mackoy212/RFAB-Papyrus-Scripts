Scriptname RFAB_DagonEnchScript extends ActiveMagicEffect

GlobalVariable Property Point  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
  Point.mod(1.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
   Point.mod(-1.0)
EndEvent