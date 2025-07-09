Scriptname tbmChrysamereHealScript extends activemagiceffect  
{Heals target for magnitude hp every interval seconds.}

float Property magnitude auto
float Property interval auto

Actor myTarget

Event OnEffectStart(Actor akTarget, Actor akCaster)
	myTarget = akTarget
	RegisterForUpdate(interval)
EndEvent

Event OnUpdate()
	myTarget.RestoreActorValue("health", magnitude)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
EndEvent