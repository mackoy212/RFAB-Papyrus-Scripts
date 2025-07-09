Scriptname RFAB_MCM extends SKI_ConfigBase
{��������� RFAB MCM, � �������� ������ ��������, ���� ���-�� ����� ��� ������ ������� ������ �����-�� �������� � ��� ���� ���������}

import PO3_SKSEFunctions
import PapyrusIniManipulator

Actor Property Player Auto

RFAB_MCM_Alias Property Data Auto
{��������� ����������� ����������}

; �������
RFAB_DoomStoneMenu Property DoomStoneMenu Auto
{���� ������ ����������}
RFAB_DifficultyMenu Property DifficultyMenu Auto
{���� ���������}
RFAB_Menu Property Menu Auto
{������� ���� RFaB}

; ���������
RFAB_ResistWidget Property ResistWidget Auto
{������ ������������� � ��������}
RFAB_PlayerInfoWidget Property PlayerInfoWidget Auto
{������ ���, ����, �������, ���-�� ������ � �.�.}
RFAB_WeaponMagicEquip Property WeaponMagicEquip Auto
{������ �������������� ������, �����, ������}

; ������ �������
RFAB_DualWielding Property DualWielding Auto
{������������ � ����������� �� ��� ���}
RFAB_GlowingBooks Property GlowingBooks Auto
{��������� ����}
RFAB_Mounts Property Mounts Auto
{������� ��������}
RFAB_ExtendedHotkeys Property ExtendedHotkeys Auto
{������� �������}
RFAB_AutoLoot Property AutoLoot Auto
{�������}

GlobalVariable Property FollowerTeleportKey Auto
GlobalVariable Property JumpNPC Auto

bool IsBizarreActived = false
bool IsGodModeActive = false

Perk Property BlockSteal Auto
Perk Property BlockSitting Auto

int Property DodgeKey
	int Function Get()
		return PullIntFromIni("Data/SKSE/Plugins/[RFAB] Dodge.ini", "RFAB Dodge", "Key")
	EndFunction
	Function Set(int aiValue)
		PushIntToIni("Data/SKSE/Plugins/[RFAB] Dodge.ini", "RFAB Dodge", "Key", aiValue)
	EndFunction
EndProperty

int Key_FollowerTeleport = 48 ; B
int PlayerDoomStoneID

Event OnConfigInit()	
	ModName = " RFAB"
	Pages = new string[8]
	Pages[0] = "���������"
	Pages[1] = "������� ��������"
	Pages[2] = "���������� �����"
	Pages[3] = "����"
	Pages[4] = "���������"
	Pages[5] = "������� �������"
	Pages[6] = "�������"
	Pages[7] = "�����"
	if IsPluginFound("RFAB_BizarreAdventure.esp")
		IsBizarreActived = True
	endif
EndEvent

Event OnPageReset(string page)
	if (page == "")
		LoadCustomContent("RFAB\\logo.dds")
		return
	else
		UnloadCustomContent()
	endIf
	SetCursorFillMode(TOP_TO_BOTTOM)
	if page == "���������"
		ShowSettings()
	elseif page == "���������� �����"
		ShowGlowingBooks()
	elseif page == "������� ��������"
		ShowMounts()
	elseif page == "���������"
		ShowInterface()
	elseif page == "����"
		ShowExperience()
	elseif page == "������� �������"
		ShowHotkeys()
	elseif page == "�������"
		ShowAutoLoot()
	elseif page == "�����"
		ShowDebug()
	endif
Endevent

Event OnConfigOpen()
	IsGodModeActive = GetGodMode()
EndEvent

; ������� ================================================================================================================================
Function ShowAutoLoot()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("�������������� ����")
	AddHeaderOption("C��� ������� ��������")
	AddToggleOptionST("AutoLoot_LootByCloak", "�������������� ����", AutoLoot.LootByCloak)
	AddToggleOptionST("AutoLoot_LootByHotKey", "C��� ������� ��������", AutoLoot.LootByHotKey)
	AddToggleOptionST("AutoLoot_InCombat", "C��� � ���", AutoLoot.InCombat, EnableIf(AutoLoot.LootByCloak))
	AddKeyMapOptionST("AutoLoot_HotKey", "������� �������", AutoLoot.HotKey, EnableIf(AutoLoot.LootByHotKey))
	AddHeaderOption("����� ���������")
	AddHeaderOption("")
	AddToggleOptionST("AutoLoot_LootMisc", "������ ��������� ����� � �����������", AutoLoot.LootMisc)
	AddEmptyOption()
	AddToggleOptionST("AutoLoot_SaveBlessing", "�� ����� ����������� ��������", AutoLoot.SaveBlessing)
	AddEmptyOption()
	AddToggleOptionST("AutoLoot_OverWeight", "������������� ��������", AutoLoot.DisallowOverWeight)
	AddEmptyOption()

	AddMenuOptionST("AutoLoot_Method", "�������� �����", AutoLoot.Methods[AutoLoot.MethodID])
	if (AutoLoot.MethodID == 3) ; ���
		AddInputOptionST("AutoLoot_Value", "�������� ���� ����:", AutoLoot.Value)
	elseif (AutoLoot.MethodID == 2) ; ����
		AddInputOptionST("AutoLoot_Value", "�������� ���� ����:", AutoLoot.Value)
	elseif (AutoLoot.MethodID == 1) ; ����/���
		AddInputOptionST("AutoLoot_Value", "�������� ���� ����/��� ����:", AutoLoot.Value)
	else
		AddEmptyOption()
	endif
