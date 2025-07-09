Scriptname RFAB_Menu extends Quest  

RFAB_XP_Handler Property XPHandler Auto
RFAB_XP_Alias Property Updater Auto
Actor Property Player Auto
Perk Property MarksmanPerk Auto

int[] ActorValues
int[] XPSumPerLevel

string[] Page2Texts
string[] Page3Texts
string[] Page4Texts
string[] Property SkillListEnglishMenu Auto Hidden
string[] Property SkillListRussianMenu Auto Hidden

int Property Hotkey Hidden
	int Function Get()
		return JSONUtil.GetIntValue("RFAB_XP_Settings.json", "Hotkey")
	EndFunction
	Function Set(int aiValue)
		Updater.UnregisterForAllKeys()
		JSONUtil.SetIntValue("RFAB_XP_Settings.json", "Hotkey", aiValue)
		JsonUtil.Save("RFAB_XP_Settings.json")
		Updater.RegisterForKey(Hotkey)
	EndFunction
EndProperty

int Property Offset_X Hidden
	int Function Get()
		return JSONUtil.GetIntValue("RFAB_XP_Settings.json", "MenuOffset_X")
	EndFunction
	Function Set(int aiValue)
		JSONUtil.SetIntValue("RFAB_XP_Settings.json", "MenuOffset_X", aiValue)
		JsonUtil.Save("RFAB_XP_Settings.json")
	EndFunction
EndProperty

int Property Offset_Y Hidden
	int Function Get()
		return JSONUtil.GetIntValue("RFAB_XP_Settings.json", "MenuOffset_Y")
	EndFunction
	Function Set(int aiValue)
		JSONUtil.SetIntValue("RFAB_XP_Settings.json", "MenuOffset_Y", aiValue)
		JsonUtil.Save("RFAB_XP_Settings.json")
	EndFunction
EndProperty

int Property Scale Hidden
	int Function Get()
		return JSONUtil.GetIntValue("RFAB_XP_Settings.json", "MenuScale")
	EndFunction
	Function Set(int aiValue)
		JSONUtil.SetIntValue("RFAB_XP_Settings.json", "MenuScale", aiValue)
		JsonUtil.Save("RFAB_XP_Settings.json")
	EndFunction
EndProperty

int Property NotificationColor Hidden
	int Function Get()
		return JSONUtil.GetIntValue("RFAB_XP_Settings.json", "Notification Color")
	EndFunction
	Function Set(int aiValue)
		JSONUtil.SetIntValue("RFAB_XP_Settings.json", "Notification Color", aiValue)
		JSONUtil.SetStringValue("RFAB_XP_Settings.json", "Notification Color", DecToHex(aiValue))
		JsonUtil.Save("RFAB_XP_Settings.json")
	EndFunction
EndProperty

MagicEffect Property PaladinChecker Auto

Event OnInit()
    SetValues()
    Page2Texts = new string[30]
	Page3Texts = new string[30]
	Page4Texts = new string[30]
    CalculateXP()
    SetupStatsMenu()
	SetupWeaponMenu()
	SetupClassesMenu()
	RegisterForModEvent("RFAB_ClassesFramework", "OnClassesFrameworkEvent") 
EndEvent

Function CalculateXP()
	int[] BaseXPCost = new int[4]
	BaseXPCost[0] = 10
	BaseXPCost[1] = 20
	BaseXPCost[2] = 30
	BaseXPCost[3] = 30

	int[] AdditiveXPCost = new int[4]
	AdditiveXPCost[0] = 20
	AdditiveXPCost[1] = 30
	AdditiveXPCost[2] = 60
	AdditiveXPCost[3] = 90

    XPSumPerLevel = new int[101]
	int i = 5
	int j = 0
	int k = 0

	XPSumPerLevel[4] = 0
	while j < 4
		while i < 25
			k = i + j * 25 
			XPSumPerLevel[k] = XPSumPerLevel[k - 1] + BaseXPCost[j] + AdditiveXPCost[j] * (k - 5) ; ����� �� 5 ���� ��-�� ����, ��� ������ � �������� � 5 ����������
			i += 1
		endwhile
		i = 0
		j += 1
	endwhile
