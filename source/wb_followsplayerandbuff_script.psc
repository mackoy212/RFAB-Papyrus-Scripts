Scriptname WB_FollowsPlayerAndBuff_Script extends ActiveMagicEffect  

; ------

Activator Property FXEmptyActivator Auto
Float Property WB_StartHeight Auto
Float Property WB_UpdateRate Auto

Float Property WB_Speed Auto

Float Property WB_RangeLimit Auto

Light Property WB_Light Auto

Float Property WB_RangeCutoff Auto

Message Property WB_Lost Auto

Spell Property WB_Buff Auto

; ------

ObjectReference TheBox
ObjectReference TheLight
Actor TheTarget
Actor TheCaster

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	TheCaster = akCaster

	TheBox = akCaster.PlaceAtMe(FXEmptyActivator)
	TheBox.SetAngle(0,0,0)
	TheBox.MoveTo(akCaster, 0, 0, WB_StartHeight)
	TheLight = TheBox.PlaceAtMe(WB_Light, abInitiallyDisabled = true)
	TheLight.Enable()
	Utility.Wait(0.1)

	TheBox.MoveTo(akTarget, 0, 0, WB_StartHeight)
	TheBox.SetAngle(0,0,0)
	TheLight.TranslateToRef(TheBox,WB_Speed)
	RegisterForUpdate(WB_UpdateRate)

EndEvent

; ------

Auto State NoBuff

Event OnUpdate()

	Float LightDistance = TheLight.GetDistance(TheTarget)
	If LightDistance > WB_RangeLimit*128/6
		WB_Lost.Show()
		UnregisterForUpdate()
		Dispel()
	Else
		If LightDistance < WB_RangeCutoff*128/6
			GoToState("YesBuff")
			TheTarget.AddSpell(WB_Buff, false)
		Else

		EndIf
		TheBox.SetAngle(0,0,0)
		TheBox.MoveTo(TheTarget, 0, 0, WB_StartHeight)
		TheLight.TranslateToRef(TheBox,WB_Speed)
	EndIf

EndEvent

EndState

; -----

State YesBuff

Event OnUpdate()

	Float LightDistance = TheLight.GetDistance(TheTarget)
	If LightDistance > WB_RangeLimit*128/6
		WB_Lost.Show()
		UnregisterForUpdate()
		Dispel()
	Else
		If LightDistance > WB_RangeCutoff*128/6
			GoToState("NoBuff")
			TheTarget.RemoveSpell(WB_Buff)
		Else

		EndIf
		TheBox.SetAngle(0,0,0)
		TheBox.MoveTo(TheTarget, 0, 0, WB_StartHeight)
		TheLight.TranslateToRef(TheBox,WB_Speed)
	EndIf

EndEvent

EndState

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.RemoveSpell(WB_Buff)
	TheLight.StopTranslation()
	TheLight.Disable(true)
	Utility.Wait(2.0)
	TheBox.Delete()
	TheLight.Delete()

EndEvent

; -----