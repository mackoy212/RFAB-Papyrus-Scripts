Scriptname _M_MCM extends SKI_ConfigBase

GlobalVariable Property _M_GlobalQuestRefresh Auto

GlobalVariable Property _M_GlobalQuestChanceLow Auto
GlobalVariable Property _M_GlobalQuestChanceMed Auto
GlobalVariable Property _M_GlobalQuestChanceHigh Auto
GlobalVariable Property _M_GlobalQuestChanceVeryHigh Auto

GlobalVariable Property _M_GlobalRewardCourierLetterLow Auto
GlobalVariable Property _M_GlobalRewardCourierLetterMed Auto
GlobalVariable Property _M_GlobalRewardCourierLetterHigh Auto

GlobalVariable Property _M_GlobalRewardCourierPotionLow Auto
GlobalVariable Property _M_GlobalRewardCourierPotionMed Auto
GlobalVariable Property _M_GlobalRewardCourierPotionHigh Auto

GlobalVariable Property _M_GlobalRewardCourierWeaponLow Auto
GlobalVariable Property _M_GlobalRewardCourierWeaponMed Auto
GlobalVariable Property _M_GlobalRewardCourierWeaponHigh Auto

GlobalVariable Property _M_GlobalRewardGatherIngrLow Auto
GlobalVariable Property _M_GlobalRewardGatherIngrMed Auto
GlobalVariable Property _M_GlobalRewardGatherIngrHigh Auto

GlobalVariable Property _M_GlobalRewardGatherInn Auto

GlobalVariable Property _M_GlobalRewardGatherOreLow Auto
GlobalVariable Property _M_GlobalRewardGatherOreMed Auto
GlobalVariable Property _M_GlobalRewardGatherOreHigh Auto
GlobalVariable Property _M_GlobalRewardGatherOreVeryHigh Auto

GlobalVariable Property _M_GlobalRewardGatherSoulGemLow Auto
GlobalVariable Property _M_GlobalRewardGatherSoulGemMed Auto
GlobalVariable Property _M_GlobalRewardGatherSoulGemHigh Auto

GlobalVariable Property _M_GlobalRewardKillAnimal Auto
GlobalVariable Property _M_GlobalRewardKillBandit Auto
GlobalVariable Property _M_GlobalRewardKillDragon Auto
GlobalVariable Property _M_GlobalRewardKillGiant Auto

GlobalVariable Property _M_GlobalRewardRetrieveHideout Auto
GlobalVariable Property _M_GlobalRewardRetrieveRuins Auto
GlobalVariable Property _M_GlobalRewardRetrieveWilderness Auto

GlobalVariable Property _M_GlobalRewardTrackFugitive Auto
GlobalVariable Property _M_GlobalRewardTrackThief Auto

GlobalVariable Property _M_GlobalTotalGatherIngrLowMin Auto
GlobalVariable Property _M_GlobalTotalGatherIngrLowMax Auto
GlobalVariable Property _M_GlobalTotalGatherIngrMedMin Auto
GlobalVariable Property _M_GlobalTotalGatherIngrMedMax Auto
GlobalVariable Property _M_GlobalTotalGatherIngrHighMin Auto
GlobalVariable Property _M_GlobalTotalGatherIngrHighMax Auto

GlobalVariable Property _M_GlobalTotalGatherInnMin Auto
GlobalVariable Property _M_GlobalTotalGatherInnMax Auto

GlobalVariable Property _M_GlobalTotalGatherOreLowMin Auto
GlobalVariable Property _M_GlobalTotalGatherOreLowMax Auto
GlobalVariable Property _M_GlobalTotalGatherOreMedMin Auto
GlobalVariable Property _M_GlobalTotalGatherOreMedMax Auto
GlobalVariable Property _M_GlobalTotalGatherOreHighMin Auto
GlobalVariable Property _M_GlobalTotalGatherOreHighMax Auto
GlobalVariable Property _M_GlobalTotalGatherOreVeryHighMin Auto
GlobalVariable Property _M_GlobalTotalGatherOreVeryHighMax Auto

