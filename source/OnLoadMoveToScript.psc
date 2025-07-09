Scriptname OnLoadMoveToScript extends ObjectReference  

ObjectReference Property MoveWho  Auto  

ObjectReference Property MoveWhere  Auto  


Event OnLoad()
	MoveWho  .Moveto(MoveWhere  )
endevent