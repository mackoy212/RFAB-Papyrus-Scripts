Scriptname RFAB_VokunHorrorExit extends ObjectReference  

ObjectReference Property VokunChamberMarker  Auto  
Actor property Vokun auto
ObjectReference property CoffinMarker Auto

Event OnActivate(ObjectReference akActionRef)
	debug.messagebox("Вы спаслись из кошмара.")
	Game.GetPlayer().MoveTo(VokunChamberMarker  )
	Vokun.enable()
	Vokun.MoveTo(CoffinMarker )

endevent