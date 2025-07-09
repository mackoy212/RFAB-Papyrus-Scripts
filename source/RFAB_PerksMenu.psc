Scriptname RFAB_PerksMenu extends SKI_ConfigBase  

Actor Property Player Auto

RFAB_XP_Handler Property XP Auto

Formlist Property CurrentPerks Auto
Formlist Property Shouts Auto

string[] Skills
string[] SkillsNames

string[] CustomSkillsFiles
string[] CustomSkillsNames

string[] Resists
string[] ResistsNames

int[] PerksIDs
int[] ResistsIDs

string CustomSkillsPath = "Data/NetScriptFramework/plugins"

Event OnConfigInit()	
	ModName = " RFAB Perks Menu"
	UpdatePages()
EndEvent

Event OnPageReset(string page)
	UpdatePages()
	int iSkillID = SkillsNames.Find(page)
	if (iSkillID != - 1)
		ShowSkill(Skills[iSkillID])
		return
	endif
	iSkillID = CustomSkillsNames.Find(page)
	if (iSkillID != - 1)
		ShowCustomSkill(CustomSkillsFiles[iSkillID])
		return
	endif
	ShowMain()
Endevent

Function UpdatePages()
	InitResists()
	InitSkills()
	InitCustomSkills()

	Pages = new string[1]
	Pages[0] = "������ � ��������������"
	Pages = PapyrusUtil.MergeStringArray(Pages, SkillsNames)
	Pages = PapyrusUtil.MergeStringArray(Pages, CustomSkillsNames)		
EndFunction

Function ShowSkill(string asSkill)
	AddToggleOptionST("Skill_AddAllPerks", "������� ��� ������", false)
	AddToggleOptionST("Skill_RemoveAllPerks", "������ ��� ������", false)
	AddInputOptionST("Skill_Value", SkillsNames[Skills.Find(asSkill)], Player.GetActorValue(asSkill) as int)
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()

	CurrentPerks.Revert()
	ActorValueInfo.GetActorValueInfoByName(asSkill).GetPerkTree(CurrentPerks, None, false, true)

	int iPerksCounts = CurrentPerks.GetSize()
	PerksIDs = Utility.CreateIntArray(iPerksCounts)

	int i = 0
	while (i < iPerksCounts)
		Perk kPerk = CurrentPerks.GetAt(i) as Perk
		PerksIDs[i] = AddToggleOption(kPerk.GetName(), Player.HasPerk(kPerk))
		i += 1
	endwhile
EndFunction

Function ShowCustomSkill(string asPath)
	AddToggleOptionST("Skill_AddAllPerks", "������� ��� ������", false)
	AddToggleOptionST("Skill_RemoveAllPerks", "������ ��� ������", false)
	AddEmptyOption()
	AddEmptyOption()

	Form[] kPerks = GetFrameworkPerks(asPath)
	CurrentPerks.Revert()
	CurrentPerks.AddForms(kPerks)
	PerksIDs = Utility.CreateIntArray(kPerks.Length)

	int i = 0
	while (i < kPerks.Length)
		Perk kPerk = kPerks[i] as Perk
		PerksIDs[i] = AddToggleOption(kPerk.GetName(), Player.HasPerk(kPerk))
		i += 1
	endwhile
EndFunction

Form[] Function GetFrameworkPerks(string asPath)
	string sContent = MiscUtil.ReadFromFile(asPath)
	string[] sLines = PapyrusUtil.StringSplit(sContent, "\n")
	Form[] kPerks = new Form[128]

	int i = 1
	while (StringUtil.Find(sContent, "Node" + i) != -1)
		string sNextNode = "Node" + i

		string sFile = GetFrameworkValue(sLines, sNextNode + ".PerkFile")
		int iStart = StringUtil.Find(sFile, "\"") + 1
		int iEnd = StringUtil.Find(sFile, "\"", iStart)
		sFile = StringUtil.Substring(sFile, iStart, iEnd - 1)

		int iFormID = PO3_SKSEFunctions.StringToInt(GetFrameworkValue(sLines, sNextNode + ".PerkId"))

		kPerks[i - 1] = Game.GetFormFromFile(iFormID, sFile)
		i += 1
	endwhile
	return Utility.ResizeFormArray(kPerks, i - 1)
