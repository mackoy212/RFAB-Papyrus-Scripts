Scriptname Rfab_CameraShake extends ObjectReference  


Event OnActivate(ObjectReference akActionRef)
	Game.ShakeCamera(Game.GetPlayer(), 0.5, 4)
endevent