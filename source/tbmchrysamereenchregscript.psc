Scriptname tbmChrysamereEnchRegScript extends activemagiceffect  
{Restores magnitude enchantment points every interval seconds to the players right hand item.}

float Property magnitude auto
float Property interval auto
float Property maxval auto
; this is needed because of the weird damage->baseval transfer that can happen

Actor myTarget

Event OnEffectStart(Actor akTarget, Actor akCaster)
	myTarget = akTarget
	RegisterForUpdate(interval)
EndEvent

Event OnUpdate()
	myTarget.RestoreActorValue("rightitemcharge", magnitude)
	
	float curmax = myTarget.GetBaseActorValue("rightitemcharge")

	if (curmax < maxval)
		float valdiff = maxval - curmax
		
		myTarget.SetActorValue("rightitemcharge", maxval)
		myTarget.DamageActorValue("rightitemcharge", valdiff)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
EndEvent