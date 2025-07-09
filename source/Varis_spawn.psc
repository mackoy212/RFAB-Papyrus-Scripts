Scriptname Varis_spawn extends ObjectReference  

Actor Property Property1  Auto  

Event OnActivate(ObjectReference akActionRef)

property1.enablenowait(true)

property1.moveto(spawn_marker)

endevent
ObjectReference Property spawn_marker  Auto  

