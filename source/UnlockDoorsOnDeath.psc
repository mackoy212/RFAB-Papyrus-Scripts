Scriptname UnlockDoorsOnDeath extends ObjectReference  



ObjectReference[] Property Doors  Auto  

Event OnDeath(Actor akKiller)
	int i = 0
	while i < Doors  .Length
		Doors[i].Lock(false)
		i = i+1
	endwhile
endevent