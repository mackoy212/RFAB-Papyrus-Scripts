Scriptname RFAB_Script_PerksAlchemy extends Quest  

ObjectReference[] Property MerchantChests  Auto  

Perk[] Property AlchemyPerk  Auto  

GlobalVariable[] Property AlchemyGlobal  Auto  

function SetAlchemyVariable(int i)	
	AlchemyGlobal[i].SetValue(0)
	RFAB_PapyrusFunctions.UpdateVendors()
endfunction