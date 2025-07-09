Scriptname WB_Interrupt_Script extends activemagiceffect  

; -----

ImagespaceModifier Property WB_IllusionAntimagic_Imod_Counterspell Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.InterruptCast()
	WB_IllusionAntimagic_Imod_Counterspell.Apply()

EndEvent

; -----