Scriptname FZR_Add2SpellsOnEquip extends ObjectReference  

SPELL Property Spell02  Auto   
Int DaedraKilled
Int Con2 = 25

Event OnEquipped(Actor akActor)

	DaedraKilled = Game.QueryStat("Daedra Killed")
	
	if DaedraKilled >= Con2
		akActor.AddSpell(Spell02)
	EndIf

EndEvent


Event OnUnequipped(Actor akActor)

	akActor.RemoveSpell(Spell02)

EndEvent
	