EndFunction

string Function GetFrameworkName(string asPath)
	string[] sLines = PapyrusUtil.StringSplit(MiscUtil.ReadFromFile(asPath), "\n")
	return GetFrameworkValue(sLines, "Name")
EndFunction

string Function GetFrameworkValue(string[] asLines, string asKey)
	string sSearched = asKey + " = " 
	int i = 0
	while (i < asLines.Length)
		int iStart = StringUtil.Find(asLines[i], sSearched)
		if (iStart != -1)
			return StringUtil.Substring(asLines[i], iStart + StringUtil.GetLength(sSearched))
		endif
		i += 1
	endwhile
EndFunction

Function ShowMain()
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("��������")
	AddHeaderOption("")
	AddSliderOptionST("Main_PlayerLevel", "�������", Player.GetLevel())
	AddSliderOptionST("Main_PlayerPerks", "���� �������", Game.GetPerkPoints())
	AddSliderOptionST("Main_DragonSouls", "���� ��������", Player.GetActorValue("DragonSouls") as int)
	AddInputOptionST("Main_Experience", "����", XP.PlayerXP.GetValueInt())
	AddToggleOptionST("DragonWords_AddAll", "�������� ��� �������� �����", false)
	AddEmptyOption()
	SetCursorFillMode(TOP_TO_BOTTOM)	
	ShowActorValues("��������", "Health", "HealRate", "HealRateMult")
	ShowActorValues("�����", "Magicka", "MagickaRate", "MagickaRateMult")
	ShowActorValues("����� ���","Stamina", "StaminaRate", "StaminaRateMult")
	SetCursorPosition(9)
	AddHeaderOption("��������������")
	ShowResists()	
EndFunction

Function ShowActorValues(string asHeader, string asName, string asRate, string asRateMult)
	AddHeaderOption(asHeader)
	AddInputOptionST("Main_" + asName + "_Add", "��������", (Player.GetActorValue(asName) - Player.GetBaseActorValue(asName)) as int)
	AddInputOptionST("Main_" + asName + "_Base", "�������", Player.GetBaseActorValue(asName) as int)
	AddInputOptionST("Main_" + asName + "_BaseRegen", "������� �����������", Player.GetActorValue(asRate))
	AddInputOptionST("Main_" + asName + "_PercentRegenBonus", "������� �������� �����������", Player.GetActorValue(asRateMult) as int)	
EndFunction

Function ShowResists()
	int i = 0
	while (i < Resists.Length)
		ResistsIDs[i] = AddInputOption(ResistsNames[i], Player.GetActorValue(Resists[i]) as int)
		i += 1
	endwhile
EndFunction

; ====================================================

State DragonWords_AddAll
	Event OnSelectST()
		SetToggleOptionValueST(true)
		int i = Shouts.GetSize()
		while (i > 0)
			i -= 1
			Shout kShout = Shouts.GetAt(i) as Shout
			Game.TeachWord(kShout.GetNthWordOfPower(0))
			Game.TeachWord(kShout.GetNthWordOfPower(1))
			Game.TeachWord(kShout.GetNthWordOfPower(2))
		endwhile
		ForcePageReset()
	EndEvent
EndState

; ====================================================

State Skill_AddAllPerks
	Event OnSelectST()
		SetToggleOptionValueST(true)
		int i = CurrentPerks.GetSize()
		while (i > 0)
			i -= 1
			Player.AddPerk(CurrentPerks.GetAt(i) as Perk)
		endwhile
		ForcePageReset()
	EndEvent
EndState

State Skill_RemoveAllPerks
	Event OnSelectST()
		SetToggleOptionValueST(true)
		int i = CurrentPerks.GetSize()
		while (i > 0)
			i -= 1
			Player.RemovePerk(CurrentPerks.GetAt(i) as Perk)
		endwhile
		ForcePageReset()
	EndEvent
EndState

