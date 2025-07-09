Scriptname hzNECRRequiemMEScript extends activemagiceffect  

Keyword Property LightXBow Auto
Actor target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
	target.SetAnimationVariableBool("bPerkQuickdraw", (target.WornHasKeyword(LightXBow)))
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Weapon
		target.SetAnimationVariableBool("bPerkQuickdraw", (akBaseObject.HasKeyword(LightXBow)))
	EndIf
EndEvent
