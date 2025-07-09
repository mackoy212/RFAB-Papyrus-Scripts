Scriptname Varis_teleport_and_sneak extends ObjectReference  

Actor Property varis Auto 

Event OnActivate(ObjectReference akActionRef)

varis.moveto(spawn_marker)

endevent
