;/ Decompiled by Champollion V1.0.1
Source   : Kelpie_AbShadows.psc
Modified : 2020-07-24 21:56:46
Compiled : 2020-07-24 21:57:34
User     : nirn2
Computer : DESKTOP-KNH59MN
/;
scriptName Kelpie_AbShadows extends ActiveMagicEffect

;-- Properties --------------------------------------
Float property N auto
spell property Drain auto

;-- Variables ---------------------------------------
Float fDiffMultHPToPCL
Float mag

;-- Functions ---------------------------------------

function OnEffectStart(Actor akTarget, Actor akCaster)

	fDiffMultHPToPCL = game.GetGameSettingfloat("fDiffMultHPToPCL")
	mag = N / fDiffMultHPToPCL
	Drain.SetNthEffectMagnitude(0, mag)
	akTarget.AddSpell(Drain, false)
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
