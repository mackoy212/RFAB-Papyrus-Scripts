Scriptname tbmChrysamereAddPowerScript extends activemagiceffect
{Responsible for adding/removing the Chrysamere power.}

Spell Property ChrysamerePower auto

Actor myTarget

Event OnEffectStart(Actor akTarget, Actor akCaster)
	myTarget = akTarget
	
	If (!myTarget.HasSpell(ChrysamerePower))
		myTarget.AddSpell(ChrysamerePower, true)
	EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	; myTarget.RemoveSpell(ChrysamerePower)
EndEvent
