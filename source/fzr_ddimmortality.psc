Scriptname FZR_DDImmortality extends ObjectReference  
 
Actor Property Actor1 Auto
Bool doOnce
GlobalVariable Property BB_Enabled Auto

Event OnTriggerEnter(ObjectReference akActionRef)
	if doOnce == False && BB_Enabled.GetValueInt() == 1 && akActionRef == Game.GetPlayer()
			Actor1.SetGhost(True)
			Utility.Wait(10.0)
			Actor1.SetGhost(False)
			doOnce = True
	EndIf
EndEvent