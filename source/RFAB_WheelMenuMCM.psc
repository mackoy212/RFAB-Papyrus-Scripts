scriptName RFAB_WheelMenuMCM extends SKI_ConfigBase

;-- Properties --------------------------------------
shout[] property ShoutList auto
String[] property WheelMenuSpellsName auto
String[] property SpellListName auto
Bool property IsWheelMenuOpen auto
form[] property WheelMenuSpells auto
actor property Player auto
Int property HotKeyInt auto
form[] property SpellList auto

;-- Variables ---------------------------------------
uiwheelmenu RFAB_WheelMenu
String[] _optionText

;-- Functions ---------------------------------------

function ReloadWheel()

	Int i = 0
	while i < 8
		if Player.HasSpell(WheelMenuSpells[i])
			RFAB_WheelMenu.SetPropertyIndexString("optionLabelText", i, (i + 1) as String + " " + WheelMenuSpellsName[i])
			RFAB_WheelMenu.SetPropertyIndexString("optionText", i, " ")
			RFAB_WheelMenu.SetPropertyIndexBool("optionEnabled", i, true)
		else
			RFAB_WheelMenu.SetPropertyIndexString("optionLabelText", i, (i + 1) as String)
		endIf
		i += 1
	endWhile
	self.RegisterForModEvent("UIWheelMenu_ChooseOption", "OnChooseOption")
endFunction

function OnOptionMenuAccept(Int a_option, Int a_index)

	Int choice
	if a_option == 2
		choice = 0
	elseIf a_option == 3
		choice = 4
	elseIf a_option == 4
		choice = 1
	elseIf a_option == 5
		choice = 5
	elseIf a_option == 6
		choice = 2
	elseIf a_option == 7
		choice = 6
	elseIf a_option == 8
		choice = 3
	elseIf a_option == 9
		choice = 7
	endIf
	WheelMenuSpells[choice] = SpellList[a_index]
	WheelMenuSpellsName[choice] = SpellListName[a_index]
	self.SetMenuOptionValue(a_option, SpellListName[a_index], false)
	self.ReloadWheel()
endFunction

; Skipped compiler generated GotoState

function OnKeyDown(Int KeyCode)

	if KeyCode == HotKeyInt && !IsWheelMenuOpen
		IsWheelMenuOpen = true
		if input.IsKeyPressed(HotKeyInt)
			ui.OpenCustomMenu("wheelmenu", 0)
			RFAB_WheelMenu.UpdateWheelOptionLabels()
			RFAB_WheelMenu.UpdateWheelOptions()
			RFAB_WheelMenu.UpdateWheelEnabledOptions()
		endIf
	elseIf KeyCode == HotKeyInt && IsWheelMenuOpen as Bool
		ui.CloseCustomMenu()
		IsWheelMenuOpen = false
	elseIf KeyCode > 1 && KeyCode < 10 && IsWheelMenuOpen as Bool
		if Player.HasSpell((WheelMenuSpells[KeyCode - 2] as spell) as form)
			Player.EquipSpell(WheelMenuSpells[KeyCode - 2] as spell, 2)
		else
			Player.EquipShout(WheelMenuSpells[KeyCode - 2] as shout)
		endIf
		ui.CloseCustomMenu()
		IsWheelMenuOpen = false
	endIf
endFunction

function OnChooseOption(String eventName, String strArg, Float numArg, form formArg)
	if Player.HasSpell((WheelMenuSpells[numArg as Int] as spell) as form)
		Player.EquipSpell(WheelMenuSpells[numArg as Int] as spell, 2)
	endif
	Player.EquipShout(WheelMenuSpells[numArg as Int] as shout)
endFunction

function OnConfigInit()

	ModName = "RFAB WheelMenu"
	self.RegisterForKey(HotKeyInt)
	IsWheelMenuOpen = false
	Int i = 2
	while i < 10
		self.RegisterForKey(i)
		i += 1
	endWhile
	RFAB_WheelMenu = uiextensions.GetMenu("uiwheelmenu", true) as uiwheelmenu
	WheelMenuSpells = new form[8]
	WheelMenuSpellsName = new String[8]
	self.ReloadWheel()
endFunction

function OnKeyUp(Int KeyCode, Float holdTime)

	if KeyCode == HotKeyInt
		ui.CloseCustomMenu()
		IsWheelMenuOpen = false
	endIf
endFunction

function OnPageReset(String a_page)

	Int spellcount = Player.GetSpellCount()
	Int i = 0
	Int k = 0
	SpellList = new form[128]
	SpellListName = new String[128]
	while i < spellcount
		if Player.GetNthSpell(i).GetEquipType().GetNumParents() == 0
			SpellList[k] = Player.GetNthSpell(i) as form
			SpellListName[k] = SpellList[k].GetName()
			k += 1
		endIf
		i += 1
	endWhile
	i = 0
	while i < 27
		if Player.HasSpell(ShoutList[i] as form)
			SpellList[k] = ShoutList[i] as form
			SpellListName[k] = SpellList[k].GetName()
			k += 1
		endIf
		i += 1
	endWhile
	self.addkeymapoption("Горячая клавиша", HotKeyInt, 0)
	self.addemptyoption()
	self.AddMenuOption("Слот 1", WheelMenuSpellsName[0], 0)
	self.AddMenuOption("Слот 5", WheelMenuSpellsName[4], 0)
	self.AddMenuOption("Слот 2", WheelMenuSpellsName[1], 0)
	self.AddMenuOption("Слот 6", WheelMenuSpellsName[5], 0)
	self.AddMenuOption("Слот 3", WheelMenuSpellsName[2], 0)
	self.AddMenuOption("Слот 7", WheelMenuSpellsName[6], 0)
	self.AddMenuOption("Слот 4", WheelMenuSpellsName[3], 0)
	self.AddMenuOption("Слот 8", WheelMenuSpellsName[7], 0)
endFunction

; Skipped compiler generated GetState

function OnOptionKeyMapChange(Int a_option, Int a_keyCode, String a_conflictControl, String a_conflictName)

	self.unRegisterForKey(HotKeyInt)
	HotKeyInt = a_keyCode
	self.SetKeyMapOptionValue(a_option, a_keyCode, false)
	self.RegisterForKey(HotKeyInt)
endFunction

function OnOptionMenuOpen(Int a_option)

	self.SetMenuDialogOptions(SpellListName)
endFunction