Scriptname WB_SimpleSpawner_Script extends ObjectReference  


; ------

Float Property WB_StartHeight Auto
Float Property WB_EndHeight Auto
Float Property WB_Speed Auto
Light Property WB_Spawner Auto

; ------

ObjectReference TheItem

; -----

Event OnLoad()

	Float CurrentX = Self.GetPositionX()
	Float CurrentY = Self.GetPositionY()
	Float CurrentZ = Self.GetPositionZ()
	TheItem = Self.PlaceAtMe(WB_Spawner)
	TheItem.SetPosition(CurrentX, CurrentY, CurrentZ + WB_StartHeight)
	TheItem.Enable(true)
	TheItem.TranslateTo(CurrentX, CurrentY, CurrentZ + WB_EndHeight, 0, 0, 0, WB_Speed)
	Delete()

EndEvent

; ------