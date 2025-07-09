scriptName RFAB_BountyHunt_Decapitate extends ObjectReference

Int alreadymoved = 0

function OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	If akOldContainer != game.GetPlayer()
		if alreadymoved == 0
			alreadymoved += 1
		elseIf alreadymoved == 1
			alreadymoved += 1
			armor RFAB_Armor_Decapitatedhead = game.GetFormFromFile(235382074, "RFAB_BountyHunt.esp") as armor
			(akOldContainer as actor).EquipItem(RFAB_Armor_Decapitatedhead as form, true, false)
		endIf
	endIf
endFunction
