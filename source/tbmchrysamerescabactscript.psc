Scriptname tbmChrysamereScabActScript extends ObjectReference  

Weapon Property tbmChrysamere Auto
Weapon Property tbmChrysamereS Auto
Message Property tbmChrysamereSheatheMsg Auto
Message Property tbmChrysamereUnsheatheMsg Auto

Event OnActivate(ObjectReference akActionRef)
	int plainCount = akActionRef.GetItemCount(tbmChrysamere)
	int scabCount = akActionRef.GetItemCount(tbmChrysamereS)

	If (plainCount > 0)
		akActionRef.RemoveItem(tbmChrysamere, 1, true)
		akActionRef.AddItem(tbmChrysamereS, 1, true)
		tbmChrysamereSheatheMsg.Show()
		return
	EndIf

	If (scabCount > 0)
		akActionRef.RemoveItem(tbmChrysamereS, 1, true)
		akActionRef.AddItem(tbmChrysamere, 1, true)
		tbmChrysamereUnsheatheMsg.Show()
		return
	EndIf
EndEvent
