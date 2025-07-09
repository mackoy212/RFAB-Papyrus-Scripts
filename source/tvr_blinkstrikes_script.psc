;/ Decompiled by Champollion V1.0.1
Source   : TVR_BlinkStrikes_Script.psc
Modified : 2020-06-27 01:32:37
Compiled : 2020-06-27 01:32:38
User     : maxim
Computer : CANOPUS
/;
scriptName TVR_BlinkStrikes_Script extends activemagiceffect

;-- Properties --------------------------------------
spell property TVR_Proc auto

;-- Variables ---------------------------------------
Actor TargetRef

;-- Functions ---------------------------------------

function OnRaceSwitchComplete()

	utility.Wait(2.00000)
	self.RegisterForAnimationEvent(TargetRef as objectreference, "PowerAttack_Start_End")
endFunction

function OnAnimationEvent(objectreference akSource, String asEventName)

	if akSource == TargetRef as objectreference
		TVR_Proc.Cast(TargetRef as objectreference, none)
	endIf
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnEffectStart(Actor akTarget, Actor akCaster)

	TargetRef = akTarget
	self.RegisterForAnimationEvent(TargetRef as objectreference, "PowerAttack_Start_End")
endFunction
