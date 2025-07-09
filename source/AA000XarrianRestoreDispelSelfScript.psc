Scriptname AA000XarrianRestoreDispelSelfScript extends activemagiceffect  

Event OnEffectStart(Actor Caster, Actor Target)
	int SpellCount = Target.GetSpellCount()
	while SpellCount
		SpellCount -= 1
		Spell CurrentSpell = Target.GetNthSpell(SpellCount)
		if CurrentSpell.IsHostile()
			Target.DispelSpell(CurrentSpell)
		endif
	endwhile
EndEvent
