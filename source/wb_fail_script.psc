Scriptname WB_Fail_Script extends ActiveMagicEffect  

; -----

Message Property WB_Message_Fail Auto
Sound Property MAGFail Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	MAGFail.Play(akTarget)
	WB_Message_Fail.Show()

EndEvent

; -----