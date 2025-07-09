Scriptname WB_Backlash_Script extends ActiveMagicEffect  

; -----

ImagespaceModifier Property WB_IllusionAntimagic_Imod_Counterspell Auto
Activator Property FXEmptyActivator Auto

; -----

Spell TheSpell
ObjectReference TheBox

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.InterruptCast()
	TheBox = akTarget.PlaceAtMe(FXEmptyActivator)
	Float TargetAngle = akTarget.GetAngleZ()
	TheBox.MoveTo(akTarget, 32*Math.Sin(TargetAngle), 32*Math.Cos(TargetAngle), 64)
	TheSpell = akTarget.GetEquippedSpell(0)
	If TheSpell
		If TheSpell.IsHostile()
			TheSpell.RemoteCast(TheBox,akCaster,akTarget)
		Else
			TheSpell.Cast(akCaster)
		EndIf
	EndIf
	TheSpell = akTarget.GetEquippedSpell(1)
	If TheSpell
		If TheSpell.IsHostile()
			TheSpell.RemoteCast(TheBox,akCaster,akTarget)
		Else
			TheSpell.Cast(akCaster)
		EndIf
	EndIf
	Utility.Wait(0.5)
	TheBox.InterruptCast()
	Utility.Wait(2.0)
	TheBox.Delete()

EndEvent

; -----