EndFunction

State AutoLoot_Method
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(AutoLoot.MethodID)
		SetMenuDialogOptions(AutoLoot.Methods)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		AutoLoot.MethodID = aiIndex
		SetMenuOptionValueST(AutoLoot.Methods[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		AutoLoot.MethodID = 0
		SetMenuOptionValueST(AutoLoot.Methods[0])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("�� ����� ���������� ����� ���� ���������.")
	EndEvent	
EndState

State AutoLoot_Value
	Event OnInputAcceptST(string asInput)
		AutoLoot.Value = asInput as int
		SetInputOptionValueST(AutoLoot.Value)
	EndEvent
	Event OnDefaultST()
		AutoLoot.Value = 0
		SetInputOptionValueST(AutoLoot.Value)
	EndEvent
EndState

State AutoLoot_SaveBlessing
	Event OnSelectST()
		AutoLoot.SaveBlessing = !AutoLoot.SaveBlessing
		SetToggleOptionValueST(AutoLoot.SaveBlessing)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������������� ���������, ������� ����� �������� � ������ �����������.")
	EndEvent
EndState

State AutoLoot_OverWeight
	Event OnSelectST()
		AutoLoot.DisallowOverWeight = !AutoLoot.DisallowOverWeight
		SetToggleOptionValueST(AutoLoot.DisallowOverWeight)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ����� ���������, ���� ��� �������� � ��������� ���������.")
	EndEvent
EndState

State AutoLoot_LootMisc
	Event OnSelectST()
		AutoLoot.LootMisc = !AutoLoot.LootMisc
		SetToggleOptionValueST(AutoLoot.LootMisc)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ ��������� ����� �������� � �����������, ���� ���� ��� �� ��������� ���������� �������.")
	EndEvent
EndState

State AutoLoot_LootByCloak
	Event OnSelectST()
		AutoLoot.LootByCloak = !AutoLoot.LootByCloak
		SetToggleOptionValueST(AutoLoot.LootByCloak)
		SetOptionFlagsST(DisableIf(!AutoLoot.LootByCloak), false, "AutoLoot_InCombat")
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� � ���������� ��������������� ������� ���������.")
	EndEvent
EndState

State AutoLoot_InCombat
	Event OnSelectST()
		AutoLoot.InCombat = !AutoLoot.InCombat
		SetToggleOptionValueST(AutoLoot.InCombat)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� � ���������� ������� ��������� �� ����� ���.")
	EndEvent
EndState

State AutoLoot_LootByHotKey
	Event OnSelectST()
		AutoLoot.LootByHotKey = !AutoLoot.LootByHotKey
		SetToggleOptionValueST(AutoLoot.LootByHotKey)
		SetOptionFlagsST(DisableIf(!AutoLoot.LootByHotKey), false, "AutoLoot_HotKey")
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� � ���������� ������� ��������� ��� ������� ������� �������.")
	EndEvent
EndState

State AutoLoot_HotKey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		AutoLoot.Hotkey = keyCode
		SetKeyMapOptionValueST(AutoLoot.Hotkey)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������� ������� ��������� � ��������� ������.")
	EndEvent
EndState

; ���� ==================================================================================================================================
Function ShowExperience()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("��������� ���� RFAB")
	AddHeaderOption("")
	AddInputOptionST("Menu_PositionX", "����� �� X", Menu.Offset_X)
	AddInputOptionST("Menu_PositionY", "����� �� Y", Menu.Offset_Y)
	AddInputOptionST("Menu_Scale", "������", Menu.Scale)
	AddColorOptionST("Menu_NoficationColor", "���� ��������� �����", Menu.NotificationColor)
	AddKeymapOptionST("Menu_Hotkey", "������� ������ ����", Menu.Hotkey)
EndFunction

State Menu_Hotkey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		Menu.Hotkey = keyCode
		SetKeyMapOptionValueST(Menu.Hotkey)
	EndEvent
	Event OnDefaultST()
		Menu.Hotkey = 35 ; H
		SetKeyMapOptionValueST(Menu.Hotkey)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������� ������ ���� RFAB.")
	EndEvent
EndState

State Menu_NoficationColor
	Event OnColorAcceptST(int color)
		Menu.NotificationColor = color
		SetColorOptionValueST(Menu.NotificationColor)
	EndEvent
	Event OnDefaultST()
		Menu.NotificationColor = 16777215
		SetColorOptionValueST(Menu.NotificationColor)
	EndEvent
EndState

State Menu_PositionX
	Event OnInputAcceptST(string asInput)
		Menu.Offset_X = asInput as int
		SetInputOptionValueST(Menu.Offset_X)
	EndEvent
	Event OnDefaultST()
		Menu.Offset_X = 0
		SetInputOptionValueST(Menu.Offset_X)
	EndEvent
	Event OnHighlightST()
		SetInfoText("����� ���� RFAB �� ��� X.")
	EndEvent	
EndState

State Menu_PositionY
	Event OnInputAcceptST(string asInput)
		Menu.Offset_Y = asInput as int
		SetInputOptionValueST(Menu.Offset_Y)
	EndEvent
	Event OnDefaultST()
		Menu.Offset_Y = 0
		SetInputOptionValueST(Menu.Offset_Y)
	EndEvent
	Event OnHighlightST()
		SetInfoText("����� ���� RFAB �� ��� Y.")
	EndEvent	
EndState

State Menu_Scale
	Event OnInputAcceptST(string asInput)
		Menu.Scale = asInput as int
		SetInputOptionValueST(Menu.Scale)
	EndEvent
	Event OnDefaultST()
		Menu.Scale = 100
		SetInputOptionValueST(Menu.Scale)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ ���� RFAB.")
	EndEvent	
EndState

; ��������� =============================================================================================================================
Function ShowInterface()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("������ �������������")
	AddHeaderOption("")
	AddInputOptionST("RW_PositionX", "��������� �� X", ResistWidget.X)
	AddInputOptionST("RW_PositionY", "��������� �� Y", ResistWidget.Y)
	AddInputOptionST("RW_Scale", "������ � ���������", ResistWidget.Scale)
	AddSliderOptionST("RW_Alpha", "��������������", ResistWidget.Alpha, "{0}%")
	AddMenuOptionST("RW_Rotation", "���������� �������", ResistWidget.RotationOptions[ResistWidget.RotationOptionID])
	AddMenuOptionST("RW_Color", "��������� �������", ResistWidget.ColorOptions[ResistWidget.ColorOptionID])

	AddHeaderOption("������ ���������� ������")
	AddHeaderOption("")
	AddMenuOptionST("PIW_State", "������� �������", PlayerInfoWidget.Sections[PlayerInfoWidget.SectionID])
	AddEmptyOption()
	AddInputOptionST("PIW_PositionX", "��������� �� X", PlayerInfoWidget.X)
	AddInputOptionST("PIW_PositionY", "��������� �� Y", PlayerInfoWidget.Y)
	AddInputOptionST("PIW_Scale", "������ � ���������", PlayerInfoWidget.Scale)
	AddSliderOptionST("PIW_Alpha", "��������������", PlayerInfoWidget.Alpha, "{0}%")

	AddHeaderOption("������ ��������������")
	AddHeaderOption("")
	AddInputOptionST("WME_PositionX", "��������� �� X", WeaponMagicEquip.X)
	AddInputOptionST("WME_PositionY", "��������� �� Y", WeaponMagicEquip.Y)
	AddInputOptionST("WME_Scale", "������ � ���������", WeaponMagicEquip.Scale)
	AddSliderOptionST("WME_Alpha", "��������������", WeaponMagicEquip.Alpha, "{0}%")
EndFunction

State WME_Scale
	Event OnInputAcceptST(string asInput)
		WeaponMagicEquip.Scale = asInput as int
		SetInputOptionValueST(WeaponMagicEquip.Scale)
	EndEvent
	Event OnDefaultST()
		WeaponMagicEquip.Scale = WeaponMagicEquip.Scale_Default
		SetInputOptionValueST(WeaponMagicEquip.Scale)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ � ���������.")
	EndEvent	
EndState

State WME_Alpha
	Event OnSliderAcceptST(float value)
		WeaponMagicEquip.Alpha = value as int
		SetSliderOptionValueST(value, "{0}%")
	EndEvent
	Event OnDefaultST()
		WeaponMagicEquip.Alpha = WeaponMagicEquip.Alpha_Default
		SetSliderOptionValueST(WeaponMagicEquip.Alpha, "{0}%")
	EndEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(WeaponMagicEquip.Alpha)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������������� ������� �������������� ������, ����� � ������.")
	EndEvent	
EndState

State WME_PositionY
	Event OnInputAcceptST(string asInput)
		WeaponMagicEquip.Y = asInput as int
		SetInputOptionValueST(WeaponMagicEquip.Y)
	EndEvent
	Event OnDefaultST()
		WeaponMagicEquip.Y = WeaponMagicEquip.Y_Default
		SetInputOptionValueST(WeaponMagicEquip.Y)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� Y.")
	EndEvent	
EndState

State WME_PositionX
	Event OnInputAcceptST(string asInput)
		WeaponMagicEquip.X = asInput as int
		SetInputOptionValueST(WeaponMagicEquip.X)
	EndEvent
	Event OnDefaultST()
		WeaponMagicEquip.X = WeaponMagicEquip.X_Default
		SetInputOptionValueST(WeaponMagicEquip.X)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� X.")
	EndEvent	
EndState

State PIW_State
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(PlayerInfoWidget.SectionID)
		SetMenuDialogOptions(PlayerInfoWidget.Sections)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		PlayerInfoWidget.SectionID = aiIndex
		SetMenuOptionValueST(PlayerInfoWidget.Sections[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		PlayerInfoWidget.SectionID = 0
		SetMenuOptionValueST(PlayerInfoWidget.Sections[0])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("������� ������� ���������� ������.")
	EndEvent	
EndState

State PIW_Scale
	Event OnInputAcceptST(string asInput)
		PlayerInfoWidget.Scale = asInput as int
		SetInputOptionValueST(PlayerInfoWidget.Scale)
	EndEvent
	Event OnDefaultST()
		PlayerInfoWidget.Scale = PlayerInfoWidget.Scale_Default
		SetInputOptionValueST(PlayerInfoWidget.Scale)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ � ���������.")
	EndEvent	
EndState

State PIW_Alpha
	Event OnSliderAcceptST(float value)
		PlayerInfoWidget.Alpha = value as int
		SetSliderOptionValueST(value, "{0}%")
	EndEvent
	Event OnDefaultST()
		PlayerInfoWidget.Alpha = PlayerInfoWidget.Alpha_Default
		SetSliderOptionValueST(PlayerInfoWidget.Alpha, "{0}%")
	EndEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(PlayerInfoWidget.Alpha)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������������� ������� ���������� ������.")
	EndEvent	
EndState

State PIW_PositionY
	Event OnInputAcceptST(string asInput)
		PlayerInfoWidget.Y = asInput as int
		SetInputOptionValueST(PlayerInfoWidget.Y)
	EndEvent
	Event OnDefaultST()
		PlayerInfoWidget.Y = PlayerInfoWidget.Y_Default
		SetInputOptionValueST(PlayerInfoWidget.Y)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� Y.")
	EndEvent	
EndState

State PIW_PositionX
	Event OnInputAcceptST(string asInput)
		PlayerInfoWidget.X = asInput as int
		SetInputOptionValueST(PlayerInfoWidget.X)
	EndEvent
	Event OnDefaultST()
		PlayerInfoWidget.X = PlayerInfoWidget.X_Default
		SetInputOptionValueST(PlayerInfoWidget.X)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� X.")
	EndEvent	
EndState

State RW_Color
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ResistWidget.ColorOptionID)
		SetMenuDialogOptions(ResistWidget.ColorOptions)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ResistWidget.ColorOptionID = aiIndex
		SetMenuOptionValueST(ResistWidget.ColorOptions[aiIndex])
	EndEvent
	Event OnDefaultST()
		ResistWidget.ColorOptionID = 1
		SetMenuOptionValueST(ResistWidget.ColorOptions[ResistWidget.ColorOptionID])
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������� ������� ������� �������������.")
	EndEvent	
EndState

State RW_Rotation
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ResistWidget.RotationOptionID)
		SetMenuDialogOptions(ResistWidget.RotationOptions)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ResistWidget.RotationOptionID = aiIndex
		SetMenuOptionValueST(ResistWidget.RotationOptions[aiIndex])
	EndEvent
	Event OnDefaultST()
		ResistWidget.RotationOptionID = 0
		SetMenuOptionValueST(ResistWidget.RotationOptions[ResistWidget.RotationOptionID])
	EndEvent
	Event OnHighlightST()
		SetInfoText("���������� ������� �������������.")
	EndEvent	
EndState

State RW_Alpha
	Event OnSliderAcceptST(float value)
		ResistWidget.Alpha = value as int
		SetSliderOptionValueST(value, "{0}%")
	EndEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(ResistWidget.Alpha)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnDefaultST()
		ResistWidget.Alpha = ResistWidget.Alpha_Default
		SetSliderOptionValueST(ResistWidget.Alpha, "{0}%")
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������������� ������� �������������.")
	EndEvent	
EndState

State RW_Scale
	Event OnInputAcceptST(string asInput)
		ResistWidget.Scale = asInput as int 
		SetInputOptionValueST(ResistWidget.Scale)
	EndEvent
	Event OnDefaultST()
		ResistWidget.Scale = ResistWidget.Scale_Default
		SetInputOptionValueST(ResistWidget.Scale)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ � ���������.")
	EndEvent	
EndState

State RW_PositionY
	Event OnInputAcceptST(string asInput)
		ResistWidget.Y = asInput as int
		SetInputOptionValueST(ResistWidget.Y)
	EndEvent
	Event OnDefaultST()
		ResistWidget.Y = ResistWidget.Y_Default
		SetInputOptionValueST(ResistWidget.Y)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� Y.")
	EndEvent	
EndState

State RW_PositionX
	Event OnInputAcceptST(string asInput)
		ResistWidget.X = asInput as int
		SetInputOptionValueST(ResistWidget.X)
	EndEvent
	Event OnDefaultST()
		ResistWidget.X = ResistWidget.X_Default
		SetInputOptionValueST(ResistWidget.X)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� �� X.")
	EndEvent	
EndState

; Extended Hotkeys =============================================================================================================================
Function ShowHotkeys()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("Extended Hotkeys")
	AddHeaderOption("")
	AddMenuOptionST("EHK_SpellPriorities", "��������� ���������� ����������", ExtendedHotkeys.SpellPriorities[ExtendedHotkeys.SpellPriorityID])
	AddMenuOptionST("EHK_ScrollPriorities", "��������� ���������� �������", ExtendedHotkeys.ScrollPriorities[ExtendedHotkeys.ScrollPriorityID])

	AddMenuOptionST("EHK_AllowDualWield", "���������� ������� ������ �������� ���������", ExtendedHotkeys.AllowDualWield[ExtendedHotkeys.AllowDualWieldID])
	AddMenuOptionST("EHK_DisallowUnequipShield", "��������� ������� ��� ������� ����������", ExtendedHotkeys.DisallowUnequipShield[ExtendedHotkeys.DisallowUnequipShieldID])
	AddKeymapOptionST("EHK_EmptyHandsHotkey", "������ ��� �� ���", ExtendedHotkeys.EmptyHandsHotkey)
EndFunction

State EHK_EmptyHandsHotkey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		ExtendedHotkeys.EmptyHandsHotkey = keyCode
		SetKeyMapOptionValueST(ExtendedHotkeys.EmptyHandsHotkey)
	EndEvent
	Event OnDefaultST()
		ExtendedHotkeys.EmptyHandsHotkey = 12
		SetKeyMapOptionValueST(ExtendedHotkeys.EmptyHandsHotkey)
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("������ ��� �� ���.")
	EndEvent
EndState

State EHK_DisallowUnequipShield
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ExtendedHotkeys.DisallowUnequipShieldID)
		SetMenuDialogOptions(ExtendedHotkeys.DisallowUnequipShield)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ExtendedHotkeys.DisallowUnequipShieldID = aiIndex
		SetMenuOptionValueST(ExtendedHotkeys.DisallowUnequipShield[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		ExtendedHotkeys.DisallowUnequipShieldID = 1
		SetMenuOptionValueST(ExtendedHotkeys.DisallowUnequipShield[1])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ������� ��� ������� ����������.")
	EndEvent	
EndState

State EHK_AllowDualWield
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ExtendedHotkeys.AllowDualWieldID)
		SetMenuDialogOptions(ExtendedHotkeys.AllowDualWield)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ExtendedHotkeys.AllowDualWieldID = aiIndex
		SetMenuOptionValueST(ExtendedHotkeys.AllowDualWield[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		ExtendedHotkeys.AllowDualWieldID = 1
		SetMenuOptionValueST(ExtendedHotkeys.AllowDualWield[1])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("���������� ������� ������ �������� ���������.")
	EndEvent	
EndState

State EHK_ScrollPriorities
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ExtendedHotkeys.ScrollPriorityID)
		SetMenuDialogOptions(ExtendedHotkeys.ScrollPriorities)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ExtendedHotkeys.ScrollPriorityID = aiIndex
		SetMenuOptionValueST(ExtendedHotkeys.ScrollPriorities[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		ExtendedHotkeys.ScrollPriorityID = 1
		SetMenuOptionValueST(ExtendedHotkeys.ScrollPriorities[1])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ���������� �������.")
	EndEvent	
EndState

State EHK_SpellPriorities
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(ExtendedHotkeys.SpellPriorityID)
		SetMenuDialogOptions(ExtendedHotkeys.SpellPriorities)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		ExtendedHotkeys.SpellPriorityID = aiIndex
		SetMenuOptionValueST(ExtendedHotkeys.SpellPriorities[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		ExtendedHotkeys.SpellPriorityID = 1
		SetMenuOptionValueST(ExtendedHotkeys.SpellPriorities[1])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ���������� �������.")
	EndEvent	
EndState

; ������� �������� ====================================================================================================================
Function ShowMounts()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("���������")
	AddHeaderOption("")
	AddKeyMapOptionST("MountsHotKey", "����� ������/������� ���������", Mounts.HotKey)
	AddToggleOptionST("MountsCarryWeightInName", "���������� ��� � �����", Mounts.IsShowWeightInName)
	AddSliderOptionST("MountsLoudness", "��������� ������", Mounts.Loudness * 100, "{0}%")
	AddToggleOptionST("MountsCarryWeightInMenu", "���������� ��� � ���������", Mounts.IsShowWeightInMenu)
	AddHeaderOption("��������������")
	AddHeaderOption("")
	AddTextOption("����������� ���", Mounts.MountCarryWeight)
	AddTextOption("��������", Mounts.MountSpeed - 50 + " %")
	AddInputOptionST("MountName", "���", Mounts.MountName)
EndFunction

State MountName
	Event OnInputAcceptST(string asInput)
		Mounts.MountName = asInput
		SetInputOptionValueST(Mounts.MountName)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��� �������� ���������, ���������������� �� ����.")
	EndEvent
EndState

State MountsLoudness
	Event OnSliderAcceptST(float value)
		Mounts.Loudness = value / 100
		SetSliderOptionValueST(value, "{0}%")
	EndEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Mounts.Loudness * 100)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
EndState

State MountsCarryWeightInMenu
	Event OnSelectST()
		Mounts.IsShowWeightInMenu = !Mounts.IsShowWeightInMenu
		SetToggleOptionValueST(Mounts.IsShowWeightInMenu)
	EndEvent
	Event OnHighlightST()
		SetInfoText("����������� ������������ ���� �������� ��������� � ��� ���������.")
	EndEvent
EndState

State MountsCarryWeightInName
	Event OnSelectST()
		Mounts.IsShowWeightInName = !Mounts.IsShowWeightInName
		SetToggleOptionValueST(Mounts.IsShowWeightInName)
	EndEvent
	Event OnHighlightST()
		SetInfoText("����������� ������������ ���� �������� ��������� � ��� �����.")
	EndEvent
EndState

State MountsHotKey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		Mounts.HotKey = keyCode
		SetKeyMapOptionValueST(Mounts.HotKey)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������, �� ������� �� ������� ������� ��������� �������� ���������, �������� � �������� ��� � ����.")
	EndEvent
EndState

; ��������� =============================================================================================================================
Function ShowSettings()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("������������ ���������")
	AddHeaderOption("")
	AddToggleOptionST("FastTravel", "������� �����������", Data.IsFastTravelAllowed)
	AddToggleOptionST("BlockSitting", "������������� ��� ������������� ���������", Player.HasPerk(BlockSitting))
	;AddToggleOptionST("JumpNPC", "������ ���", JumpNPC.GetValueInt() as bool)
	AddToggleOptionST("BlessingMessage", "����������� � �����������", Data.IsBlessingMessageOn)
	AddToggleOptionST("BlockSteal", "�������������� ��������� �����", Player.HasPerk(BlockSteal))

	AddHeaderOption("������� �������")
	AddHeaderOption("")
	AddKeyMapOptionST("BlockKey", "������� ������������", DualWielding.KeyBlock)
	AddKeyMapOptionST("FollowerTeleport", "������� ��������� ���������", Key_FollowerTeleport)
	AddKeyMapOptionST("ParryingKey", "������� �����������", DualWielding.KeyBash)
	AddKeyMapOptionST("DodgeKey", "������� �������", DodgeKey)
	
	AddHeaderOption("��������� ����")
	AddHeaderOption("")
	AddMenuOptionST("Difficulty", "������� ���������", DifficultyMenu.DifficultyNames[DifficultyMenu.DifficultyIndex], 0)
	AddToggleOptionST("Curse", "���������", DifficultyMenu.Cursed)
EndFunction

State Difficulty
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(DifficultyMenu.DifficultyIndex)
		SetMenuDialogOptions(DifficultyMenu.DifficultyNames)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		DifficultyMenu.SetDifficulty(aiIndex)
		SetMenuOptionValueST(DifficultyMenu.DifficultyNames[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnDefaultST()
		DifficultyMenu.SetDifficulty(0)
		SetMenuOptionValueST(DifficultyMenu.DifficultyNames[0])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText(DifficultyMenu.DifficultyInfo[DifficultyMenu.DifficultyIndex])
	EndEvent
EndState

State Curse
	Event OnSelectST()
		DifficultyMenu.SetCurse(!DifficultyMenu.Cursed)
		SetToggleOptionValueST(DifficultyMenu.Cursed)
	EndEvent
	Event OnHighlightST()
		SetInfoText("� ������ ������ �������� ��� �������� ������������� ������.\n�� �������� �������� �������� �����.")
	EndEvent
EndState

State FollowerTeleport
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		Key_FollowerTeleport = keyCode
		SetKeyMapOptionValueST(Key_FollowerTeleport)
		FollowerTeleportKey.SetValueInt(Key_FollowerTeleport)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������, �� ������� �� ������� ������ ������� � ���� ���������.")
	EndEvent
EndState

State BlockKey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		DualWielding.SetBlockKey(keyCode)
		SetKeyMapOptionValueST(keyCode)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������, �� ������� ������� �������� ������ ������ �����������, � ��� ����� ������ ������� � ������.")
	EndEvent
EndState

State ParryingKey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		DualWielding.SetBashKey(keyCode)
		SetKeyMapOptionValueST(keyCode)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������, �� ������� ������� �������� ������ ������ ����������, � ��� ����� ������ ������� � ������.")
	EndEvent
EndState

State DodgeKey
	Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
		DodgeKey = keyCode
		SetKeyMapOptionValueST(keyCode)
	EndEvent
	Event OnHighlightST()
		SetInfoText("�������, �� ������� ������� �������� ������ ������������ ������.")
	EndEvent
EndState

State BlessingMessage
	Event OnSelectST()
		Data.IsBlessingMessageOn = !Data.IsBlessingMessageOn
		SetToggleOptionValueST(Data.IsBlessingMessageOn)
	EndEvent
	Event OnHighlightST()
		SetInfoText("����������� � ������ � �������������� �����������.")
	EndEvent
EndState

State BlockSitting
	Event OnSelectST()
		bool bBlockSitting = Player.HasPerk(BlockSitting)
		if bBlockSitting
			Player.RemovePerk(BlockSitting)
		else
			Player.AddPerk(BlockSitting)
		endif
		SetToggleOptionValueST(!bBlockSitting)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��� ������������� �������/������/������� ��������� ���� � �������������� ������.")
	EndEvent
EndState

State BlockSteal
	Event OnSelectST()
		bool bBlockSteal = Player.HasPerk(BlockSteal)
		if bBlockSteal
			Player.RemovePerk(BlockSteal)
		else
			Player.AddPerk(BlockSteal)
		endif
		SetToggleOptionValueST(!bBlockSteal)
	EndEvent
	Event OnHighlightST()
		SetInfoText("������������� ��������� ����� � ����. �������� ������� ��� ��������� ����������.")
	EndEvent
EndState

State JumpNPC
	Event OnSelectST()
		bool bJumpOn = JumpNPC.GetValueInt() as Bool
		if bJumpOn
			JumpNPC.SetValueInt(0)
		else
			JumpNPC.SetValueInt(1)
		endif
		SetToggleOptionValueST(!bJumpOn)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� � ���������� �������� ������� � ���")
	EndEvent
EndState

State FastTravel
	Event OnSelectST()
		if (!IsBizarreActived || IsGodModeActive)
			Data.IsFastTravelAllowed = !Data.IsFastTravelAllowed
			SetToggleOptionValueST(Data.IsFastTravelAllowed)
		else
			debug.messagebox("������� ����������� ���������� � ������� ������ Bizarre Adventure")		    
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ����������� �������� ����������� �� �����. ���������� � ������� ������ Bizarre Adventure.")
	EndEvent
EndState

; ���������� ����� =============================================================================================================================
Function ShowGlowingBooks()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("��������� ����")
	AddHeaderOption("")

	AddToggleOptionST("BooksGlowingXP", "������������ ����� �����", GlowingBooks.Glowing_BookXP)
	AddColorOptionST("BooksColorXP", "���� ��������", GlowingBooks.Color_BookXP)

	AddToggleOptionST("BooksGlowingSpell", "������������ ���� ����������", GlowingBooks.Glowing_BookSpell)
	AddColorOptionST("BooksColorSpell", "���� ��������", GlowingBooks.Color_BookSpell)

	AddToggleOptionST("BooksGlowingQuest", "������������ ����� �������", GlowingBooks.Glowing_BookQuest)
	AddColorOptionST("BooksColorQuest", "���� ��������", GlowingBooks.Color_BookQuest)

	AddToggleOptionST("BooksGlowingDefault", "������������ ������� �����", GlowingBooks.Glowing_BookDefault)
	AddColorOptionST("BooksColorDefault", "���� ��������", GlowingBooks.Color_BookDefault)

	AddMenuOptionST("BookGlowTexture", "�������� ��������", GlowingBooks.TextureNames[GlowingBooks.GlowTextureID])
	AddSliderOptionST("BooksAlpha", "�������������� ��������", GlowingBooks.GlowingAlpha, "{0}%")
EndFunction

State BooksAlpha
	Event OnSliderAcceptST(float value)
		GlowingBooks.GlowingAlpha = value
		SetSliderOptionValueST(value, "{0}%")
	EndEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(GlowingBooks.GlowingAlpha)
		SetSliderDialogDefaultValue(GlowingBooks.GlowingAlpha)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
EndState

State BookGlowTexture
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(GlowingBooks.GlowTextureID)
		SetMenuDialogOptions(GlowingBooks.TextureNames)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		GlowingBooks.GlowTextureID = aiIndex
		SetMenuOptionValueST(GlowingBooks.TextureNames[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("����� �������� ����.")
	EndEvent
EndState

State BooksColorXP
	Event OnColorAcceptST(int color)
		SetColorOptionValueST(color)
		GlowingBooks.Color_BookXP = color
	EndEvent
EndState

State BooksColorSpell
	Event OnColorAcceptST(int color)
		SetColorOptionValueST(color)
		GlowingBooks.Color_BookSpell = color
	EndEvent
EndState

State BooksColorQuest
	Event OnColorAcceptST(int color)
		SetColorOptionValueST(color)
		GlowingBooks.Color_BookQuest = color
	EndEvent
EndState

State BooksColorDefault
	Event OnColorAcceptST(int color)
		SetColorOptionValueST(color)
		GlowingBooks.Color_BookDefault = color
	EndEvent
EndState

State BooksGlowingXP
	Event OnSelectST()
		bool BooksGlowing = JsonUtil.GetIntValue("RFAB_MCM_Settings.json", "books glowing xp")
		GlowingBooks.Glowing_BookXP = !BooksGlowing
		SetToggleOptionValueST(!BooksGlowing)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ����, �� ������ ������� �������� �������� ����.")
	EndEvent
EndState

State BooksGlowingSpell
	Event OnSelectST()
		bool BooksGlowing = JsonUtil.GetIntValue("RFAB_MCM_Settings.json", "books glowing spell")
		GlowingBooks.Glowing_BookSpell = !BooksGlowing
		SetToggleOptionValueST(!BooksGlowing)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ����� ����������.")
	EndEvent
EndState

State BooksGlowingQuest
	Event OnSelectST()
		bool BooksGlowing = JsonUtil.GetIntValue("RFAB_MCM_Settings.json", "books glowing quest")
		GlowingBooks.Glowing_BookQuest = !BooksGlowing
		SetToggleOptionValueST(!BooksGlowing)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ����, ��������� � ��������.")
	EndEvent
EndState

State BooksGlowingDefault
	Event OnSelectST()
		bool BooksGlowing = JsonUtil.GetIntValue("RFAB_MCM_Settings.json", "books glowing default")
		GlowingBooks.Glowing_BookDefault = !BooksGlowing
		SetToggleOptionValueST(!BooksGlowing)
	EndEvent
	Event OnHighlightST()
		SetInfoText("��������� ������� ����.")
	EndEvent
EndState

;�����======================================================================================
Function ShowDebug()
	AddHeaderOption("����� ���������")
	PlayerDoomStoneID = DoomStoneMenu.GetDoomStoneID()
	AddMenuOptionST("DoomStones", "������ ���������", DoomStoneMenu.DoomStoneNames[PlayerDoomStoneID], 0)
	if IsBizarreActived
		AddHeaderOption("Bizarre Adventure")
		Spell BizarreDebugSpell = Game.GetFormFromFile(0x161EDD28, "RFAB_BizarreAdventure.esp") as Spell
		AddToggleOptionST("BizarreDebug", "Debug spell", Player.HasSpell(BizarreDebugSpell))
	endif
EndFunction

State DoomStones
	Event OnMenuOpenST()
		SetMenuDialogStartIndex(PlayerDoomStoneID)
		SetMenuDialogOptions(DoomStoneMenu.DoomStoneNames)
	EndEvent
	Event OnMenuAcceptST(int aiIndex)
		DoomStoneMenu.SetDoomStoneByID(aiIndex)
		SetMenuOptionValueST(DoomStoneMenu.DoomStoneNames[aiIndex])
		ForcePageReset()
	EndEvent
	Event OnHighlightST()
		SetInfoText("����� ����� ��������� �������� ���������. ������������� �� ��� ������� ����.")
	EndEvent
EndState

State BizarreDebug
	Event OnSelectST()
		Spell BizarreDebugSpell = Game.GetFormFromFile(0x161EDD28, "RFAB_BizarreAdventure.esp") as Spell
		if Player.HasSpell(BizarreDebugSpell)
			Player.RemoveSpell(BizarreDebugSpell)
			SetToggleOptionValueST(false)
		else
			Player.AddSpell(BizarreDebugSpell)
			SetToggleOptionValueST(true)
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("����� � ����������� ������ Bizarre Adventure")
	EndEvent
EndState

; =========================================================================

; ��������� �������������� �����, ���� ������� �����
int Function DisableIf(bool abValue)
	if (abValue)
		return OPTION_FLAG_DISABLED
	endif 
	return 0
EndFunction

; �������� �������������� �����, ���� ������� ��������
int Function EnableIf(bool abValue)
	if (abValue)
		return 0
	endif 
	return OPTION_FLAG_DISABLED
EndFunction