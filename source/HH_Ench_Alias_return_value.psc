Scriptname HH_Ench_Alias_return_value extends ReferenceAlias  

GlobalVariable Property HH_Global_Old_Enchanting Auto
GlobalVariable Property HH_Glob_Menu_Enchanting Auto
Perk Property HH_Perk_to_100_Enchanting Auto

Event OnInit()
	RegisterForMenu("Crafting Menu")
	Game.GetPlayer().addperk(HH_Perk_to_100_Enchanting)
EndEvent


Event OnMenuClose(String MenuName)
	If MenuName == "Crafting Menu" && HH_Global_Old_Enchanting.GetValue() !=0 && HH_Glob_Menu_Enchanting.GetValue() !=0
		Game.GetPlayer().SetActorValue("Enchanting", HH_Global_Old_Enchanting.GetValue())
		HH_Glob_Menu_Enchanting.SetValue(0)
		;Debug.MessageBox("D"+HH_Global_Old_Enchanting.GetValue())
	EndIf
	;Debug.MessageBox("D"+HH_Global_Old_Enchanting.GetValue())
EndEvent