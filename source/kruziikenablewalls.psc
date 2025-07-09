Scriptname KruziikEnableWalls extends ObjectReference  

ObjectReference Property startTrigger auto

Event OnActivate(ObjectReference akActionRef)
    if (akActionRef == startTrigger)
    	self.Enable()
    endif
EndEvent