GlobalVariable Property _M_GlobalTotalGatherSoulGemLowMin Auto
GlobalVariable Property _M_GlobalTotalGatherSoulGemLowMax Auto
GlobalVariable Property _M_GlobalTotalGatherSoulGemMedMin Auto
GlobalVariable Property _M_GlobalTotalGatherSoulGemMedMax Auto
GlobalVariable Property _M_GlobalTotalGatherSoulGemHighMin Auto
GlobalVariable Property _M_GlobalTotalGatherSoulGemHighMax Auto

int S_Refresh
int S_LowChance
int S_MedChance
int S_HighChance
int S_VeryHighChance

int S_RewardCourierLetterLow
int S_RewardCourierLetterMed
int S_RewardCourierLetterHigh

int S_RewardCourierPotionLow
int S_RewardCourierPotionMed
int S_RewardCourierPotionHigh

int S_RewardCourierWeaponLow
int S_RewardCourierWeaponMed
int S_RewardCourierWeaponHigh

int S_RewardGatherIngrLow
int S_RewardGatherIngrMed
int S_RewardGatherIngrHigh

int S_RewardGatherSoulGemLow
int S_RewardGatherSoulGemMed
int S_RewardGatherSoulGemHigh

int S_RewardGatherInn

int S_RewardGatherOreLow
int S_RewardGatherOreMed
int S_RewardGatherOreHigh
int S_RewardGatherOreVeryHigh

int S_RewardKillAnimal
int S_RewardKillBandit
int S_RewardKillDragon
int S_RewardKillGiant

int S_RewardRetrieveWilderness
int S_RewardRetrieveHideout
int S_RewardRetrieveRuins

int S_RewardHuntThief
int S_RewardHuntFugitive

