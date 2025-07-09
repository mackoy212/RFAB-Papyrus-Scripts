Scriptname RFAB_AddSpellOnPickup extends ObjectReference  
spell[] property SpellsToAdd auto
bool property silent auto
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	if akNewContainer == Game.GetPlayer()
		int i = 0
		while i < SpellsToAdd .Length
			Game.GetPlayer().Addspell(SpellsToAdd[i], !silent)
			i = i + 1
		endwhile
	else
		int i = 0
		while i < SpellsToAdd .Length
			Game.GetPlayer().Removespell(SpellsToAdd[i])
			i = i + 1
		endwhile
	endif
endevent