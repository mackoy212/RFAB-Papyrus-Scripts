Scriptname UnderforgeTotemScriptRFAB extends ObjectReference  

Spell Property SpellToAdd1 auto
Spell Property SpellToRemove1 auto
Spell Property SpellToRemove2 auto

Event OnActivate(ObjectReference akActor)
		(akActor as Actor).RemoveSpell(SpellToRemove1)
		(akActor as Actor).RemoveSpell(SpellToRemove2)
		(akActor as Actor).AddSpell(SpellToAdd1, true)
EndEvent