Event OnPageReset(string page)
	if(page == "General" || page == "")
		S_Refresh = AddSliderOption("Quest Refresh:", _M_GlobalQuestRefresh.GetValue(), "{1} Days")
		AddEmptyOption()
		AddHeaderOption("")
		AddHeaderOption("")
		S_LowChance = AddSliderOption("Easy Quest Chance:", _M_GlobalQuestChanceLow.GetValue(), "{0}%")
		S_MedChance = AddSliderOption("Normal Quest Chance:", _M_GlobalQuestChanceMed.GetValue(), "{0}%")
		S_HighChance = AddSliderOption("Hard Quest Chance:", _M_GlobalQuestChanceHigh.GetValue(), "{0}%")
		S_VeryHighChance = AddSliderOption("Very Hard Quest Chance:", _M_GlobalQuestChanceVeryHigh.GetValue(), "{0}%")
	elseif(page == "Rewards")
		AddHeaderOption("Courier Quests")
		AddHeaderOption("")
		S_RewardCourierLetterLow = AddSliderOption("Easy Letter Delivery Reward:", _M_GlobalRewardCourierLetterLow.GetValue(), "{0}")
		S_RewardCourierWeaponLow = AddSliderOption("Easy Weapon Delivery Reward:", _M_GlobalRewardCourierWeaponLow.GetValue(), "{0}")
		S_RewardCourierLetterMed = AddSliderOption("Normal Letter Delivery Reward:", _M_GlobalRewardCourierLetterMed.GetValue(), "{0}")
		S_RewardCourierWeaponMed = AddSliderOption("Normal Weapon Delivery Reward:", _M_GlobalRewardCourierWeaponMed.GetValue(), "{0}")
		S_RewardCourierLetterHigh = AddSliderOption("Hard Letter Delivery Reward:", _M_GlobalRewardCourierLetterHigh.GetValue(), "{0}")
		S_RewardCourierWeaponHigh = AddSliderOption("Hard Weapon Delivery Reward:", _M_GlobalRewardCourierWeaponHigh.GetValue(), "{0}")
		
		AddEmptyOption()
		AddEmptyOption()
		S_RewardCourierPotionLow = AddSliderOption("Easy Potion Delivery Reward:", _M_GlobalRewardCourierPotionLow.GetValue(), "{0}")
		AddEmptyOption()
		S_RewardCourierPotionMed = AddSliderOption("Normal Potion Delivery Reward:", _M_GlobalRewardCourierPotionMed.GetValue(), "{0}")
		AddEmptyOption()
		S_RewardCourierPotionHigh = AddSliderOption("Hard Potion Delivery Reward:", _M_GlobalRewardCourierPotionHigh.GetValue(), "{0}")
		AddEmptyOption()
		
		AddHeaderOption("Gathering Quests")
		AddHeaderOption("")
		S_RewardGatherIngrLow = AddSliderOption("Easy Ingredient Gathering Reward:", _M_GlobalRewardGatherIngrLow.GetValue(), "{0}")
		S_RewardGatherSoulGemLow = AddSliderOption("Easy Soul Gem Gathering Reward:", _M_GlobalRewardGatherSoulGemLow.GetValue(), "{0}")
		S_RewardGatherIngrMed = AddSliderOption("Normal Ingredient Gathering Reward:", _M_GlobalRewardGatherIngrMed.GetValue(), "{0}")
		S_RewardGatherSoulGemMed = AddSliderOption("Normal Soul Gem Gathering Reward:", _M_GlobalRewardGatherSoulGemMed.GetValue(), "{0}")
		S_RewardGatherIngrHigh = AddSliderOption("Hard Ingredient Gathering Reward:", _M_GlobalRewardGatherIngrHigh.GetValue(), "{0}")
		S_RewardGatherSoulGemHigh = AddSliderOption("Hard Soul Gem Gathering Reward:", _M_GlobalRewardGatherSoulGemHigh.GetValue(), "{0}")
		AddEmptyOption()
		AddEmptyOption()
		S_RewardGatherOreLow = AddSliderOption("Easy Ore Gathering Reward:", _M_GlobalRewardGatherOreLow.GetValue(), "{0}")
		S_RewardGatherInn = AddSliderOption("Food Gathering Reward:", _M_GlobalRewardGatherInn.GetValue(), "{0}")
		S_RewardGatherOreMed = AddSliderOption("Normal Ore Gathering Reward:", _M_GlobalRewardGatherOreMed.GetValue(), "{0}")
		AddEmptyOption()
		S_RewardGatherOreHigh = AddSliderOption("Hard Ore Gathering Reward:", _M_GlobalRewardGatherOreHigh.GetValue(), "{0}")
		AddEmptyOption()
		S_RewardGatherOreVeryHigh = AddSliderOption("Very Hard Ore Gathering Reward:", _M_GlobalRewardGatherOreVeryHigh.GetValue(), "{0}")
		AddEmptyOption()
		
		AddHeaderOption("Bounty Quests")
		AddHeaderOption("")
		S_RewardKillAnimal = AddSliderOption("Animal Bounty Reward:", _M_GlobalRewardKillAnimal.GetValue(), "{0}")
		S_RewardKillBandit = AddSliderOption("Bandit Bounty Reward:", _M_GlobalRewardKillBandit.GetValue(), "{0}")
		S_RewardKillDragon = AddSliderOption("Dragon Bounty Reward:", _M_GlobalRewardKillDragon.GetValue(), "{0}")
		S_RewardKillGiant = AddSliderOption("Giant Bounty Reward:", _M_GlobalRewardKillGiant.GetValue(), "{0}")
		
		AddHeaderOption("Retrieve Quests")
		AddHeaderOption("")
		S_RewardRetrieveWilderness = AddSliderOption("Wilderness Retrieval Reward:", _M_GlobalRewardRetrieveWilderness.GetValue(), "{0}")
		S_RewardRetrieveHideout = AddSliderOption("Hideout Retrieval Reward:", _M_GlobalRewardRetrieveHideout.GetValue(), "{0}")
		S_RewardRetrieveRuins = AddSliderOption("Ruins Retrieval Reward:", _M_GlobalRewardRetrieveRuins.GetValue(), "{0}")
		AddEmptyOption()
		
		AddHeaderOption("Hunt Quests")
		AddHeaderOption("")
		S_RewardHuntThief = AddSliderOption("Hunt Thief Reward:", _M_GlobalRewardTrackThief.GetValue(), "{0}")
		S_RewardHuntFugitive = AddSliderOption("Hunt Fugitive Reward:", _M_GlobalRewardTrackFugitive.GetValue(), "{0}")
	endIf
