Scriptname wezEasterScript extends ObjectReference  

Message Property EasterMessage auto
MiscObject Property Gold001 auto

Event OnActivate(ObjectReference akActionRef)
    int iButton = EasterMessage.Show()
    if iButton == 0
    	Game.GetPlayer().RemoveItem(Gold001, 5)
    endif
EndEvent