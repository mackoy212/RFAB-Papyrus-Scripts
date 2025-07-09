Scriptname WB_ForceHPto1_Script extends ActiveMagicEffect  

; -----

Float Property WB_HealthValue Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.ForceActorValue("Health", WB_HealthValue)

EndEvent

; -----