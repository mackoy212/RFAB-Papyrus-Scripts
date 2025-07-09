Scriptname FZR_AddSpellOnEquipDaedraConScript extends ObjectReference  

SPELL Property Spell01  Auto 
SPELL Property Spell02  Auto  
SPELL Property Spell03  Auto  
Int DaedraKilled
Int Con = 25
Int Con2 = 50
Int Con3 = 75

Event OnEquipped(Actor akActor)

	DaedraKilled = Game.QueryStat("Daedra Killed")
	
	if DaedraKilled >= Con
		akActor.AddSpell(Spell01)
	EndIf
	
	if DaedraKilled >= Con2
		akActor.AddSpell(Spell02)
	EndIf
		
	if DaedraKilled >= Con3
		akActor.AddSpell(Spell03)
	EndIf

EndEvent


Event OnUnequipped(Actor akActor)

	akActor.RemoveSpell(Spell01)
	akActor.RemoveSpell(Spell02)
	akActor.RemoveSpell(Spell03)

EndEvent
	