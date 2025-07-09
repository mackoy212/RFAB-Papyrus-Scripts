Scriptname RFAB_MasterOnItemEvent extends ReferenceAlias  

import PAPER_SKSEFunctions

Actor Property Player Auto

GlobalVariable Property GlobalIW Auto ; Используется как кондишн в idle атаках 

Event OnBatchItemsAdded(Form[] akBaseItems, Int[] aiItemCounts, ObjectReference[] akSourceContainers)
    GlobalIW.SetValue(Player.GetAV("InventoryWeight") as Float)
EndEvent

Event OnBatchItemsRemoved(Form[] akBaseItems, Int[] aiItemCounts, ObjectReference[] akSourceContainers)
    GlobalIW.SetValue(Player.GetAV("InventoryWeight") as Float)
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
    GlobalIW.SetValue(Player.GetAV("InventoryWeight") as Float)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    GlobalIW.SetValue(Player.GetAV("InventoryWeight") as Float)
EndEvent