EndFunction

Function Open()
	CalculateActorValues()

	int SkillID = XPMenu(ActorValues)

	int i = ActorValues[SkillID]
	int SkillMaxRange
	int CurrentSkillXP = XPSumPerLevel[i - 1]
	while i < 100
		if XPSumPerLevel[i] - CurrentSkillXP <= XPHandler.PlayerXP.GetValueInt() 
			i += 1
			SkillMaxRange = i 
		else
			SkillMaxRange = i
			i = 100
		endif
	endwhile
	
	if (SkillID < 18) && (SkillID != -1)
		string slider = "||" + ""+ "|| " + ""  + "||" + ActorValues[SkillID] + "||" + SkillMaxRange

		int Result = SliderMenuMult(slider, ActorValues[SkillID], SkillListRussianMenu[SkillID] )
		if (Result != -1) && (Result > ActorValues  [SkillID])
			Player.SetActorValue(SkillListEnglishMenu[SkillID], Result)
			ActorValues[SkillID] = Result 
			int XPSpent =  XPSumPerLevel[Result - 1] - CurrentSkillXP 
			XPHandler.PlayerXP.Mod(-XPSpent)
		endif
		Open()
	elseif SkillID == 18
		int Color = ColorPicker(XPHandler.GetXPColor() as int, TitleText = "���� �����������", InfoText = "") 
		if Color != -1
			NotificationColor = Color
			Open()
		endif
	endif
	;RegisterForKey(HotkeyValue)
endfunction

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

Function CalculateActorValues()
	int i = 0
	while i < 18
		ActorValues[i] = Player.GetBaseActorValue(SkillListEnglishMenu[i]) as int
		i += 1
	endwhile
EndFunction

Int Function XPMenu(int[] Buttons = none, Bool CancelIsFirstButton = true, Int FontSize = 22, Int Align = 1, Bool html = true, Bool WaitForResult = true)  
    If UI.IsMenuOpen("CustomMenu") 
        UI.CloseCustomMenu() 
		return -1
    else 
		UI.OpenCustomMenu("RFAB_Menu")

		String[] InitParams = new String[17] 
		InitParams[0] = XPHandler.PlayerXP.GetValueInt()  as int
		InitParams[1] = Game.GetPlayerExperience() as int
		InitParams[2] = Game.GetExperienceForLevel(Player.GetLevel()) as int
		InitParams[3] = CancelIsFirstButton as int
		InitParams[4] = WaitForResult as int
		InitParams[5] = 28
		InitParams[6] = 1
		InitParams[7] = 15
		InitParams[8] = 54
		InitParams[9] = 42
		InitParams[10] = 276
		InitParams[11] = 277
		InitParams[12] = FontSize
		InitParams[13] = Align
		InitParams[14] = html as int
		InitParams[15] = Hotkey
		InitParams[16] = Scale
		InitParams[17] = Offset_X
		InitParams[18] = Offset_Y
		
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.InitMessageBox", InitParams) 
		UI.InvokeIntA("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons", Buttons)
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetPage2", Page2Texts)
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetPage3", Page3Texts)
		UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetPage4", Page4Texts)
		If WaitForResult 
			return XPMenuResult()
		Endif
	endif
EndFunction

