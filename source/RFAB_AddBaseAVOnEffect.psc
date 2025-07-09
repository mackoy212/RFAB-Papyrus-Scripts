Scriptname RFAB_AddBaseAVOnEffect extends ActiveMagicEffect  

REQ_AttributeSystem Property AttributeSystem Auto
{REQ_Quest_Playerscripts}
String[] Property StatNames Auto
Int[] Property StatCount Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	int Iteration = StatNames.Length
	while Iteration
		Iteration -= 1
		akCaster.SetAV(StatNames[Iteration], akCaster.GetBaseAV(StatNames[Iteration]) + StatCount[Iteration])
	endwhile
	AttributeSystem.UpdateAttributeBonuses()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	int Iteration = StatNames.Length
	while Iteration
		Iteration -= 1
		akCaster.SetAV(StatNames[Iteration], akCaster.GetBaseAV(StatNames[Iteration]) + StatCount[Iteration])
	endwhile
	AttributeSystem.UpdateAttributeBonuses()
EndEvent