State Skill_Value
	Event OnInputAcceptST(string asInput)
		string sActorValue = Skills[SkillsNames.Find(CurrentPage)]
		Player.SetActorValue(sActorValue, asInput as int)
		SetInputOptionValueST(Player.GetActorValue(sActorValue) as int)
	EndEvent
EndState

State Main_Experience
	Event OnInputAcceptST(string asInput)
		XP.ModXP(asInput as int - XP.PlayerXP.GetValueInt())
		SetInputOptionValueST(XP.PlayerXP.GetValueInt())
	EndEvent
EndState

State Main_DragonSouls
	Event OnSliderAcceptST(float afValue)
		int iValue = afValue as int
		Player.SetActorValue("DragonSouls", afValue)
		SetSliderOptionValueST(iValue)
	EndEvent
	Event OnSliderOpenST()
		int iValue = Player.GetActorValue("DragonSouls") as int
		SetSliderDialogStartValue(iValue)
		SetSliderDialogDefaultValue(iValue)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
EndState

State Main_PlayerPerks
	Event OnSliderAcceptST(float afValue)
		int iValue = afValue as int
		Game.SetPerkPoints(iValue)
		SetSliderOptionValueST(iValue)
	EndEvent
	Event OnSliderOpenST()
		int iValue = Game.GetPerkPoints()
		SetSliderDialogStartValue(iValue)
		SetSliderDialogDefaultValue(iValue)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
EndState

State Main_PlayerLevel
	Event OnSliderAcceptST(float afValue)
		int iValue = afValue as int
		Game.SetPlayerLevel(iValue)
		SetSliderOptionValueST(iValue)
	EndEvent
	Event OnSliderOpenST()
		int iValue = Player.GetLevel()
		SetSliderDialogStartValue(iValue)
		SetSliderDialogDefaultValue(iValue)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
EndState

State Main_Stamina_PercentRegenBonus
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("StaminaRateMult", asInput as int)
		SetInputOptionValueST(Player.GetActorValue("StaminaRateMult") as int)
	EndEvent
EndState

State Main_Magicka_PercentRegenBonus
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("MagickaRateMult", asInput as int)
		SetInputOptionValueST(Player.GetActorValue("MagickaRateMult") as int)
	EndEvent
EndState

State Main_Health_PercentRegenBonus
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("HealRateMult", asInput as int)
		SetInputOptionValueST(Player.GetActorValue("HealRateMult") as int)
	EndEvent
EndState

State Main_Stamina_BaseRegen
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("StaminaRate", asInput as float)
		SetInputOptionValueST(Player.GetActorValue("StaminaRate"))
	EndEvent
EndState

State Main_Magicka_BaseRegen
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("MagickaRate", asInput as float)
		SetInputOptionValueST(Player.GetActorValue("MagickaRate"))
	EndEvent
EndState

State Main_Health_BaseRegen
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("HealRate", asInput as float)
		SetInputOptionValueST(Player.GetActorValue("HealRate"))
	EndEvent
EndState

State Main_Stamina_Base
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("Stamina", asInput as int)
		SetInputOptionValueST(Player.GetBaseActorValue("Stamina") as int)
	EndEvent
EndState

State Main_Magicka_Base
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("Magicka", asInput as int)
		SetInputOptionValueST(Player.GetBaseActorValue("Magicka") as int)
	EndEvent
EndState

State Main_Health_Base
	Event OnInputAcceptST(string asInput)
		Player.SetActorValue("Health", asInput as int)
		SetInputOptionValueST(Player.GetBaseActorValue("Health") as int)
	EndEvent
EndState

State Main_Stamina_Add
	Event OnInputAcceptST(string asInput)
		ActorValueAdd("Stamina", asInput as int)
	EndEvent
EndState

State Main_Magicka_Add
	Event OnInputAcceptST(string asInput)
		ActorValueAdd("Magicka", asInput as int)
	EndEvent
EndState

State Main_Health_Add
	Event OnInputAcceptST(string asInput)
		ActorValueAdd("Health", asInput as int)
	EndEvent
EndState

