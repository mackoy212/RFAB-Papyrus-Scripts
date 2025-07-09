Scriptname WB_AlarmProc_Script extends activemagiceffect  

; -----

Sound Property WB_AlterationDetect_Scripted_Marker_Alarm Auto
MagicEffect Property WB_A000_AlterationDetect_Alarm_EffectInitDelay Auto
Message Property WB_AlterationDetect_Alarm_Message Auto
Actor Property PlayerRef Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	If !akCaster.HasMagicEffect(WB_A000_AlterationDetect_Alarm_EffectInitDelay) && akCaster == PlayerRef
		WB_AlterationDetect_Scripted_Marker_Alarm.Play(akTarget)
		WB_AlterationDetect_Alarm_Message.Show()
	EndIf

EndEvent

; -----