Scriptname KruziikFrozenDoorScript extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	if (akActionRef == Game.GetPlayer())
		debug.Notification("����� �������.")
	endif
EndEvent