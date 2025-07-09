Scriptname RFAB_Script_AddMurder_Reference extends ObjectReference

Event OnDeath(Actor akKiller)
	If akKiller == Game.GetPlayer()
		Game.IncrementStat("Murders")
	Endif
EndEvent