Function ActorValueAdd(string asAV, int aiValue)
	Player.ModActorValue(asAV, aiValue - (Player.GetActorValue(asAV) - Player.GetBaseActorValue(asAV)) as int)
	SetInputOptionValueST((Player.GetActorValue(asAV) - Player.GetBaseActorValue(asAV)) as int)	
EndFunction

Event OnOptionInputAccept(int aiOption, string asInput)
	int iResistID = ResistsIDs.Find(aiOption)
	if (iResistID != -1)
		Player.ModActorValue(Resists[iResistID], (asInput as int) - Player.GetActorValue(Resists[iResistID]))
		SetInputOptionValue(aiOption, Player.GetActorValue(Resists[iResistID]) as int)
	endif
EndEvent

Event OnOptionSelect(int aiOption)
	int iPerkID = PerksIDs.Find(aiOption)
	if (iPerkID != -1)
		Perk kPerk = CurrentPerks.GetAt(iPerkID) as Perk
		bool bHasPerk = Player.HasPerk(kPerk)
		if (bHasPerk)
			Player.RemovePerk(kPerk)
		else
			Player.AddPerk(kPerk)
		endif
		SetToggleOptionValue(aiOption, !bHasPerk)
	endif
EndEvent

; ====================================================

Function InitSkills()
	Skills = new string[18]
	Skills[0]  = "Block"
	Skills[1]  = "HeavyArmor"
	Skills[2]  = "OneHanded"
	Skills[3]  = "Smithing"
	Skills[4]  = "TwoHanded"
	Skills[5]  = "Alteration"
	Skills[6]  = "Conjuration"
	Skills[7]  = "Destruction"
	Skills[8]  = "Enchanting"
	Skills[9]  = "Illusion"
	Skills[10] = "Restoration"
	Skills[11] = "Marksman"
	Skills[12] = "Alchemy"
	Skills[13] = "LightArmor"
	Skills[14] = "Lockpicking"
	Skills[15] = "Pickpocket"
	Skills[16] = "Sneak"
	Skills[17] = "Speechcraft"

	SkillsNames = new string[18]
	int i = 0
	while (i < Skills.Length)
		SkillsNames[i] = ActorValueInfo.GetActorValueInfoByName(Skills[i]).GetName()
		i += 1
	endwhile
EndFunction

Function InitCustomSkills()
	string[] sFiles = MiscUtil.FilesInFolder(CustomSkillsPath, ".txt")
	CustomSkillsFiles = Utility.CreateStringArray(sFiles.Length)

	int j = 0
	int i = 0
	while (i < sFiles.Length)
		if (StringUtil.Find(sFiles[i], "customskill") != -1)
			CustomSkillsFiles[j] = CustomSkillsPath + "/" + sFiles[i]
			j += 1
		endif
		i += 1
	endwhile

	CustomSkillsFiles = Utility.ResizeStringArray(CustomSkillsFiles, j)
	CustomSkillsNames = Utility.CreateStringArray(CustomSkillsFiles.Length)

	i = 0
	while (i < CustomSkillsFiles.Length)
		CustomSkillsNames[i] = GetFrameworkName(CustomSkillsFiles[i])
		i += 1
	endwhile
EndFunction

Function InitResists()
	Resists = new string[10]
	Resists[0] = "DamageResist"
	Resists[1] = "MagicResist"
	Resists[2] = "FireResist"
	Resists[3] = "FrostResist"
	Resists[4] = "ElectricResist"
	Resists[5] = "AbsorbChance"
	Resists[6] = "PoisonResist"
	Resists[7] = "DiseaseResist"
	Resists[8] = "SpeedMult"
	Resists[9] = "AlterationSkillAdvance"
	ResistsNames = new string[10]
	ResistsNames[0] = "�����"
	ResistsNames[1] = "������������� �����"
	ResistsNames[2] = "������������� ����"
	ResistsNames[3] = "������������� ������"
	ResistsNames[4] = "������������� �������������"
	ResistsNames[5] = "���� ���������� ����������"
	ResistsNames[6] = "������������� ����"
	ResistsNames[7] = "������������� ��������"
	ResistsNames[8] = "�������� ������������"
	ResistsNames[9] = "�������� ����������� ����������"
	ResistsIDs = new int[10]
EndFunction