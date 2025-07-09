Scriptname zzzSXPConfig Extends SKI_ConfigBase Conditional
;=============================================================;
;Basic Properties
;=============================================================;
zzzSXPController Property XPC Auto
zzzSXPWorkerKillActor Property XPW Auto
zzzSXPGainExpStatPolling Property XPoll Auto
zzzSXPHelper Property XPH Auto
zzzSXPPAlias Property XPAlias Auto
zzzSXPMonitorMagicEffectAlias Property XPME Auto
Actor Property PlayerREF Auto

;=============================================================;
;Basic Variables
;=============================================================;
int[] skills
string[] stats
string[] names
int[] _TID_skill_
int[] _TID_skill_Slide_
int[] XPtoNextLevel
int[] MCMMenuOrder
int[] MCMMenuToggleOrder
string PlayerName
int[] SXPReadmeSID
string[] SXPReadme
int[] LvlUpMax
;=============================================================;
;General Page
;=============================================================;
int[] SXPGeneralSID
float[] Property SXPGeneral Auto Hidden
float[] SXPDefaultGeneral
string[] SXPGeneralStrings
string[] SXPGeneralHLStrings
string[] SXPGeneralDecimal
int SXPNotificationColor
bool SXPLockpickingFix
bool Property SXPActivated = True Auto Conditional
int Property PERK_COUNT = 0 Auto Hidden
;=============================================================;
;Misc Configure Page
;=============================================================;
int[] SXPGameStatsSID
int[] SXPDefaultGameStats
string[] SXPGameStatsStrings
string[] SXPGameStatsHLStrings
string[] SXPGameStatsHeaderStrings
bool Property SXPGameStatsContainerToggle Auto Hidden
;=============================================================;
;Toggle Page
;=============================================================;
int[] SXPToggleSID
string[] SXPToggleStrings
string[] SXPToggleHLStrings
;=============================================================;
;Actor Page
;=============================================================;
int[] SXPActorSID
float[] SXPDefaultActor
string[] SXPActorStrings
string[] SXPActorHLStrings
string[] SXPActorHeaderStrings
string[] SXPActorDecimal
;=============================================================;
;Leveling Page
;=============================================================;
int[] SXPLevelingSID
float[] SXPLeveling
float[] SXPDefaultLeveling
string[] SXPLevelingStrings
string[] SXPLevelingHLStrings
string[] SXPLevelingHeaderStrings
string[] SXPLevelingDecimal
int[] SXPSKillCaps
string[] SXPSkillCapString
int SXPSkillCapStringIndex
bool SXPLevelingHybridBonusToggle
;------ActionToGainLevel
int[] SXPActionToGainLevel
int SXPActionToGainLevelPrayKeyBind
bool SXPActionToGainLevelToggle
string SXPActionToGainLevelOrder
;=============================================================;
;Magic Effect Page
;=============================================================;
;------General
int[] SXPMagicEffectGeneralSID
float[] SXPMagicEffectGeneralDefault
string[] SXPMagicEffectGeneralStrings
string[] SXPMagicEffectGeneralHLStrings
string[] SXPMagicEffectGeneralDecimal
;------MagicEffects
int[] SXPMagicEffectSID
float[] Property SXPMagicEffectBonus Auto Hidden
string[] Property SXPMagicEffectBonusString Auto Hidden
float[] SXPMagicEffectDefault
string[] SXPMagicEffectHeaderStrings
string[] SXPMagicEffectStrings
string[] SXPMagicEffectHLStrings
int[] SXPMagicEffectHeaderIndex
;=============================================================;
;Compatibility Page
;=============================================================;
int[] SXPCompatibilitySID
float[] Property SXPCompatibility Auto Hidden
float[] SXPDefaultCompatibility
bool[] CompatibilityCheck
string[] SXPCompatiblityStrings
string[] SXPCompatibilityHeaderStrings
string[] SXPCompatibilityHLStrings
string[] SXPCompatibilityDecimal
bool Property PERMAToggle Auto Hidden
bool[] Property REQUIEMToggle Auto Hidden
int UIEXTKeyBind
bool IsPlayerInUIEXTMenu
string[] PUPreset
int[] PresetIndex
GlobalVariable[] SXPCompatibilitySliderGlobals
;=============================================================;
;No Rest For The Wicked
;=============================================================;
Message Property zzzSXPNRFTWDevilsTradeMessage Auto
int[] GetXPointArray
int ChekCounter1 = 0
int ChekCounter2 = 0
string sLanguage


Event OnConfigInit()
	
	((Self as Form) as UILIB_1).ShowNotification("$StartMessage1", "#FF0000")
	string Filename = "../SXP/PapyrusUtil/Preset 1.json"
	
	;debug.Trace("sLanguage = " + sLanguage)
	ModName = "A SXP"
	
	Pages = new String[10]
	Pages[0] = "$Page_General"
	Pages[1] = "$Page_Warrior"
	Pages[2] = "$Page_Mage"
	Pages[3] = "$Page_Thief"
	Pages[4] = "$Page_GameStats"
	Pages[5] = "$Page_Actor"
	Pages[6] = "$Page_Toggle"
	Pages[7] = "$Page_Leveling"
	;if JsonUtil.GetFloatValue(Filename, "magiceffect_polling interval") == 0.0
	;	Pages[8] = "$Page_Compatibility"
	;else
		Pages[8] = "$Page_MagicEffect"
		Pages[9] = "$Page_Compatibility"
	;endif
	
	stats = new string[18]
	stats[0] = "Block"
	stats[1] = "HeavyArmor"
	stats[2] = "OneHanded"
	stats[3] = "Smithing"
	stats[4] = "TwoHanded"
	stats[5] = "Alteration"
	stats[6] = "Conjuration"
	stats[7] = "Destruction"
	stats[8] = "Enchanting"
	stats[9] = "Illusion"
	stats[10] = "Restoration"
	stats[11] = "Marksman"
	stats[12] = "Alchemy"
	stats[13] = "LightArmor"
	stats[14] = "Lockpicking"
	stats[15] = "Pickpocket"
	stats[16] = "Sneak"
	stats[17] = "Speechcraft"
	
	if SXPActionToGainLevel.Length == 0
		SXPActionToGainLevel = new int[18]
	endif
	_TID_skill_Slide_ = new int[18]
	_TID_skill_ = new int[18]
	SXPReadmeSID = new int[2]
	LvlUpMax = new int[18]
	GetXPointArray = Utility.CreateIntArray(200)	;Массив для CreateMaxSkillLevelSlider
	
	SecurityWait()
	
	SetDefaultValuesGeneral()
	SetDefaultValuesGameStats()
	SetDefaultToggleGameStats()
	SetDefaultValuesActor()
	SetDefaultValuesLeveling()
	XPME.SetDefaultValuesMagicEffect()
	SetDefaultValuesCompatibility()
	
		;Вызов функций предзагрузки пресета, сами функции в конце	
		;-------Status
		MenugeneratorFloat_PreLoad(SXPGeneral.Length, SXPGeneralStrings, SXPGeneral, Filename)
		;-------Misc
		MenugeneratorInt_PreLoad(XPoll.SXPGameStats.Length, SXPGameStatsStrings, XPoll.SXPGameStats, Filename)
		;-------Actor
		MenugeneratorFloat_PreLoad(XPW.SXPActor.Length, SXPActorStrings, XPW.SXPActor, Filename)
		;-------Toggle
		MenugeneratorBool_PreLoad(XPC.SXPToggle.Length, SXPToggleStrings, XPC.SXPToggle, Filename)
		;-------Leveling
		MenugeneratorFloat_PreLoad(SXPLeveling.Length, SXPLevelingStrings, SXPLeveling, Filename)
		;MenugeneratorInt_PreLoad(SXPSKillCaps.Length, SXPLevelingStrings, SXPSKillCaps, Filename)
		;-------Magic Effects
		MenugeneratorFloat_PreLoad(XPME.SXPMagicEffectGeneral.Length, SXPMagicEffectGeneralStrings, XPME.SXPMagicEffectGeneral, Filename)		
		XPME.MenugeneratorFloat_PreLoad(Filename)		;отсылка в zzzsxpmonitormagiceffectalias.psc функция в конце скрипта
		;-------Compatibility
		MenugeneratorFloat_PreLoad(SXPCompatibility.Length, SXPCompatiblityStrings, SXPCompatibility, Filename)
		;-------Compatibility & Individual
		MenugeneratorIndividual_PreLoad(Filename)

		; Переключатель на дефолтную формулу расчета GetNextXP 
		; Проверяются ряд значений из пресета
		ChekPresetCreateGetXPointArray()
		
	MCMMenuOrder = new int[58]
	MCMMenuOrder[0] = 0
	MCMMenuOrder[1] = 1
	MCMMenuOrder[2] = 2
	MCMMenuOrder[3] = 3
	MCMMenuOrder[4] = 4
	MCMMenuOrder[5] = 5
	MCMMenuOrder[6] = 6
	MCMMenuOrder[7] = 7
	MCMMenuOrder[8] = 8
	MCMMenuOrder[9] = 9
	MCMMenuOrder[10] = 10
	MCMMenuOrder[11] = 11
	MCMMenuOrder[12] = 36
	MCMMenuOrder[13] = 42
	MCMMenuOrder[14] = 12
	MCMMenuOrder[15] = 13
	MCMMenuOrder[16] = 14
	MCMMenuOrder[17] = 15
	MCMMenuOrder[18] = 16
	MCMMenuOrder[19] = 17
	MCMMenuOrder[20] = 18
	MCMMenuOrder[21] = 19
	MCMMenuOrder[22] = 20
	MCMMenuOrder[23] = 21
	MCMMenuOrder[24] = 22
	MCMMenuOrder[25] = 23
	MCMMenuOrder[26] = 24
	MCMMenuOrder[27] = 25
	MCMMenuOrder[28] = 26
	MCMMenuOrder[29] = 43
	MCMMenuOrder[30] = 27
	MCMMenuOrder[31] = 28
	MCMMenuOrder[32] = 29
	MCMMenuOrder[33] = 30
	MCMMenuOrder[34] = 44
	MCMMenuOrder[35] = 55
	MCMMenuOrder[36] = 56
	MCMMenuOrder[37] = 45
	MCMMenuOrder[38] = 46
	MCMMenuOrder[39] = 47
	MCMMenuOrder[40] = 48
	MCMMenuOrder[41] = 49
	MCMMenuOrder[42] = 31
	MCMMenuOrder[43] = 32
	MCMMenuOrder[44] = 33
	MCMMenuOrder[45] = 37
	MCMMenuOrder[46] = 50
	MCMMenuOrder[47] = 51
	MCMMenuOrder[48] = 52
	MCMMenuOrder[49] = 57
	MCMMenuOrder[50] = 34
	MCMMenuOrder[51] = 35
	MCMMenuOrder[52] = 38
	MCMMenuOrder[53] = 41
	MCMMenuOrder[54] = 53
	MCMMenuOrder[55] = 54
	MCMMenuOrder[56] = 39
	MCMMenuOrder[57] = 40
	
	MCMMenuToggleOrder = new int[55]
	MCMMenuToggleOrder[0] = 0
	MCMMenuToggleOrder[1] = 1
	MCMMenuToggleOrder[2] = 2
	MCMMenuToggleOrder[3] = 3
	MCMMenuToggleOrder[4] = 4
	MCMMenuToggleOrder[5] = 5
	MCMMenuToggleOrder[6] = 6
	MCMMenuToggleOrder[7] = 7
	MCMMenuToggleOrder[8] = 8
	MCMMenuToggleOrder[9] = 9
	MCMMenuToggleOrder[10] = 10
	MCMMenuToggleOrder[11] = 11
	MCMMenuToggleOrder[12] = 36
	MCMMenuToggleOrder[13] = 42
	MCMMenuToggleOrder[14] = 12
	MCMMenuToggleOrder[15] = 13
	MCMMenuToggleOrder[16] = 14
	MCMMenuToggleOrder[17] = 15
	MCMMenuToggleOrder[18] = 16
	MCMMenuToggleOrder[19] = 17
	MCMMenuToggleOrder[20] = 18
	MCMMenuToggleOrder[21] = 19
	MCMMenuToggleOrder[22] = 20
	MCMMenuToggleOrder[23] = 21
	MCMMenuToggleOrder[24] = 22
	MCMMenuToggleOrder[25] = 23
	MCMMenuToggleOrder[26] = 24
	MCMMenuToggleOrder[27] = 25
	MCMMenuToggleOrder[28] = 26
	MCMMenuToggleOrder[29] = 43
	MCMMenuToggleOrder[30] = 27
	MCMMenuToggleOrder[31] = 28
	MCMMenuToggleOrder[32] = 29
	MCMMenuToggleOrder[33] = 30
	MCMMenuToggleOrder[34] = 44
	MCMMenuToggleOrder[35] = 45
	MCMMenuToggleOrder[36] = 46
	MCMMenuToggleOrder[37] = 47
	MCMMenuToggleOrder[38] = 48
	MCMMenuToggleOrder[39] = 49
	MCMMenuToggleOrder[40] = 31
	MCMMenuToggleOrder[41] = 32
	MCMMenuToggleOrder[42] = 33
	MCMMenuToggleOrder[43] = 37
	MCMMenuToggleOrder[44] = 50
	MCMMenuToggleOrder[45] = 51
	MCMMenuToggleOrder[46] = 52
	MCMMenuToggleOrder[47] = 34
	MCMMenuToggleOrder[48] = 35
	MCMMenuToggleOrder[49] = 38
	MCMMenuToggleOrder[50] = 41
	MCMMenuToggleOrder[51] = 53
	MCMMenuToggleOrder[52] = 54
	MCMMenuToggleOrder[53] = 39
	MCMMenuToggleOrder[54] = 40
			
EndEvent

Event OnConfigRegister()	
	XPC.GameInit()
	XPW.GameInit()
	XPoll.SetPollingInterval(SXPGeneral[3])
	XPH.GameInit()
	XPAlias.GameInit()
		
	GameReloaded()
	XPME.UpdateSkillEffects(false)
	PlayerBonusLevel()
	
	;Ѕлокировка "Enter" Skyrim Unbound до загрузки SXP
	if game.GetModbyName("Skyrim Unbound.esp") < 255
		SendModEvent("Unb_Wait_SXP", "", 10)
	endif
	
	((Self as Form) as UILIB_1).ShowNotification("$StartMessage2", "#19B271")
	
EndEvent

Function GameReloaded()
	CompatibilityMaintenance()
EndFunction

Event OnConfigOpen()
	if ChekSkill_Alt
		Skill_Alt = new bool[18]
		_Skill_Alt = new int[18]
		ChekSkill_Alt = false
	endif
	SkillZero.SetNthEntryValue(0, 0, 1.00)
	if SXPActivated
		XPME.UpdateSkillEffects(False)
		PlayerBonusLevel()
	endif
EndEvent

Perk Property SkillZero auto
Event OnConfigClose()
	SkillZero.SetNthEntryValue(0, 0, 0.00)
EndEvent

int _slider1
int _slider2
int _slider3
bool slider = true

