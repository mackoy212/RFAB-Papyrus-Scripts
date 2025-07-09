Scriptname RFAB_SummonEffect extends ActiveMagicEffect  

int Property SlotCount Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if (akTarget.GetActorValue("ConjurationSkillAdvance") < SlotCount)
		Dispel()
	endif

	akTarget.ModActorValue("ConjurationSkillAdvance", -SlotCount)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModActorValue("ConjurationSkillAdvance", SlotCount)
EndEvent