Scriptname WB_Sound_Script extends ActiveMagicEffect  

; -----

Sound Property WB_Sound Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	WB_Sound.Play(akTarget)

EndEvent

; -----