Event OnPageReset( string s_page )
	
	UpdateSkills()
	if ( s_page == "" )
		LoadCustomContent( "SXP/sxp_logo.dds", 90.0, 230.0  )
		return
	else
		UnloadCustomContent()
	endif
	
	if !SXPActivated
		if ( s_page == "$Page_General" )
			SetCursorFillMode( TOP_TO_BOTTOM )
			AddHeaderOption("$Page_General")
			SXPGeneralSID[12] = AddTextOption("$General_12a", "$Click")
		endif
	else
	if ( s_page == "$Page_General" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		
		int i_current = XPC.GetXP() as int
		int next_pp = (SXPLeveling[7] + (( PERK_COUNT + 1 ) * SXPLeveling[8])) as Int
		
		AddHeaderOption("$Header_Status")

		AddTextOption( "$General_XP", i_current)
		AddTextOption( "$General_REST", XPC.GetRestPoint() as Int)
		
		AddEmptyOption()
		AddHeaderOption("$Header_Debug")
		SXPGeneralSID[10] = AddTextOption("$General_10", "$Click")
		SXPGeneralSID[11] = AddTextOption("$General_11", "$Click")
		SXPGeneralSID[12] = AddTextOption("$General_12", "$Click")
		
		SetCursorPosition(1)		
		AddHeaderOption("$Header_Option")
		SXPGeneralSID[0] = AddSliderOption("$General_0", (SXPGeneral[0] * 100.0), SXPGeneralDecimal[0])
		SXPGeneralSID[1] = AddSliderOption("$General_1", SXPGeneral[1], SXPGeneralDecimal[1])
		SXPGeneralSID[2] = AddSliderOption("$General_2", SXPGeneral[2], SXPGeneralDecimal[2])
		SXPGeneralSID[3] = AddSliderOption("$General_3", SXPGeneral[3], SXPGeneralDecimal[3])
		
		AddEmptyOption()
		AddHeaderOption("$Header_Rest")
		SXPGeneralSID[4] = AddSliderOption("$General_4", SXPGeneral[4], SXPGeneralDecimal[4])
		SXPGeneralSID[5] = AddSliderOption("$General_5", SXPGeneral[5], SXPGeneralDecimal[5])
		SXPGeneralSID[6] = AddSliderOption("$General_6", SXPGeneral[6], SXPGeneralDecimal[6])
		
		AddEmptyOption()
		AddHeaderOption("$Header_Customization")
		SXPGeneralSID[7] = AddColorOption("$General_7", SXPNotificationColor)
		SXPGeneralSID[8] = AddToggleOption("$General_8", SXPLockpickingFix)		
	elseif ( s_page == "$Page_Warrior" )
		SetCursorFillMode( TOP_TO_BOTTOM )		
		int i = 0
		int i_current = XPC.GetXP() as Int
		AddHeaderOption( "$Page_Warrior" )
		AddTextOption( "$Skill_0", "" + i_current )
		AddEmptyOption()
		if slider
			CreateMaxSkillLevelSlider(i, 5)
		endif
		While ( i < 5 )
			int i_next = XPtoNextLevel[i]
			SliderXpoint[i] = TotalXpoint - SliderXpointArray[skills[i] - 1]
			AddHeaderOption( names[i] )
			AddTextOption( "$Skill_1", CreateCurrentLevelString(i), OPTION_FLAG_DISABLED )
			AddTextOption(CreateProgressString(i, i_current, i_next, skills[i]), CreateNextXPString( i, i_next ), OPTION_FLAG_DISABLED )
			AddTextOption("$TotalXP", SliderXpoint[i], OPTION_FLAG_DISABLED)
			if ( i_current >= i_next ) && (skills[i] < SXPSKillCaps[i])
				_TID_Skill_[i] = AddToggleOption( "$Skill_3", False, GetOptionFlags(i_current,i_next) )
				if slider
				_TID_skill_Slide_[i] = AddSliderOption("$Skill_4", LvlUpMax[i])
				endif
			else
				AddEmptyOption()
			endif
			if ( i == 2 )
				SetCursorPosition( 7 )
			endif
			i += 1
		EndWhile
		SetCursorPosition(1)
		_slider1 = AddToggleOption("$DisableSlider", slider)
		;debug.trace("AddToggleOption1 = " + _slider1)
	elseif ( s_page == "$Page_Mage" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		
		int i = 5
		int i_current = XPC.GetXP() as Int
		AddHeaderOption( "$Page_Mage" )
		AddTextOption( "$Skill_0", "" + i_current )
		AddEmptyOption()
		if slider
			CreateMaxSkillLevelSlider(i, 11)
		endif
		While ( i < 11 )
			int i_next = XPtoNextLevel[i]
			SliderXpoint[i] = TotalXpoint - SliderXpointArray[skills[i] - 1]
			AddHeaderOption( names[i] )
			AddTextOption( "$Skill_1", CreateCurrentLevelString(i), OPTION_FLAG_DISABLED )
			AddTextOption(CreateProgressString(i, i_current, i_next, skills[i]), CreateNextXPString( i, i_next ), OPTION_FLAG_DISABLED )
			AddTextOption("$TotalXP", SliderXpoint[i], OPTION_FLAG_DISABLED)
			if ( i_current >= i_next ) && (skills[i] < SXPSKillCaps[i])
				_TID_Skill_[i] = AddToggleOption( "$Skill_3", False, GetOptionFlags(i_current,i_next) )
				if slider
				_TID_skill_Slide_[i] = AddSliderOption("$Skill_4", LvlUpMax[i])
				endif
			else
				AddEmptyOption()
			endif
			if ( i == 7 )
				SetCursorPosition( 7 )
			endif
			i += 1
		EndWhile
		SetCursorPosition(1)
		_slider2 = AddToggleOption("$DisableSlider", slider)
		;debug.trace("AddToggleOption2 = " + _slider2)
	elseif ( s_page == "$Page_Thief" )
		SetCursorFillMode( TOP_TO_BOTTOM )		
		int i = 11
		int i_current = XPC.GetXP() as Int
		AddHeaderOption( "$Page_Thief" )
		AddTextOption( "$Skill_0", "" + i_current )
		AddEmptyOption()
		if slider
			CreateMaxSkillLevelSlider(i, 18)
		endif
		While ( i < 18 )
			int i_next = XPtoNextLevel[i]
			SliderXpoint[i] = TotalXpoint - SliderXpointArray[skills[i] - 1]
			AddHeaderOption( names[i] )
			AddTextOption( "$Skill_1", CreateCurrentLevelString(i), OPTION_FLAG_DISABLED )
			AddTextOption(CreateProgressString(i, i_current, i_next, skills[i]), CreateNextXPString( i, i_next ), OPTION_FLAG_DISABLED )
			AddTextOption("$TotalXP", SliderXpoint[i], OPTION_FLAG_DISABLED)
			if ( i_current >= i_next ) && (skills[i] < SXPSKillCaps[i])
				_TID_Skill_[i] = AddToggleOption( "$Skill_3", False, GetOptionFlags(i_current,i_next) )
				if slider
				_TID_skill_Slide_[i] = AddSliderOption("$Skill_4", LvlUpMax[i])
				endif
			else
				AddEmptyOption()
			endif
			if ( i == 14 )
				SetCursorPosition( 7 )
			endif
			i += 1
		EndWhile
		SetCursorPosition(1)
		_slider3 = AddToggleOption("$DisableSlider", slider)
		;debug.trace("AddToggleOption3 = " + _slider3)	
	elseif ( s_page == "$Page_GameStats" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		int iIndex = 0
		int hIndex = 0
		int HeaderIndex = 0
		int iElement = XPoll.SXPGameStats.Length
		While iIndex < iElement
			if iIndex == 0 || iIndex == 14 || iIndex == 27 || iIndex == 29 || iIndex == 34 || iIndex == 46 || iIndex == 54 || iIndex == 56
				if iIndex == 27
					SetCursorPosition(1)
				elseif iIndex != 0
					AddEmptyOption()
				endif
					AddHeaderOption(SXPGameStatsHeaderStrings[HeaderIndex])
					HeaderIndex += 1
			endif
			if hIndex == 46 || hIndex == 55 || hIndex == 56 || hIndex == 57
				SXPGameStatsSID[hIndex] = AddSliderOption(SXPGameStatsStrings[hIndex], XPoll.SXPGameStats[hIndex], "{0} %")
			else
				SXPGameStatsSID[hIndex] = AddSliderOption(SXPGameStatsStrings[hIndex], XPoll.SXPGameStats[hIndex])
			endif
			iIndex += 1
			if iIndex < iElement
				hIndex = MCMMenuOrder[iIndex]
			endif
		EndWhile
		
		SXPGameStatsSID[iElement] = AddToggleOption(SXPGameStatsStrings[iElement], SXPGameStatsContainerToggle)
	elseif ( s_page == "$Page_Actor" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		int iIndex = 0
		int HeaderIndex = 0
		int iElement = XPW.SXPActor.Length
		While iIndex < iElement
			if iIndex == 0
				AddHeaderOption("$Read Me")
				SXPReadmeSID[0] = AddTextOption("$Read Me", "$Click")
				AddEmptyOption()
			endif
			if iIndex == 0 || iIndex == 5 || iIndex == 9 || iIndex == 29
				if iIndex == 9
					SetCursorPosition(1)
				elseif iIndex == 29
					SetCursorPosition(32)
				elseif iIndex != 0
					AddEmptyOption()
				endif
					AddHeaderOption(SXPActorHeaderStrings[HeaderIndex])
					HeaderIndex += 1
			endif
			SXPActorSID[iIndex] = AddSliderOption(SXPActorStrings[iIndex], XPW.SXPActor[iIndex], SXPActorDecimal[iIndex])
			iIndex += 1
		EndWhile
	elseif ( s_page == "$Page_Toggle" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		int iIndex = 0
		int hIndex = 0
		int HeaderIndex = 0
		int iElement = (XPC.SXPToggle.Length - 3)
		While iIndex < iElement
			if iIndex == 0 || iIndex == 14 || iIndex == 27 || iIndex == 29 || iIndex == 34 || iIndex == 44 || iIndex == 51 || iIndex == 53
				if iIndex == 27
					SetCursorPosition(1)
				elseif iIndex != 0
					AddEmptyOption()
				endif
					if iIndex == 0
						AddHeaderOption("")
						SXPToggleSID[57] = AddToggleOption(SXPToggleStrings[57], XPC.SXPToggle[57])
						AddEmptyOption()
						
						AddHeaderOption("$Header_Rest")
						SXPToggleSID[56] = AddToggleOption(SXPToggleStrings[56], XPC.SXPToggle[56])
						AddEmptyOption()
						
						AddHeaderOption(SXPGameStatsHeaderStrings[8])
						SXPToggleSID[55] = AddToggleOption(SXPToggleStrings[55], XPC.SXPToggle[55])
						AddEmptyOption()
					endif
					AddHeaderOption(SXPGameStatsHeaderStrings[HeaderIndex])
					HeaderIndex += 1
			endif
			SXPToggleSID[hIndex] = AddToggleOption(SXPToggleStrings[hIndex], XPC.SXPToggle[hIndex])
			iIndex += 1
			if iIndex < iElement
				hIndex = MCMMenuToggleOrder[iIndex]
			endif
		EndWhile
	elseif ( s_page == "$Page_Leveling" )		
		SetCursorFillMode( TOP_TO_BOTTOM )		
		int iIndex = 0
		int HeaderIndex = 0
		int iElement = SXPLeveling.Length
		While iIndex < iElement
			if iIndex == 0
				AddHeaderOption("$Read Me")
				SXPReadmeSID[1] = AddTextOption("$Read Me", "$Click")
				AddEmptyOption()
			endif
			if iIndex == 0 || iIndex == 2 || iIndex == 7 || iIndex == 9 || iIndex == 11
				if iIndex == 9
					SetCursorPosition(1)
				elseif iIndex != 0
					AddEmptyOption()
				endif
					AddHeaderOption(SXPLevelingHeaderStrings[HeaderIndex])
					HeaderIndex += 1
			endif
			if iIndex == 0 || iIndex == 1
				SXPLevelingSID[iIndex] = AddSliderOption(SXPLevelingStrings[iIndex], SXPLeveling[iIndex], SXPLevelingDecimal[iIndex])
			elseif iIndex == 10
				SXPLevelingSID[iIndex] = AddSliderOption(SXPLevelingStrings[iIndex], (SXPLeveling[iIndex] * 100.0), SXPLevelingDecimal[iIndex])
			else
				SXPLevelingSID[iIndex] = AddSliderOption(SXPLevelingStrings[iIndex], SXPLeveling[iIndex], SXPLevelingDecimal[iIndex])
			endif
			if iIndex == 10
				AddEmptyOption()
				AddHeaderOption(SXPLevelingHeaderStrings[HeaderIndex])
				SXPLevelingSID[15] = AddMenuOption(SXPLevelingStrings[15], SXPSkillCapString[SXPSkillCapStringIndex])
				AddEmptyOption()
				AddHeaderOption(SXPLevelingHeaderStrings[HeaderIndex + 1])
				SXPLevelingSID[16] = AddToggleOption(SXPLevelingStrings[16], SXPLevelingHybridBonusToggle)
				HeaderIndex += 2
			endif
			if iIndex == 12
				string[] sArray = FurnitureMarkerArray()
				SXPLevelingSID[13] = AddMenuOption(SXPLevelingStrings[13], sArray[XPH.FurnitureMarkerIndex])
				SXPLevelingSID[14] = AddKeyMapOption(SXPLevelingStrings[14], SXPActionToGainLevelPrayKeyBind)
			endif
			iIndex += 1
		EndWhile					
		if GetState() != "Default" && ChekCounter1 < 2				
			ShowMessage("$LevelingConfig")			
			ChekCounter1 += 1
		endif			
	elseif ( s_page == "$Page_MagicEffect" )
	SetCursorFillMode( TOP_TO_BOTTOM )
	AddHeaderOption("$Header_MagicEffect_General")
	SXPMagicEffectGeneralSID[0] = AddSliderOption(SXPMagicEffectGeneralStrings[0], XPME.SXPMagicEffectGeneral[0], SXPMagicEffectGeneralDecimal[0])
	SXPMagicEffectGeneralSID[1] = AddSliderOption(SXPMagicEffectGeneralStrings[1], (XPME.SXPMagicEffectGeneral[1] * 100), SXPMagicEffectGeneralDecimal[1])
	SXPMagicEffectGeneralSID[2] = AddSliderOption(SXPMagicEffectGeneralStrings[2], (XPME.SXPMagicEffectGeneral[2] * 100), SXPMagicEffectGeneralDecimal[2])
	
	AddEmptyOption()
	int iIndex = 0
	int HeaderIndex = 0
	int iElement = SXPMagicEffectSID.Length
	int iSecondHalf = Math.Floor(iElement / 2)
		While iIndex < iElement
			if iIndex == SXPMagicEffectHeaderIndex[HeaderIndex]
				if iIndex >= iSecondHalf
					SetCursorPosition(1)
					iSecondHalf = iElement
				elseif iIndex != 0
					AddEmptyOption()
				endif
				AddHeaderOption(SXPMagicEffectHeaderStrings[HeaderIndex])
				HeaderIndex += 1
			endif
			SXPMagicEffectSID[iIndex] = AddSliderOption(SXPMagicEffectStrings[iIndex], (XPME.SXPMagicEffect[iIndex] * 100), "{0} %")
			iIndex += 1
		EndWhile
		if GetState() != "Default" && ChekCounter2 < 2	
			ShowMessage("$MagicEffects")							
			ChekCounter2 += 1
		endif
	elseif ( s_page == "$Page_Compatibility" )
		SetCursorFillMode( TOP_TO_BOTTOM )
		
		int[] Position = new int[6]
		Position[0] = 0
		Position[1] = 5
		Position[2] = 10
		Position[3] = 11
		Position[4] = 12
		
		
		int iIndex = 0
		int iElement = SXPCompatibilityHeaderStrings.Length
		While iIndex < iElement
			if iIndex == 2
				SetCursorPosition(1)
			elseif iIndex != 0
				AddEmptyOption()
			endif
			AddHeaderOption(SXPCompatibilityHeaderStrings[iIndex])
			if CompatibilityCheck[iIndex] == True
				if iIndex == 0
					SXPCompatibilitySID[0] = AddSliderOption(SXPCompatiblityStrings[0], SXPCompatibility[0], SXPCompatibilityDecimal[0])
					SXPCompatibilitySID[1] = AddSliderOption(SXPCompatiblityStrings[1], SXPCompatibility[1], SXPCompatibilityDecimal[1])
					SXPCompatibilitySID[2] = AddSliderOption(SXPCompatiblityStrings[2], SXPCompatibility[2], SXPCompatibilityDecimal[2])
					SXPCompatibilitySID[3] = AddSliderOption(SXPCompatiblityStrings[3], SXPCompatibility[3], SXPCompatibilityDecimal[3])
					SXPCompatibilitySID[4] = AddSliderOption(SXPCompatiblityStrings[4], SXPCompatibility[4], SXPCompatibilityDecimal[4])
					SXPCompatibilitySID[14] = AddToggleOption(SXPCompatiblityStrings[14], PERMAToggle)
				elseif iIndex == 1
					SXPCompatibilitySID[5] = AddSliderOption(SXPCompatiblityStrings[5], SXPCompatibility[5], SXPCompatibilityDecimal[5])
					SXPCompatibilitySID[6] = AddSliderOption(SXPCompatiblityStrings[6], SXPCompatibility[6], SXPCompatibilityDecimal[6])
					SXPCompatibilitySID[7] = AddToggleOption(SXPCompatiblityStrings[7], REQUIEMToggle[0])
					SXPCompatibilitySID[8] = AddToggleOption(SXPCompatiblityStrings[8], REQUIEMToggle[1])
					SXPCompatibilitySID[9] = AddToggleOption(SXPCompatiblityStrings[9], REQUIEMToggle[2])
				elseif iIndex == 2
					SXPCompatibilitySID[10] = AddKeyMapOption(SXPCompatiblityStrings[10], UIEXTKeyBind)
				elseif iIndex == 3
					AddTextOption(SXPCompatibilityHeaderStrings[iIndex], "$Active", 1)
				
				elseif iIndex == 4
					SXPCompatibilitySID[11] = AddMenuOption(SXPCompatiblityStrings[11], PUPreset[PresetIndex[0]])
					SXPCompatibilitySID[12] = AddMenuOption(SXPCompatiblityStrings[12], PUPreset[PresetIndex[0]])
					SXPCompatibilitySID[13] = AddMenuOption(SXPCompatiblityStrings[13], PUPreset[PresetIndex[1]])
				endif
			else
				SXPCompatibilitySID[Position[iIndex]] = AddTextOption(SXPCompatibilityHeaderStrings[iIndex], "$Not Installed", 1)
			endif
			iIndex += 1
		EndWhile
		AddEmptyOption()
		AddHeaderOption("$Skill_Alt")
		int i = 0
		while i < 18
			_Skill_Alt[i] = AddToggleOption(names[i], Skill_Alt[i])
			i += 1
		endwhile
	endif
	endif
EndEvent

Event OnOptionDefault(int option)
	
	if ( CurrentPage == "$Page_General" )
		int index = SXPGeneralSID.Find(option)
		if option == SXPGeneralSID[7]
			SXPNotificationColor = 0xFFFFFF
			XPC.SXPNotificationColorString = "#FFFFFF"
			SetColorOptionValue(option, SXPNotificationColor)
		elseif option == SXPGeneralSID[8]
			if !SXPLockpickingFix
				if !ShowMessage("$General_Message_1", true, "$Yes", "$No")
					return
				endif
			endif
			SXPLockpickingFix = True
			SetToggleOptionValue(option, SXPLockpickingFix)
		elseif index >= 0 && index <= 6
			MCMBrowserSliderOpenFloat(SXPGeneralSID, option, SXPGeneral, SXPDefaultGeneral, SXPGeneralDecimal, "Default")
		endif
	elseif ( CurrentPage == "$Page_GameStats" )
		if option == SXPGameStatsSID[58]
			SXPGameStatsContainerToggle = False
			SetToggleOptionValue(option, SXPGameStatsContainerToggle)
		else
			MCMBrowserSliderOpenInt(SXPGameStatsSID, option, XPoll.SXPGameStats, SXPDefaultGameStats, "Default")
		endif
	elseif ( CurrentPage == "$Page_Actor" )
		MCMBrowserSliderOpenFloat(SXPActorSID, option, XPW.SXPActor, SXPDefaultActor, SXPActorDecimal, "Default")
	elseif ( CurrentPage == "$Page_Toggle" )
		MCMBrowserToggle(SXPToggleSID, option, XPC.SXPToggle, "Default")
	elseif ( CurrentPage == "$Page_Leveling" )
		if option == SXPLevelingSID[13]
			string[] sArray = FurnitureMarkerArray()
			XPH.FurnitureMarkerIndex = XPH.FurnitureMarker.Length
			SetMenuOptionValue(option, sArray[XPH.FurnitureMarkerIndex])
		elseif option == SXPLevelingSID[14]
			UnregisterForKey(SXPActionToGainLevelPrayKeyBind)
			SXPActionToGainLevelPrayKeyBind = -1
			SetKeymapOptionValue(option, SXPActionToGainLevelPrayKeyBind)
		elseif option == SXPLevelingSID[15]
			int iIndex = 0
			int iElement = SXPSKillCaps.Length
			While iIndex < iElement
				SXPSKillCaps[iIndex] = 100
				SXPSkillCapString[iIndex] = names[iIndex] + ": " + SXPSKillCaps[iIndex]
				iIndex += 1
			EndWhile
			SXPSkillCapStringIndex = 0
			SetMenuOptionValue(option, SXPSkillCapString[SXPSkillCapStringIndex])
		elseif option == SXPLevelingSID[16]
			SXPLevelingHybridBonusToggle = False
			SetToggleOptionValue(option, SXPLevelingHybridBonusToggle)
		else
			MCMBrowserSliderOpenFloat(SXPLevelingSID, option, SXPLeveling, SXPDefaultLeveling, SXPLevelingDecimal, "Default")
		endif
		UpdateSkills()
		ForcePageReset()
	elseif ( CurrentPage == "$Page_MagicEffect" )
		MCMBrowserSliderMagicEffect(SXPMagicEffectSID, option, XPME.SXPMagicEffect, SXPMagicEffectDefault, SXPMagicEffectHLStrings, "Default")
	elseif ( CurrentPage == "$Page_Compatibility" )
		int index = SXPCompatibilitySID.Find(option)
		if index < 7
			MCMBrowserSliderOpenFloat(SXPCompatibilitySID, option, SXPCompatibility, SXPDefaultCompatibility, SXPCompatibilityDecimal, "Default")
		elseif index < 10
			MCMBrowserToggle(SXPCompatibilitySID, option, REQUIEMToggle, "Default")
		elseif index == 10
			UnregisterForKey(UIEXTKeyBind)
			UIEXTKeyBind = -1
			SetKeymapOptionValue(option, UIEXTKeyBind)
		elseif index == 14
			PERMAToggle = True
			PERMAMiscExpGain()
			SetToggleOptionValue(option, PERMAToggle)
		elseif index < 13
			
			SetMenuOptionValue(option, PUPreset[0])
			PresetIndex[index - 11] = 0
		endif
	endif
	
EndEvent

Event OnOptionHighlight(int a_option)
	if ( CurrentPage == "$Page_General" )
		MCMBrowserHL(SXPGeneralSID, a_option, SXPGeneralHLStrings)
	elseif ( CurrentPage == "$Page_GameStats" )
		MCMBrowserHL(SXPGameStatsSID, a_option, SXPGameStatsHLStrings)
	elseif ( CurrentPage == "$Page_Actor" )
		MCMBrowserHL(SXPActorSID, a_option, SXPActorHLStrings)
	elseif ( CurrentPage == "$Page_Toggle" )
		MCMBrowserHL(SXPToggleSID, a_option, SXPGameStatsHLStrings)
	elseif ( CurrentPage == "$Page_Leveling" )
		MCMBrowserHL(SXPLevelingSID, a_option, SXPLevelingHLStrings)
	elseif ( CurrentPage == "$Page_MagicEffect" )
		MCMBrowserSliderMagicEffect(SXPMagicEffectSID, a_option, XPME.SXPMagicEffect, SXPMagicEffectDefault, SXPMagicEffectHLStrings, "HighLight")
	elseif ( CurrentPage == "$Page_Compatibility" )
		MCMBrowserHL(SXPCompatibilitySID, a_option, SXPCompatibilityHLStrings)
		if a_option > 2584
			SetInfoText("$Skill_Alt2")
		endif
		;debug.trace("a_option = " + a_option)
	endif
EndEvent

Event OnOptionSliderOpen( int sid )
	if ( CurrentPage == "$Page_General" )
		MCMBrowserSliderOpenFloat(SXPGeneralSID, sid, SXPGeneral, SXPDefaultGeneral, SXPGeneralDecimal)
	elseif ( CurrentPage == "$Page_Warrior" )
		MCMBrowserSliderOpenStatsInt(_TID_skill_Slide_, sid)	
	elseif ( CurrentPage == "$Page_Mage" )
		MCMBrowserSliderOpenStatsInt(_TID_skill_Slide_, sid)	
	elseif ( CurrentPage == "$Page_Thief" )
		MCMBrowserSliderOpenStatsInt(_TID_skill_Slide_, sid)
	elseif ( CurrentPage == "$Page_GameStats" )
		MCMBrowserSliderOpenInt(SXPGameStatsSID, sid, XPoll.SXPGameStats, SXPDefaultGameStats)
	elseif ( CurrentPage == "$Page_Actor" )
		MCMBrowserSliderOpenFloat(SXPActorSID, sid, XPW.SXPActor, SXPDefaultActor, SXPActorDecimal)
	elseif ( CurrentPage == "$Page_Leveling" )
		MCMBrowserSliderOpenFloat(SXPLevelingSID, sid, SXPLeveling, SXPDefaultLeveling, SXPLevelingDecimal)
	elseif ( CurrentPage == "$Page_MagicEffect" )
		MCMBrowserSliderMagicEffect(SXPMagicEffectSID, sid, XPME.SXPMagicEffect, SXPMagicEffectDefault, SXPMagicEffectHLStrings, "SliderOpen")
	elseif ( CurrentPage == "$Page_Compatibility" )
		MCMBrowserSliderOpenFloat(SXPCompatibilitySID, sid, SXPCompatibility, SXPDefaultCompatibility, SXPCompatibilityDecimal)
	endif
EndEvent

Event OnOptionSliderAccept( int sid, float value )
	if ( CurrentPage == "$Page_General" )
		MCMBrowserSliderAccept(SXPGeneralSID, sid, SXPGeneral, SXPGeneralDecimal, value)
	elseif ( CurrentPage == "$Page_Warrior" )
		MCMBrowserSliderStatsAccept(_TID_skill_Slide_, sid, value)
	elseif ( CurrentPage == "$Page_Mage" )
		MCMBrowserSliderStatsAccept(_TID_skill_Slide_, sid, value)
	elseif ( CurrentPage == "$Page_Thief" )
		MCMBrowserSliderStatsAccept(_TID_skill_Slide_, sid, value)
	elseif ( CurrentPage == "$Page_GameStats" )
		MCMBrowserSliderAccept(SXPGameStatsSID, sid, SXPGeneral, SXPGeneralDecimal, value)
	elseif ( CurrentPage == "$Page_Actor" )
		MCMBrowserSliderAccept(SXPActorSID, sid, XPW.SXPActor, SXPActorDecimal, value)
	elseif ( CurrentPage == "$Page_Leveling" )
		MCMBrowserSliderAccept(SXPLevelingSID, sid, SXPLeveling, SXPLevelingDecimal, value)
		UpdateSkills()
	elseif ( CurrentPage == "$Page_MagicEffect" )
		MCMBrowserSliderMagicEffect(SXPMagicEffectSID, sid, XPME.SXPMagicEffect, SXPMagicEffectDefault, SXPMagicEffectHLStrings, "SliderAccept", value)
	elseif ( CurrentPage == "$Page_Compatibility" )
		MCMBrowserSliderAccept(SXPCompatibilitySID, sid, SXPCompatibility, SXPCompatibilityDecimal, value)
	endif
EndEvent

Event OnOptionSelect( int tid )
	MCMBrowserShowReadme(tid, CurrentPage)
	if ( CurrentPage == "$Page_General" )
		if tid == SXPGeneralSID[8]
			if !ShowMessage("$General_Message_1", true, "$Yes", "$No")
				return
			endif
			SXPLockpickingFix = !SXPLockpickingFix
			SetToggleOptionValue(tid, SXPLockpickingFix)
		elseif tid == SXPGeneralSID[9]
			if !ShowMessage("$General_Message_0{ " + XPC.GV_StoredXP as int + "." + "\n\n}", true, "$Yes", "$No")
				return
			endif
			XPC.GV_XP.SetValue(XPC.GetXP() + XPC.GV_StoredXP)
			XPC.GV_StoredXP = 0
			UpdateSkills()
			ForcePageReset()
		elseif tid == SXPGeneralSID[10]
			if !ShowMessage("$General_Message_2", true, "$Yes", "$No")
				return
			endif
			SetDefaultValuesGeneral()
			SetDefaultValuesGameStats()
			SetDefaultToggleGameStats()
			SetDefaultValuesActor()
			SetDefaultValuesLeveling()
			;XPME.SetDefaultValuesMagicEffect()
			SetDefaultValuesCompatibility()			
			UI.InvokeBool("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu", false)
			ChekPresetCreateGetXPointArray()
			((Self as Form) as UILIB_1).ShowNotification("Default profile is loaded", "#19B271")
		elseif tid == SXPGeneralSID[11]
			ClearAccumulatedXP()
		elseif tid == SXPGeneralSID[12]
			if !ShowMessage("$General_Message_4_" + SXPActivated as string, true, "$Yes", "$No")
				return
			endif
			SXPActivated = !SXPActivated
			DeactivateSXP(SXPActivated)
		elseif tid == SXPGeneralSID[13]
			ConvertToPerkPoint()
			ForcePageReset()
		endif
	elseif (CurrentPage == "$Page_Warrior")
		if tid == _slider1
			slider = !slider
			SetToggleOptionValue(tid, slider)
			ForcePageReset()
		endif
		int i = 0
		while ( i < 18 )
			if ( tid == _TID_skill_[i] )				
				PurchaseSkill( i )
				ForcePageReset()
				return
			endif
			i += 1
		endwhile
	elseif (CurrentPage == "$Page_Mage")
		if tid == _slider2
			slider = !slider
			SetToggleOptionValue(tid, slider)
			ForcePageReset()
		endif
		int i = 0
		while ( i < 18 )
			if ( tid == _TID_skill_[i] )				
				PurchaseSkill( i )
				ForcePageReset()
				return
			endif
			i += 1
		endwhile
	elseif (CurrentPage == "$Page_Thief")
		if tid == _slider3
			slider = !slider
			SetToggleOptionValue(tid, slider)
			ForcePageReset()
		endif
		int i = 0
		while ( i < 18 )
			if ( tid == _TID_skill_[i] )				
				PurchaseSkill( i )
				ForcePageReset()
				return
			endif
			i += 1
		endwhile	
	elseif ( CurrentPage == "$Page_GameStats" )
		SXPGameStatsContainerToggle = !SXPGameStatsContainerToggle
		SetToggleOptionValue(tid, SXPGameStatsContainerToggle)
	elseif ( CurrentPage == "$Page_Toggle" )
		MCMBrowserToggle(SXPToggleSID, tid, XPC.SXPToggle)
	elseif ( CurrentPage == "$Page_Leveling" )
		if tid == SXPLevelingSID[16]
			SXPLevelingHybridBonusToggle = !SXPLevelingHybridBonusToggle
			SetToggleOptionValue(tid, SXPLevelingHybridBonusToggle)
		endif
		UpdateSkills()
		ForcePageReset()
	elseif (CurrentPage == "$Page_Compatibility")
		if tid == SXPCompatibilitySID[14]
			PERMAToggle = !PERMAToggle
			PERMAMiscExpGain()
			SetToggleOptionValue(tid, PERMAToggle)
		else
			MCMBrowserToggle(SXPCompatibilitySID, tid, REQUIEMToggle)
		endif
		int i = 0
		while i < 18
			if tid == _Skill_Alt[i]
				Skill_Alt[i] = !Skill_Alt[i]
				if Skill_Alt[i]
					ChekSkillListMenu_Alt = false
				endif
				SetToggleOptionValue(tid, Skill_Alt[i])
				ForcePageReset()
			endif
			i += 1
		endwhile
	;/else
		int i = 0
		while ( i < 18 )
			if ( tid == _TID_skill_[i] )				
				PurchaseSkill( i )
				ForcePageReset()
				return
			endif
			i += 1
		endwhile/;
	endif
EndEvent

Event OnOptionMenuOpen(int option)
	if option == SXPLevelingSID[13]
		string[] sArray = FurnitureMarkerArray()
		SetMenuDialogStartIndex(XPH.FurnitureMarkerIndex)
		SetMenuDialogDefaultIndex(XPH.FurnitureMarker.Length)
		SetMenuDialogOptions(sArray)
	elseif option == SXPLevelingSID[15]
		SetMenuDialogStartIndex(SXPSkillCapStringIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(SXPSkillCapString)
	elseif option == SXPCompatibilitySID[11]
		SetMenuDialogStartIndex(PresetIndex[0])
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(PUPreset)
	elseif option == SXPCompatibilitySID[12]
		SetMenuDialogStartIndex(PresetIndex[0])
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(PUPreset)
	elseif option == SXPCompatibilitySID[13]
		SetMenuDialogStartIndex(PresetIndex[1])
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(PUPreset)
	endif
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if (CurrentPage == "$Page_Leveling")
		if option == SXPLevelingSID[13]
			string[] sArray = FurnitureMarkerArray()
			XPH.FurnitureMarkerIndex = index
			SetMenuOptionValue(option, sArray[index])
		elseif option == SXPLevelingSID[15]
			if index == 18
				String sInput = ((Self as Form) as UILIB_1).ShowTextInput(SXPSkillCapString[index], 100)
				if sInput != ""
					int iInput = sInput as int
					int iIndex = 0
					int iElement = SXPSKillCaps.Length
					While iIndex < iElement
						SXPSKillCaps[iIndex] = iInput
						SXPSkillCapString[iIndex] = names[iIndex] + ": " + iInput
						iIndex += 1
					EndWhile
				endif
			else
				String sInput = ((Self as Form) as UILIB_1).ShowTextInput(SXPSkillCapString[index], SXPSKillCaps[index])
				if sInput != ""
					int iInput = sInput as int
					SXPSKillCaps[index] = iInput
					SXPSkillCapString[index] = names[index] + ": " + iInput
				endif
			endif
			UpdateSkills()
			SXPSkillCapStringIndex = index
			ForcePageReset()
		endif
	elseif (CurrentPage == "$Page_Compatibility")
	string Mod
	string SaveLoad
	string[] Array
	string Filename
	string Result = ""
		
	if option == SXPCompatibilitySID[11] 
					Array = PUPreset
			PresetIndex[0] = index
		
			String sInput = ((Self as Form) as UILIB_1).ShowTextInput("$Compatibility_Message_9", Array[index])
			if sInput != ""
				Array[index] = sInput
			endif
			SetMenuOptionValue(option, Array[index])
			ForcePageReset()
			return
	
	elseif option == SXPCompatibilitySID[12] || option == SXPCompatibilitySID[13]
		Mod = "PU"
		if option == SXPCompatibilitySID[12]
			SaveLoad = "Load"
			PresetIndex[0] = index
		else
			SaveLoad = "Save"
			PresetIndex[1] = index
		endif
		Array = PUPreset
	endif
		
	if SaveLoad == "Load"
		if !ShowMessage("$Compatibility_Message_0", true, "$Load", "$Cancel")
			return
		endif
		if !ShowMessage("$Compatibility_Message_1", true, "$Load", "$Cancel")
			return
		endIf
	elseif SaveLoad == "Save"
		if !ShowMessage("$Compatibility_Message_4", true, "$Save", "$Cancel")
			return
		endif
		if !ShowMessage("$Compatibility_Message_5", true, "$Save", "$Cancel")
			return
		endif
		If ShowMessage("$Compatibility_Message_8", true, "$Yes", "$No")
			String sInput = ((Self as Form) as UILIB_1).ShowTextInput("$Compatibility_Message_9", Array[index])
			if sInput != ""
				Array[index] = sInput
			endif
		EndIf
	endif
	
	
	if Mod == "PU"
		Filename = "../SXP/PapyrusUtil/" + Array[index]
		if SaveLoad == "Load"
			if !(JsonUtil.Load(Filename)) ; check the result
				Result = "Fail"
			endif
		endif
	endif
	
	if Result == ""
		;-------Status
		MenugeneratorFloat(Mod, SaveLoad, SXPGeneral.Length, SXPGeneralStrings, SXPGeneral, Filename)
		;-------Misc
		MenugeneratorInt(Mod, SaveLoad, XPoll.SXPGameStats.Length, SXPGameStatsStrings, XPoll.SXPGameStats, Filename)
		;-------Actor
		MenugeneratorFloat(Mod, SaveLoad, XPW.SXPActor.Length, SXPActorStrings, XPW.SXPActor, Filename)
		;-------Toggle
		MenugeneratorBool(Mod, SaveLoad, XPC.SXPToggle.Length, SXPToggleStrings, XPC.SXPToggle, Filename)
		;-------Leveling
		MenugeneratorFloat(Mod, SaveLoad, SXPLeveling.Length, SXPLevelingStrings, SXPLeveling, Filename)
		
		MenugeneratorInt(Mod, SaveLoad, SXPSKillCaps.Length, SXPLevelingStrings, SXPSKillCaps, Filename)
		;-------Magic Effects
		MenugeneratorFloat(Mod, SaveLoad, XPME.SXPMagicEffectGeneral.Length, SXPMagicEffectGeneralStrings, XPME.SXPMagicEffectGeneral, Filename)
		XPME.MenugeneratorFloat(Mod, SaveLoad, Filename)
		;-------Compatibility
		MenugeneratorFloat(Mod, SaveLoad, SXPCompatibility.Length, SXPCompatiblityStrings, SXPCompatibility, Filename)
		;-------Compatibility & Individual
		MenugeneratorIndividual(Mod, SaveLoad, Filename)
				
		if Mod == "PU"
			bool PUResult
			if SaveLoad == "Load"
				PUResult = JsonUtil.Load(Filename) ; check the result
			elseif SaveLoad == "Save"
				PUResult = JsonUtil.Save(Filename) ; check the result
			endif
			if !PUResult
				Result = "Fail"
			endif
		endif
	endif
	
	If (Result != "")
		if SaveLoad == "Load"
			ShowMessage("$Compatibility_Message_3")
		elseif SaveLoad == "Save"
			ShowMessage("$Compatibility_Message_7")
		endif
	Else
		if SaveLoad == "Load"
			CompatibilityMaintenance()
			XPME.UpdateSkillEffects(False)
			PlayerBonusLevel()
			XPoll.SetPollingInterval(SXPGeneral[3])
			XPC.SXPNotificationColorString = DecToHex(SXPNotificationColor)
			ChekPresetCreateGetXPointArray()
			ShowMessage("$Compatibility_Message_2", false, "$Okay")
			;UI.InvokeBool("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu", false)
		elseif SaveLoad == "Save"
			ShowMessage("$Compatibility_Message_6", false, "$Okay")
		endif
	EndIf
	SetMenuOptionValue(option, Array[index])
	ForcePageReset()
	endif
EndEvent

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if option == SXPCompatibilitySID[10]
		UnregisterForKey(UIEXTKeyBind)
		if KeyBindConflict(option, keyCode, conflictControl, conflictName) == True
			UIEXTKeyBind = keyCode
		else
			if UIEXTKeyBind != -1
				RegisterForKey(UIEXTKeyBind)
			endif
		endif
	elseif option == SXPLevelingSID[14]
		UnregisterForKey(SXPActionToGainLevelPrayKeyBind)
		if KeyBindConflict(option, keyCode, conflictControl, conflictName) == True
			SXPActionToGainLevelPrayKeyBind = keyCode
		else
			if SXPActionToGainLevelPrayKeyBind != -1
				RegisterForKey(SXPActionToGainLevelPrayKeyBind)
			endif
		endif
	endif
endEvent

Event OnKeyDown(Int KeyCode)
	if keyCode == UIEXTKeyBind
		if !IsPlayerInUIEXTMenu
			if (!Utility.IsInMenuMode())
				IsPlayerInUIEXTMenu = True
				;SkillZero.SetNthEntryValue(0, 0, 1.00)
				ListMenu()
			endif
		else
			SkillZero.SetNthEntryValue(0, 0, 0.00)
			UI.CloseCustomMenu()
		endif
		IsPlayerInUIEXTMenu = False
	elseif keyCode == SXPActionToGainLevelPrayKeyBind
		if (!Utility.IsInMenuMode())
			SendModEvent("SXPStartPray")
		endif
	endif
EndEvent

Event OnOptionColorOpen(int option)
   if (option == SXPGeneralSID[7])
		SetColorDialogStartColor(SXPNotificationColor)
		SetColorDialogDefaultColor(0xFFFFFF)
    endIf
EndEvent

Event OnOptionColorAccept(int option, int color)
	if (option == SXPGeneralSID[7])
		SXPNotificationColor = color
		XPC.SXPNotificationColorString = DecToHex(color)
		SetColorOptionValue(option, color)
    endIf
EndEvent

Function MCMBrowserSliderMagicEffect(int[] Array, int MCMID, float[] Array1, float[] Array2, string[] Array3, string Option = "", float value = 0.0)
	int iIndex = Array.Find(MCMID)
	if iIndex >= 0
		if Option == "Default"
			Array1[iIndex] = Array2[iIndex]
			SetSliderOptionValue(MCMID, Array2[iIndex] * 100, "{0} %")
			XPME.UpdateSkillEffects(True, iIndex)
		elseif Option == "SliderOpen"
			SetSliderDialogStartValue(Array1[iIndex] * 100)
			SetSliderDialogDefaultValue(Array2[iIndex] * 100)
			SetSliderDialogRange(-100.0, 100.0)
			SetSliderDialogInterval(1.0)
		elseif Option == "SliderAccept"
			Array1[iIndex] = (value / 100.0)
			SetSliderOptionValue(MCMID, value, "{0} %")
			XPME.UpdateSkillEffects(True, iIndex)
		elseif Option == "HighLight"
			SetInfoText(Array3[iIndex])
		endif
	else
		if Option == "Default"
			MCMBrowserSliderOpenFloat(SXPMagicEffectGeneralSID, MCMID, XPME.SXPMagicEffectGeneral, SXPMagicEffectGeneralDefault, SXPMagicEffectGeneralDecimal, "Default")
			XPME.UpdateSkillEffects(False)
		elseif Option == "SliderOpen"
			MCMBrowserSliderOpenFloat(SXPMagicEffectGeneralSID, MCMID, XPME.SXPMagicEffectGeneral, SXPMagicEffectGeneralDefault, SXPMagicEffectGeneralDecimal)
		elseif Option == "SliderAccept"
			MCMBrowserSliderAccept(SXPMagicEffectGeneralSID, MCMID, XPME.SXPMagicEffectGeneral, SXPMagicEffectGeneralDecimal, value)
			XPME.UpdateSkillEffects(False)
		elseif Option == "HighLight"
			MCMBrowserHL(SXPMagicEffectGeneralSID, MCMID, SXPMagicEffectGeneralHLStrings)
		endif
	endif
EndFunction

;Настроечная функция для слайдера _TID_skill_Slide_
Function MCMBrowserSliderOpenStatsInt(int[] Array, int MCMID)
	int i = 0
	while ( i < 18 )		
		if  MCMID == Array[i] 
			SetSliderDialogStartValue(0)
			SetSliderDialogRange( 0.0, LvlUpMax[i] as float)
			SetSliderDialogInterval(1)
			return
		endif
		i += 1
	endwhile
EndFunction

Function MCMBrowserSliderStatsAccept(int[] Array, int MCMID, float value)	
	int i = 0
	while ( i < 18 )
		if ( MCMID == Array[i] )
			if value == 0.0
				return
			endif
			PurchaseSkillSlide(i, value as int)		
			ForcePageReset()			
			return
		endif
		i += 1
	endwhile			
EndFunction

;Настроечная функция для слайдера _TID_skill_Slide_
Function CreateMaxSkillLevelSlider(int i, int ii)

	int i_skill = 0		
	while ( i < ii )
		int i_stats = XPC.GetXP() as int
		i_skill = PlayerREF.GetBaseActorValue(stats[i]) as Int
		;debug.trace("i_skill2 = " + i_skill)
		if i_stats >= 25000000
			return
		endif
		if i_skill < 100
			int z1 = i_skill
			;debug.trace("i_stats = " + i_stats)
			int i_lvl = XPtoNextLevel[i]
			while (i_stats >= i_lvl)		
				i_skill += 1
				i_lvl += GetXPointArray[i_skill]
			endwhile
			;debug.trace("i_skill2 = " + i_skill)
			int z2 = i_skill - z1
			if i_skill >= 100
				z2 = 100 - z1
			endif
			LvlUpMax[i] = z2			
		else 
			LvlUpMax[i] = 0
		endif
		i += 1
	endwhile
	;/int i_skill = 0		
	while ( i < ii )
		int i_stats = XPC.GetXP() as int
		i_skill = PlayerREF.GetBaseActorValue(stats[i]) as Int	
		;debug.trace("i_skill = " + i_skill)	
		
		if i_skill < 100
			int z1 = i_skill
			int i_lvl = XPtoNextLevel[i]
			;debug.trace(stats[i] + "[" + i_skill + "] = " + i_lvl)
			if i_stats < TotalXpoint	;2951842
				while (i_stats >= i_lvl)	
					i_skill += 1
					i_lvl += GetXPointArray[i_skill]
					debug.trace(stats[i] + "[" + i_skill + "] = " + i_lvl)
					;debug.trace("i_lvl = " + i_lvl)
				endwhile
			else
				i_skill = 100
				while (i_stats > i_lvl)	
					i_skill += 1
					i_lvl += GetXPointArray[i_skill]
					if i_skill == 100
						i_stats = i_lvl
					endif	
				;debug.trace("i_lvl = " + i_lvl)
				endwhile
			endif
			debug.trace("TotalXpoint = " + TotalXpoint)
			int z2 = i_skill - z1
			LvlUpMax[i] = z2
		else 
			LvlUpMax[i] = 0
		endif
		i += 1
	endwhile/;
EndFunction

Function MCMBrowserSliderOpenInt(int[] Array, int MCMID, int[] Array1, int[] Array2, string Option = "", float DialogInverval = 1.0)
	if Array == SXPReadmeSID
		return
	endif
	int iIndex = Array.Find(MCMID)
	if iIndex >= 0
		if Option == "Default"
			if iIndex == 48 || iIndex == 54 || iIndex == 55 || iIndex == 59
				SetSliderOptionValue(MCMID, Array2[iIndex], "{0} %")
			else
				SetSliderOptionValue(MCMID, Array2[iIndex])
			endif
			Array1[iIndex] = Array2[iIndex]
		else
			SetSliderDialogStartValue(Array1[iIndex])
			SetSliderDialogDefaultValue(Array2[iIndex])
				SetSliderDialogRange( 0.0, 100000.0)
			SetSliderDialogInterval(DialogInverval)
		endif
	endif
EndFunction

Function MCMBrowserSliderOpenFloat(int[] Array, int MCMID, float[] Array1, float[] Array2, string[] Array3, string Option = "")
	if Array == SXPReadmeSID
		return
	endif
	int iIndex = Array.Find(MCMID)
	if iIndex >= 0
		float fSliderValue = MCMBrowserProcentHelper(Array3[iIndex])
		if Option == "Default"    
			SetSliderOptionValue(MCMID, (Array2[iIndex] * fSliderValue), Array3[iIndex])
			Array1[iIndex] = Array2[iIndex]
			if MCMID == SXPGeneralSID[3]
				XPoll.SetPollingInterval(Array1[iIndex])
			elseif MCMID == SXPLevelingSID[9] || MCMID == SXPLevelingSID[10]
				PlayerBonusLevel()
			elseif Array == SXPCompatibilitySID && iIndex < 5
				SXPCompatibilitySliderGlobals[iIndex].SetValue(Array1[iIndex])
			endif
		else
			if Array == SXPCompatibilitySID && iIndex < 5
				SetSliderDialogStartValue(SXPCompatibilitySliderGlobals[iIndex].GetValue())
			else
				SetSliderDialogStartValue(Array1[iIndex] * fSliderValue)
			endif
			SetSliderDialogDefaultValue(Array2[iIndex] * fSliderValue)
				if MCMID == SXPGeneralSID[6]
					SetSliderDialogRange(1.0, 10.0)
					SetSliderDialogInterval(0.1)
				elseif MCMID == SXPActorSID[9]
					SetSliderDialogRange(0.0, 1000.0)
					SetSliderDialogInterval(1.0)
				elseif MCMID == SXPActorSID[10]
					SetSliderDialogRange(0.0, 0.50)
					SetSliderDialogInterval(0.01)
				elseif MCMID == SXPLevelingSID[11] || MCMID == SXPLevelingSID[12]
					SetSliderDialogRange(0.0, 10.0)
					SetSliderDialogInterval(1.0)
				else
					RangeInterval((Array2[iIndex] * fSliderValue), Array3[iIndex])
				endif
		endif
	endif
EndFunction

Function MCMBrowserSliderAccept(int[] Array, int MCMID, float[] Array1, string[] Array2, float value)
	if Array == SXPReadmeSID
		return
	endif
	int iIndex = Array.Find(MCMID)
	if iIndex >= 0
		if Array == SXPGameStatsSID
			XPoll.SXPGameStats[iIndex] = value as int
			if iIndex == 46 || iIndex == 55 || iIndex == 56 || iIndex == 57
				SetSliderOptionValue(MCMID, value, "{0} %")
			else
				SetSliderOptionValue(MCMID, value)
			endif
			XPoll.SetPollingInterval(SXPGeneral[3]) ;запуск пересчета массива SXPNGameStat
		else
			float fSliderValue = MCMBrowserProcentHelper(Array2[iIndex])
			Array1[iIndex] = (value / fSliderValue)
			SetSliderOptionValue(MCMID, value, Array2[iIndex])
			if MCMID == SXPGeneralSID[3]
				XPoll.SetPollingInterval(Array1[iIndex])
			elseif MCMID == SXPLevelingSID[9] || MCMID == SXPLevelingSID[10]
				PlayerBonusLevel()
			elseif Array == SXPCompatibilitySID && iIndex < 5
				SXPCompatibilitySliderGlobals[iIndex].SetValue(Array1[iIndex])
			endif
		endif
		if Array == SXPLevelingSID
			SXPActionToGainLevelToggle = SetActionToGainLevel()
		endif
	endif
EndFunction

Function MCMBrowserToggle(int[] Array, int MCMID, bool[] Array1, string Option = "", bool Default = True)
	if Array == SXPReadmeSID
		return
	endif
	int iIndex = Array.Find(MCMID)
	if iIndex >= 0
		int oIndex = iIndex
		if Array1 == REQUIEMToggle
			oIndex = oIndex - 7
		endif
		if Option == "Default"
			Array1[oIndex] = Default
		else
			Array1[oIndex] = !Array1[oIndex]
		endif
		if MCMID == SXPToggleSID[57]
			MasterToggleSwitch()
		;elseif MCMID == SXPCompatibilitySID[9]
			;REQUIEMPassiveArmorGain()
		endif
		SetToggleOptionValue(Array[iIndex], Array1[oIndex])
	endif
EndFunction

Function MCMBrowserHL(int[] Array, int MCMID, string[] Array1)
	if Array == SXPReadmeSID
		return
	endif
	int iIndex = Array.Find(MCMID)
	if Array == SXPToggleSID
		if iIndex == 57
			SetInfoText(SXPToggleHLStrings[1])
		else
			SetInfoText(SXPToggleHLStrings[0])
		endif
	else
		if iIndex < 0
			SetInfoText("")
		else
			SetInfoText(Array1[iIndex])
		endif
	endif
EndFunction

Function MCMBrowserShowReadme(int MCMID, string CurrentPage)
	int iIndex = SXPReadmeSID.Find(MCMID)
	if iIndex != -1
		if CurrentPage == "$Page_Actor"
			ShowMessage("$Readme_Actor", False, "$Okay")
		elseif CurrentPage == "$Page_Leveling"
			bool Continue = True
			int Page = 1
			While Continue
				Continue = ShowMessage("$Readme_Leveling_" + Page as string, True, "$Readme_Leveling_" + (Page + 2) as string, "$Okay")
				if Continue
					if Page == 1
						Page = 2
					else
						Page = 1
					endif
				endif
			EndWhile
		endif
	endif
EndFunction

float Function MCMBrowserProcentHelper(string Decimal)
	int i = StringUtil.GetLength(Decimal)
	if i > 3
		if StringUtil.Substring(Decimal, 4) == "%"
			return 100
		endif
	endif
	
	return 1
EndFunction

Function RangeInterval(float Number, string Decimal)
	float Dec = (StringUtil.GetNthChar(Decimal, 1)) as float
	float Power = Math.Pow(10.0, Dec)
	float Interval = (1/Power)
	
	if Number < 0.0
		SetSliderDialogRange(-100.0, 0.0)
	else
		SetSliderDialogRange(0.0, (Number * Power * 10))
	endif
	SetSliderDialogInterval(Interval)
EndFunction

bool Function KeyBindConflict(int option, int keyCode, string conflictControl, string conflictName)
	bool continue = true
	if (conflictControl != "")
		string msg
		if (conflictName != "")
			msg = "$Compatibility_Message_10{\n\"" + conflictControl + "\"\n}{(" + conflictName + ")\n\n}"
		else
			msg = "$Compatibility_Message_11{\n\"" + conflictControl + "\"\n\n}"
		endIf
		continue = ShowMessage(msg, true, "$Yes", "$No")
	endIf

	if (continue)
		SetKeymapOptionValue(option, keyCode)
		RegisterForKey(keyCode)
	endIf
	
	return continue
EndFunction

string Function GetCustomControl(int keyCode)
	if keyCode == UIEXTKeyBind
		return "UIExtensions - Level Menu"
	elseif keyCode == SXPActionToGainLevelPrayKeyBind
		return "Praying - Keybind"
	endif
EndFunction

string[] Function FurnitureMarkerArray()
	string[] sArray = new string[5]
	
	sArray[0] = "KneelingMarker"
	sArray[1] = "PrayCrouchedMarker"
	sArray[2] = "SitCrossLeggedMarkerNoSandbox"
	sArray[3] = "GreybeardMeditate"
	sArray[4] = "$Random"
	
	return sArray
EndFunction

bool Function SetActionToGainLevel()
	bool bResult = True
	if SXPLeveling[11] == 0.0 && SXPLeveling[12] == 0.0
		bResult = False
	endif
	
	if !bResult
		if SXPActionToGainLevelOrder != ""
			if UI.IsMenuOpen("Journal Menu")
				if !ShowMessage("$Leveling_Message_1", true, "$Yes", "$No")
					SXPLeveling[11] = 1.0
					ForcePageReset()
					return True
				endif
			endif
			UI.InvokeBool("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu", false)
			((Self as Form) as UILIB_1).ShowNotification("$StartMessage3", "#FF0000")
			GivePlayerGainedLevels("Reset", 1)
			((Self as Form) as UILIB_1).ShowNotification("$StartMessage4", "#19B271")
		endif
	endif
	
	return bResult
EndFunction

int Function GetNextXP(int index, int skill)
	;debug.trace("State = " + getstate())
	int n_ret = 0
	int n_skill = skill + 1
	
	n_ret = (Math.pow(n_skill, 2.5) * SXPLeveling[0] * SXPLeveling[1]) as Int
	
	if ( n_skill < 25 )
		n_ret += (SXPLeveling[2] * (1 - n_skill * 0.01)) as int
	elseif ( n_skill < 50 )
		n_ret += (SXPLeveling[3] * (1 - n_skill * 0.01)) as int
	elseif ( n_skill < 75 )
		n_ret += (SXPLeveling[4] * (1 - n_skill * 0.01)) as int
	elseif ( n_skill < 100 )
		n_ret += (SXPLeveling[5] * (1 - n_skill * 0.01)) as int
	else
		n_ret += (SXPLeveling[6] * (1 - n_skill * 0.01)) as int
	endif
	
	n_ret = (n_ret * SXPMagicEffectBonus[index]) as int

	if SXPLevelingHybridBonusToggle
		if SXPActionToGainLevel[index] < 1
			ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[index])
			float GainedExperience = aVI.GetSkillExperience()
			float RequiredExperience = aVI.GetExperienceForLevel(skill)
			float Result = (1.0 - (GainedExperience/RequiredExperience))
			n_ret = (n_ret * Result) as int
		endif
	endif
	
	if n_ret < 0
		n_ret = 0
	endif
	return n_ret
	EndFunction
;/	
int Function GetNextXP(int index, int skill)
	int n_ret = 0
	int n_skill = skill + 1
	n_ret = Math.pow(n_skill, 2.5) as Int + 1000  - n_skill * 10
		
	if n_ret < 0
		n_ret = 0
	endif
	return n_ret
EndFunction
/;
Function PurchaseSkillSlide(int id, int val)
	int i_old = PlayerREF.GetBaseActorValue(stats[id]) as Int
	if i_old + SXPActionToGainLevel[id] >= SXPSKillCaps[id]
		UpdateSpecificSkill(id)		
		return
	elseif XPC.GetXP() as Int < XPtoNextLevel[id]
		return
	endif	
	;XPC.UseXP(XPtoNextLevel[id])	
	if SXPActionToGainLevelToggle
		string sSkill = id as string + ";"
		if id < 10
			sSkill = "0" + id as string + ";"
		endif
		SXPActionToGainLevelOrder += sSkill
		SXPActionToGainLevel[id] = SXPActionToGainLevel[id] + 1
		UpdateSpecificSkill(id)		
		return
	endif
	if Skill_Alt[id]
		SkillAdvanceAlt(id, val)
		;debug.trace("SkillAdvanceAlt1")
	else
		SkillAdvanceSlide(id, val)
		;debug.trace("SkillAdvanceSlide1")		
	endif
	Int i_new = PlayerREF.GetBaseActorValue(stats[id]) as Int
	int zz = 0
	While i_new > i_old
		i_new = i_new - 1
		If i_new <= 100
			zz += GetXPointArray[i_new]	
			;debug.trace("zz[" + i_new + "] = " + zz)
		EndIf		
	EndWhile
	XPC.UseXP(zz)
EndFunction

Function SkillAdvanceSlide(int id, int val)
	int i_old = PlayerREF.GetBaseActorValue(stats[id]) as Int
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[id])	
	Game.IncrementSkillBy(stats[id], val)	
	aVI.SetSkillExperience(0 as Float)
	
	int i_new = PlayerREF.GetBaseActorValue(stats[id]) as Int
	int i_check = i_new - i_old
	if i_check != val
		ShowMessage("$Skill_Alt1")
		Skill_Alt[id] = true
		RegisterforMenu("Journal Menu")
	endif
	UpdateSpecificSkill(id)	
EndFunction

Event OnMenuClose(String MenuName)	
	If MenuName == "Journal Menu"
		;debug.notification("Journal Menu")
		StoryIncreaseSkill()					;Вместо Event OnStoryIncreaseSkill(string asSkill) при сломаной прокачке
		PlayerBonusLevel()
	EndIf
EndEvent

Function SkillAdvanceAlt(int id, int val)
	int i_old = PlayerREF.GetBaseActorValue(stats[id]) as Int
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[id])	
	PlayerREF.SetAv(stats[id], (i_old + val) as float)
	float PlayerExperience = Game.GetPlayerExperience()
	int i = 1
	float PlayerExperienceUp = PlayerExperience
	while i <= val
		PlayerExperienceUp += (i_old + i)
		i += 1
	endwhile
	Game.SetPlayerExperience(PlayerExperienceUp)		
	aVI.SetSkillExperience(0.0000)
	if Utility.IsInMenuMode()
		UpdateSpecificSkill(id)			;из МСМ меню
	else
		StoryIncreaseSkill()
		UpdateSpecificSkill(id)			;из Г-меню
		PlayerBonusLevel()
	endif	
EndFunction

Function PurchaseSkill(int id)
	int i_old = PlayerREF.GetBaseActorValue(stats[id]) as Int	
	if i_old + SXPActionToGainLevel[id] >= SXPSKillCaps[id]
		UpdateSpecificSkill(id)
		return
	elseif XPC.GetXP() as Int < XPtoNextLevel[id]
		return
	endif

	XPC.UseXP(XPtoNextLevel[id])
	if SXPActionToGainLevelToggle
		string sSkill = id as string + ";"
		if id < 10
			sSkill = "0" + id as string + ";"
		endif
		SXPActionToGainLevelOrder += sSkill
		SXPActionToGainLevel[id] = SXPActionToGainLevel[id] + 1
		UpdateSpecificSkill(id)
		return
	endif	
	
	if Skill_Alt[id]
		SkillAdvanceAlt(id, 1)
		;debug.trace("SkillAdvanceAlt2")
	else
		SkillAdvance(id)
		;debug.trace("SkillAdvance2")
	endif
	Int i_new = PlayerREF.GetBaseActorValue(stats[id]) as Int
	While i_new > i_old + 1
		If i_new <= 100
			XPC.UseXP(GetNextXP(id, i_new))			
		EndIf
		i_new = i_new - 1
	EndWhile
EndFunction

Function SkillAdvance(int id)
	int i_new = PlayerREF.GetBaseActorValue(stats[id]) as Int + 1
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[id])
	while PlayerREF.GetBaseActorValue(stats[id]) as Int < i_new
		Game.IncrementSkill(stats[id])	
	endwhile
	aVI.SetSkillExperience(0 as Float)
	
	int i_new1 = PlayerREF.GetBaseActorValue(stats[id]) as Int
	int i_check = i_new1 - (i_new - 1)
	if i_check != 1
		if Utility.IsInMenuMode()		
			ShowMessage("$Skill_Alt1")
			Skill_Alt[id] = true
			ChekSkillListMenu_Alt = false
		else
			if Utility.GetINIString("sLanguage:General") == "russian"		
				debug.MessageBox("Что то в Скайриме сломалось и он начал через жопу прокачивать умение.\n Прокачка данного умения переключится на альтернативный способ,\n при нем не будет уведомления о повышении уровня")						
			else 	
				debug.MessageBox("Something in Skyrim broke and he started progression of the skill through the ass.\n Progression this skill will be switched to the alternative way,\n and there will be no notification of the level up.")
			endif
			Skill_Alt[id] = true
			ChekSkillListMenu_Alt = true
		endif
		RegisterforMenu("Journal Menu")
	endif
	UpdateSpecificSkill(id)
EndFunction

Function UpdateSkills()
	skills = new int[18]
	XPtoNextLevel = new int[18]	
	int i = 0
	While ( i < 18 )
		UpdateSpecificSkill(i)
		i += 1
	EndWhile
EndFunction

Function UpdateSpecificSkill(int id)
	skills[id] = (PlayerREF.GetBaseActorValue(stats[id]) as Int) + SXPActionToGainLevel[id]
	;debug.trace("SXPActionToGainLevel[" + id + "] = " + SXPActionToGainLevel[id])
	XPtoNextLevel[id] = GetNextXP(id, skills[id])
EndFunction

int Function GetSkillInteger(string skill)
	return stats.Find(skill)
EndFunction

string Function GetSkillString(int skill)
	return stats[skill]
EndFunction

Function PlayerBonusLevel()
	float farg1 = SXPLeveling[9]
	float farg2 = SXPLeveling[10]
	float fValue = 1.0
	
	if (farg1 != 0.0) && (farg2 != 0.0)
		int PlayerLevel = Math.Floor(PlayerREF.GetLevel() / farg1)
		fValue = 1.0 + (PlayerLevel * farg2)
	endif
	
	XPC.fPlayerLevelBonus = fValue
EndFunction

Function GivePlayerGainedLevels(string sEvent, int Time)	
	if Time == 0
		return
	endif
		
	int idn = 0
	if sEvent == "Sleep"
		idn = Math.Floor(Time * SXPLeveling[11])
	elseif sEvent == "Pray"
		idn = Math.Floor(Time * SXPLeveling[12])
	endif
	
	string[] AdvanceOrder = StringUtil.Split(SXPActionToGainLevelOrder, ";")
	if sEvent == "Reset"
		idn = AdvanceOrder.Length
	endif
	
	int i = 0
	int ie = AdvanceOrder.Length
	if ie > 0
		if idn > ie
			idn = ie
		endif
		While i < idn
			int id = AdvanceOrder[i] as int
			SXPActionToGainLevel[id] = SXPActionToGainLevel[id] - 1
			SXPActionToGainLevelOrder = StringUtil.Substring(SXPActionToGainLevelOrder, 3)
			SkillAdvance(id)
			i += 1
		EndWhile
	endif
	if sEvent != "Reset"
		if CompatibilityCheck[3]
			SleepToGainExperience.FlushBufferedExperience(Time as float, False)
		endif
	endif
EndFunction

bool Function ShouldGive(string sEvent, int Time = 0, bool Interrupted = False)
	bool bResult = False
	if sEvent == "Sleep"
		if SXPLeveling[11] > 0.0
			bResult = True
		endif
		if !bResult
			if CompatibilityCheck[3]
				SleepToGainExperience.FlushBufferedExperience(Time as float, Interrupted)
			endif
		endif
	elseif sEvent == "Pray"
		if SXPLeveling[12] > 0.0
			bResult = True
		endif
	endif
	
	return bResult
EndFunction

Function ConvertToPerkPoint()
	int i_current = XPC.GetXP() as Int
	int i_next = (SXPLeveling[7] + (( PERK_COUNT + 1 ) * SXPLeveling[8])) as Int
	if ( i_current < i_next )
		return
	endif
	
	Game.ModPerkPoints( 1 )
	XPC.UseXP( i_next )
	PERK_COUNT += 1
EndFunction

string Function CreateNextXPString(int index, int value)
	string ret = SXPMagicEffectBonusString[index] + " "
	ret += value
	
	return ret
EndFunction

string Function CreateCurrentLevelString(int index)
	string sString = "" + skills[index]
	if SXPActionToGainLevel[index] > 0
		sString += "(" + SXPActionToGainLevel[index] + ")"
	endif
	
	return sString
EndFunction

string Function CreateProgressString(int index, int current_value, int required_value, int level)
	if level >= SXPSKillCaps[index]
		return ""
	endif
	float f_Procent = 100.0
	if required_value > 0.0
		f_Procent = ((current_value as float/required_value as float) * 100)
	endif
	if f_Procent > 100.0
		f_Procent = 100.0
	endif
	return "$Skill_2{ " + " [" + f_Procent as int + "%]" +"}"
EndFunction

Function CompatibilityMaintenance()
	UnregisterForAllKeys()
	
	if SXPLockpickingFix
		Game.SetGameSettingFloat("fSkillUsageLockPickAverage", 0.0)
		Game.SetGameSettingFloat("fSkillUsageLockPickBroken", 0.0)
		Game.SetGameSettingFloat("fSkillUsageLockPickEasy", 0.0)
		Game.SetGameSettingFloat("fSkillUsageLockPickHard", 0.0)
		Game.SetGameSettingFloat("fSkillUsageLockPickVeryEasy", 0.0)
		Game.SetGameSettingFloat("fSkillUsageLockPickVeryHard", 0.0)
		Game.SetGameSettingFloat("fSkillUsageRechargeMult", 0.0)
		Game.SetGameSettingFloat("fSkillUsageSneakHidden", 0.0)
		Game.SetGameSettingFloat("fSkillUsageSneakPerSecond", 0.0)
	endif
	
	if SXPActionToGainLevelPrayKeyBind != -1
		RegisterForKey(SXPActionToGainLevelPrayKeyBind)
	endif
	
	PlayerName = PlayerREF.GetBaseObject().GetName()
	
	names = new string[18]	
	int i = 0
	int ie = names.Length
	While i < ie
		ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[i])
		names[i] = aVI.GetName()
		i += 1
	EndWhile

	string[] CompatibilityCheckNames = new string[4]
	CompatibilityCheckNames[0] = "PerkusMaximus_Master.esp"
	CompatibilityCheckNames[1] = "Requiem.esp"
	CompatibilityCheckNames[2] = "UIExtensions.esp"
	CompatibilityCheckNames[3] = "SleepToGainExperience.esp"
	
	
	CompatibilityCheck = new bool[5]
	int iIndex = 0
	int iElement = CompatibilityCheck.Length
	While iIndex < iElement
		if iIndex < (iElement - 1)
		int Decider = Game.GetModByName(CompatibilityCheckNames[iIndex])
			if Decider != 255
				CompatibilityCheck[iIndex] = True
			else
				CompatibilityCheck[iIndex] = False
			endif
		else
			int PapyrusUtilPluginVersion = SKSE.GetPluginVersion("papyrusutil plugin")
			if PapyrusUtilPluginVersion != -1
				if PapyrusUtil.GetVersion() >= 32
					CompatibilityCheck[iIndex] = True
				else
					CompatibilityCheck[iIndex] = False
				endif
			endif
		endif
		iIndex += 1
	EndWhile
	
	SXPCompatibilitySliderGlobals = new GlobalVariable[5]

	if CompatibilityCheck[0] == True
		SXPCompatibilitySliderGlobals[0] = (Game.GetFormFromFile( 0x0008E225, "PerkusMaximus_Master.esp" ) as GlobalVariable)
		SXPCompatibilitySliderGlobals[1] = (Game.GetFormFromFile( 0x0044251B, "PerkusMaximus_Master.esp" ) as GlobalVariable)
		SXPCompatibilitySliderGlobals[2] = (Game.GetFormFromFile( 0x00310C01, "PerkusMaximus_Master.esp" ) as GlobalVariable)
		SXPCompatibilitySliderGlobals[3] = (Game.GetFormFromFile( 0x00117C27, "PerkusMaximus_Master.esp" ) as GlobalVariable)
		SXPCompatibilitySliderGlobals[4] = (Game.GetFormFromFile( 0x0036D87B, "PerkusMaximus_Master.esp" ) as GlobalVariable)
		
		SXPCompatibilitySliderGlobals[0].SetValue(SXPCompatibility[0])
		SXPCompatibilitySliderGlobals[1].SetValue(SXPCompatibility[1])
		SXPCompatibilitySliderGlobals[2].SetValue(SXPCompatibility[2])
		SXPCompatibilitySliderGlobals[3].SetValue(SXPCompatibility[3])
		SXPCompatibilitySliderGlobals[4].SetValue(SXPCompatibility[4])
		
		PERMAMiscExpGain()
	endif
	
	;if CompatibilityCheck[1] == True
	;	REQUIEMPassiveArmorGain()
	;endif
	
	if CompatibilityCheck[2] == True
		if UIEXTKeyBind != -1
			RegisterForKey(UIEXTKeyBind)
		endif
	endif
	
	if CompatibilityCheck[3] == True
		Quest SleepToGainExperienceQuest = (Game.GetFormFromFile(0x00000D62, "SleepToGainExperience.esp")) as Quest
		if SleepToGainExperienceQuest.IsRunning()
			SleepToGainExperienceQuest.UnregisterForSleep()
		endif
	else
		if SKSE.GetPluginVersion("Sleep To Gain Experience Plugin") != -1
			SleepToGainExperience.ClearBufferedExperience()
		endif
	endif
	
	SXPActionToGainLevelToggle = SetActionToGainLevel()
EndFunction

Function MenugeneratorInt(string Mod, string SaveLoad, int Repetitions, string[] Array, int[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = ""
			if Array1 == SXPSKillCaps
				Name = "Leveling_Skill_Cap_" + names[iIndex]
			else
				Name = StringUtil.Substring(Array[iIndex], 1)
			endif
			int Value = Array1[iIndex]
			if SaveLoad == "Save"
				if Mod == "PU"
					JsonUtil.SetIntValue(Filename, Name, Value)
				endIf
			elseif SaveLoad == "Load"
				if Mod == "PU"
					Array1[iIndex] = JsonUtil.GetIntValue(Filename, Name)
				endIf
			endif
			iIndex += 1
		EndWhile
		
	;Цикл взят из функции SetDefaultValuesLeveling
		int i = 0
	int ie = SXPSkillCapString.Length
	While i < ie
		if i == 18
			SXPSkillCapString[i] = "$All"
		else
			ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[i])
			string sSkillName = aVI.GetName()
			SXPSKillCaps[i] = 100
			SXPSkillCapString[i] = sSkillName + ": " + SXPSKillCaps[i]
		endif
		i += 1
	EndWhile
EndFunction



Function MenugeneratorBool(string Mod, string SaveLoad, int Repetitions, string[] Array, bool[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = StringUtil.Substring(Array[iIndex], 1) + "_toggle"
			bool Value = Array1[iIndex]
			if SaveLoad == "Save"
				if Mod == "PU"
					JsonUtil.SetIntValue(Filename, Name, Value as int)
				endif	
			elseif SaveLoad == "Load"
				if Mod == "PU"
					Array1[iIndex] = JsonUtil.GetIntValue(Filename, Name) as bool
				endif
			endif
			iIndex += 1
		EndWhile
EndFunction


Function MenugeneratorFloat(string Mod, string SaveLoad, int Repetitions, string[] Array, float[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = StringUtil.Substring(Array[iIndex], 1)
			float Value = Array1[iIndex]
			if SaveLoad == "Save"
				if Mod == "PU"
					JsonUtil.SetFloatValue(Filename, Name, Value)
				endif
			elseif SaveLoad == "Load"
				if Mod == "PU"
					Array1[iIndex] = JsonUtil.GetFloatValue(Filename, Name)
				endif
			endif
			iIndex += 1
		EndWhile
EndFunction



Function MenugeneratorIndividual(string Mod, string SaveLoad, string Filename)
	if SaveLoad == "Save"
		if Mod == "PU"
			JsonUtil.SetIntValue(Filename, "General_Notification Color", SXPNotificationColor)
			JsonUtil.SetIntValue(Filename, "General_Prevent XP Gain_toggle", SXPLockpickingFix as int)
			JsonUtil.SetIntValue(Filename, "GameStats_Container Steal_toggle", SXPGameStatsContainerToggle as int)
			JsonUtil.SetIntValue(Filename, "Leveling_Hybrid Bonus_toggle", SXPLevelingHybridBonusToggle as int)
			JsonUtil.SetIntValue(Filename, "PERMA_Misc Skill Experience Gain_toggle", PERMAToggle as int)
			JsonUtil.SetIntValue(Filename, "REQUIEM_Illusion Skill Experience Gain_toggle", REQUIEMToggle[0] as int)
			JsonUtil.SetIntValue(Filename, "REQUIEM_Magic Skill Experience Gain_toggle", REQUIEMToggle[1] as int)
			JsonUtil.SetIntValue(Filename, "REQUIEM_Passive Armor Experience Gain_toggle", REQUIEMToggle[2] as int)
			JsonUtil.SetIntValue(Filename, "UIEXT_Level Menu Keybind", UIEXTKeyBind)
		endif
	elseif SaveLoad == "Load"
		if Mod == "PU"
			SXPNotificationColor = JsonUtil.GetIntValue(Filename, "General_Notification Color")
			SXPLockpickingFix = JsonUtil.GetIntValue(Filename, "General_Prevent XP Gain_toggle") as bool
			SXPGameStatsContainerToggle = JsonUtil.GetIntValue(Filename, "GameStats_Container Steal_toggle") as bool
			SXPLevelingHybridBonusToggle = JsonUtil.GetIntValue(Filename, "Leveling_Hybrid Bonus_toggle") as bool
			PERMAToggle = JsonUtil.GetIntValue(Filename, "PERMA_Misc Skill Experience Gain_toggle") as bool
			REQUIEMToggle[0] = JsonUtil.GetIntValue(Filename, "REQUIEM_Illusion Skill Experience Gain_toggle") as bool
			REQUIEMToggle[1] = JsonUtil.GetIntValue(Filename, "REQUIEM_Magic Skill Experience Gain_toggle") as bool
			REQUIEMToggle[2] = JsonUtil.GetIntValue(Filename, "REQUIEM_Passive Armor Experience Gain_toggle") as bool
			UIEXTKeyBind = JsonUtil.GetIntValue(Filename, "UIEXT_Level Menu Keybind")
		endif
	endif
EndFunction

Function ListMenu()
	if ChekSkill_Alt
		Skill_Alt = new bool[18]
		_Skill_Alt = new int[18]
		ChekSkill_Alt = false
	endif
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	
	string[] AleteredNames = new string[51]
	int Selection = 0
	
	listMenu.ResetMenu()
    listMenu.SetPropertyStringA("appendEntries", UIExtensionsMenuSetup(AleteredNames))
	
	While Selection >= -1 && IsPlayerInUIEXTMenu
	listMenu.OpenMenu()
	Selection = listMenu.GetResultInt()
		int i = -1
		if (Selection >= 18 && Selection <= 35)
			i = (Selection - 18)
			SkillZero.SetNthEntryValue(0, 0, 1.00)
			PurchaseSkill(i)
			Utility.WaitMenuMode(0.1)
			SkillZero.SetNthEntryValue(0, 0, 0.00)
			if ChekSkillListMenu_Alt
				IsPlayerInUIEXTMenu = False
				ChekSkillListMenu_Alt = false
				UI.CloseCustomMenu()
			endif
		endif
		if Selection >= -1
			listMenu.ResetMenu()
			listMenu.SetPropertyStringA("appendEntries", UIExtensionsMenuSetup(AleteredNames, UIExtensionsMenuPageSetup(i)))
		endif
    EndWhile
EndFunction

state correct_display_skill_values
	string[] Function UIExtensionsMenuSetup(string[] Array, int Page = -1)
				
		int i_current = XPC.GetXP() as Int
		int i_current_rest = XPC.GetRestPoint() as int
		int i_next_pp = (SXPLeveling[7] + (( PERK_COUNT + 1 ) * SXPLeveling[8])) as Int
		
		int[] PageIndex = new int[4]
		
		if Page == -1
			PageIndex[0] = -1
			PageIndex[1] = 0
			PageIndex[2] = 1
			PageIndex[3] = 2
		elseif Page == 0
			PageIndex[0] = 0
			PageIndex[1] = -1
			PageIndex[2] = 1
			PageIndex[3] = 2
		elseif Page == 1
			PageIndex[0] = 1
			PageIndex[1] = 0
			PageIndex[2] = -1
			PageIndex[3] = 2
		elseif Page == 2
			PageIndex[0] = 2
			PageIndex[1] = 0
			PageIndex[2] = 1
			PageIndex[3] = -1
		endif
		
		UIExtensionsMenuFirstPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		UIExtensionsWarriorPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		UIExtensionsMagePage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		UIExtensionsThiefPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)

		return Array
	EndFunction
endstate

string[] Function UIExtensionsMenuSetup(string[] Array, int Page = -1)

	gotostate("correct_display_skill_values")
	UpdateSkills()								;корректное отображение скилов в UI меню
	debug.Notification("Update Skills")
			
	int i_current = XPC.GetXP() as Int
	int i_current_rest = XPC.GetRestPoint() as int
	int i_next_pp = (SXPLeveling[7] + (( PERK_COUNT + 1 ) * SXPLeveling[8])) as Int
	
	int[] PageIndex = new int[4]
	
	if Page == -1
		PageIndex[0] = -1
		PageIndex[1] = 0
		PageIndex[2] = 1
		PageIndex[3] = 2
	elseif Page == 0
		PageIndex[0] = 0
		PageIndex[1] = -1
		PageIndex[2] = 1
		PageIndex[3] = 2
	elseif Page == 1
		PageIndex[0] = 1
		PageIndex[1] = 0
		PageIndex[2] = -1
		PageIndex[3] = 2
	elseif Page == 2
		PageIndex[0] = 2
		PageIndex[1] = 0
		PageIndex[2] = 1
		PageIndex[3] = -1
	endif
	
	UIExtensionsMenuFirstPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
	UIExtensionsWarriorPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
	UIExtensionsMagePage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
	UIExtensionsThiefPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)

	return Array
		
EndFunction

Function UIExtensionsMenuFirstPage(string[] Array, int[] Array1, int i_current, int i_current_rest, int i_next_pp)
	int Page = Array1[0]
	string sPage = ";;" + Page + ";;"
	;/string note
	if Utility.GetINIString("sLanguage:General") == "russian"
		 note = "Чтобы прокачать умение\n используйте МСМ меню"
	else
		 note = "To pump up a skill\n use the MCM menu"
	endif/;
	Array[0] = PlayerName + sPage + -2
	Array[1] = " " + sPage + Page
	;Array[2] = note + sPage
	Array[2] = Pages[1] + sPage + Array1[1] + ";;0" + ";;1"
	Array[3] = Pages[2] + sPage + Array1[2] + ";;0" + ";;1"
	Array[4] = Pages[3] + sPage + Array1[3] + ";;0" + ";;1"
	
	UIExtensionsFooter(Array, Array1, i_current, i_current_rest, i_next_pp, 5, Page)
EndFunction

Function UIExtensionsWarriorPage(string[] Array, int[] Array1, int i_current, int i_current_rest, int i_next_pp)

	int Page = Array1[1]
	string sPage = ";;" + Page + ";;"
	
	Array[12] = Pages[1] + sPage + Array1[0] + ";;"
	Array[13] = " " + sPage + Array1[0] + ";;"
	
	int i = 18
	int iIndex = 0
	While iIndex < 5
		Array[i] = names[iIndex] + " [" + CreateCurrentLevelString(iIndex) + "] " + CreateNextXPString(iIndex, XPtoNextLevel[iIndex]) + LevelMark(i_current, iIndex) + sPage + i
		i += 1
		iIndex += 1
	EndWhile
	
	UIExtensionsFooter(Array, Array1, i_current, i_current_rest, i_next_pp, 36, Page)
EndFunction

Function UIExtensionsMagePage(string[] Array, int[] Array1, int i_current, int i_current_rest, int i_next_pp)
	
	int Page = Array1[2]
	string sPage = ";;" + Page + ";;"
	
	Array[14] = Pages[2] + sPage + Array1[0] + ";;"
	Array[15] = " " + sPage + Array1[0] + ";;"
	
	int i = 23
	int iIndex = 5
	While iIndex < 11
		Array[i] = names[iIndex] + " [" + CreateCurrentLevelString(iIndex) + "] " + CreateNextXPString(iIndex, XPtoNextLevel[iIndex]) + LevelMark(i_current, iIndex) + sPage + i
		i += 1
		iIndex += 1
	EndWhile
	
	UIExtensionsFooter(Array, Array1, i_current, i_current_rest, i_next_pp, 41, Page)
EndFunction

Function UIExtensionsThiefPage(string[] Array, int[] Array1, int i_current, int i_current_rest, int i_next_pp)
	
	int Page = Array1[3]
	string sPage = ";;" + Page + ";;"
	
	Array[16] = Pages[3] + sPage + Array1[0] + ";;"
	Array[17] = " " + sPage + Array1[0] + ";;"
	
	int i = 29
	int iIndex = 11
	While iIndex < 18
		Array[i] = names[iIndex] + " [" + CreateCurrentLevelString(iIndex) + "] " + CreateNextXPString(iIndex, XPtoNextLevel[iIndex]) + LevelMark(i_current, iIndex) + sPage + i
		i += 1
		iIndex += 1
	EndWhile
	
	UIExtensionsFooter(Array, Array1, i_current, i_current_rest, i_next_pp, 46, Page)
EndFunction

Function UIExtensionsFooter(string[] Array, int[] Array1, int i_current, int i_current_rest, int i_next_pp, int iStartIndex, int Page)
	string sPage = ";;" + Page + ";;"
	
	Array[iStartIndex] = " " + sPage + Array1[0] + ";;"
	Array[iStartIndex + 1] = "$General_XP" + sPage + Array1[0] + ";;"
	Array[iStartIndex + 2] = i_current + sPage + Array1[0] + ";;"
	Array[iStartIndex + 3] = "$General_REST" + sPage + Array1[0] + ";;"
	Array[iStartIndex + 4] = i_current_rest + sPage + Array1[0] + ";;"
EndFunction

int Function UIExtensionsMenuPageSetup(int iIndex)
	if iIndex == -1
		return -1
	elseif iIndex < 5
		return 0
	elseif iIndex < 11
		return 1
	else
		return 2
	endif
EndFunction

string Function LevelMark(int CurrentXP, int id)
	string base = ""
	
		if (CurrentXP >= XPtoNextLevel[id]) && (skills[id] < SXPSKillCaps[id])
			base = " [*]"
		else
			if skills[id] < SXPSKillCaps[id]
				base = " [" + (((CurrentXP as float/XPtoNextLevel[id] as float) * 100) as int) as string + "%]"
			endif
		endif
	
	return base
EndFunction

Function StringGenerator(int Repetitions, string[] Array, string Base)
	int iIndex = 0
	int iElement = Repetitions
	While iIndex < IElement
	string Result = Base + iIndex as string
		Array[iIndex] = Result
		iIndex += 1
	EndWhile
EndFunction

Function StringHLGenerator(int Repetitions, string[] Array, string Base, float[] Array1, string[] Array2)
	int iIndex = 0
	int iElement = Repetitions
	While iIndex < IElement
		string Result = Base + iIndex as string + "{\n"+"}{" + HLSuffix(Array1[iIndex], Array2[iIndex]) + "}"
		Array[iIndex] = Result
		iIndex += 1
	EndWhile
EndFunction

string Function HLSuffix(float InputNumber, string Decimal)
	int iLength = StringUtil.GetLength(Decimal)
	string Suffix = ""
	
	if iLength > 3
		Suffix = StringUtil.Substring(Decimal, 4)
		if Suffix == "%"
			InputNumber *= 100.0
		else
			Suffix = " " + Suffix
		endif
	endif
	
	int Dec = (StringUtil.GetNthChar(Decimal, 1)) as int
	if Dec != 0
		Dec += 1
	endif
	
	return StringUtil.Substring(InputNumber as string, 0, StringUtil.Find(InputNumber as string, ".", 0) + Dec) + Suffix
EndFunction

string Function DecToHex(int ColorInt)
	string HexLine = "0123456789ABCDEF"
	string ColorinHex = ""
	int Counter = 0
	int Result
	While Counter < 6
		Result = (ColorInt % 16)
		ColorinHex = StringUtil.GetNthChar(HexLine, Result) + ColorinHex		
		ColorInt = (ColorInt / 16)
		Counter += 1
	EndWhile
	
	return "#" + ColorinHex
EndFunction

int Function GetOptionFlags( int nCurrent, int nNext )
	if ( nCurrent >= nNext )
		return OPTION_FLAG_NONE
	endif
	return OPTION_FLAG_DISABLED
EndFunction

Function ClearAccumulatedXP()
	string[] sOptions = new string[19]
	sOptions[0] = names[0]
	sOptions[1] = names[1]
	sOptions[2] = names[2]
	sOptions[3] = names[3]
	sOptions[4] = names[4]
	sOptions[5] = names[5]
	sOptions[6] = names[6]
	sOptions[7] = names[7]
	sOptions[8] = names[8]
	sOptions[9] = names[9]
	sOptions[10] = names[10]
	sOptions[11] = names[11]
	sOptions[12] = names[12]
	sOptions[13] = names[13]
	sOptions[14] = names[14]
	sOptions[15] = names[15]
	sOptions[16] = names[16]
	sOptions[17] = names[17]
	sOptions[18] = "$All" 
	Int iInput = ((Self as Form) as UILIB_1).ShowList("$General_Message_3", sOptions, 0, 0)
		if !ShowMessage("$General_Message_3a", true, "$Yes", "$No")
			return
		endif
		if iInput == 18
			int iIndex = 0
			int iElement = names.Length
			While iIndex < iElement
				ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[iIndex])
				aVI.SetSkillExperience(0.0)
				iIndex += 1
			EndWhile
		else
			ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[iInput])
			aVI.SetSkillExperience(0.0)
		endif
EndFunction

Function DeactivateSXP(bool bToggle)
	if bToggle
		UI.InvokeBool("Journal Menu", "_root.QuestJournalFader.Menu_mc.CloseMenu", false)
		XPC.Start()
		XPoll.Start()
		XPH.Start()
		XPW.Start()
		XPME.GetOwningQuest().Start()
		OnConfigInit()
		OnConfigRegister()
	else
		Pages = new String[1]
		Pages[0] = "$Page_General"
		XPoll.SetPollingInterval(0.0)
		UnregisterForAllKeys()
		XPC.Stop()
		XPoll.Stop()
		XPH.Stop()
		XPW.Stop()
		XPME.GetOwningQuest().Stop()
		UI.InvokeStringA("Journal Menu", "_root.ConfigPanelFader.configPanel" + ".setPageNames", Pages)
		ForcePageReset()
	endif
EndFunction

Function MasterToggleSwitch()
	int iIndex = 0
	int iElement = (XPC.SXPToggle.Length - 1)
	
	While iIndex < iElement
		XPC.SXPToggle[iIndex] = XPC.SXPToggle[57]
		iIndex += 1
	EndWhile
	ForcePageReset()
EndFunction

Function PERMAMiscExpGain()
	GlobalVariable xMAALCTrapMaxPoisonCount = (Game.GetFormFromFile( 0x000FE6D6, "PerkusMaximus_Master.esp" ) as GlobalVariable)
	Quest xMAQuestConjuration = (Game.GetFormFromFile( 0x00010092, "PerkusMaximus_Master.esp" ) as Quest)
	
	xMAALCTrapMaxPoisonCount.SetValue(0)
	if xMAQuestConjuration.IsRunning()
		(xMAQuestConjuration as xMAQuestConjurationScript).fHarvestSkillGain = 0.0
	endif
	
	if PERMAToggle
		xMAALCTrapMaxPoisonCount.SetValue(2)
		if xMAQuestConjuration.IsRunning()
			(xMAQuestConjuration as xMAQuestConjurationScript).fHarvestSkillGain = 3.0
		endif
	endif
EndFunction
;/
Function REQUIEMPassiveArmorGain()
	Quest REQ_Playerscripts = Game.GetFormFromFile( 0x00AD3B16, "Requiem.esp" ) as Quest
	if REQ_Playerscripts.IsRunning()
	
		REQ_PassiveArmorTraining REQ_PAT = REQ_Playerscripts.GetAlias(4) as REQ_PassiveArmorTraining
		
		REQ_PAT.Skillgain = new float[6]
		if REQUIEMToggle[2]
			REQ_PAT.Skillgain[0] = 0.025000
			REQ_PAT.Skillgain[1] = 0.350000
			REQ_PAT.Skillgain[2] = 0.050000
			REQ_PAT.Skillgain[3] = 0.050000
			REQ_PAT.Skillgain[4] = 0.100000
			REQ_PAT.Skillgain[5] = 0.025000
		endif
		REQ_PAT.Adjust_Values()
		;debug.Notification("REQUIEMPassiveArmorGain")
	endif
	
EndFunction
/;
Function SecurityWait()
	Quest[] QuestArray = new Quest[5]
	QuestArray[0] = XPC
	QuestArray[1] = XPW
	QuestArray[2] = XPoll
	QuestArray[3] = XPH
	QuestArray[4] = XPME.GetOwningQuest()
	
	int i = 0
	int ie = QuestArray.Length
	int isafetycounter = 0
	While i < ie
		bool IsQuestRunning = QuestArray[i].IsRunning()
		if (IsQuestRunning) || (isafetycounter == 10)
			i += 1
			isafetycounter = 0
		else
			isafetycounter += 1
		endif
		Utility.Wait(0.1)
	EndWhile
EndFunction

Function SetDefaultValuesGeneral()
	
	SXPDefaultGeneral = new float[7]
	SXPGeneral = new float[7]
	SXPGeneralStrings = new string[7]
	SXPGeneralDecimal = new string[7]
	SXPGeneralSID = new int[14]
	SXPGeneralHLStrings = new string[14]
	SXPNotificationColor = 0xFFFFFF
	XPC.SXPNotificationColorString = "#FFFFFF"
	SXPLockpickingFix = True
	
	SXPDefaultGeneral[0] = 1.0
	SXPDefaultGeneral[1] = 1.0
	SXPDefaultGeneral[2] = 1.0
	SXPDefaultGeneral[3] = 2.0
	SXPDefaultGeneral[4] = 16000.0
	SXPDefaultGeneral[5] = 2000.0
	SXPDefaultGeneral[6] = 1.2
	
	SXPGeneral[0] = 1.0
	SXPGeneral[1] = 1.0
	SXPGeneral[2] = 1.0
	SXPGeneral[3] = 2.0
	SXPGeneral[4] = 16000.0
	SXPGeneral[5] = 2000.0
	SXPGeneral[6] = 1.2
	
	SXPGeneralStrings[0] = "$General_XP Rate"
	SXPGeneralStrings[1] = "$General_XP Multiplier"
	SXPGeneralStrings[2] = "$General_Actor XP Multiplier"
	SXPGeneralStrings[3] = "$General_Polling Interval"
	SXPGeneralStrings[4] = "$General_Maximum Rest Points"
	SXPGeneralStrings[5] = "$General_Rest Points Per Hour Of Sleep"
	SXPGeneralStrings[6] = "$General_Rest Bonus Multiplier"
	
		
	SXPGeneralDecimal[0] = "{0} %"
	SXPGeneralDecimal[1] = "{1}"
	SXPGeneralDecimal[2] = "{1}"
	SXPGeneralDecimal[3] = "{1} sec"
	SXPGeneralDecimal[4] = "{0}"
	SXPGeneralDecimal[5] = "{0}"
	SXPGeneralDecimal[6] = "{1}"

	StringGenerator(SXPGeneralHLStrings.Length, SXPGeneralHLStrings, "$General_HL_")
EndFunction

Function SetDefaultValuesGameStats()
	SXPDefaultGameStats = new int[58]
	XPoll.SXPGameStats = new int[58]
	SXPGameStatsStrings = new string[59]
	SXPGameStatsHLStrings = new string[59]
	SXPGameStatsSID = new int[59]
	SXPGameStatsHeaderStrings = new string[9]
	SXPGameStatsContainerToggle = False
	
	SXPGameStatsHeaderStrings[0] = "$Header_General"
	SXPGameStatsHeaderStrings[1] = "$Header_Quest"
	SXPGameStatsHeaderStrings[2] = "$Header_Combat"
	SXPGameStatsHeaderStrings[3] = "$Header_Magic"
	SXPGameStatsHeaderStrings[4] = "$Header_Crafting"
	SXPGameStatsHeaderStrings[5] = "$Header_Crime"
	SXPGameStatsHeaderStrings[6] = "$Header_Economy"
	SXPGameStatsHeaderStrings[7] = "$Header_Unsupported"
	SXPGameStatsHeaderStrings[8] = "$Header_Actor"
	
	SXPDefaultGameStats[0] = 1000 ;LocationsDiscovered
	SXPDefaultGameStats[1] = 2500 ;DungeonsCleared
	SXPDefaultGameStats[2] = 2500 ;StandingStonesFound
	SXPDefaultGameStats[3] = 10 ;FoodEaten
	SXPDefaultGameStats[4] = 250 ;BooksRead
	SXPDefaultGameStats[5] = 2000 ;HorsesOwned
	SXPDefaultGameStats[6] = 5000 ;HousesOwned
	SXPDefaultGameStats[7] = 500 ;StoresInvestedIn
	SXPDefaultGameStats[8] = 500 ;Persuasions
	SXPDefaultGameStats[9] = 500 ;Bribes
	SXPDefaultGameStats[10] = 500 ;Intimidations
	SXPDefaultGameStats[11] = 100 ;DiseasesContracted
	SXPDefaultGameStats[12] = 1000 ;QuestsCompleted
	SXPDefaultGameStats[13] = 500 ;MiscObjectivesCompleted
	SXPDefaultGameStats[14] = 10000 ;MainQuestsCompleted
	SXPDefaultGameStats[15] = 5000 ;SideQuestsCompleted
	SXPDefaultGameStats[16] = 7500 ;TheCompanionsQuestsCompleted
	SXPDefaultGameStats[17] = 7500 ;CollegeOfWinterholdQuestsCompleted
	SXPDefaultGameStats[18] = 7500 ;ThievesGuildQuestsCompleted
	SXPDefaultGameStats[19] = 7500 ;TheDarkBrotherhoodQuestsCompleted
	SXPDefaultGameStats[20] = 7500 ;CivilWarQuestsCompleted
	SXPDefaultGameStats[21] = 7500 ;DaedricQuestsCompleted
	SXPDefaultGameStats[22] = 1000 ;QuestlinesCompleted
	SXPDefaultGameStats[23] = 10000 ;DawnguardQuestsCompleted
	SXPDefaultGameStats[24] = 10000 ;DragonbornQuestsCompleted
	SXPDefaultGameStats[25] = 200 ;SneakAttacks
	SXPDefaultGameStats[26] = 5000 ;BrawlsWon
	SXPDefaultGameStats[27] = 1000 ;DragonSoulsCollected
	SXPDefaultGameStats[28] = 2000 ;WordsOfPowerLearned
	SXPDefaultGameStats[29] = 2500 ;ShoutsLearned
	SXPDefaultGameStats[30] = 5000 ;ShoutsMastered
	SXPDefaultGameStats[31] = 10 ;IngredientsHarvested
	SXPDefaultGameStats[32] = 100 ;IngredientsEaten
	SXPDefaultGameStats[33] = 1000 ;NirnrootsFound
	SXPDefaultGameStats[34] = 2000 ;Murders
	SXPDefaultGameStats[35] = 150 ;Trespasses
	SXPDefaultGameStats[36] = 150 ;NecksBitten
	SXPDefaultGameStats[37] = 150 ;SoulsTrapped
	SXPDefaultGameStats[38] = 500 ;JailEscapes
	SXPDefaultGameStats[39] = 0 ;Backstabs
	SXPDefaultGameStats[40] = 0 ;Assaults
	SXPDefaultGameStats[41] = 500 ;HorsesStolen
	SXPDefaultGameStats[42] = 10 ;HorseRiding
	SXPDefaultGameStats[43] = 1000 ;SpellLearned
	SXPDefaultGameStats[44] = 10 ;CraftingAType
	SXPDefaultGameStats[45] = 10 ;CraftingBType
	SXPDefaultGameStats[46] = 100 ;Mining
	SXPDefaultGameStats[47] = 25 ;UsingWoodBlock
	SXPDefaultGameStats[48] = 25 ;UsingSawMill
	SXPDefaultGameStats[49] = 25 ;UsingGrainMill
	SXPDefaultGameStats[50] = 5 ;StealAType
	SXPDefaultGameStats[51] = 5 ;StealBType
	SXPDefaultGameStats[52] = 100 ;Lockpicking
	SXPDefaultGameStats[53] = 5 ;ItemBuy
	SXPDefaultGameStats[54] = 5 ;ItemSell
	SXPDefaultGameStats[55] = 25 ;CraftingATypeJewelry
	SXPDefaultGameStats[56] = 120 ;CraftingATypeSkyforge
	SXPDefaultGameStats[57] = 200 ;LockpickingNoBrokenLockpicks

	int iIndex = 0
	int iElement = XPoll.SXPGameStats.Length
	While iIndex < iElement

		XPoll.SXPGameStats[iIndex] = SXPDefaultGameStats[iIndex]
		
		if iIndex == 39 || iIndex == 40
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_NotSupported{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 42
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_HorseRiding{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 43
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_SpellLearned{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 44
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_CraftingAType{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 45
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_CraftingBType{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 46
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_Mining{\n"+"}{" + SXPDefaultGameStats[iIndex] + "%}"
		elseif iIndex == 50
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_StealAType{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 51
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_StealBType{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 52
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_Lockpicking{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 53
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_ItemBuy{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 54
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_ItemSell{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		elseif iIndex == 55
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_CraftingATypeJewelry{\n"+"}{" + SXPDefaultGameStats[iIndex] + "%}"
		elseif iIndex == 56
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_CraftingATypeSkyforge{\n"+"}{" + SXPDefaultGameStats[iIndex] + "%}"
		elseif iIndex == 57
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_NoBrokenLockpicks{\n"+"}{" + SXPDefaultGameStats[iIndex] + "%}"
		else
			SXPGameStatsHLStrings[iIndex] = "$GameStats_HL_Generic{\n"+"}{" + SXPDefaultGameStats[iIndex] + "}"
		endif
		if iIndex == 0
			SXPGameStatsHLStrings[58] = "$GameStats_HL_ContainerSteal"
		endif
		iIndex += 1
	EndWhile
	
	SXPGameStatsStrings[0] = "$GameStats_Location Discovered"
	SXPGameStatsStrings[1] = "$GameStats_Dungeons Cleared"
	SXPGameStatsStrings[2] = "$GameStats_Standing Stones Found"
	SXPGameStatsStrings[3] = "$GameStats_Food Eaten"
	SXPGameStatsStrings[4] = "$GameStats_Books Read"
	SXPGameStatsStrings[5] = "$GameStats_Horses Owned"
	SXPGameStatsStrings[6] = "$GameStats_Houses Owned"
	SXPGameStatsStrings[7] = "$GameStats_Stores Invested In"
	SXPGameStatsStrings[8] = "$GameStats_Persuasions"
	SXPGameStatsStrings[9] = "$GameStats_Bribes"
	SXPGameStatsStrings[10] = "$GameStats_Intimidations"
	SXPGameStatsStrings[11] = "$GameStats_Diseases Contracted"
	SXPGameStatsStrings[12] = "$GameStats_Quests Completed"
	SXPGameStatsStrings[13] = "$GameStats_Misc Objectives Completed"
	SXPGameStatsStrings[14] = "$GameStats_Main Quests Completed"
	SXPGameStatsStrings[15] = "$GameStats_Side Quests Completed"
	SXPGameStatsStrings[16] = "$GameStats_Companion Quests Completed"
	SXPGameStatsStrings[17] = "$GameStats_Winterhold College Quests Completed"
	SXPGameStatsStrings[18] = "$GameStats_Thieves Guild Quests Completed"
	SXPGameStatsStrings[19] = "$GameStats_Dark Brotherhood Quests Completed"
	SXPGameStatsStrings[20] = "$GameStats_Civil War Quests Completed"
	SXPGameStatsStrings[21] = "$GameStats_Daedric Quests Completed"
	SXPGameStatsStrings[22] = "$GameStats_Questlines Completed"
	SXPGameStatsStrings[23] = "$GameStats_Dawnguard Quests Completed"
	SXPGameStatsStrings[24] = "$GameStats_Dragonborn Quests Completed"
	SXPGameStatsStrings[25] = "$GameStats_Sneak Attacks"
	SXPGameStatsStrings[26] = "$GameStats_Brawls Won"
	SXPGameStatsStrings[27] = "$GameStats_Dragon Souls Collected"
	SXPGameStatsStrings[28] = "$GameStats_Words of Power Learned"
	SXPGameStatsStrings[29] = "$GameStats_Shouts Learned"
	SXPGameStatsStrings[30] = "$GameStats_Shouts Mastered"
	SXPGameStatsStrings[31] = "$GameStats_Ingredients Harvested"
	SXPGameStatsStrings[32] = "$GameStats_Ingredients Eaten"
	SXPGameStatsStrings[33] = "$GameStats_Nirnroots Found"
	SXPGameStatsStrings[34] = "$GameStats_Murders"
	SXPGameStatsStrings[35] = "$GameStats_Trespasses"
	SXPGameStatsStrings[36] = "$GameStats_Necks Bitten"
	SXPGameStatsStrings[37] = "$GameStats_Souls Trapped"
	SXPGameStatsStrings[38] = "$GameStats_Jail Escapes"
	SXPGameStatsStrings[39] = "$GameStats_Backstabs"
	SXPGameStatsStrings[40] = "$GameStats_Assaults"
	SXPGameStatsStrings[41] = "$GameStats_Horses Stolen"
	SXPGameStatsStrings[42] = "$GameStats_Horse Riding"
	SXPGameStatsStrings[43] = "$GameStats_Spells Learned"
	SXPGameStatsStrings[44] = "$GameStats_Crafting"
	SXPGameStatsStrings[45] = "$GameStats_Crating 2"
	SXPGameStatsStrings[46] = "$GameStats_Mining"
	SXPGameStatsStrings[47] = "$GameStats_Chopping Wood"
	SXPGameStatsStrings[48] = "$GameStats_Saw Mill"
	SXPGameStatsStrings[49] = "$GameStats_Grain Mill"
	SXPGameStatsStrings[50] = "$GameStats_Pickpocket/Container Steal"
	SXPGameStatsStrings[51] = "$GameStats_Stealing"
	SXPGameStatsStrings[52] = "$GameStats_Lockpicking"
	SXPGameStatsStrings[53] = "$GameStats_Item Buy"
	SXPGameStatsStrings[54] = "$GameStats_Item Sell"
	SXPGameStatsStrings[55] = "$GameStats_CraftingJewelry"
	SXPGameStatsStrings[56] = "$GameStats_CraftingSkyforge"
	SXPGameStatsStrings[57] = "$GameStats_Lockpicking No Broken Lockpicks"
	SXPGameStatsStrings[58] = "$GameStats_Container Steal_toggle"
EndFunction

Function SetDefaultToggleGameStats()
	XPC.SXPToggle = new bool[58]
	SXPToggleSID = new int[58]
	SXPToggleStrings = new string[58]
	SXPToggleHLStrings = new string[2]
	
	int iIndex = 0
	int iElement = XPC.SXPToggle.Length
	While iIndex < iElement
		if iIndex == 57
			SXPToggleStrings[iIndex] = "$Master_Switch"
		elseif iIndex == 56
			SXPToggleStrings[iIndex] = "$Rest_Message"
		elseif iIndex == 55
			SXPToggleStrings[iIndex] = "$Actor_Message"
		else
			SXPToggleStrings[iIndex] = SXPGameStatsStrings[iIndex]
		endif
		XPC.SXPToggle[iIndex] = False
		iIndex += 1
	EndWhile
	XPC.SXPToggle[14] = True
	XPC.SXPToggle[21] = True
	XPC.SXPToggle[55] = True
	XPC.SXPToggle[56] = True
	
	SXPToggleHLStrings[0] = "$Toggle_HL_Generic"
	SXPToggleHLStrings[1] = "$Toggle_HL_Master_Switch"
EndFunction

Function SetDefaultValuesActor()
	SXPDefaultActor = new float[35]
	XPW.SXPActor = new float[35]
	SXPActorStrings = new string[35]
	SXPActorHLStrings = new string[35]
	SXPActorSID = new int[35]
	SXPActorHeaderStrings = new string[4]
	SXPActorDecimal = new string[35]
	
	SXPActorHeaderStrings[0] = "$Header_Actor_Fundamental"
	SXPActorHeaderStrings[1] = "$Header_Actor_General"
	SXPActorHeaderStrings[2] = "$Header_Actor_Creature"
	SXPActorHeaderStrings[3] = "$Header_Actor_Special"
	
	
	
	
	SXPDefaultActor[0] = 100 ;FUND_BASE
	SXPDefaultActor[1] = 1 ;FUND_MULT
	SXPDefaultActor[2] = 10 ;FUND_ONE
	SXPDefaultActor[3] = 20 ;FUND_TWO
	SXPDefaultActor[4] = 50 ;FUND_THREE
	SXPDefaultActor[5] = 0.01 ;MULT_HEALTH
	SXPDefaultActor[6] = 0.04 ;MULT_SPELL
	SXPDefaultActor[8] = 1.0 ;MULT_ARMORRATING
	SXPDefaultActor[9] = 0.0 ;BASE_PREY
	SXPDefaultActor[10] = 0.00 ;MULT_PREY
	SXPDefaultActor[11] = 500 ;BASE_MAMMOTH
	SXPDefaultActor[12] = 0.1 ;MULT_MAMMOTH
	SXPDefaultActor[13] = 1000 ;BASE_GIANT
	SXPDefaultActor[14] = 0.15 ;MULT_GIANT
	SXPDefaultActor[15] = 500 ;BASE_WEREWOLF
	SXPDefaultActor[16] = 0.2 ;MULT_WEREWOLF
	SXPDefaultActor[17] = 100 ;BASE_AUTOMATION
	SXPDefaultActor[18] = 0.4 ;MULT_AUTOMATION
	SXPDefaultActor[19] = 1500 ;BASE_DRAGONPRIEST
	SXPDefaultActor[20] = 0.25 ;MULT_DRAGONPRIEST
	SXPDefaultActor[21] = 2500 ;BASE_DRAGON
	SXPDefaultActor[22] = 0.25 ;MULT_DRAGON
	SXPDefaultActor[23] = 10000 ;BASE_ALDUIN
	SXPDefaultActor[24] = 0.1 ;MULT_ALDUIN
	SXPDefaultActor[25] = 100 ;BASE_VAMPIRE
	SXPDefaultActor[26] = 0.1 ;MULT_VAMPIRE
	SXPDefaultActor[27] = 200 ;BASE_DAEDRA
	SXPDefaultActor[28] = 0.15 ;MULT_DAEDRA
	SXPDefaultActor[29] = 150 ;BASE_PARA
	SXPDefaultActor[30] = 0.1 ;MULT_PARA
	SXPDefaultActor[31] = 200 ;BASE_KNOCKDOWN
	SXPDefaultActor[32] = 0.15 ;MULT_KNOCKDOWN
	SXPDefaultActor[33] = 250 ;BASE_NOPUSH
	SXPDefaultActor[34] = 0.1 ;MULT_NOPUSH

	
	int iIndex = 0
	int iElement = XPW.SXPActor.Length
	While iIndex < iElement
		XPW.SXPActor[iIndex] = SXPDefaultActor[iIndex]
		if iIndex == 9
			SXPActorDecimal[iIndex] = "{0}"
		elseif SXPDefaultActor[iIndex] <= 1
			SXPActorDecimal[iIndex] = "{2}"
		else
			SXPActorDecimal[iIndex] = "{0}"
		endif
		iIndex += 1
	EndWhile
	
	SXPActorStrings[0] = "$Actor_Fundamental (Base)"
	SXPActorStrings[1] = "$Actor_Fundamental (Multiplier)"
	SXPActorStrings[2] = "$Actor_Correctional Value 1 (Multiplier)"
	SXPActorStrings[3] = "$Actor_Correctional Value 2 (Multiplier)"
	SXPActorStrings[4] = "$Actor_Correctional Value 3 (Multiplier)"
	SXPActorStrings[5] = "$Actor_Health (Multiplier)"
	SXPActorStrings[6] = "$Actor_Spell (Multiplier)"
	SXPActorStrings[8] = "$Actor_Armor Rating (Multiplier)"
	SXPActorStrings[9] = "$Actor_Prey (Base)"
	SXPActorStrings[10] = "$Actor_Prey (Multiplier)"
	SXPActorStrings[11] = "$Actor_Mammoth (Base)"
	SXPActorStrings[12] = "$Actor_Mammoth (Multiplier)"
	SXPActorStrings[13] = "$Actor_Giant (Base)"
	SXPActorStrings[14] = "$Actor_Giant (Multiplier)"
	SXPActorStrings[15] = "$Actor_Werewolf (Base)"
	SXPActorStrings[16] = "$Actor_Werewolf (Multiplier)"
	SXPActorStrings[17] = "$Actor_Automation (Base)"
	SXPActorStrings[18] = "$Actor_Automation (Multiplier)"
	SXPActorStrings[19] = "$Actor_Dragonpriest (Base)"
	SXPActorStrings[20] = "$Actor_Dragonpriest (Multiplier)"
	SXPActorStrings[21] = "$Actor_Dragon (Base)"
	SXPActorStrings[22] = "$Actor_Dragon (Multiplier)"
	SXPActorStrings[23] = "$Actor_Alduin (Base)"
	SXPActorStrings[24] = "$Actor_Alduin (Multiplier)"
	SXPActorStrings[25] = "$Actor_Vampire (Base)"
	SXPActorStrings[26] = "$Actor_Vampire (Multiplier)"
	SXPActorStrings[27] = "$Actor_Daedra (Base)"
	SXPActorStrings[28] = "$Actor_Daedra (Multiplier)"
	SXPActorStrings[29] = "$Actor_No Paralysis (Base)"
	SXPActorStrings[30] = "$Actor_No Paralysis (Multiplier)"
	SXPActorStrings[31] = "$Actor_No Knockdown (Base)"
	SXPActorStrings[32] = "$Actor_No Knockdown (Multiplier)"
	SXPActorStrings[33] = "$Actor_Not Pushable (Base)"
	SXPActorStrings[34] = "$Actor_Not Pushable (Multiplier)"

	StringHLGenerator(SXPActorHLStrings.Length, SXPActorHLStrings, "$Actor_HL_", SXPDefaultActor, SXPActorDecimal)
EndFunction

Function SetDefaultValuesLeveling()
	SXPDefaultLeveling = new float[13]
	SXPLeveling = new float[13]
	SXPLevelingStrings = new string[17]
	SXPLevelingHLStrings = new string[17]
	SXPLevelingSID = new int[17]
	SXPLevelingHeaderStrings = new string[7]
	SXPLevelingDecimal = new string[13]
	SXPSKillCaps = new int[18]
	SXPSkillCapString = new string[19]
	SXPLevelingHybridBonusToggle = False
	
	XPH.FurnitureMarkerIndex = XPH.FurnitureMarker.Length
	SXPActionToGainLevelPrayKeyBind = -1
	
	SXPLevelingHeaderStrings[0] = "$Header_Leveling_Default_Fundamental"
	SXPLevelingHeaderStrings[1] = "$Header_Leveling_Skill"
	SXPLevelingHeaderStrings[2] = "$Header_Leveling_Perk"
	SXPLevelingHeaderStrings[3] = "$Header_Leveling_Player_Level_Bonus"
	SXPLevelingHeaderStrings[4] = "$Header_Skill_Caps"
	SXPLevelingHeaderStrings[5] = "$Header_Leveling_Hybrid_Bonus"
	SXPLevelingHeaderStrings[6] = "$Header_Leveling_Action_To_Gain_Level"
	
	SXPDefaultLeveling[0] = 0.5  ;DEFAULT_CORR_ONE	"leveling_default_correctional value 1" : 1
	SXPDefaultLeveling[1] = 10 ;DEFAULT_CORR_TWO	"leveling_default_correctional value 2" : 1
	SXPDefaultLeveling[2] = 1000 ;NOVICE			"leveling_skill bonus_novice" : 1000,
	SXPDefaultLeveling[3] = 2500 ;APPRENTICE		"leveling_skill bonus_apprentice" : 1000,
	SXPDefaultLeveling[4] = 5000 ;ADEPT				"leveling_skill bonus_adept" : 1000,
	SXPDefaultLeveling[5] = 10000 ;EXPERT			"leveling_skill bonus_expert" : 1000,
	SXPDefaultLeveling[6] = 50000 ;MASTER			"leveling_skill bonus_master" : 1000,
	SXPDefaultLeveling[7] = 20000 ;BASE_PER_PERK	0
	SXPDefaultLeveling[8] = 5000 ;OFFSET_PER_PERK	0
	SXPDefaultLeveling[9] = 10 ;PLAYER_LEVEL_STEP_BONUS	0
	SXPDefaultLeveling[10] = 0.05  ;PLAYER_LEVEL_PERCENT_BONUS	0
	SXPDefaultLeveling[11] = 0 ;ACTIONTOGAINLEVEL_SLEEP
	SXPDefaultLeveling[12] = 0 ;ACTIONTOGAINLEVEL_BLESSING
	
	int iIndex = 0
	int iElement = SXPLeveling.Length
	While iIndex < iElement
		SXPLeveling[iIndex] = SXPDefaultLeveling[iIndex]
		if iIndex == 10
			SXPLevelingDecimal[iIndex] = "{1} %"
		elseif iIndex == 11 || iIndex == 12
			SXPLevelingDecimal[iIndex] = "{0}"
		elseif SXPDefaultLeveling[iIndex] < 1.0
			SXPLevelingDecimal[iIndex] = "{2}"
		else
			SXPLevelingDecimal[iIndex] = "{0}"
		endif
		iIndex += 1
	EndWhile
	
	int i = 0
	int ie = SXPSkillCapString.Length
	While i < ie
		if i == 18
			SXPSkillCapString[i] = "$All"
		else
			ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(stats[i])
			string sSkillName = aVI.GetName()
			SXPSKillCaps[i] = 100
			SXPSkillCapString[i] = sSkillName + ": " + SXPSKillCaps[i]
		endif
		i += 1
	EndWhile
	
	SXPLevelingStrings[0] = "$Leveling_Default_Correctional Value 1"
	SXPLevelingStrings[1] = "$Leveling_Default_Correctional Value 2"
	SXPLevelingStrings[2] = "$Leveling_Skill Bonus_Novice"
	SXPLevelingStrings[3] = "$Leveling_Skill Bonus_Apprentice"
	SXPLevelingStrings[4] = "$Leveling_Skill Bonus_Adept"
	SXPLevelingStrings[5] = "$Leveling_Skill Bonus_Expert"
	SXPLevelingStrings[6] = "$Leveling_Skill Bonus_Master"
	SXPLevelingStrings[7] = "$Leveling_Perk_Base"
	SXPLevelingStrings[8] = "$Leveling_Perk_Offset"
	SXPLevelingStrings[9] = "$Leveling_Player_Level_Bonus_Step"
	SXPLevelingStrings[10] = "$Leveling_Player_Level_Bonus_Percentage"
	SXPLevelingStrings[11] = "$Leveling_Action_To_Gain_Level Sleep"
	SXPLevelingStrings[12] = "$Leveling_Action_To_Gain_Level Praying"
	SXPLevelingStrings[13] = "$Leveling_Action_To_Gain_Level Praying Animation"
	SXPLevelingStrings[14] = "$Leveling_Action_To_Gain_Level Praying Keybind"
	SXPLevelingStrings[15] = "$Leveling_Skill_Cap"
	SXPLevelingStrings[16] = "$Leveling_Hybrid Bonus_toggle"

	StringHLGenerator(SXPLeveling.Length, SXPLevelingHLStrings, "$Leveling_HL_", SXPDefaultLeveling, SXPLevelingDecimal)
	SXPLevelingHLStrings[13] = "$Leveling_HL_13"
	SXPLevelingHLStrings[14] = "$Leveling_HL_14"
	SXPLevelingHLStrings[15] = "$Leveling_HL_15"
	SXPLevelingHLStrings[16] = "$Leveling_HL_16"
EndFunction

Function SetDefaultValuesMagicEffect(int iLength, float[] Array, string[] Array1, int[] Array2, string[] Array3, string[] Array4)
	SXPMagicEffectSID = Utility.CreateIntArray(iLength)
	SXPMagicEffectDefault = Array
	SXPMagicEffectHeaderStrings = Array1
	SXPMagicEffectHeaderIndex = Array2
	SXPMagicEffectStrings = Array3
	SXPMagicEffectHLStrings = Array4
	
	SXPMagicEffectGeneralSID = new int[3]
	SXPMagicEffectGeneralDefault = new float[3]
	SXPMagicEffectGeneralStrings = new string[3]
	SXPMagicEffectGeneralHLStrings = new string[3]
	SXPMagicEffectGeneralDecimal = new string[3]
	
	SXPMagicEffectGeneralDefault[0] = XPME.SXPMagicEffectGeneral[0]
	SXPMagicEffectGeneralDefault[1] = XPME.SXPMagicEffectGeneral[1]
	SXPMagicEffectGeneralDefault[2] = XPME.SXPMagicEffectGeneral[2]
	
	SXPMagicEffectGeneralStrings[0] = "$MagicEffect_Polling Interval"
	SXPMagicEffectGeneralStrings[1] = "$MagicEffect_Maximum Negative Bonus"
	SXPMagicEffectGeneralStrings[2] = "$MagicEffect_Maximum Positive Bonus"
	
	SXPMagicEffectGeneralDecimal[0] = "{1} sec"
	SXPMagicEffectGeneralDecimal[1] = "{0} %"
	SXPMagicEffectGeneralDecimal[2] = "{0} %"
	
	StringHLGenerator(XPME.SXPMagicEffectGeneral.Length, SXPMagicEffectGeneralHLStrings, "$MagicEffect_HL_", SXPMagicEffectGeneralDefault, SXPMagicEffectGeneralDecimal)
EndFunction

Function SetDefaultValuesCompatibility()
	SXPCompatibilityHeaderStrings = new string[5]
	SXPCompatibilitySID = new int[15]
	SXPCompatiblityStrings = new string[15]
	SXPCompatibilityHLStrings = new string[15]
	SXPCompatibilityDecimal = new string[7]
	SXPCompatibility = new float[7]
	REQUIEMToggle = new bool[3]
	UIEXTKeyBind = -1
	
	PUPreset = new string[5]
	PresetIndex = new int[2]
	SXPDefaultCompatibility = new float[7]
	
	SXPCompatibilityHeaderStrings[0] = "$Header_Compatibility_PERMA"
	SXPCompatibilityHeaderStrings[1] = "$Header_Compatibility_REQUIEM"
	SXPCompatibilityHeaderStrings[2] = "$Header_Compatibility_UIEXT"
	SXPCompatibilityHeaderStrings[3] = "$Header_Compatibility_SLEEPTOGAINEXPERIENCE"
	
	SXPCompatibilityHeaderStrings[4] = "$Header_Compatibility_PAPYRUSUTIL"
	
	PERMAToggle = True
	
	REQUIEMToggle[0] = True
	REQUIEMToggle[1] = True
	REQUIEMToggle[2] = True
	
	SXPDefaultCompatibility[0] = 0.9 ; PERMA
	SXPDefaultCompatibility[1] = 10.0
	SXPDefaultCompatibility[2] = 0.2
	SXPDefaultCompatibility[3] = 10.0
	SXPDefaultCompatibility[4] = 0.1
	SXPDefaultCompatibility[5] = 750.0 ; REQUIEM
	SXPDefaultCompatibility[6] = 100000.0
	
	
	
	PUPreset[0] = "Preset 1"
	PUPreset[1] = "Preset 2"
	PUPreset[2] = "Preset 3"
	PUPreset[3] = "Preset 4"
	PUPreset[4] = "Preset 5"
	
	int i = 0
	int ie =  SXPCompatibility.Length
		While i < ie
			SXPCompatibility[i] = SXPDefaultCompatibility[i]
			if i == 1 || i == 3 || i == 5 || i == 6
				SXPCompatibilityDecimal[i] = "{0}"
			else
				SXPCompatibilityDecimal[i] = "{1}"
			endif
			i += 1
		EndWhile
	
	SXPCompatiblityStrings[0] = "$PERMA_Wayfarer Skill Experience Gain"
	SXPCompatiblityStrings[1] = "$PERMA_Speech Skill Experience Gain"
	SXPCompatiblityStrings[2] = "$PERMA_Enchanting Skill Experience Gain"
	SXPCompatiblityStrings[3] = "$PERMA_Dexterity Skill Experience Gain"
	SXPCompatiblityStrings[4] = "$PERMA_Passive Armor Experience Gain"
	SXPCompatiblityStrings[5] = "$REQUIEM_Enchanting Skill Experience Gain"
	SXPCompatiblityStrings[6] = "$REQUIEM_Light Armor Skill Experience Gain"
	SXPCompatiblityStrings[7] = "$REQUIEM_Illusion Skill Experience Gain_toggle"
	SXPCompatiblityStrings[8] = "$REQUIEM_Magic Skill Experience Gain_toggle"
	SXPCompatiblityStrings[9] = "$REQUIEM_Passive Armor Experience Gain_toggle"
	SXPCompatiblityStrings[10] = "$UIEXT_Level Menu Keybind"
	
	SXPCompatiblityStrings[11] = "$PU_Rename Preset"
	SXPCompatiblityStrings[12] = "$PU_Load Preset"
	SXPCompatiblityStrings[13] = "$PU_Save Current Settings"
	SXPCompatiblityStrings[14] = "$PERMA_Misc Skill Experience Gain_toggle"

	StringGenerator(SXPCompatibilityHLStrings.Length, SXPCompatibilityHLStrings, "$Compatibility_HL_")
EndFunction

float Function OnFakeDeath(float fPassedNumberOfSouls)
	float f_current = XPC.GetXP()
	XPC.GV_XP.SetValue(0)
	XPC.GV_RP.SetValue(0)
	float f_numdragonsouls = fPassedNumberOfSouls
	if f_numdragonsouls > 0 && f_current > 0
		int i_rnumdragonsouls = Utility.RandomInt(1, Math.Ceiling(PlayerREF.GetLevel() / 10.0))
		float f_rnumexperiencepercent = (Utility.RandomInt(1, 9) / 10.0)
		if i_rnumdragonsouls > f_numdragonsouls as int
			i_rnumdragonsouls = f_numdragonsouls as int
		endif
		float f_rnumexperience = f_current * f_rnumexperiencepercent
		if zzzSXPNRFTWDevilsTradeMessage.Show(i_rnumdragonsouls, f_rnumexperience, (f_rnumexperiencepercent * 100), f_numdragonsouls) == 0
			PlayerREF.ModActorValue("Dragonsouls", (i_rnumdragonsouls * -1.0))
			XPC.DevilsTradeGainXPMessage(f_rnumexperience)
			f_current -= f_rnumexperience
		endif
	endif
	
	return f_current
EndFunction

Function SXPRewardPlayer(float fDragonSoulNumber, float fSXPExperience)
	if fDragonSoulNumber > 0
		XPoll.SilentIncrement(27, fDragonSoulNumber as int)
		float fbase = PlayerREF.GetBaseActorValue("Dragonsouls")
		PlayerREF.SetActorValue("Dragonsouls", fbase + fDragonSoulNumber)
	endif
	if fSXPExperience > 0
		XPC.DevilsTradeGainXPMessage(fSXPExperience)
	endif
EndFunction

;Функции предзагрузки

Function MenugeneratorInt_PreLoad(int Repetitions, string[] Array, int[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = ""
			Name = StringUtil.Substring(Array[iIndex], 1)
			Array1[iIndex] = JsonUtil.GetIntValue(Filename, Name)
			iIndex += 1	
		EndWhile
EndFunction

Function MenugeneratorBool_PreLoad(int Repetitions, string[] Array, bool[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = StringUtil.Substring(Array[iIndex], 1) + "_toggle"
			;bool Value = Array1[iIndex]
			Array1[iIndex] = JsonUtil.GetIntValue(Filename, Name) as bool
			iIndex += 1
		EndWhile
EndFunction

Function MenugeneratorFloat_PreLoad(int Repetitions, string[] Array, float[] Array1, string Filename)
	int iIndex = 0
	int iElement = Repetitions
		While iIndex < iElement
			string Name = StringUtil.Substring(Array[iIndex], 1)
			;float Value = Array1[iIndex]
			Array1[iIndex] = JsonUtil.GetFloatValue(Filename, Name)
			iIndex += 1
		EndWhile
		
EndFunction

Function MenugeneratorIndividual_PreLoad(string Filename)
			SXPNotificationColor = JsonUtil.GetIntValue(Filename, "General_Notification Color")
			SXPLockpickingFix = JsonUtil.GetIntValue(Filename, "General_Prevent XP Gain_toggle") as bool
			SXPGameStatsContainerToggle = JsonUtil.GetIntValue(Filename, "GameStats_Container Steal_toggle") as bool
			SXPLevelingHybridBonusToggle = JsonUtil.GetIntValue(Filename, "Leveling_Hybrid Bonus_toggle") as bool
			PERMAToggle = JsonUtil.GetIntValue(Filename, "PERMA_Misc Skill Experience Gain_toggle") as bool
			REQUIEMToggle[0] = JsonUtil.GetIntValue(Filename, "REQUIEM_Illusion Skill Experience Gain_toggle") as bool
			REQUIEMToggle[1] = JsonUtil.GetIntValue(Filename, "REQUIEM_Magic Skill Experience Gain_toggle") as bool
			REQUIEMToggle[2] = JsonUtil.GetIntValue(Filename, "REQUIEM_Passive Armor Experience Gain_toggle") as bool
			UIEXTKeyBind = JsonUtil.GetIntValue(Filename, "UIEXT_Level Menu Keybind")
EndFunction

		; Переключатель на дефолтную формулу расчета GetNextXP
		; Проверяются ряд значений из пресета
bool[] Skill_Alt			;для альтернативной прокачки
int[] _Skill_Alt
bool ChekSkill_Alt = true	;для тех кто поставил этот патч в текущую игру
bool ChekSkillListMenu_Alt = true

int TotalXpoint
int[] TotalXpointArray
int[] SliderXpointArray
int[] SliderXpoint

Function ChekPresetCreateGetXPointArray()
	if ChekPreset1() || XPME.SXPMagicEffectGeneral[0] != 0.0
		gotostate("Default")
		UpdateSkills()
		CountTotalXpoint()
		;debug.trace("gotostate(Default)")		
	else		
		gotostate("")
		;TotalXpoint = 0
		int i = 0
		while i < 200
			GetXPointArray[i] = GetNextXP(1, i)
			;TotalXpoint += GetXPointArray[i]
			;debug.trace("GetXPointArray[" + i +"] = " + GetXPointArray[i])
			i += 1
		endwhile
		UpdateSkills()
		CountTotalXpoint()
	endif
EndFunction

Function CountTotalXpoint()
	Skill_Alt = new bool[18]
	_Skill_Alt = new int[18]
	ChekSkill_Alt = false	
	;debug.trace("Skill_Alt = " + Skill_Alt)
	SliderXpoint = new int[18]
	SliderXpointArray = new int[100]
	TotalXpoint = 0
	int i = 0
	int ii = 0
	TotalXpointArray = new int[18]		
	while i < 18
		TotalXpointArray[i] = PlayerREF.GetBaseActorValue(stats[i]) as Int
		;debug.trace("TotalXpointArray[" + i + "] = " + TotalXpointArray[i])
		i += 1
	endwhile
	i = 0
	ii = TotalXpointArray[i]
	while i < 17			
		if ii < TotalXpointArray[i + 1]
			ii = ii
		else
			ii = TotalXpointArray[i + 1]
		endif
		i += 1
	endwhile
	while ii < 100		
		TotalXpoint += GetNextXP(1, ii)
		SliderXpointArray[ii] = TotalXpoint
		ii += 1
	endwhile
EndFunction

bool Function ChekPreset1()
	int i = 0
	int ie = XPME.SXPMagicEffect.Length
		while i < ie
			;debug.trace("XPME.SXPMagicEffect[" + i + "] = " + XPME.SXPMagicEffect[i])
			if XPME.SXPMagicEffect[i] != 0			
				return true	
			endif
			i += 1
		endwhile
	return false
EndFunction

state Default
	Function CreateMaxSkillLevelSlider(int i, int ii)
		;debug.trace("State = " + getstate())
		int i_skill = 0		
		while ( i < ii )
			int i_stats = XPC.GetXP() as int
			i_skill = PlayerREF.GetBaseActorValue(stats[i]) as Int				
			if i_skill < 100
				int z1 = i_skill
				int i_lvl = GetNextXP(i, i_skill)				
				while (i_stats >= i_lvl)	
					i_skill += 1
					i_lvl += GetNextXP(i, i_skill)
					if i_skill == 100
						i_stats = i_lvl - 1
					endif
					;debug.trace("i_lvl = " + i_lvl)
				endwhile				
				;debug.trace("i_stats = " + i_stats)
				int z2 = i_skill - z1
				LvlUpMax[i] = z2
			else 
				LvlUpMax[i] = 0
			endif
			i += 1
		endwhile
	EndFunction

	string[] Function UIExtensionsMenuSetup(string[] Array, int Page = -1)
		;debug.trace("State = " + getstate())		
		int i_current = XPC.GetXP() as Int
		int i_current_rest = XPC.GetRestPoint() as int
		int i_next_pp = (SXPLeveling[7] + (( PERK_COUNT + 1 ) * SXPLeveling[8])) as Int
		
		int[] PageIndex = new int[4]
		
		if Page == -1
			PageIndex[0] = -1
			PageIndex[1] = 0
			PageIndex[2] = 1
			PageIndex[3] = 2
		elseif Page == 0
			PageIndex[0] = 0
			PageIndex[1] = -1
			PageIndex[2] = 1
			PageIndex[3] = 2
		elseif Page == 1
			PageIndex[0] = 1
			PageIndex[1] = 0
			PageIndex[2] = -1
			PageIndex[3] = 2
		elseif Page == 2
			PageIndex[0] = 2
			PageIndex[1] = 0
			PageIndex[2] = 1
			PageIndex[3] = -1
		endif
		
		UIExtensionsMenuFirstPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		;UIExtensionsWarriorPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		;UIExtensionsMagePage(Array, PageIndex, i_current, i_current_rest, i_next_pp)
		;UIExtensionsThiefPage(Array, PageIndex, i_current, i_current_rest, i_next_pp)

		return Array
	EndFunction
	
	Function PurchaseSkillSlide(int id, int val)
	;debug.trace("State = " + getstate())
		int i_old = PlayerREF.GetBaseActorValue(stats[id]) as Int
			;debug.trace("i_old = " + i_old)
		if i_old + SXPActionToGainLevel[id] >= SXPSKillCaps[id]
			UpdateSpecificSkill(id)		
			return
		elseif XPC.GetXP() as Int < XPtoNextLevel[id]
			return
		endif	
		;XPC.UseXP(XPtoNextLevel[id])	
		if SXPActionToGainLevelToggle
			string sSkill = id as string + ";"
			if id < 10
				sSkill = "0" + id as string + ";"
			endif
			SXPActionToGainLevelOrder += sSkill
			SXPActionToGainLevel[id] = SXPActionToGainLevel[id] + 1
			UpdateSpecificSkill(id)		
			return
		endif	
		if Skill_Alt[id]
			SkillAdvanceAlt(id, val)
		else
			SkillAdvanceSlide(id, val)
		endif
		Int i_new = PlayerREF.GetBaseActorValue(stats[id]) as Int
		;debug.trace("i_new = " + i_new)
		int zz = 0
		While i_new > i_old
			i_new = i_new - 1
			If i_new <= 100
				zz += GetNextXP(id, i_new)
				;debug.trace("zz = " + zz)
			EndIf		
		EndWhile
		;debug.trace("zz = " + zz)
		XPC.UseXP(zz)
	EndFunction
endstate

;Вместо Event OnStoryIncreaseSkill(string asSkill) из WISkillIncrease02.psc когда сломалась прокачка
Function StoryIncreaseSkill()
	; === Alteration ===
	If PlayerREF.GetAV("Alteration") >= PCSkillMaster.GetValue()
		PCAlterationMaster.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Alteration") >= PCSkillExpert.GetValue()
		PCAlterationExpert.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Alteration") >= PCSkillAdept.GetValue()
		PCAlterationAdept.SetValue(0)
	EndIf

	; === Conjuration ===
	If PlayerREF.GetAV("Conjuration") >= PCSkillMaster.GetValue()
		PCConjurationMaster.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Conjuration") >= PCSkillExpert.GetValue()
		PCConjurationExpert.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Conjuration") >= PCSkillAdept.GetValue()
		PCConjurationAdept.SetValue(0)
	EndIf

	; === Destruction ===
	If PlayerREF.GetAV("Destruction") >= PCSkillMaster.GetValue()
		PCDestructionMaster.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Destruction") >= PCSkillExpert.GetValue()
		PCDestructionExpert.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Destruction") >= PCSkillAdept.GetValue()
		PCDestructionAdept.SetValue(0)
	EndIf

	; === Illusion ===
	If PlayerREF.GetAV("Illusion") >= PCSkillMaster.GetValue()
		PCIllusionMaster.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Illusion") >= PCSkillExpert.GetValue()
		PCIllusionExpert.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Illusion") >= PCSkillAdept.GetValue()
		PCIllusionAdept.SetValue(0)
	EndIf

	; === Restoration ===
	If PlayerREF.GetAV("Restoration") >= PCSkillMaster.GetValue()
		PCRestorationMaster.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Restoration") >= PCSkillExpert.GetValue()
		PCRestorationExpert.SetValue(0)
	EndIf
	If PlayerREF.GetAV("Restoration") >= PCSkillAdept.GetValue()
		PCRestorationAdept.SetValue(0)
	EndIf
EndFunction

GlobalVariable Property PCSkillAdept  Auto  
GlobalVariable Property PCSkillExpert  Auto  
GlobalVariable Property PCSkillMaster  Auto  

GlobalVariable Property PCAlterationAdept  Auto  
GlobalVariable Property PCAlterationExpert  Auto  
GlobalVariable Property PCAlterationMaster  Auto  

GlobalVariable Property PCConjurationAdept  Auto  
GlobalVariable Property PCConjurationExpert  Auto  
GlobalVariable Property PCConjurationMaster  Auto  

GlobalVariable Property PCDestructionAdept  Auto  
GlobalVariable Property PCDestructionExpert  Auto  
GlobalVariable Property PCDestructionMaster  Auto  

GlobalVariable Property PCIllusionAdept  Auto  
GlobalVariable Property PCIllusionExpert  Auto  
GlobalVariable Property PCIllusionMaster  Auto  

GlobalVariable Property PCRestorationAdept  Auto  
GlobalVariable Property PCRestorationExpert  Auto  
GlobalVariable Property PCRestorationMaster  Auto  