endEvent

Event OnOptionSliderOpen(int option)
	if(option == S_Refresh)
		SetSliderDialogStartValue(_M_GlobalQuestRefresh.GetValue())
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0.1, 7.0)
		SetSliderDialogInterval(0.1)
	elseif(option == S_LowChance)
		SetSliderDialogStartValue(_M_GlobalQuestChanceLow.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif(option == S_MedChance)
		SetSliderDialogStartValue(_M_GlobalQuestChanceMed.GetValue())
		SetSliderDialogDefaultValue(35)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif(option == S_HighChance)
		SetSliderDialogStartValue(_M_GlobalQuestChanceHigh.GetValue())
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif(option == S_VeryHighChance)
		SetSliderDialogStartValue(_M_GlobalQuestChanceVeryHigh.GetValue())
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	elseif(option == S_RewardCourierLetterLow)
		SetSliderDialogStartValue(_M_GlobalRewardCourierLetterLow.GetValue())
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierLetterMed)
		SetSliderDialogStartValue(_M_GlobalRewardCourierLetterMed.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierLetterHigh)
		SetSliderDialogStartValue(_M_GlobalRewardCourierLetterHigh.GetValue())
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierPotionLow)
		SetSliderDialogStartValue(_M_GlobalRewardCourierPotionLow.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierPotionMed)
		SetSliderDialogStartValue(_M_GlobalRewardCourierPotionMed.GetValue())
		SetSliderDialogDefaultValue(200)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierPotionHigh)
		SetSliderDialogStartValue(_M_GlobalRewardCourierPotionHigh.GetValue())
		SetSliderDialogDefaultValue(300)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierWeaponLow)
		SetSliderDialogStartValue(_M_GlobalRewardCourierWeaponLow.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierWeaponMed)
		SetSliderDialogStartValue(_M_GlobalRewardCourierWeaponMed.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardCourierWeaponHigh)
		SetSliderDialogStartValue(_M_GlobalRewardCourierWeaponHigh.GetValue())
		SetSliderDialogDefaultValue(150)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherIngrLow)
		SetSliderDialogStartValue(_M_GlobalRewardGatherIngrLow.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherIngrMed)
		SetSliderDialogStartValue(_M_GlobalRewardGatherIngrMed.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherIngrHigh)
		SetSliderDialogStartValue(_M_GlobalRewardGatherIngrHigh.GetValue())
		SetSliderDialogDefaultValue(150)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherSoulGemLow)
		SetSliderDialogStartValue(_M_GlobalRewardGatherSoulGemLow.GetValue())
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherSoulGemMed)
		SetSliderDialogStartValue(_M_GlobalRewardGatherSoulGemMed.GetValue())
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherSoulGemHigh)
		SetSliderDialogStartValue(_M_GlobalRewardGatherSoulGemHigh.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherInn)
		SetSliderDialogStartValue(_M_GlobalRewardGatherInn.GetValue())
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherOreLow)
		SetSliderDialogStartValue(_M_GlobalRewardGatherOreLow.GetValue())
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherOreMed)
		SetSliderDialogStartValue(_M_GlobalRewardGatherOreMed.GetValue())
		SetSliderDialogDefaultValue(150)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherOreHigh)
		SetSliderDialogStartValue(_M_GlobalRewardGatherOreHigh.GetValue())
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardGatherOreVeryHigh)
		SetSliderDialogStartValue(_M_GlobalRewardGatherOreVeryHigh.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardKillAnimal)
		SetSliderDialogStartValue(_M_GlobalRewardKillAnimal.GetValue())
		SetSliderDialogDefaultValue(150)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardKillBandit)
		SetSliderDialogStartValue(_M_GlobalRewardKillBandit.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardKillDragon)
		SetSliderDialogStartValue(_M_GlobalRewardKillDragon.GetValue())
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardKillGiant)
		SetSliderDialogStartValue(_M_GlobalRewardKillGiant.GetValue())
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardRetrieveWilderness)
		SetSliderDialogStartValue(_M_GlobalRewardRetrieveWilderness.GetValue())
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardRetrieveHideout)
		SetSliderDialogStartValue(_M_GlobalRewardRetrieveHideout.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardRetrieveRuins)
		SetSliderDialogStartValue(_M_GlobalRewardRetrieveRuins.GetValue())
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardHuntThief)
		SetSliderDialogStartValue(_M_GlobalRewardTrackThief.GetValue())
		SetSliderDialogDefaultValue(250)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	elseif(option == S_RewardHuntFugitive)
		SetSliderDialogStartValue(_M_GlobalRewardTrackFugitive.GetValue())
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(0, 10000)
		SetSliderDialogInterval(25)
	endIf
