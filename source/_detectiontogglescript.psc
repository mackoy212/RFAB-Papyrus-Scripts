Scriptname _DetectionToggleScript Extends ActiveMagicEffect

GlobalVariable Property DetectionIsActive Auto
Spell Property DetectionMainSpell Auto
String Property DetectionActivated Auto
String Property DetectionDeactivated Auto

Event OnEffectStart(Actor Target, Actor Caster)
	If DetectionIsActive.GetValue() == 0
		Caster.AddSpell(DetectionMainSpell, false)
		DetectionIsActive.SetValue(1)
		Debug.Notification(DetectionActivated)
	ElseIf DetectionIsActive.GetValue() == 1
		Caster.RemoveSpell(DetectionMainSpell)
		DetectionIsActive.SetValue(0)
		Debug.Notification(DetectionDeactivated)
	EndIf
EndEvent
