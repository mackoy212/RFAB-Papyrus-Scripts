Scriptname REQ_PassiveArmorTraining extends REQ_PlayerAlias

Int[] Property contributions Auto
Message Property NoCombatChanges Auto
GlobalVariable Property CombatEquip Auto
Armor[] slots
Formlist Property worn Auto

Bool updating = true
Bool working = false

Event ScriptInit(string eventName, string strArg, float numArg, Form sender)
	slots = new Armor[32]
	Adjust_Values()
	req_autoupdater UpdateControl = self.GetOwningQuest().GetAlias(0) as req_autoupdater
	Int index = UpdateControl.Scripts.find(self as REQ_PlayerAlias, 0)
	updating = false
	UpdateControl.ShutdownReady[index] = false
EndEvent

function ScriptShutDown(String eventName, String strArg, Float numArg, Form sender)

	updating = true
	while working
		utility.Wait(0.500000)
	endWhile
	req_autoupdater UpdateControl = self.GetOwningQuest().GetAlias(0) as req_autoupdater
	Int index = UpdateControl.Scripts.find(self as REQ_PlayerAlias, 0)
	UpdateControl.ShutdownReady[index] = true
endFunction

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
return
	If ( akBaseObject as Armor != None )
		If Player.GetRace().GetName() != "Вервольф" && (!Player.IsInCombat() || CombatEquip.GetValueInt() > 0)
			Adjust_Values()
		ElseIf (Player.GetRace().GetName() != "Вервольф" && slots.find(akBaseObject as Armor) < 0 ) && CombatEquip.GetValueInt() == 0 && !(akBaseObject as Armor).IsShield()
			
			Player.UnequipItem(akBaseObject, abSilent = True )
			debug.Notification("Я не могу менять броню в бою!")
		EndIf
	EndIf
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	return
	If ( akBaseObject as Armor != None )
		If  (!Player.IsInCombat() || CombatEquip.GetValueInt() > 0)
			Adjust_Values()
		ElseIf (Player.GetRace().GetName() != "Вервольф" && slots.find(akBaseObject as Armor) > 0 ) && CombatEquip.GetValueInt() == 0 && !(akBaseObject as Armor).IsShield()
			
			Player.EquipItem(akBaseObject, abSilent = True )
			debug.Notification("Я не могу менять броню в бою!")
		EndIf
	EndIf
EndEvent

Function Adjust_Values()
	Int i = 30
	Int type = -1
	Int pos = -1
	worn.Revert()
	While (i < 62)
		slots[i - 30] = Player.GetWornForm(Armor.GetMaskForSlot(i)) as Armor
		worn.AddForm(slots[i - 30])
		pos = contributions.find(i)
		If ( pos >= 0 && slots[i - 30] != None )
			type = slots[i - 30].GetWeightClass()
		EndIf
		i += 1
	EndWhile
EndFunction