endEvent

Event OnOptionSliderAccept(int option, float value)
	if(option == S_Refresh)
		_M_GlobalQuestRefresh.SetValue(value)
	elseif(option == S_LowChance)
		_M_GlobalQuestChanceLow.SetValue(value)
	elseif(option == S_MedChance)
		_M_GlobalQuestChanceMed.SetValue(value)
	elseif(option == S_HighChance)
		_M_GlobalQuestChanceHigh.SetValue(value)
	elseif(option == S_VeryHighChance)
		_M_GlobalQuestChanceVeryHigh.SetValue(value)
	elseif(option == S_RewardCourierLetterLow)
		_M_GlobalRewardCourierLetterLow.SetValue(value)
	elseif(option == S_RewardCourierLetterMed)
		_M_GlobalRewardCourierLetterMed.SetValue(value)
	elseif(option == S_RewardCourierLetterHigh)
		_M_GlobalRewardCourierLetterHigh.SetValue(value)
	elseif(option == S_RewardCourierPotionLow)
		_M_GlobalRewardCourierPotionLow.SetValue(value)
	elseif(option == S_RewardCourierPotionMed)
		_M_GlobalRewardCourierPotionMed.SetValue(value)
	elseif(option == S_RewardCourierPotionHigh)
		_M_GlobalRewardCourierPotionHigh.SetValue(value)
	elseif(option == S_RewardCourierWeaponLow)
		_M_GlobalRewardCourierWeaponLow.SetValue(value)
	elseif(option == S_RewardCourierWeaponMed)
		_M_GlobalRewardCourierWeaponMed.SetValue(value)
	elseif(option == S_RewardCourierWeaponHigh)
		_M_GlobalRewardCourierWeaponHigh.SetValue(value)
	elseif(option == S_RewardGatherIngrLow)
		_M_GlobalRewardGatherIngrLow.SetValue(value)
	elseif(option == S_RewardGatherIngrMed)
		_M_GlobalRewardGatherIngrMed.SetValue(value)
	elseif(option == S_RewardGatherIngrHigh)
		_M_GlobalRewardGatherIngrHigh.SetValue(value)
	elseif(option == S_RewardGatherSoulGemLow)
		_M_GlobalRewardGatherSoulGemLow.SetValue(value)
	elseif(option == S_RewardGatherSoulGemMed)
		_M_GlobalRewardGatherSoulGemMed.SetValue(value)
	elseif(option == S_RewardGatherSoulGemHigh)
		_M_GlobalRewardGatherSoulGemHigh.SetValue(value)
	elseif(option == S_RewardGatherInn)
		_M_GlobalRewardGatherInn.SetValue(value)
	elseif(option == S_RewardGatherOreLow)
		_M_GlobalRewardGatherOreLow.SetValue(value)
	elseif(option == S_RewardGatherOreMed)
		_M_GlobalRewardGatherOreMed.SetValue(value)
	elseif(option == S_RewardGatherOreHigh)
		_M_GlobalRewardGatherOreHigh.SetValue(value)
	elseif(option == S_RewardGatherOreVeryHigh)
		_M_GlobalRewardGatherOreVeryHigh.SetValue(value)
	elseif(option == S_RewardKillAnimal)
		_M_GlobalRewardKillAnimal.SetValue(value)
	elseif(option == S_RewardKillBandit)
		_M_GlobalRewardKillBandit.SetValue(value)
	elseif(option == S_RewardKillDragon)
		_M_GlobalRewardKillDragon.SetValue(value)
	elseif(option == S_RewardKillGiant)
		_M_GlobalRewardKillGiant.SetValue(value)
	elseif(option == S_RewardRetrieveWilderness)
		_M_GlobalRewardRetrieveWilderness.SetValue(value)
	elseif(option == S_RewardRetrieveHideout)
		_M_GlobalRewardRetrieveHideout.SetValue(value)
	elseif(option == S_RewardRetrieveRuins)
		_M_GlobalRewardRetrieveRuins.SetValue(value)
	elseif(option == S_RewardHuntThief)
		_M_GlobalRewardTrackThief.SetValue(value)
	elseif(option == S_RewardHuntFugitive)
		_M_GlobalRewardTrackFugitive.SetValue(value)
	endIf
	ForcePageReset()
