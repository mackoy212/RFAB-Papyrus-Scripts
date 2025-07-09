Scriptname WB_Mudhole_Script extends activemagiceffect  

; -----

Activator Property FXEmptyActivator Auto
VisualEffect Property WB_AlterationAlt_VFX_Collapse Auto
Sound Property WB_AlterationBaleful_Marker_Explosion_Subsonic Auto
Hazard Property WB_AlterationWater_Hazard_Sinkhole Auto
Float Property WB_HeightMultSink Auto
Float Property WB_HeightMultScale Auto

; -----

ObjectReference TheBox
ObjectReference TheOrigin
Actor TheTarget
ObjectReference TheFountain
Int SinkState = 0

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Float TargetHeight = akTarget.GetHeight()
	Utility.Wait(0.01)
	TheTarget = akTarget
	TheOrigin = akTarget.PlaceAtMe(FXEmptyActivator)
	TheBox = akTarget.PlaceAtMe(FXEmptyActivator)
	TheBox.MoveTo(akTarget, 0,0, -400)
	akTarget.SetdontMove(true)
	TheFountain = akTarget.PlaceAtMe(WB_AlterationWater_Hazard_Sinkhole)
	TheFountain.SetScale(TargetHeight * WB_HeightMultScale)

	akTarget.TranslateToRef(TheBox, TargetHeight * WB_HeightMultSink)
	RegisterForSingleUpdate(1.0)

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.MoveTo(TheOrigin)
	akTarget.StopTranslation()
	akTarget.SetdontMove(false)
	TheFountain.Disable(true)
	Utility.Wait(2.0)
	TheBox.Delete()
	TheOrigin.Delete()
	TheFountain.Delete()

EndEvent

; -----

Event OnUpdate()

	If SinkState == 0		; stop rapid sink
		TheTarget.TranslateToRef(TheBox, 1)
		WB_AlterationAlt_VFX_Collapse.Play(TheTarget)
		SinkState = 1
		RegisterForSingleUpdate(5.0)
	ElseIf SinkState == 1	; stop downward sink
		TheTarget.TranslateToRef(TheFountain, 1)
		SinkState = 2
		RegisterForSingleUpdate(5.0)
	Else						; stop upward sink
		TheTarget.TranslateToRef(TheBox, 1)
		SinkState = 1
		RegisterForSingleUpdate(5.0)
	EndIf

EndEvent

; -----