Int Function XPMenuResult() 
	bool stats_loaded = false
	bool weapon_loaded = false
	bool classes_loaded = false
    While (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") < 9) ;wait for user to accept or cancel
		if (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 6) 
			stats_loaded = true
			SetupStatsMenu()
			UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.UpdatePage2", Page2Texts)
		elseif (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 7) 

			weapon_loaded = true
			SetupWeaponMenu()
			UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.UpdatePage3", Page3Texts)	
		elseif (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 8) 

			classes_loaded = true
			SetupClassesMenu()

			UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.UpdatePage4", Page4Texts)			
		endif
    EndWhile 
    if (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 9)  
		int result = UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
		UI.CloseCustomMenu()
		return result
	else
		UI.CloseCustomMenu()
		return -1	
	endif
endfunction

int function SliderMenuMult(String SliderParams, Float InitialValues, String TitleText = "", String AcceptText = "$Accept", String CancelText = "$Cancel", Bool WaitForResult = true)     
    If UI.IsMenuOpen("CustomMenu") 
        UI.CloseCustomMenu()  
    Endif 
    
    UI.OpenCustomMenu("RFAB_SliderMenu")
    
    String[] InitParams = new String[13] 
   
    InitParams[0] = TitleText
    InitParams[1] = AcceptText
    InitParams[2] = CancelText
    InitParams[3] = WaitForResult as int
    InitParams[4] = Game.UsingGamepad() as int
    InitParams[5] = 28
    InitParams[6] = 1
    InitParams[7] = 15
    InitParams[8] = 54
    InitParams[9] = 42
    InitParams[10] = 276
    InitParams[11] = 277
    InitParams[12] = Hotkey
	
    UI.InvokeStringA("CustomMenu", "_root.RFABSliderMenu_MC.InitSliderMenu", InitParams)
    UI.InvokeString("CustomMenu", "_root.RFABSliderMenu_MC.SetSliders", SliderParams)
    UI.InvokeFloat("CustomMenu", "_root.RFABSliderMenu_MC.SetSliderValues", InitialValues) 
    
    If WaitForResult 
        return GetSliderMenuMultResult()
    Endif
EndFunction

int Function GetSliderMenuMultResult( ) 
    While (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFABSliderMenu_MC.Status") < 9) ;wait for user to accept or cancel

    EndWhile 
    If UI.GetInt("CustomMenu", "_root.RFABSliderMenu_MC.Status") == 9 ;user accepted new value 
       	int result = UI.GetInt("CustomMenu", "_root.RFABSliderMenu_MC.SliderResult") 
		UI.CloseCustomMenu()
		return result 
	else
		UI.CloseCustomMenu()
		return -1
    Endif 
    UI.CloseCustomMenu()
EndFunction

int Function ColorPicker(Int InitialColor = 16711680, String TitleText = "", String InfoText = "", String AcceptText = "$Accept", String CancelText = "$Cancel", Bool WaitForResult = true) 
    If UI.IsMenuOpen("CustomMenu") 
        UI.CloseCustomMenu()
    Endif 
    
    Int[] HSL = DbColorFunctions.ColorIntToHSL(InitialColor)
    
    UI.OpenCustomMenu("RFAB_ColorPicker")
    
    String[] InitParams = New String[17] 
    InitParams[0] = HSL[0]
    InitParams[1] = HSL[1]
    InitParams[2] = HSL[2]
    InitParams[3] = TitleText
    InitParams[4] = InfoText
    InitParams[5] = AcceptText
    InitParams[6] = CancelText
    InitParams[7] = WaitForResult as int
    InitParams[8] = Game.UsingGamepad() as int
    InitParams[9] = 28
    InitParams[10] = 1
    InitParams[11] = 15
    InitParams[12] = 54
    InitParams[13] = 42
    InitParams[14] = 276
    InitParams[15] = 277
    InitParams[16] = Hotkey

    UI.InvokeStringA("CustomMenu", "_root.RFAB_ColorPickerMC.InitColorPicker", InitParams)
    
    If WaitForResult 
        return GetColorPickerResult()
    Endif
EndFunction

int Function GetColorPickerResult() 
    while (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFAB_ColorPickerMC.Status") == 1)

    endwhile 
    
    int ReturnColorInt = -1
    
    if UI.GetInt("CustomMenu", "_root.RFAB_ColorPickerMC.Status") == 2 ; user accepted new value 
        ReturnColorInt = UI.GetInt("CustomMenu", "_root.RFAB_ColorPickerMC.ColorInt")
    endif
    UI.CloseCustomMenu()
    
    return ReturnColorInt
EndFunction

Function SetupStatsMenu()

	int i = 0
	while i < Page2Texts.length
		Page2Texts[i] = 0
		i = i + 1
	endwhile
	
	Page2Texts[0] = Player.GetActorValue("DamageResist") as Int
	Page2Texts[1] = Player.GetActorValue("MagicResist") as Int
	Page2Texts[2] = Player.GetActorValue("FireResist") as Int
	Page2Texts[3] = Player.GetActorValue("FrostResist") as Int
	Page2Texts[4] = Player.GetActorValue("ElectricResist") as Int
	Page2Texts[5] = Player.GetActorValue("PoisonResist") as Int
	Page2Texts[6] = Player.GetActorValue("DiseaseResist") as Int
	Page2Texts[7] = Player.GetActorValue("AbsorbChance") as Int
	Page2Texts[8] = Player.GetActorValue("HeavyArmorSkillAdvance") as Int
	

	Page2Texts[9] =  (100 - LimitActorValue("DestructionMod" , 0, 50)) as Int + "%"
	Page2Texts[10] = (100 - LimitActorValue("RestorationMod" , 0, 50)) as Int + "%"
	Page2Texts[11] = (100 - LimitActorValue("AlterationMod" , 0, 50)) as Int + "%"
	Page2Texts[12] = (100 - LimitActorValue("IllusionMod" , 0, 50)) as Int + "%"
	Page2Texts[13] = (100 - LimitActorValue("ConjurationMod" , 0, 50)) as Int + "%"
	

	float health_regen = Player.GetActorValue("HealRate") * Player.GetActorValue("HealRateMult") / 100 as Float
	if Player.IsInCombat()
		health_regen = health_regen  * Game.GetGameSettingFloat("fCombatHealthRegenRateMult")
	endif
	if health_regen < 0.01
		health_regen = 0.00
	endif

	float health_restore_mag = 0
	float magicka_restore_mag = 0
	float stamina_restore_mag = 0
	
	health_restore_mag = RFAB_PapyrusFunctions.GetActorNumericHealthRegen(Player)

	string total_health_regen = (Player.GetActorValueMax("Health")* health_regen/100 + health_restore_mag) as string

	total_health_regen = StringUtil.Split(total_health_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(total_health_regen,".")[1],0,2)
	string health_restore_magstr  = StringUtil.Split(health_restore_mag as string,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(health_restore_mag as string,".")[1],0,2)
	Page2Texts[14] = StringUtil.Split(health_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(health_regen,".")[1],0,2) + "%" + " + " + health_restore_magstr + "��. = " + total_health_regen + "/���"
	
	
	magicka_restore_mag = RFAB_PapyrusFunctions.GetActorNumericMagickaRegen(Player)

	float magicka_regen = Player.GetActorValue("MagickaRate") * Player.GetActorValue("MagickaRateMult") / 100 as Float
	if Player.IsInCombat()
		magicka_regen = magicka_regen  * Game.GetGameSettingFloat("fCombatMagickaRegenRateMult")
	endif
	if magicka_regen < 0.01
		magicka_regen = 0.00
	endif

	string total_magicka_regen = (Player.GetActorValueMax("Magicka")* magicka_regen / 100 as Float + magicka_restore_mag) as string

	total_magicka_regen = StringUtil.Split(total_magicka_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(total_magicka_regen,".")[1],0,2)
	string magicka_restore_magstr  = StringUtil.Split(magicka_restore_mag as string,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(magicka_restore_mag as string,".")[1],0,2)
	Page2Texts[15] = StringUtil.Split(magicka_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(magicka_regen,".")[1],0,2) + "%" + " + " + magicka_restore_magstr + "��. = " + total_magicka_regen + "/���"
	
	stamina_restore_mag = RFAB_PapyrusFunctions.GetActorNumericStaminaRegen(Player)

	float stamina_regen = Player.GetActorValue("StaminaRate") * Player.GetActorValue("StaminaRateMult") / 100 as Float
	if Player.IsInCombat()
		stamina_regen = stamina_regen  * Game.GetGameSettingFloat("fCombatStaminaRegenRateMult")
	endif
	
	if stamina_regen < 0.01
		stamina_regen = 0.00
	endif
			
	string total_stamina_regen = (Player.GetActorValueMax("Stamina")* stamina_regen/ 100 as Float + stamina_restore_mag) as string
	
	total_stamina_regen = StringUtil.Split(total_stamina_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(total_stamina_regen,".")[1],0,2)
	string stamina_restore_magstr  = StringUtil.Split(stamina_restore_mag as string,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(stamina_restore_mag as string,".")[1],0,2)
	Page2Texts[16] = StringUtil.Split(stamina_regen,".")[0] + "."  + StringUtil.Substring(StringUtil.Split(stamina_regen,".")[1],0,2) + "%" + " + " + stamina_restore_magstr + "��. = " + total_stamina_regen + "/���"
	
	string total_sneak = (Player.GetActorValue("Sneak") + Player.GetActorValue("Sneak")*Player.GetActorValue("SneakMod")/100) as int
	Page2Texts[17] = Player.GetActorValue("Sneak") as Int + " ��. + " + Player.GetActorValue("SneakMod") as Int + "% = " + total_sneak
	Page2Texts[18] = (Player.GetActorValue("MovementNoiseMult") * 100) as int
	Page2Texts[19] = Player.GetActorValue("SpeedMult") as Int
Endfunction

function SetupWeaponMenu()

	int i = 0
	while i < Page3Texts.length
		Page3Texts[i] = 0
		i = i + 1
	endwhile
	Page3Texts[0] = (Player.GetActorValue("WeaponSpeedMult") * 100) as int + "%"
	if Player.GetActorValue("AlterationSkillAdvance") < -90
		Page3Texts[1] = "10%"
	else
		Page3Texts[1] = (Player.GetActorValue("AlterationSkillAdvance") + 100) as int + "%"
	endif
	Page3Texts[2] = (Player.GetActorValue("OneHandedSkillAdvance") + 100) as int + "%"
	Page3Texts[3] = (Player.GetActorValue("TwoHandedSkillAdvance") + 100) as int + "%"
	Page3Texts[4] = (Player.GetActorValue("PickpocketSkillAdvance") + 100) as int + "%"
	Page3Texts[5] = Player.GetActorValue("OneHandedMod") as int
	Page3Texts[6] = Player.GetActorValue("TwoHandedMod") as int
	Page3Texts[7] = Player.GetActorValue("PickpocketMod") as int
	Page3Texts[8] = Player.GetActorValue("MarksmanMod") as int
	
	ammo current_ammo = PO3_SKSEFunctions.GetEquippedAmmo(Player)
	
	if current_ammo != none
		
		int ammo_penetration
		if current_ammo.HasKeywordString("REQ_KW_ArmorPiercingArrow_Tier5")
			ammo_penetration = 250
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingArrow_Tier4")
			ammo_penetration = 200
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingArrow_Tier3")
			ammo_penetration = 150
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingArrow_Tier2")
			ammo_penetration = 100
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingArrow_Tier1")
			ammo_penetration = 50
	
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingBolt_Tier5")
			ammo_penetration = 300
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingBolt_Tier4")
			ammo_penetration = 250
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingBolt_Tier3")
			ammo_penetration = 200
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingBolt_Tier2")
			ammo_penetration = 150
		elseif current_ammo.HasKeywordString("REQ_KW_ArmorPiercingBolt_Tier1")
			ammo_penetration = 100
		endif
		if Player.HasPerk(MarksmanPerk)
			Page3Texts[8] = Player.GetActorValue("MarksmanMod") as int - ammo_penetration
		endif
		Page3Texts[9] = ammo_penetration
	endif
	
	Weapon RightHandWeapon = Player.GetEquippedWeapon(false)
	
	if RightHandWeapon != none
		Page3Texts[10] = RightHandWeapon.GetName()
		Page3Texts[11] = GetMaterial(RightHandWeapon)
		if Page3Texts[10] != "�����"
			Page3Texts[12] = StringUtil.Substring(RightHandWeapon.GetBaseDamage(),0,3)
		else
			Page3Texts[12] = Player.GetActorValue("UnarmedDamage") as int
		endIf
		Page3Texts[13] = StringUtil.Substring(RightHandWeapon.GetSpeed(),0,3)
		Page3Texts[14] = StringUtil.Substring(RightHandWeapon.GetReach(),0,3)
		Page3Texts[15] = StringUtil.Substring(RightHandWeapon.GetStagger(),0,3)
	else
		Page3Texts[10] = "�"
		Page3Texts[11] = ""
		Page3Texts[12] = ""
		Page3Texts[13] = ""
		Page3Texts[14] = ""
		Page3Texts[15] = ""
	endif
	
	if RightHandWeapon.HasKeywordString("WeapTypeBow")
		if RightHandWeapon.HasKeywordString("REQ_KW_WeaponType_CrossbowHeavy") || RightHandWeapon.HasKeywordString("REQ_KW_WeaponType_BowHeavy")
			Page3Texts[14] = "�������"
		elseif RightHandWeapon.HasKeywordString("REQ_KW_WeaponType_CrossbowLight") || RightHandWeapon.HasKeywordString("REQ_KW_WeaponType_BowLight")
			Page3Texts[14] = "������"
		endif
	endif
	
	Weapon LeftHandWeapon = Player.GetEquippedWeapon(true)
	
	if LeftHandWeapon != none
		Page3Texts[16] = LeftHandWeapon.GetName()
		Page3Texts[17] = GetMaterial(LeftHandWeapon)
		if Page3Texts[16] == "�����" 
			Page3Texts[18] = Player.GetActorValue("UnarmedDamage") as int
		else
			Page3Texts[18] = StringUtil.Substring(LeftHandWeapon.GetBaseDamage(),0,3)
		endif
		Page3Texts[19] = StringUtil.Substring(LeftHandWeapon.GetSpeed(),0,3)
		Page3Texts[20] = StringUtil.Substring(LeftHandWeapon.GetReach(),0,3)
		Page3Texts[21] = StringUtil.Substring(LeftHandWeapon.GetStagger(),0,3)
	else
		Page3Texts[16] = "�"
		Page3Texts[17] = ""
		Page3Texts[18] = ""
		Page3Texts[19] = ""
		Page3Texts[20] = ""
		Page3Texts[21] = ""
	endif
endfunction

function SetupClassesMenu()

	;if (RFAB_PapyrusFunctions.HasActiveMagicEffect(Player, PaladinChecker))
		Page4Texts = new string[2]
		Page4Texts[0] = "������� �����"
		Page4Texts[1] = "����� �����������"
		Page4Texts[2] = "������ ������"
	;else
	;	Page4Texts = new string[1]
	;	Page4Texts[0] = "����� �����������"
	;endif
	
	
	
EndFunction
float function LimitActorValue(string Value, int min = 0, int max = 100)
	int actorvalue = Player.GetActorValue(Value) as Int
	if actorvalue > max
		actorvalue = max
	elseif actorvalue < min
		actorvalue = min
	endif
	return actorvalue
endfunction	

string function GetMaterial(form akForm)
	string material
	if akForm.HasKeywordString("WeapMaterialDaedric")
		material = "������������"
	elseif akForm.HasKeywordString("DLC1WeapMaterialDragonbone")
		material = "��������"
	elseif akForm.HasKeywordString("WeapMaterialEbony")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialGlass")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialOrcish")
		material = "������"
	elseif akForm.HasKeywordString("WeapMaterialElven")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialDwarven")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialSteel")
		material = "��������"
	elseif akForm.HasKeywordString("WeapMaterialIron")
		material = "��������"
	elseif akForm.HasKeywordString("WeapMaterialWood")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialDraugr")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialDraugrHoned")
		material = "���������� ���������"
	elseif akForm.HasKeywordString("WeapMaterialFalmer")
		material = "����������"
	elseif akForm.HasKeywordString("WeapMaterialFalmerHoned")
		material = "���������� �������"
	elseif akForm.HasKeywordString("WeapMaterialImperial")
		material = "���������"
	elseif akForm.HasKeywordString("DLC2WeaponMaterialNordic")
		material = "��������"
	elseif akForm.HasKeywordString("DLC2WeaponMaterialStalhrim")
		material = "������������"
	elseif akForm.HasKeywordString("RFAB_KW_WeaponMaterial_NordicSilver")
		material = "�������� ���������"
	elseif akForm.HasKeywordString("RFAB_KW_WeaponMaterial_LegendarySilver")
		material = "����������� ����������"
	else
		material = "����������"
	endif
	
	return material