endEvent

Event OnOptionHighlight(int option)
	if(option == S_Refresh)
		SetInfoText("The minimum number of days it takes for new missives to be put up or old missives to be taken down.\nDefault: 3 Days")
	elseif(option == S_LowChance)
		SetInfoText("The chance that a new easy quest is put up or an unaccepted one taken down.\nDefault: 50%")
	elseif(option == S_MedChance)
		SetInfoText("The chance that a new normal quest is put up or an unaccepted one taken down.\nDefault: 35%")
	elseif(option == S_HighChance)
		SetInfoText("The chance that a new hard quest is put up or an unaccepted one taken down.\nDefault: 20%")
	elseif(option == S_VeryHighChance)
		SetInfoText("The chance that a very hard quest is put up or an unaccepted one taken down.\nDefault: 5%")
	elseif(option == S_RewardCourierLetterLow)
		SetInfoText("The reward given both before and after delivering a letter to a nearby settlement.\nDefault: 25 Septims")
	elseif(option == S_RewardCourierLetterMed)
		SetInfoText("The reward given both before and after delivering a letter to a distant city.\nDefault: 50 Septims")
	elseif(option == S_RewardCourierLetterHigh)
		SetInfoText("The reward given both before and after delivering a letter to a distant settlement.\nDefault: 75 Septims")
	elseif(option == S_RewardCourierPotionLow)
		SetInfoText("The reward given both before and after delivering a potion to a nearby settlement.\nDefault: 100 Septims")
	elseif(option == S_RewardCourierPotionMed)
		SetInfoText("The reward given both before and after delivering a potion to a distant city.\nDefault: 200 Septims")
	elseif(option == S_RewardCourierPotionHigh)
		SetInfoText("The reward given both before and after delivering a potion to a distant settlement.\nDefault: 200 Septims")
	elseif(option == S_RewardCourierWeaponLow)
		SetInfoText("The reward given both before and after delivering a weapon to a nearby settlement.\nDefault: 50 Septims")
	elseif(option == S_RewardCourierWeaponMed)
		SetInfoText("The reward given both before and after delivering a weapon to a distant city.\nDefault: 100 Septims")
	elseif(option == S_RewardCourierWeaponHigh)
		SetInfoText("The reward given both before and after delivering a weapon to a distant settlement.\nDefault: 150 Septims")
	elseif(option == S_RewardGatherIngrLow)
		SetInfoText("The reward given after gathering 15-25 common ingredients, in addition to a random potion.\nDefault: 50 Septims")
	elseif(option == S_RewardGatherIngrMed)
		SetInfoText("The reward given after gathering 5-15 uncommon ingredients, in addition to a few random potions.\nDefault: 100 Septims")
	elseif(option == S_RewardGatherIngrHigh)
		SetInfoText("The reward given after gathering 3-5 rare ingredients, in addition to some random potions.\nDefault: 150 Septims")
	elseif(option == S_RewardGatherSoulGemLow)
		SetInfoText("The reward given after gathering 6-10 petty or empty lesser soul gems, in addition to some novice and apprentice scrolls.\nDefault: 100 Septims")
	elseif(option == S_RewardGatherSoulGemMed)
		SetInfoText("The reward given after gathering 2-6 filled lesser or common soul gems, in addition to some apprentice and adept scrolls.\nDefault: 250 Septims")
	elseif(option == S_RewardGatherSoulGemHigh)
		SetInfoText("The reward given after gathering 1 greater or grand soul gem, in addition to some adept and expert scrolls.\nDefault: 500 Septims")
	elseif(option == S_RewardGatherInn)
		SetInfoText("The reward given after gathering 8-15 rabbit legs, salmon, or venison, in addition to a hot meal.\nDefault: 50 Septims")
	elseif(option == S_RewardGatherOreLow)
		SetInfoText("The reward given after gathering 10-15 chunks of iron ore, in addition to a basic weapon or piece of armor.\nDefault: 75 Septims")
	elseif(option == S_RewardGatherOreMed)
		SetInfoText("The reward given after gathering 5-10 chunks of corundrum, silver, moonstone, or orichalcum ore, in addition to a random weapon or piece of armor.\nDefault: 150 Septims")
	elseif(option == S_RewardGatherOreHigh)
		SetInfoText("The reward given after gathering 3-5 chunks of ebony, quicksilver, malachite, or gold ore, in addition to a random enchanted weapon or piece of armor.\nDefault: 250 Septims")
	elseif(option == S_RewardGatherOreVeryHigh)
		SetInfoText("The reward given after gathering 2-3 dragon bones, dragon scalse, daedra hearts, or ebony ingots, in addition to a excellent enchanted weapon or piece of armor.\nDefault: 500 Septims")
	elseif(option == S_RewardKillAnimal)
		SetInfoText("The reward given after clearing out a den of animals.\nThis is considered a 'Normal' Quest.\nDefault: 150 Septims")
	elseif(option == S_RewardKillBandit)
		SetInfoText("The reward given after killing a bandit or forsworn leader.\nThis is considered a 'Hard' Quest.\nDefault: 500 Septims")
	elseif(option == S_RewardKillDragon)
		SetInfoText("The reward given after killing a dragon.\nThis is considered a 'Very Hard' Quest.\nDefault: 1000 Septims")
	elseif(option == S_RewardKillGiant)
		SetInfoText("The reward given after killing a giant.\nThis is considered a 'Very Hard' Quest.\nDefault: 1000 Septims")
	elseif(option == S_RewardRetrieveWilderness)
		SetInfoText("The reward given after retrieving an item from an animal den or cave.\nThis is considered a 'Normal' Quest.\nDefault: 250 Septims")
	elseif(option == S_RewardRetrieveHideout)
		SetInfoText("The reward given after retrieving an item from a bandit, forsworn, warlock, or vampire hideout.\nThis is considered a 'Hard' Quest.\nDefault: 500 Septims")
	elseif(option == S_RewardRetrieveRuins)
		SetInfoText("The reward given after retrieving an item from a nordic or dwemer ruin.\nThis is considered a 'Very Hard' Quest.\nDefault: 1000 Septims")
	elseif(option == S_RewardHuntThief)
		SetInfoText("The reward given after retrieving a stolen item from a thief in an adjacent hold.\nThis is considered an 'Easy' Quest.\nDefault: 250 Septims")
	elseif(option == S_RewardHuntFugitive)
		SetInfoText("The reward given killing a fugitive in an adjacent hold.\nThis is considered a 'Normal' Quest.\nDefault: 500 Septims")
	endIf
endEvent
