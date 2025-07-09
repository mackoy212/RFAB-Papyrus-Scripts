Scriptname MLQ_AutoBeastformEffect extends ActiveMagicEffect

Race originalRace
Actor selfRef
bool outOfCombat
bool outOfDuration
float property chanceBear auto
float property duration auto
Spell transform
Spell property werewolfTransform auto
Spell property werebearTransform auto
Armor skin
Armor property WolfSkinFXArmor auto
Armor property BearSkinFXArmor auto
Race Property WerebearRace Auto
LeveledItem Property WerewolfDeathItem Auto
MiscObject Property WolfPelt Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if(Utility.randomFloat() < chanceBear)
		transform = werebearTransform
		skin = BearSkinFXArmor
	else
		transform = werewolfTransform
		skin = WolfSkinFXArmor
	endIf
endEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if(!selfRef)
		selfRef = GetTargetActor()
		originalRace = selfRef.getRace()
	endIf
	if (aeCombatState > 0 && !selfRef.isDead()) ; transform
		outOfCombat = false
		outOfDuration = false
		registerForSingleUpdate(duration)
		transform.cast(selfRef)
	else ; revert
		outOfCombat = true
		checkRevert()
	endIf
endEvent
Event OnUpdate()
	outOfDuration = true
	checkRevert()
endEvent

Event OnDeath(Actor akKiller)
	if(selfRef.getRace() != originalRace)
		selfRef.addItem(WerewolfDeathItem, 1)
		if(selfRef.getRace() == WerebearRace && selfRef.getItemCount(WolfPelt) > 0)
			selfRef.removeItem(WolfPelt, 1)
		endIf
	endIf
	dispel()
endEvent

function checkRevert()
	if(outOfCombat && outOfDuration && !selfRef.isDead()) ; revert
		selfRef.RemoveItem(skin, 1, True)
		selfRef.setRace(originalRace)
	endIf
endFunction