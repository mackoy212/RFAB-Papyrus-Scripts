Scriptname REQ_ArrowWeight extends REQ_PlayerAlias  
{simulate weight for ammunition}
;/
import PO3_SKSEFunctions

Weapon[] Property Dummies  Auto  
{legacy}
Keyword[] Property AmmoWeight Auto
{keyword identifier for a weight class, maps to ammoWeightDummies with the same array index}
Weapon[] Property ammoWeightDummies Auto
{hidden weight dummy item for a weight class, maps to ammoWeightIdentifiers with the same array index}

Keyword Property weightlessAmmo Auto
{keyword identifier for ammunition that is treated as weightless}
Int Property defaultWeightIndex Auto
{index from ammoWeightDummies which is used for any ammunition without a known weight keyword}
MiscObject Property displayQuiver Auto
{a quest item added to the player's inventory to display the total ammunition weight}
ObjectReference Property hideQuiverPlace Auto
{container where the quiver can be hidden when the player has no ammunition in their inventory}

FormList Property ArrowsList Auto
FormList Property BlankFormList Auto

int kAmmo = 42

Event OnPlayerLoadGame()
    updateAmmoWeightDisplay()
    self.RegisterForMenu("BarterMenu")
    self.RegisterForMenu("ContainerMenu")
    self.RegisterForMenu("InventoryMenu")
    AddInventoryEventFilter(ArrowsList)
EndEvent

Event OnBatchItemsAdded(Form[] akBaseItems, Int[] aiItemCounts, ObjectReference[] akSourceContainers)
    int NumberOfArrows = akBaseItems.Length
    int Index
    While NumberOfArrows
        NumberOfArrows -= 1
        Index = GetAmmunutionWeightIndex(akBaseItems[NumberOfArrows])
        If Index != -1
            AddArrowsWeight(ammoWeightDummies[Index], aiItemCounts[NumberOfArrows])
        EndIf
    Endwhile
    updateAmmoWeightDisplay()
EndEvent

Event OnMenuOpen(String MenuName)
	AddInventoryEventFilter(BlankFormList)
EndEvent

function OnMenuClose(String MenuName)
    RemoveInventoryEventFilter(BlankFormList)

    Form[] ArrowInInventory = AddItemsOfTypeToArray(Player, kAmmo)

    int i = 0 
    While (i < AmmoWeight.length)
		Player.RemoveItem(ammoWeightDummies[i], Player.GetItemCount(ammoWeightDummies[i]), true)
        i += 1
    EndWhile

    int NumberOfArrows = ArrowInInventory.Length
    int Index
    While NumberOfArrows
        NumberOfArrows -= 1
        Index = GetAmmunutionWeightIndex(ArrowInInventory[NumberOfArrows])
        If Index != -1
            AddArrowsWeight(ammoWeightDummies[Index], Player.GetItemCount(ArrowInInventory[NumberOfArrows]))
        EndIf
    Endwhile
    updateAmmoWeightDisplay()
endFunction

Event OnBatchItemsRemoved(Form[] akBaseItems, Int[] aiItemCounts, ObjectReference[] akSourceContainers)
    int NumberOfArrows = akBaseItems.Length
    while NumberOfArrows
        NumberOfArrows -= 1
        int Index = GetAmmunutionWeightIndex(akBaseItems[NumberOfArrows])
        If Index != -1
            RemoveArrowsWeight(ammoWeightDummies[Index], aiItemCounts[NumberOfArrows])
        ;/ElseIf (akBaseItem == displayQuiver && akDestContainer != hideQuiverPlace)
            akDestContainer.removeItem(displayQuiver, 1, true, hideQuiverPlace)
        EndIf
    endWhile
    updateAmmoWeightDisplay()
EndEvent

Int Function GetAmmunutionWeightIndex(Form akArrow)
	if akArrow as Ammo != None
	    Int Iteration = AmmoWeight.length
	    While Iteration
	        Iteration -= 1
	        If akArrow.HasKeyword(AmmoWeight[Iteration])
	            return Iteration
	        EndIf
	    EndWhile

	    If (akArrow.HasKeyword(weightlessAmmo))
	        return -1
	    Else
	        return defaultWeightIndex
	    EndIf
	endif
	return -1
EndFunction

Function AddArrowsWeight(Weapon type, Int count)
    If count > 0
        player.AddItem(type, count, true)
    EndIf
EndFunction

Function RemoveArrowsWeight(Weapon type, Int count)
    If count > 0
        player.RemoveItem(type, count, true)
    EndIf
EndFunction

Function updateAmmoWeightDisplay()
    Float weight = 0
    Int i = 0
    While (i < AmmoWeight.length)
        weight += player.getItemCount(ammoWeightDummies[i]) * ammoWeightDummies[i].getWeight()
        i += 1
    EndWhile
    displayQuiver.setWeight(weight)
    If (weight == 0 && player.getItemCount(displayQuiver) > 0)
        player.removeItem(displayQuiver, 1, true, hideQuiverPlace)
    ElseIf (weight > 0 && player.getItemCount(displayQuiver) == 0)
        hideQuiverPlace.removeItem(displayQuiver, 1, true, player)
    EndIf
EndFunction



Event ScriptInit(string eventName, string strArg, float numArg, Form sender)
    Int i = 0
    While (i < ammoWeightDummies.length)
        player.removeItem(ammoWeightDummies[i], Player.GetItemCount(ammoWeightDummies[i]), true)
        i += 1
    EndWhile

    Int[] ammoCounts = Utility.createIntArray(ammoWeightIdentifiers.length, 0)

    i = player.getNumItems()
    While (i > 0)
        i -= 1
        Form object = player.getNthForm(i)
        Int ammoType = getWeightIndexForObject(object)
        If (ammoType >= 0)
            ammoCounts[ammoType] = ammoCounts[ammoType] + Player.GetItemCount(object)
        EndIf
    EndWhile

    i = 0
    While (i < ammoWeightDummies.length)
        player.addItem(ammoWeightDummies[i], ammoCounts[i], true)
        i += 1
    EndWhile
    updateAmmoWeightDisplay()

    parent.ScriptInit(eventName, strArg, numArg, sender)
EndEvent

Event ScriptShutDown(string eventName, string strArg, float numArg, Form sender)
    ; legacy code for updating from 3.1.1 and older
    Player.removeItem(Dummies[0], Player.GetItemCount(Dummies[0]), true)
    Player.removeItem(Dummies[1], Player.GetItemCount(Dummies[1]), true)
    Player.removeItem(Dummies[2], Player.GetItemCount(Dummies[2]), true)
    Player.removeItem(Dummies[3], Player.GetItemCount(Dummies[3]), true)

    ; a new one will be spawned by restarting the dummy item auxiliary quest
    player.removeItem(displayQuiver, player.getItemCount(displayQuiver), true)
    hideQuiverPlace.removeItem(displayQuiver, hideQuiverPlace.getItemCount(displayQuiver), true)
    Int i = 0
    While (i < ammoWeightDummies.length)
        player.removeItem(ammoWeightDummies[i], Player.GetItemCount(ammoWeightDummies[i]), true)
        i += 1
    EndWhile
    parent.ScriptShutDown(eventName, strArg, numArg, sender)
EndEvent
/;
