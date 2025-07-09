Scriptname WB_ContinuousDamage_Self_Script extends ActiveMagicEffect  

; -----

Float Property WB_UpdateRate Auto
Float Property WB_DamagePerSecond Auto

; -----

Float calculatedDamage
Actor effectCaster

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	effectCaster = akCaster
	calculatedDamage = WB_DamagePerSecond * WB_UpdateRate
	OnUpdate()
	RegisterForUpdate(WB_UpdateRate)

EndEvent

; -----

Event OnUpdate()

	effectCaster.DamageActorValue("Health", calculatedDamage)

EndEvent

; -----