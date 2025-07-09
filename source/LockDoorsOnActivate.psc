Scriptname LockDoorsOnActivate extends ObjectReference  


ObjectReference[] Property Doors  Auto  

Event OnActivate(ObjectReference akActionRef)
int i = 0
	while i < Doors  .Length
	
	Doors  [i].setopen(false)
	Doors  [i].setlocklevel(255)
	
	Doors  [i].lock()
	i = i+1
	endwhile
EndEvent
