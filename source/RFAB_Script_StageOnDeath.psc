Scriptname RFAB_Script_StageOnDeath extends ObjectReference  

Actor Property Talen  Auto  

Quest Property property1  Auto  

Event OnDeath(Actor Talen)

	if property1.GetStageDone(10) == 1
		property1.setobjectivedisplayed(21)
		property.setstage(21)
	endif

endevent


Actor Property Talen  Auto  

Actor Property NewProperty1  Auto  
