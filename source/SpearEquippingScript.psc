Scriptname SpearEquippingScript extends ReferenceAlias

Keyword Property SpearKeyword Auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

    Form EqLeft = game.GetPlayer().GetEquippedObject(0)
    Form EqRight = game.GetPlayer().GetEquippedObject(1)
    If (akBaseObject as Weapon).HasKeyword(SpearKeyword) && akBaseObject != game.GetPlayer().GetEquippedObject(1)
        game.GetPlayer().EquipItemEx(akBaseObject, 1, false, false)
        If !(game.GetPlayer().GetEquippedObject(0) as Armor).IsShield() && game.GetPlayer().GetEquippedItemType(0) != 0
            game.GetPlayer().UnequipItemEx(game.GetPlayer().GetEquippedObject(0), 2, false)
        EndIf
    EndIf 
    If akBaseObject as Spell || akBaseObject as Weapon || akBaseObject as Light
        If game.GetPlayer().GetEquippedObject(1).HasKeyword(SpearKeyword) && game.GetPlayer().GetEquippedItemType(1) != 0 && !(akBaseObject as Weapon).HasKeyword(SpearKeyword)
            game.GetPlayer().UnequipItemEx(game.GetPlayer().GetEquippedObject(1), 1, false)
        EndIf
    EndIf
EndEvent