endfunction

Function SetValues()
	ActorValues = new int[18]

	SkillListRussianMenu = new string[18]
	SkillListRussianMenu[0] = "���������� ������"	
	SkillListRussianMenu[1] = "��������� ������"
	SkillListRussianMenu[2] = "��������"
	SkillListRussianMenu[3] = "������������"
	SkillListRussianMenu[4] = "������� �����"
	SkillListRussianMenu[5] = "��������� ����"

	SkillListRussianMenu[6] = "�������"
	SkillListRussianMenu[7] = "����������"
	SkillListRussianMenu[8] = "����������"
	SkillListRussianMenu[9] = "��������������"
	SkillListRussianMenu[10] = "���������"
	SkillListRussianMenu[11] = "�����������"

	SkillListRussianMenu[12] = "���������"
	SkillListRussianMenu[13] = "����������"
	SkillListRussianMenu[14] = "���� ������"
	SkillListRussianMenu[15] = "���������� ���"
	SkillListRussianMenu[16] = "�������� ���"
	SkillListRussianMenu[17] = "�������"

	SkillListEnglishMenu = new string[18]
	SkillListEnglishMenu[0] = "OneHanded"	
	SkillListEnglishMenu[1] = "TwoHanded"
	SkillListEnglishMenu[2] = "Marksman"
	SkillListEnglishMenu[3] = "Block"
	SkillListEnglishMenu[4] = "HeavyArmor"
	SkillListEnglishMenu[5] = "Smithing"

	SkillListEnglishMenu[6] = "Illusion"
	SkillListEnglishMenu[7] = "Conjuration"
	SkillListEnglishMenu[8] = "Destruction"
	SkillListEnglishMenu[9] = "Restoration"
	SkillListEnglishMenu[10] = "Alteration"
	SkillListEnglishMenu[11] = "Enchanting"

	SkillListEnglishMenu[12] = "LightArmor"
	SkillListEnglishMenu[13] = "Sneak"
	SkillListEnglishMenu[14] = "Speechcraft"
	SkillListEnglishMenu[15] = "Pickpocket"
	SkillListEnglishMenu[16] = "Lockpicking"
	SkillListEnglishMenu[17] = "Alchemy"								
EndFunction

Event OnClassesFrameworkEvent(string eventName, string strArg, float numArg, Form formArg)
	if (strArg == "������� �����")
		CustomSkills.OpenCustomSkillMenu("RFAB_AedraChampion")
	elseif (strArg == "����� �����������")
		CustomSkills.OpenCustomSkillMenu("RFAB_Lich")
	elseif (strArg == "������ ������")
		CustomSkills.OpenCustomSkillMenu("RFAB_Vampire")
	elseif (strArg == "���� �����")
		CustomSkills.OpenCustomSkillMenu("RFAB_Classes")
	elseif (strArg == "���������")
		CustomSkills.OpenCustomSkillMenu("RFAB_Survival")
	endif
EndEvent