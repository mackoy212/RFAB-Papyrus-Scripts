Scriptname WB_KnotOfFetters_Script extends ActiveMagicEffect  

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.SetRestrained(true)

EndEvent

; ----- 

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.SetRestrained(false)

EndEvent

; ----- 