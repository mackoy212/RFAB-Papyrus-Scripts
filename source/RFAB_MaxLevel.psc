Scriptname RFAB_MaxLevel extends ReferenceAlias  

import PO3_Events_Alias 
GlobalVariable Property MaxLevel Auto 

Event OnInit()
	RegisterForLevelIncrease(self as Alias)
EndEvent

Event OnPlayerLoadGame()
    RegisterForLevelIncrease(self as Alias)
EndEvent

Event OnLevelIncrease(int aiLevel)
	if aiLevel == MaxLevel.GetValueInt()
		Game.SetGameSettingFloat("fXPLevelUpMult", 9999999999999999999999)
		Game.SetGameSettingFloat("fXPLevelUpBase", 9999999999999999999999)
		UnregisterForLevelIncrease(self as Alias)
	endif
EndEvent