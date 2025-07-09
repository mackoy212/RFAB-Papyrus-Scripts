Scriptname WB_WiltingDispelTracker_Script extends activemagiceffect  

; -----

Float Property WB_UpdateRate Auto
String Property WB_Stat Auto
Float Property WB_Threshold Auto

; -----

Actor TheTarget

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	RegisterForSingleUpdate(WB_UpdateRate)

EndEvent

; -----

Event OnUpdate()

	; much more responsive than a spell condition, which ticks once per second
	If TheTarget.GetActorValuePercentage(WB_Stat) < WB_Threshold
		Dispel()
	Else
		RegisterForSingleUpdate(WB_UpdateRate)
	EndIf

EndEvent

; -----