Scriptname RFAB_Mounts_Alias extends ReferenceAlias 

RFAB_Mounts Property Mounts Auto

Formlist Property BlankFilter Auto

Actor Player

Event OnInit()
    Player = Game.GetPlayer()
    AddInventoryEventFilter(BlankFilter)
    RegisterForAnimationEvent(Player, "MountEnd")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    Mounts.UpdateMountStats()
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    Mounts.UpdateWeightInMenu()
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    Mounts.UpdateWeightInMenu()
EndEvent

Event OnMenuOpen(String asMenuName)
    Mounts.UpdateWeightInMenu()
    if (Mounts.IsShowWeightInMenu)
        RemoveAllInventoryEventFilters()
    endif
EndEvent

Event OnMenuClose(String asMenuName)
    if (Mounts.IsShowWeightInMenu)
        AddInventoryEventFilter(BlankFilter)
    endif
    Mounts.UpdateWeightInName()
    UnRegisterForMenu(asMenuName)
EndEvent