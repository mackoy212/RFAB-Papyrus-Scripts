;/ Decompiled by Champollion V1.0.1
Source   : CHConfigQuestScript.psc
Modified : 2013-12-17 17:58:19
Compiled : 2013-12-17 18:13:18
User     : Alek
Computer : ALEK-PC
/;
scriptName CHConfigQuestScript extends SKI_ConfigBase
{Script by Alek (mitchalek@yahoo.com).
SkyUI mod configuration implementation.}

;-- Properties --------------------------------------
globalvariable property CHFollowerPreferRidingEnable auto
globalvariable property CHMultiTapDismountMode auto
String property TXTHorseBehaviorMode hidden
	String function get()

		if CHHorseBehaviorMode.GetValue() == 0.000000
			return "$CHMCMStateBehaviorCowardly"
		elseIf CHHorseBehaviorMode.GetValue() == 1.00000
			return "$CHMCMStateBehaviorFoolhardy"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHLearnWhistleOverride auto
globalvariable property CHMultiTapCombatOverride auto
globalvariable property CHFollowerDeferredDismountEnable auto
globalvariable property CHHorseFollowEnable auto
globalvariable property CHHorseChargeDamageBase auto
globalvariable property CHHorseProtectionMode auto
globalvariable property CHMultiTapDelay auto
globalvariable property CHKeyDismount auto
String property TXTBoundKeyInventoryMode hidden
	String function get()

		if CHBoundKeyInventoryMode.GetValue() == 0.000000
			return "$CHMCMStateLocal"
		elseIf CHBoundKeyInventoryMode.GetValue() == 1.00000
			return "$CHMCMStateTravel"
		elseIf CHBoundKeyInventoryMode.GetValue() == 2.00000
			return "$CHMCMStateRemote"
		elseIf CHBoundKeyInventoryMode.GetValue() == 3.00000
			return "$CHMCMStateAbsolute"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootOreAndIngotsMode auto
globalvariable property CHFollowerMountedCombatDamageMult auto
String property TXTFollowerHorseGlobalSkinSelection hidden
	String function get()

		if CHFollowerHorseGlobalSkinSelection.GetValue() == 0.000000
			return "$CHMCMStatePerFollower"
		elseIf CHFollowerHorseGlobalSkinSelection.GetValue() == 1.00000
			return "$CHMCMStateGlobal"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
String property TXTMultiTapDismountMode hidden
	String function get()

		if CHMultiTapDismountMode.GetValue() == 0.000000
			return "$CHMCMStateNever"
		elseIf CHMultiTapDismountMode.GetValue() == 1.00000
			return "$CHMCMStateCombat"
		elseIf CHMultiTapDismountMode.GetValue() == 2.00000
			return "$CHMCMStateAlways"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHKeyHarvest auto
spell property CHConfigurationPower auto
globalvariable property CHAutoLootSoulGemsMode auto
globalvariable property CHHorseInventoryWeightLimit auto
globalvariable property CHHorseBonusStamina auto
globalvariable property CHAutoLootBooksMode auto
globalvariable property CHHorseChargeSFXMode auto
globalvariable property CHFollowerDeferredDismountSeconds auto
globalvariable property CHHorseBehaviorMode auto
String property TXTFollowerHorseGlobalSkin hidden
	String function get()

		if CHFollowerHorseGlobalSkin.GetValue() >= 0.000000 && CHFollowerHorseGlobalSkin.GetValue() < Skins.length as Float
			return Skins[CHFollowerHorseGlobalSkin.GetValue() as Int]
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootPotionsMode auto
globalvariable property CHFollowerAutoRetaliateEnable auto
globalvariable property CHAutoLootIngredientsMode auto
globalvariable property CHHorseChargePushForceMult auto
String property TXTHorseChargeSFXMode hidden
	String function get()

		if CHHorseChargeSFXMode.GetValue() == 0.000000
			return "Базовые"
		elseIf CHHorseChargeSFXMode.GetValue() == 1.00000
			return "Энергичные"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
String property TXTFollowerHorseGlobalEquipment hidden
	String function get()

		if CHFollowerHorseGlobalEquipment.GetValue() >= 0.000000 && CHFollowerHorseGlobalEquipment.GetValue() < (Equipment.length - 1) as Float
			return Equipment[CHFollowerHorseGlobalEquipment.GetValue() as Int + 1]
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootEquipmentMode auto
quest property CHLatencyTest auto
String property TXTAutoLootMode hidden
	String function get()

		if CHAutoLootMode.GetValue() == 0.000000
			return "$CHMCMStateDisabled"
		elseIf CHAutoLootMode.GetValue() == 1.00000
			return "$CHMCMStateBasic"
		elseIf CHAutoLootMode.GetValue() == 2.00000
			return "$CHMCMStateAdvanced"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootEquipmentMinWeightValue auto
globalvariable property CHFollowerHorseGlobalEquipmentSelection auto
String property TXTFollowerHorseGlobalEquipmentSelection hidden
	String function get()

		if CHFollowerHorseGlobalEquipmentSelection.GetValue() == 0.000000
			return "$CHMCMStatePerFollower"
		elseIf CHFollowerHorseGlobalEquipmentSelection.GetValue() == 1.00000
			return "$CHMCMStateGlobal"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHFollowerHorseGlobalEquipment auto
String property TXTFollowerHorseCallDistanceMode hidden
	String function get()

		if CHFollowerHorseCallDistanceMode.GetValue() == 0.000000
			return "$CHMCMStateDist56"
		elseIf CHFollowerHorseCallDistanceMode.GetValue() == 1.00000
			return "$CHMCMStateDist112"
		elseIf CHFollowerHorseCallDistanceMode.GetValue() == 2.00000
			return "$CHMCMStateDist168"
		elseIf CHFollowerHorseCallDistanceMode.GetValue() == 3.00000
			return "$CHMCMStateDist225"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
String property TXTHorseEquipmentMode hidden
	String function get()

		if CHHorseEquipmentMode.GetValue() >= 0.000000 && CHHorseEquipmentMode.GetValue() < Equipment.length as Float
			return Equipment[CHHorseEquipmentMode.GetValue() as Int]
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootSpellTomesUnknownOnly auto
globalvariable property CHAutoLootAnimalHidesMode auto
String property TXTHorseFollowDistanceMode hidden
	String function get()

		if CHHorseFollowDistanceMode.GetValue() == 0.000000
			return "$CHMCMStateDist30"
		elseIf CHHorseFollowDistanceMode.GetValue() == 1.00000
			return "$CHMCMStateDist45"
		elseIf CHHorseFollowDistanceMode.GetValue() == 2.00000
			return "$CHMCMStateDist60"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootPreciousGemsMode auto
String property TXTHorseFollowMode hidden
	String function get()

		if CHHorseFollowMode.GetValue() == 0.000000
			return "$CHMCMStateSmart"
		elseIf CHHorseFollowMode.GetValue() == 1.00000
			return "$CHMCMStateAlways"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
String property TXTHorseProtectionMode hidden
	String function get()

		if CHHorseProtectionMode.GetValue() == 0.000000
			return "$CHMCMStateProtOff"
		elseIf CHHorseProtectionMode.GetValue() == 1.00000
			return "$CHMCMStateProtEssential"
		elseIf CHHorseProtectionMode.GetValue() == 2.00000
			return "$CHMCMStateProtInvulnerable"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHFollowerHorseRecallEnable auto
String property TXTFactionRelationsMode hidden
	String function get()

		if CHFactionRelationsMode.GetValue() == 0.000000
			return "$CHMCMStateFactionNeutral"
		elseIf CHFactionRelationsMode.GetValue() == 1.00000
			return "$CHMCMStateFactionFriendly"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
String property TXTInventoryRecovery hidden
	String function get()

		if bRecoverInventory
			return "$CHMCMStateRecoverOn"
		else
			return "$CHMCMStateRecoverOff"
		endIf
	endFunction
endproperty
globalvariable property CHAutoLootRecipesMode auto
globalvariable property CHMountedCombatCameraFixEnable auto
String property TXTControlMode hidden
	String function get()

		if CHControlMode.GetValue() == 0.000000
			return "$CHMCMStateBoundKey"
		elseIf CHControlMode.GetValue() == 1.00000
			return "$CHMCMStateMultiTap"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
globalvariable property CHBoundKeyConsolidate auto
String property TXTScriptLatencyTest hidden
	String function get()

		if bLatencyTest
			return "$CHMCMStateRunning"
		else
			return "$CHMCMStateStopped"
		endIf
	endFunction
endproperty
globalvariable property CHKeyInventory auto
String property TXTConfigurationPower hidden
	String function get()

		if bConfigPower
			return "$CHMCMStateShown"
		else
			return "$CHMCMStateHidden"
		endIf
	endFunction
endproperty
globalvariable property CHHorseChargeStaminaCostPercent auto
globalvariable property CHFollowerCombatEscapeEnable auto
globalvariable property CHFactionRelationsMode auto
globalvariable property CHAutoLootKeysMode auto
globalvariable property CHControlMode auto
globalvariable property CHBoundKeyInventoryMode auto
globalvariable property CHHorseChargeDamageHealthPercent auto
globalvariable property CHHorseChargeHeadingAngleTolerance auto
globalvariable property CHHorseChargeFeedbackSlowPercent auto
globalvariable property CHHorseChargeFeedbackSlowTime auto
globalvariable property CHHorseEquipmentMode auto
globalvariable property CHHorseChargePushElevationAngle auto
globalvariable property CHHorseChargeHeadingAngleScaleFactor auto
globalvariable property CHHorseChargeImpactPrecognitionTime auto
globalvariable property CHHorseCallFormationEnable auto
globalvariable property CHKeySpecial auto
globalvariable property CHAutoLootEquipmentEnchantedOnly auto
globalvariable property CHFollowerHorseCallDistanceMode auto
globalvariable property CHAutoLootAmmoMode auto
globalvariable property CHAutoLootFoodAndDrinksMode auto
globalvariable property CHLearnWhistleCompleted auto
globalvariable property CHAutoLootPoisonsMode auto
globalvariable property CHAutoLootScrollsMode auto
message property CHHorseInventoryRecoveryMessage auto
globalvariable property CHHorseFollowMode auto
globalvariable property CHHorseTrackingDisable auto
globalvariable property CHHorseBonusSpeed auto
spell property CHHorseWhistlePower auto
globalvariable property CHHorseCallFadeEnable auto
globalvariable property CHAutoLootSpellTomesMode auto
globalvariable property CHFollowerMountedCombatEnable auto
globalvariable property CHHorseBonusHealth auto
globalvariable property CHKeyTalk auto
globalvariable property CHFactionRelationsUpdate auto
quest property CH auto
String property TXTFactionRelationsUpdate hidden
	String function get()

		if CHFactionRelationsUpdate.GetValue() == 0.000000
			return "$CHMCMStateFactionUpdateOff"
		elseIf CHFactionRelationsUpdate.GetValue() == 1.00000
			return "$CHMCMStateFactionUpdateOn"
		else
			return "$CHMCMStateInvalid"
		endIf
	endFunction
endproperty
quest property CHFollower auto
globalvariable property CHFollowerHorseGlobalSkin auto
globalvariable property CHAutoLootBooksMinValue auto
globalvariable property CHFollowerModeEnable auto
globalvariable property CHHorseFollowDistanceMode auto
referencealias property Alias_Sack auto
globalvariable property CHFollowerHorseDynamicSpeedEnable auto
globalvariable property CHFollowerDeferredDismountRadius auto
globalvariable property CHAutoLootLightAndTorchesMode auto
globalvariable property CHAnimationsEnable auto
globalvariable property CHHorseChargeEnable auto
globalvariable property CHFollowerHorseGlobalSkinSelection auto
globalvariable property CHAutoLootMode auto

;-- Variables ---------------------------------------
Int OIDAutoLootPoisonsMode
Int OIDScriptLatencyTest
Int OIDHorseChargePushElevationAngle
Int OIDAutoLootKeysMode
Int OIDFollowerHorseCallDistanceMode
Int OIDHorseChargeSFXMode
Int OIDBoundKeyHarvest
Int OIDCameraFix
Int iFactionModeInit
Int OIDHorseChargeStaminaCostPercent
Int OIDFollowerHorseGlobalSkinSelection
Int iFactionUpdateInit
Bool bConfigPower
Int OIDAutoLootEquipmentMode
Int OIDAutoLootMode
Int OIDHorseChargeDamageBase
Int OIDHorseBonusHealth
Int OIDControlMode
Int OIDHorseChargeHeadingAngleTolerance
Bool bUpdateSkins
Int OIDFollowerMountedCombatDamage
Int OIDBoundKeySpecial
Int OIDHorseChargeHeadingAngleScaleFactor
Int OIDHorseChargePushForceMult
Int OIDHorseChargeImpactPrecognitionTime
Int OIDFollowerHorseGlobalEquipmentSelection
Int OIDFactionRelationsUpdate
Int OIDAutoLootSoulGemsMode
Int OIDBoundKeyInventoryMode
Int OIDMultiTapCombatOverride
Int OIDAutoLootFoodAndDrinksMode
Int OIDInventoryRecovery
Int OIDHorseBonusSpeed
Int OIDBoundKeyDismount
Int OIDAutoLootBooksMode
Int OIDMultiTapDismountMode
Int OIDFollowerDeferredDismountSeconds
Int OIDHorseBonusStamina
Bool bUpdateEquipment
Int OIDFactionRelationsMode
Int OIDAutoLootScrollsMode
Int OIDHorseFollowMode
Int OIDAutoLootLightAndTorchesMode
Int OIDAutoLootEquipmentMinWeightValue
Int OIDFollowerPreferRidingEnable
Int OIDHorseCharge
Int OIDAutoLootPotionsMode
Int OIDHorseCallFormation
String[] Presets
Int OIDFollowerHorseGlobalEquipment
Int OIDBoundKeyConsolidate
Int OIDInventoryWeightLimit
Int OIDHorseFollowEnable
Int OIDAutoLootSpellTomesUnknownOnly
Int OIDHorseTracking
Int OIDAutoLootIngredientsMode
Bool bHorseTrackingWasDisabled
Int OIDBoundKeyTalk
Int OIDHorseBehaviorMode
Int OIDFollowerHorseGlobalSkin
Int OIDAutoLootPreciousGemsMode
String[] Skins
Int OIDAutoLootAnimalHidesMode
Int OIDFollowerCombatEscapeEnable
Int OIDAutoLootAmmoMode
Int OIDAutoLootBooksMinValue
Int OIDHorseChargeLoadPreset
Bool bLatencyTest
Int OIDAutoLootRecipesMode
Int OIDFollowerHorseDynamicSpeedEnable
Int OIDHorseChargeFeedbackSlowTime
Bool bFollowerHorses
Int OIDFollowerAutoRetaliateEnable
Int OIDBoundKeyInventory
Int OIDHorseChargeFeedbackSlowPercent
Int OIDFollowerModeEnable
Int OIDAutoLootEquipmentEnchantedOnly
Int OIDHorseFollowDistanceMode
Int OIDAutoLootSpellTomesMode
Int OIDFollowerMountedCombatEnable
Int OIDAnimations
Int OIDFollowerDeferredDismountRadius
Int OIDFollowerDeferredDismountEnable
String[] Equipment
Int OIDLearnWhistleOverride
Int OIDConfigurationPower
Int OIDHorseChargeDamageHealthPercent
Int OIDHorseProtectionMode
Int OIDAutoLootOreAndIngotsMode
Int OIDHorseCallFade
Bool bRecoverInventory
Int OIDMultiTapDelay
Int OIDHorseEquipmentMode
Bool bUserWantFactionUpdate
Int OIDFollowerHorseRecallEnable

;-- Functions ---------------------------------------

function OnVersionUpdate(Int NewVersion)

	if NewVersion != CurrentVersion
		self.InitArrays()
	endIf
endFunction

String function GetLooterName(Int aiLooterIndex)

	if aiLooterIndex == 0
		return "$CHMCMStateIgnore"
	elseIf aiLooterIndex == 1
		return "$CHMCMStateLoot"
	elseIf aiLooterIndex == 2
		return "$CHMCMStateStash"
	else
		return "$CHMCMStateInvalid"
	endIf
endFunction

Int function GetVersion()

	return 5
endFunction

function OnOptionMenuAccept(Int Option, Int Index)

	if Option == OIDHorseEquipmentMode
		CHHorseEquipmentMode.SetValue(Index as Float)
		self.SetMenuOptionValue(OIDHorseEquipmentMode, self.TXTHorseEquipmentMode, false)
	elseIf Option == OIDFollowerHorseGlobalSkin
		CHFollowerHorseGlobalSkin.SetValue(Index as Float)
		self.SetMenuOptionValue(OIDFollowerHorseGlobalSkin, self.TXTFollowerHorseGlobalSkin, false)
		bUpdateSkins = true
	elseIf Option == OIDFollowerHorseGlobalEquipment
		if Index == 0
			Index = 1
		endIf
		CHFollowerHorseGlobalEquipment.SetValue((Index - 1) as Float)
		self.SetMenuOptionValue(OIDFollowerHorseGlobalEquipment, self.TXTFollowerHorseGlobalEquipment, false)
		bUpdateEquipment = true
	elseIf Option == OIDHorseChargeLoadPreset
		if Index == 0
			CHHorseChargeHeadingAngleTolerance.SetValue(20.0000)
			CHHorseChargeHeadingAngleScaleFactor.SetValue(0.660000)
			CHHorseChargePushForceMult.SetValue(1.00000)
			CHHorseChargePushElevationAngle.SetValue(0.000000)
			CHHorseChargeFeedbackSlowTime.SetValue(0.400000)
			CHHorseChargeFeedbackSlowPercent.SetValue(0.990000)
			self.ForcePageReset()
		elseIf Index == 1
			CHHorseChargeHeadingAngleTolerance.SetValue(30.0000)
			CHHorseChargeHeadingAngleScaleFactor.SetValue(0.330000)
			CHHorseChargePushForceMult.SetValue(1.30000)
			CHHorseChargePushElevationAngle.SetValue(60.0000)
			CHHorseChargeFeedbackSlowTime.SetValue(0.000000)
			CHHorseChargeFeedbackSlowPercent.SetValue(0.000000)
			self.ForcePageReset()
		elseIf Index == 2
			CHHorseChargeHeadingAngleTolerance.SetValue(60.0000)
			CHHorseChargeHeadingAngleScaleFactor.SetValue(0.000000)
			CHHorseChargePushForceMult.SetValue(2.20000)
			CHHorseChargePushElevationAngle.SetValue(-30.0000)
			CHHorseChargeFeedbackSlowTime.SetValue(0.100000)
			CHHorseChargeFeedbackSlowPercent.SetValue(0.990000)
			self.ForcePageReset()
		elseIf Index == 3
			CHHorseChargeHeadingAngleTolerance.SetValue(40.0000)
			CHHorseChargeHeadingAngleScaleFactor.SetValue(0.200000)
			CHHorseChargePushForceMult.SetValue(2.00000)
			CHHorseChargePushElevationAngle.SetValue(15.0000)
			CHHorseChargeFeedbackSlowTime.SetValue(0.600000)
			CHHorseChargeFeedbackSlowPercent.SetValue(0.200000)
			self.ForcePageReset()
		elseIf Index == 4
			CHHorseChargeHeadingAngleTolerance.SetValue(45.0000)
			CHHorseChargeHeadingAngleScaleFactor.SetValue(0.800000)
			CHHorseChargePushForceMult.SetValue(1.80000)
			CHHorseChargePushElevationAngle.SetValue(45.0000)
			CHHorseChargeFeedbackSlowTime.SetValue(0.200000)
			CHHorseChargeFeedbackSlowPercent.SetValue(0.500000)
			self.ForcePageReset()
		endIf
	endIf
endFunction

function InitArrays()

	Pages = new String[5]
	Pages[0] = "$CHMCMPageName01"
	Pages[1] = "$CHMCMPageName02"
	Pages[2] = "$CHMCMPageName03"
	Pages[3] = "$CHMCMPageName04"
	Pages[4] = "$CHMCMPageName05"
	Equipment = new String[19]
	Equipment[0] = "$CHMCMEquipmentName01"
	Equipment[1] = "$CHMCMEquipmentName02"
	Equipment[2] = "$CHMCMEquipmentName03"
	Equipment[3] = "$CHMCMEquipmentName04"
	Equipment[4] = "$CHMCMEquipmentName05"
	Equipment[5] = "$CHMCMEquipmentName06"
	Equipment[6] = "$CHMCMEquipmentName07"
	Equipment[7] = "$CHMCMEquipmentName08"
	Equipment[8] = "$CHMCMEquipmentName09"
	Equipment[9] = "$CHMCMEquipmentName10"
	Equipment[10] = "$CHMCMEquipmentName11"
	Equipment[11] = "$CHMCMEquipmentName12"
	Equipment[12] = "$CHMCMEquipmentName13"
	Equipment[13] = "$CHMCMEquipmentName14"
	Equipment[14] = "$CHMCMEquipmentName15"
	Equipment[15] = "$CHMCMEquipmentName16"
	Equipment[16] = "$CHMCMEquipmentName17"
	Equipment[17] = "$CHMCMEquipmentName18"
	Equipment[18] = "$CHMCMEquipmentName19"
	Skins = new String[6]
	Skins[0] = "$CHMCMSkinName01"
	Skins[1] = "$CHMCMSkinName02"
	Skins[2] = "$CHMCMSkinName03"
	Skins[3] = "$CHMCMSkinName04"
	Skins[4] = "$CHMCMSkinName05"
	Skins[5] = "$CHMCMSkinName06"
	Presets = new String[5]
	Presets[0] = "$CHMCMPresetName01"
	Presets[1] = "$CHMCMPresetName02"
	Presets[2] = "$CHMCMPresetName03"
	Presets[3] = "$CHMCMPresetName04"
	Presets[4] = "$CHMCMPresetName05"
endFunction

function OnOptionDefault(Int Option)

	if Option == OIDControlMode
		CHControlMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDControlMode, self.TXTControlMode, false)
	elseIf Option == OIDFactionRelationsMode
		CHFactionRelationsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDFactionRelationsMode, self.TXTFactionRelationsMode, false)
	elseIf Option == OIDFactionRelationsUpdate
		CHFactionRelationsUpdate.SetValue(1.00000)
		self.SetTextOptionValue(OIDFactionRelationsUpdate, self.TXTFactionRelationsUpdate, false)
	elseIf Option == OIDConfigurationPower
		bConfigPower = true
		self.SetTextOptionValue(OIDConfigurationPower, self.TXTConfigurationPower, false)
	elseIf Option == OIDLearnWhistleOverride
		CHLearnWhistleOverride.SetValue(0.000000)
		self.SetToggleOptionValue(OIDLearnWhistleOverride, false, false)
	elseIf Option == OIDScriptLatencyTest
		bLatencyTest = false
		self.SetTextOptionValue(OIDScriptLatencyTest, self.TXTScriptLatencyTest, false)
	elseIf Option == OIDInventoryRecovery
		bRecoverInventory = false
		self.SetTextOptionValue(OIDInventoryRecovery, self.TXTInventoryRecovery, false)
	elseIf Option == OIDInventoryWeightLimit
		CHHorseInventoryWeightLimit.SetValue(0.000000)
		self.SetSliderOptionValue(OIDInventoryWeightLimit, 0.000000, "{0}", false)
	elseIf Option == OIDAnimations
		CHAnimationsEnable.SetValue(1.00000)
		self.SetToggleOptionValue(OIDAnimations, true, false)
	elseIf Option == OIDCameraFix
		CHMountedCombatCameraFixEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDCameraFix, false, false)
	elseIf Option == OIDHorseTracking
		CHHorseTrackingDisable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDHorseTracking, false, false)
	elseIf Option == OIDMultiTapDelay
		CHMultiTapDelay.SetValue(0.300000)
		self.SetSliderOptionValue(OIDMultiTapDelay, 300.000, "$CHMCMValueMS", false)
	elseIf Option == OIDMultiTapCombatOverride
		CHMultiTapCombatOverride.SetValue(1.00000)
		self.SetToggleOptionValue(OIDMultiTapCombatOverride, true, false)
	elseIf Option == OIDMultiTapDismountMode
		CHMultiTapDismountMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDMultiTapDismountMode, self.TXTMultiTapDismountMode, false)
	elseIf Option == OIDBoundKeyInventoryMode
		CHBoundKeyInventoryMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDBoundKeyInventoryMode, self.TXTBoundKeyInventoryMode, false)
	elseIf Option == OIDBoundKeyConsolidate
		CHBoundKeyConsolidate.SetValue(0.000000)
		self.SetToggleOptionValue(OIDBoundKeyConsolidate, false, false)
		self.SetOptionFlags(OIDBoundKeyHarvest, self.OPTION_FLAG_NONE, false)
	elseIf Option == OIDBoundKeyTalk
		CHKeyTalk.SetValue(-1.00000)
		self.SetKeyMapOptionValue(OIDBoundKeyTalk, -1, false)
	elseIf Option == OIDBoundKeyHarvest
		CHKeyHarvest.SetValue(-1.00000)
		self.SetKeyMapOptionValue(OIDBoundKeyHarvest, -1, false)
	elseIf Option == OIDBoundKeyDismount
		CHKeyDismount.SetValue(-1.00000)
		self.SetKeyMapOptionValue(OIDBoundKeyDismount, -1, false)
	elseIf Option == OIDBoundKeyInventory
		CHKeyInventory.SetValue(-1.00000)
		self.SetKeyMapOptionValue(OIDBoundKeyInventory, -1, false)
	elseIf Option == OIDBoundKeySpecial
		CHKeySpecial.SetValue(-1.00000)
		self.SetKeyMapOptionValue(OIDBoundKeySpecial, -1, false)
	elseIf Option == OIDHorseEquipmentMode
		CHHorseEquipmentMode.SetValue(0.000000)
		self.SetMenuOptionValue(OIDHorseEquipmentMode, self.TXTHorseEquipmentMode, false)
	elseIf Option == OIDHorseBonusHealth
		CHHorseBonusHealth.SetValue(0.000000)
		self.SetSliderOptionValue(OIDHorseBonusHealth, 0.000000, "$CHMCMValueInt", false)
	elseIf Option == OIDHorseBonusStamina
		CHHorseBonusStamina.SetValue(0.000000)
		self.SetSliderOptionValue(OIDHorseBonusStamina, 0.000000, "$CHMCMValueInt", false)
	elseIf Option == OIDHorseBonusSpeed
		CHHorseBonusSpeed.SetValue(0.000000)
		self.SetSliderOptionValue(OIDHorseBonusSpeed, 0.000000, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseProtectionMode
		CHHorseProtectionMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDHorseProtectionMode, self.TXTHorseProtectionMode, false)
	elseIf Option == OIDHorseBehaviorMode
		CHHorseBehaviorMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDHorseBehaviorMode, self.TXTHorseBehaviorMode, false)
	elseIf Option == OIDHorseFollowEnable
		CHHorseFollowEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDHorseFollowEnable, false, false)
	elseIf Option == OIDHorseFollowMode
		CHHorseFollowMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDHorseFollowMode, self.TXTHorseFollowMode, false)
	elseIf Option == OIDHorseFollowDistanceMode
		CHHorseFollowDistanceMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDHorseFollowDistanceMode, self.TXTHorseFollowDistanceMode, false)
	elseIf Option == OIDHorseCallFormation
		CHHorseCallFormationEnable.SetValue(1.00000)
		self.SetToggleOptionValue(OIDHorseCallFormation, CHHorseCallFormationEnable.GetValue() as Bool, false)
	elseIf Option == OIDHorseCallFade
		CHHorseCallFadeEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDHorseCallFade, false, false)
	elseIf Option == OIDFollowerModeEnable
		bFollowerHorses = false
		self.SetToggleOptionValue(OIDFollowerModeEnable, false, false)
		self.ForcePageReset()
	elseIf Option == OIDFollowerPreferRidingEnable
		CHFollowerPreferRidingEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDFollowerPreferRidingEnable, false, false)
	elseIf Option == OIDFollowerAutoRetaliateEnable
		CHFollowerAutoRetaliateEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDFollowerAutoRetaliateEnable, false, false)
		self.SetOptionFlags(OIDFollowerCombatEscapeEnable, self.OPTION_FLAG_NONE, false)
	elseIf Option == OIDFollowerCombatEscapeEnable
		CHFollowerCombatEscapeEnable.SetValue(1.00000)
		self.SetToggleOptionValue(OIDFollowerCombatEscapeEnable, true, false)
	elseIf Option == OIDFollowerDeferredDismountEnable
		CHFollowerDeferredDismountEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDFollowerDeferredDismountEnable, false, false)
		self.SetOptionFlags(OIDFollowerDeferredDismountRadius, self.OPTION_FLAG_DISABLED, false)
		self.SetOptionFlags(OIDFollowerDeferredDismountSeconds, self.OPTION_FLAG_DISABLED, false)
	elseIf Option == OIDFollowerDeferredDismountRadius
		CHFollowerDeferredDismountRadius.SetValue(640.000)
		self.SetSliderOptionValue(OIDFollowerDeferredDismountRadius, 30.0000, "$CHMCMValueFT", false)
	elseIf Option == OIDFollowerDeferredDismountSeconds
		CHFollowerDeferredDismountSeconds.SetValue(60.0000)
		self.SetSliderOptionValue(OIDFollowerDeferredDismountSeconds, 60.0000, "$CHMCMValueS", false)
	elseIf Option == OIDFollowerHorseRecallEnable
		CHFollowerHorseRecallEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDFollowerHorseRecallEnable, false, false)
		self.SetOptionFlags(OIDFollowerHorseCallDistanceMode, self.OPTION_FLAG_NONE, false)
	elseIf Option == OIDFollowerHorseCallDistanceMode
		CHFollowerHorseCallDistanceMode.SetValue(2.00000)
		self.SetTextOptionValue(OIDFollowerHorseCallDistanceMode, self.TXTFollowerHorseCallDistanceMode, false)
	elseIf Option == OIDFollowerMountedCombatEnable
		CHFollowerMountedCombatEnable.SetValue(1.00000)
		self.SetToggleOptionValue(OIDFollowerMountedCombatEnable, true, false)
		self.SetOptionFlags(OIDFollowerMountedCombatDamage, self.OPTION_FLAG_NONE, false)
	elseIf Option == OIDFollowerMountedCombatDamage
		CHFollowerMountedCombatDamageMult.SetValue(1.00000)
		self.SetSliderOptionValue(OIDFollowerMountedCombatDamage, 100.000, "$CHMCMValuePct", false)
	elseIf Option == OIDFollowerHorseGlobalSkinSelection
		CHFollowerHorseGlobalSkinSelection.SetValue(0.000000)
		self.SetTextOptionValue(OIDFollowerHorseGlobalSkinSelection, self.TXTFollowerHorseGlobalSkinSelection, false)
		self.SetOptionFlags(OIDFollowerHorseGlobalSkin, self.OPTION_FLAG_DISABLED, false)
		bUpdateSkins = true
	elseIf Option == OIDFollowerHorseGlobalSkin
		CHFollowerHorseGlobalSkin.SetValue(0.000000)
		self.SetMenuOptionValue(OIDFollowerHorseGlobalSkin, self.TXTFollowerHorseGlobalSkin, false)
		bUpdateSkins = true
	elseIf Option == OIDFollowerHorseGlobalEquipmentSelection
		CHFollowerHorseGlobalEquipmentSelection.SetValue(0.000000)
		self.SetTextOptionValue(OIDFollowerHorseGlobalEquipmentSelection, self.TXTFollowerHorseGlobalEquipmentSelection, false)
		self.SetOptionFlags(OIDFollowerHorseGlobalEquipment, self.OPTION_FLAG_DISABLED, false)
		bUpdateEquipment = true
	elseIf Option == OIDFollowerHorseGlobalEquipment
		CHFollowerHorseGlobalEquipment.SetValue(0.000000)
		self.SetMenuOptionValue(OIDFollowerHorseGlobalEquipment, self.TXTFollowerHorseGlobalEquipment, false)
		bUpdateEquipment = true
	elseIf Option == OIDFollowerHorseDynamicSpeedEnable
		CHFollowerHorseDynamicSpeedEnable.SetValue(0.000000)
		self.SetToggleOptionValue(OIDFollowerHorseDynamicSpeedEnable, false, false)
	elseIf Option == OIDAutoLootMode
		CHAutoLootMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootMode, self.TXTAutoLootMode, false)
		self.ForcePageReset()
	elseIf Option == OIDAutoLootIngredientsMode
		CHAutoLootIngredientsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootIngredientsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootAnimalHidesMode
		CHAutoLootAnimalHidesMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootAnimalHidesMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootOreAndIngotsMode
		CHAutoLootOreAndIngotsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootOreAndIngotsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootPotionsMode
		CHAutoLootPotionsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootPotionsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootPoisonsMode
		CHAutoLootPoisonsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootPoisonsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootSpellTomesMode
		CHAutoLootSpellTomesMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootSpellTomesMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootSpellTomesUnknownOnly
		CHAutoLootSpellTomesUnknownOnly.SetValue(0.000000)
		self.SetToggleOptionValue(OIDAutoLootSpellTomesUnknownOnly, false, false)
	elseIf Option == OIDAutoLootBooksMode
		CHAutoLootBooksMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootBooksMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootBooksMinValue
		CHAutoLootBooksMinValue.SetValue(50.0000)
		self.SetSliderOptionValue(OIDAutoLootBooksMinValue, 50.0000, "$CHMCMValueGold", false)
	elseIf Option == OIDAutoLootLightAndTorchesMode
		CHAutoLootLightAndTorchesMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootLightAndTorchesMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootFoodAndDrinksMode
		CHAutoLootFoodAndDrinksMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDAutoLootFoodAndDrinksMode, self.GetLooterName(0), false)
	elseIf Option == OIDAutoLootRecipesMode
		CHAutoLootRecipesMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootRecipesMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootScrollsMode
		CHAutoLootScrollsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootScrollsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootSoulGemsMode
		CHAutoLootSoulGemsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootSoulGemsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootPreciousGemsMode
		CHAutoLootPreciousGemsMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootPreciousGemsMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootKeysMode
		CHAutoLootKeysMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootKeysMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootAmmoMode
		CHAutoLootAmmoMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootAmmoMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootEquipmentMode
		CHAutoLootEquipmentMode.SetValue(1.00000)
		self.SetTextOptionValue(OIDAutoLootEquipmentMode, self.GetLooterName(1), false)
	elseIf Option == OIDAutoLootEquipmentEnchantedOnly
		CHAutoLootEquipmentEnchantedOnly.SetValue(0.000000)
		self.SetToggleOptionValue(OIDAutoLootEquipmentEnchantedOnly, false, false)
	elseIf Option == OIDAutoLootEquipmentMinWeightValue
		CHAutoLootEquipmentMinWeightValue.SetValue(25.0000)
		self.SetSliderOptionValue(OIDAutoLootEquipmentMinWeightValue, 25.0000, "$CHMCMValueVW", false)
	elseIf Option == OIDHorseCharge
		CHHorseChargeEnable.SetValue(1.00000)
		self.SetToggleOptionValue(OIDHorseCharge, true, false)
		self.ForcePageReset()
	elseIf Option == OIDHorseChargeImpactPrecognitionTime
		CHHorseChargeImpactPrecognitionTime.SetValue(0.100000)
		self.SetSliderOptionValue(OIDHorseChargeImpactPrecognitionTime, 100.000, "$CHMCMValueMS", false)
	elseIf Option == OIDHorseChargeDamageBase
		CHHorseChargeDamageBase.SetValue(20.0000)
		self.SetSliderOptionValue(OIDHorseChargeDamageBase, 20.0000, "{0}", false)
	elseIf Option == OIDHorseChargeDamageHealthPercent
		CHHorseChargeDamageHealthPercent.SetValue(0.200000)
		self.SetSliderOptionValue(OIDHorseChargeDamageHealthPercent, 20.0000, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargeStaminaCostPercent
		CHHorseChargeStaminaCostPercent.SetValue(0.200000)
		self.SetSliderOptionValue(OIDHorseChargeStaminaCostPercent, 20.0000, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargeSFXMode
		CHHorseChargeSFXMode.SetValue(0.000000)
		self.SetTextOptionValue(OIDHorseChargeSFXMode, self.TXTHorseChargeSFXMode, false)
	elseIf Option == OIDHorseChargeHeadingAngleTolerance
		CHHorseChargeHeadingAngleTolerance.SetValue(20.0000)
		self.SetSliderOptionValue(OIDHorseChargeHeadingAngleTolerance, 20.0000, "$CHMCMValueDeg", false)
	elseIf Option == OIDHorseChargeHeadingAngleScaleFactor
		CHHorseChargeHeadingAngleScaleFactor.SetValue(0.660000)
		self.SetSliderOptionValue(OIDHorseChargeHeadingAngleScaleFactor, 66.0000, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargePushForceMult
		CHHorseChargePushForceMult.SetValue(1.00000)
		self.SetSliderOptionValue(OIDHorseChargePushForceMult, 100.000, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargePushElevationAngle
		CHHorseChargePushElevationAngle.SetValue(0.000000)
		self.SetSliderOptionValue(OIDHorseChargePushElevationAngle, 0.000000, "$CHMCMValueDeg", false)
	elseIf Option == OIDHorseChargeFeedbackSlowTime
		CHHorseChargeFeedbackSlowTime.SetValue(0.400000)
		self.SetSliderOptionValue(OIDHorseChargeFeedbackSlowTime, 400.000, "$CHMCMValueMS", false)
	elseIf Option == OIDHorseChargeFeedbackSlowPercent
		CHHorseChargeFeedbackSlowPercent.SetValue(0.990000)
		self.SetSliderOptionValue(OIDHorseChargeFeedbackSlowPercent, 99.0000, "$CHMCMValuePct", false)
	endIf
endFunction

function OnOptionSliderAccept(Int Option, Float value)

	if Option == OIDInventoryWeightLimit
		CHHorseInventoryWeightLimit.SetValue(value)
		self.SetSliderOptionValue(OIDInventoryWeightLimit, value, "{0}", false)
	elseIf Option == OIDMultiTapDelay
		CHMultiTapDelay.SetValue(value * 0.00100000)
		self.SetSliderOptionValue(OIDMultiTapDelay, value, "$CHMCMValueMS", false)
	elseIf Option == OIDHorseBonusHealth
		CHHorseBonusHealth.SetValue(value)
		self.SetSliderOptionValue(OIDHorseBonusHealth, value, "$CHMCMValueInt", false)
	elseIf Option == OIDHorseBonusStamina
		CHHorseBonusStamina.SetValue(value)
		self.SetSliderOptionValue(OIDHorseBonusStamina, value, "$CHMCMValueInt", false)
	elseIf Option == OIDHorseBonusSpeed
		CHHorseBonusSpeed.SetValue(value)
		self.SetSliderOptionValue(OIDHorseBonusSpeed, value, "$CHMCMValuePct", false)
	elseIf Option == OIDFollowerDeferredDismountRadius
		CHFollowerDeferredDismountRadius.SetValue(value * 21.0000)
		self.SetSliderOptionValue(OIDFollowerDeferredDismountRadius, value, "$CHMCMValueFT", false)
	elseIf Option == OIDFollowerDeferredDismountSeconds
		CHFollowerDeferredDismountSeconds.SetValue(value)
		self.SetSliderOptionValue(OIDFollowerDeferredDismountSeconds, value, "$CHMCMValueS", false)
	elseIf Option == OIDFollowerMountedCombatDamage
		CHFollowerMountedCombatDamageMult.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDFollowerMountedCombatDamage, value, "$CHMCMValuePct", false)
	elseIf Option == OIDAutoLootBooksMinValue
		CHAutoLootBooksMinValue.SetValue(value)
		self.SetSliderOptionValue(OIDAutoLootBooksMinValue, value, "$CHMCMValueGold", false)
	elseIf Option == OIDAutoLootEquipmentMinWeightValue
		CHAutoLootEquipmentMinWeightValue.SetValue(value)
		self.SetSliderOptionValue(OIDAutoLootEquipmentMinWeightValue, value, "$CHMCMValueVW", false)
	elseIf Option == OIDHorseChargeImpactPrecognitionTime
		CHHorseChargeImpactPrecognitionTime.SetValue(value * 0.00100000)
		self.SetSliderOptionValue(OIDHorseChargeImpactPrecognitionTime, value, "$CHMCMValueMS", false)
	elseIf Option == OIDHorseChargeHeadingAngleTolerance
		CHHorseChargeHeadingAngleTolerance.SetValue(value)
		self.SetSliderOptionValue(OIDHorseChargeHeadingAngleTolerance, value, "$CHMCMValueDeg", false)
	elseIf Option == OIDHorseChargeHeadingAngleScaleFactor
		CHHorseChargeHeadingAngleScaleFactor.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDHorseChargeHeadingAngleScaleFactor, value, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargePushForceMult
		CHHorseChargePushForceMult.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDHorseChargePushForceMult, value, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargePushElevationAngle
		CHHorseChargePushElevationAngle.SetValue(value)
		self.SetSliderOptionValue(OIDHorseChargePushElevationAngle, value, "$CHMCMValueDeg", false)
	elseIf Option == OIDHorseChargeDamageBase
		CHHorseChargeDamageBase.SetValue(value)
		self.SetSliderOptionValue(OIDHorseChargeDamageBase, value, "$CHMCMValueInt", false)
	elseIf Option == OIDHorseChargeDamageHealthPercent
		CHHorseChargeDamageHealthPercent.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDHorseChargeDamageHealthPercent, value, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargeStaminaCostPercent
		CHHorseChargeStaminaCostPercent.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDHorseChargeStaminaCostPercent, value, "$CHMCMValuePct", false)
	elseIf Option == OIDHorseChargeFeedbackSlowTime
		CHHorseChargeFeedbackSlowTime.SetValue(value * 0.00100000)
		self.SetSliderOptionValue(OIDHorseChargeFeedbackSlowTime, value, "$CHMCMValueMS", false)
	elseIf Option == OIDHorseChargeFeedbackSlowPercent
		CHHorseChargeFeedbackSlowPercent.SetValue(value * 0.0100000)
		self.SetSliderOptionValue(OIDHorseChargeFeedbackSlowPercent, value, "$CHMCMValuePct", false)
	endIf
endFunction

function OnOptionHighlight(Int Option)

	if Option == OIDControlMode
		if CHControlMode.GetValue() == 0.000000
			self.SetInfoText("$CHMCMInfoControlModeBK")
		elseIf CHControlMode.GetValue() == 1.00000
			self.SetInfoText("$CHMCMInfoControlModeMT")
		else
			self.SetInfoText("")
		endIf
	elseIf Option == OIDFactionRelationsMode
		self.SetInfoText("$CHMCMInfoFactionRelationsMode")
	elseIf Option == OIDFactionRelationsUpdate
		self.SetInfoText("$CHMCMInfoFactionRelationsUpdate")
	elseIf Option == OIDConfigurationPower
		self.SetInfoText("$CHMCMInfoConfigPower")
	elseIf Option == OIDLearnWhistleOverride
		self.SetInfoText("$CHMCMInfoLearnWhistleOverride")
	elseIf Option == OIDScriptLatencyTest
		self.SetInfoText("$CHMCMInfoScriptLatency")
	elseIf Option == OIDInventoryRecovery
		self.SetInfoText("$CHMCMInfoInventoryRecovery")
	elseIf Option == OIDInventoryWeightLimit
		self.SetInfoText("$CHMCMInfoInventoryWeightLimit")
	elseIf Option == OIDAnimations
		self.SetInfoText("$CHMCMInfoAnimations")
	elseIf Option == OIDCameraFix
		self.SetInfoText("$CHMCMInfoCameraFix")
	elseIf Option == OIDHorseTracking
		self.SetInfoText("$CHMCMInfoHorseTracking")
	elseIf Option == OIDMultiTapDelay
		self.SetInfoText("$CHMCMInfoMTDelay")
	elseIf Option == OIDMultiTapCombatOverride
		self.SetInfoText("$CHMCMInfoMTCombatOverride")
	elseIf Option == OIDMultiTapDismountMode
		self.SetInfoText("$CHMCMInfoMTDismountMode")
	elseIf Option == OIDBoundKeyInventoryMode
		if CHBoundKeyInventoryMode.GetValue() == 0.000000
			self.SetInfoText("$CHMCMInfoBKInventoryLocal")
		elseIf CHBoundKeyInventoryMode.GetValue() == 1.00000
			self.SetInfoText("$CHMCMInfoBKInventoryTravel")
		elseIf CHBoundKeyInventoryMode.GetValue() == 2.00000
			self.SetInfoText("$CHMCMInfoBKInventoryRemote")
		elseIf CHBoundKeyInventoryMode.GetValue() == 3.00000
			self.SetInfoText("$CHMCMInfoBKInventoryAbsolute")
		else
			self.SetInfoText("")
		endIf
	elseIf Option == OIDBoundKeyConsolidate
		self.SetInfoText("$CHMCMInfoBKConsolidate")
	elseIf Option == OIDBoundKeyTalk
		self.SetInfoText("$CHMCMInfoBKKeyTalk")
	elseIf Option == OIDBoundKeyHarvest
		self.SetInfoText("$CHMCMInfoBKKeyHarvest")
	elseIf Option == OIDBoundKeyDismount
		self.SetInfoText("$CHMCMInfoBKKeyDismount")
	elseIf Option == OIDBoundKeyInventory
		self.SetInfoText("$CHMCMInfoBKKeyInventory")
	elseIf Option == OIDBoundKeySpecial
		self.SetInfoText("$CHMCMInfoBKKeySpecial")
	elseIf Option == OIDHorseEquipmentMode
		self.SetInfoText("$CHMCMInfoHorseEquipmentMode")
	elseIf Option == OIDHorseBonusHealth
		self.SetInfoText("$CHMCMInfoBonusHealth")
	elseIf Option == OIDHorseBonusStamina
		self.SetInfoText("$CHMCMInfoBonusStamina")
	elseIf Option == OIDHorseBonusSpeed
		self.SetInfoText("$CHMCMInfoBonusSpeed")
	elseIf Option == OIDHorseProtectionMode
		if CHHorseProtectionMode.GetValue() == 0.000000
			self.SetInfoText("$CHMCMInfoHorseProtOff")
		elseIf CHHorseProtectionMode.GetValue() == 1.00000
			self.SetInfoText("$CHMCMInfoHorseProtEssential")
		elseIf CHHorseProtectionMode.GetValue() == 2.00000
			self.SetInfoText("$CHMCMInfoHorseProtInvulnerable")
		else
			self.SetInfoText("")
		endIf
	elseIf Option == OIDHorseBehaviorMode
		if CHHorseBehaviorMode.GetValue() == 0.000000
			self.SetInfoText("$CHMCMInfoBehaviorCowardly")
		elseIf CHHorseBehaviorMode.GetValue() == 1.00000
			self.SetInfoText("$CHMCMInfoBehaviorFoolhardy")
		else
			self.SetInfoText("")
		endIf
	elseIf Option == OIDHorseFollowEnable
		self.SetInfoText("$CHMCMInfoHorseFollow")
	elseIf Option == OIDHorseFollowMode
		self.SetInfoText("$CHMCMInfoHorseFollowMode")
	elseIf Option == OIDHorseFollowDistanceMode
		self.SetInfoText("$CHMCMInfoHorseFollowDist")
	elseIf Option == OIDHorseCallFormation
		self.SetInfoText("$CHMCMInfoFormation")
	elseIf Option == OIDHorseCallFade
		self.SetInfoText("$CHMCMInfoScreenFade")
	elseIf Option == OIDFollowerModeEnable
		self.SetInfoText("$CHMCMInfoFollowersHorses")
	elseIf Option == OIDFollowerPreferRidingEnable
		self.SetInfoText("$CHMCMInfoPreferRiding")
	elseIf Option == OIDFollowerAutoRetaliateEnable
		self.SetInfoText("$CHMCMInfoAutoRetaliate")
	elseIf Option == OIDFollowerCombatEscapeEnable
		self.SetInfoText("$CHMCMInfoCombatEscape")
	elseIf Option == OIDFollowerDeferredDismountEnable
		self.SetInfoText("$CHMCMInfoDeferredDismount")
	elseIf Option == OIDFollowerDeferredDismountRadius
		self.SetInfoText("$CHMCMInfoDeferRadius")
	elseIf Option == OIDFollowerDeferredDismountSeconds
		self.SetInfoText("$CHMCMInfoDeferTime")
	elseIf Option == OIDFollowerHorseRecallEnable
		self.SetInfoText("$CHMCMInfoHorseRecall")
	elseIf Option == OIDFollowerHorseCallDistanceMode
		self.SetInfoText("$CHMCMInfoCallDist")
	elseIf Option == OIDFollowerMountedCombatEnable
		self.SetInfoText("$CHMCMInfoMountedCombat")
	elseIf Option == OIDFollowerMountedCombatDamage
		self.SetInfoText("$CHMCMInfoMCdamage")
	elseIf Option == OIDFollowerHorseGlobalSkinSelection
		self.SetInfoText("$CHMCMInfoSkinSelection")
	elseIf Option == OIDFollowerHorseGlobalSkin
		self.SetInfoText("$CHMCMInfoGlobalSkin")
	elseIf Option == OIDFollowerHorseGlobalEquipmentSelection
		self.SetInfoText("$CHMCMInfoEquipmentSelection")
	elseIf Option == OIDFollowerHorseGlobalEquipment
		self.SetInfoText("$CHMCMInfoGlobalEquipment")
	elseIf Option == OIDFollowerHorseDynamicSpeedEnable
		self.SetInfoText("$CHMCMInfoDynamicSpeed")
	elseIf Option == OIDAutoLootMode
		self.SetInfoText("$CHMCMInfoAutoLoot")
	elseIf Option == OIDAutoLootIngredientsMode
		self.SetInfoText("$CHMCMInfoIngredients")
	elseIf Option == OIDAutoLootAnimalHidesMode
		self.SetInfoText("$CHMCMInfoHides")
	elseIf Option == OIDAutoLootOreAndIngotsMode
		self.SetInfoText("$CHMCMInfoIngots")
	elseIf Option == OIDAutoLootPotionsMode
		self.SetInfoText("$CHMCMInfoPotions")
	elseIf Option == OIDAutoLootPoisonsMode
		self.SetInfoText("$CHMCMInfoPoisons")
	elseIf Option == OIDAutoLootSpellTomesMode
		self.SetInfoText("$CHMCMInfoSpellTomes")
	elseIf Option == OIDAutoLootSpellTomesUnknownOnly
		self.SetInfoText("$CHMCMInfoSpellTomesUnknownOnly")
	elseIf Option == OIDAutoLootBooksMode
		self.SetInfoText("$CHMCMInfoBooks")
	elseIf Option == OIDAutoLootBooksMinValue
		self.SetInfoText("$CHMCMInfoBooksMinValue")
	elseIf Option == OIDAutoLootLightAndTorchesMode
		self.SetInfoText("$CHMCMInfoLight")
	elseIf Option == OIDAutoLootFoodAndDrinksMode
		self.SetInfoText("$CHMCMInfoFood")
	elseIf Option == OIDAutoLootRecipesMode
		self.SetInfoText("$CHMCMInfoRecipes")
	elseIf Option == OIDAutoLootScrollsMode
		self.SetInfoText("$CHMCMInfoScrolls")
	elseIf Option == OIDAutoLootSoulGemsMode
		self.SetInfoText("$CHMCMInfoSoulGems")
	elseIf Option == OIDAutoLootPreciousGemsMode
		self.SetInfoText("$CHMCMInfoJewels")
	elseIf Option == OIDAutoLootKeysMode
		self.SetInfoText("$CHMCMInfoKeys")
	elseIf Option == OIDAutoLootAmmoMode
		self.SetInfoText("$CHMCMInfoAmmo")
	elseIf Option == OIDAutoLootEquipmentMode
		self.SetInfoText("$CHMCMInfoEquipment")
	elseIf Option == OIDAutoLootEquipmentEnchantedOnly
		self.SetInfoText("$CHMCMInfoEquipmentEnchOnly")
	elseIf Option == OIDAutoLootEquipmentMinWeightValue
		self.SetInfoText("$CHMCMInfoEquipmentMinVW")
	elseIf Option == OIDHorseCharge
		self.SetInfoText("$CHMCMInfoHorseCharge")
	elseIf Option == OIDHorseChargeImpactPrecognitionTime
		self.SetInfoText("$CHMCMInfoHCImpactPrecog")
	elseIf Option == OIDHorseChargeDamageBase
		self.SetInfoText("$CHMCMInfoHCDamageBase")
	elseIf Option == OIDHorseChargeDamageHealthPercent
		self.SetInfoText("$CHMCMInfoHCDamagePercent")
	elseIf Option == OIDHorseChargeStaminaCostPercent
		self.SetInfoText("$CHMCMInfoHCStaminaCost")
	elseIf Option == OIDHorseChargeSFXMode
		self.SetInfoText("$CHMCMInfoHCSFXMode")
	elseIf Option == OIDHorseChargeLoadPreset
		self.SetInfoText("$CHMCMInfoHCLoadPreset")
	elseIf Option == OIDHorseChargeHeadingAngleTolerance
		self.SetInfoText("$CHMCMInfoHCAngleTolerance")
	elseIf Option == OIDHorseChargeHeadingAngleScaleFactor
		self.SetInfoText("$CHMCMInfoHCForceDissipation")
	elseIf Option == OIDHorseChargePushForceMult
		self.SetInfoText("$CHMCMInfoHCPushForce")
	elseIf Option == OIDHorseChargePushElevationAngle
		self.SetInfoText("$CHMCMInfoHCElevationAngle")
	elseIf Option == OIDHorseChargeFeedbackSlowTime
		self.SetInfoText("$CHMCMInfoHCSlowTime")
	elseIf Option == OIDHorseChargeFeedbackSlowPercent
		self.SetInfoText("$CHMCMInfoHCSlowPercent")
	else
		self.SetInfoText("")
	endIf
endFunction

function OnPageReset(String Page)

	self.SetInfoText("")
	if Page == ""
		self.LoadCustomContent("CH/CH_logo.dds", 0.000000, 68.0000)
		return 
	else
		self.UnloadCustomContent()
	endIf
	if Page == Pages[0]
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$CHMCMTxtGeneral", 0)
		OIDControlMode = self.AddTextOption("$CHMCMTxtControlMode", self.TXTControlMode, 0)
		OIDConfigurationPower = self.AddTextOption("$CHMCMTxtConfigPower", self.TXTConfigurationPower, 0)
		OIDScriptLatencyTest = self.AddTextOption("$CHMCMTxtScriptLatency", self.TXTScriptLatencyTest, 0)
		self.AddHeaderOption("$CHMCMTxtFactionRelations", 0)
		OIDFactionRelationsMode = self.AddTextOption("$CHMCMTxtFactionRelationsMode", self.TXTFactionRelationsMode, 0)
		OIDFactionRelationsUpdate = self.AddTextOption("$CHMCMTxtFactionRelationsUpdate", self.TXTFactionRelationsUpdate, 0)
		self.AddHeaderOption("$CHMCMTxtMisc", 0)
		OIDAnimations = self.AddToggleOption("$CHMCMTxtAnimations", CHAnimationsEnable.GetValue() as Bool, 0)
		OIDCameraFix = self.AddToggleOption("$CHMCMTxtCameraFix", CHMountedCombatCameraFixEnable.GetValue() as Bool, 0)
		OIDHorseTracking = self.AddToggleOption("$CHMCMTxtHorseTracking", CHHorseTrackingDisable.GetValue() as Bool, 0)
		OIDLearnWhistleOverride = self.AddToggleOption("$CHMCMTxtLearnWhistleOverride", CHLearnWhistleOverride.GetValue() as Bool, 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$CHMCMTxtMultiTap", 0)
		OIDMultiTapDelay = self.AddSliderOption("$CHMCMTxtMTDelay", CHMultiTapDelay.GetValue() * 1000.00, "$CHMCMValueMS", 0)
		OIDMultiTapCombatOverride = self.AddToggleOption("$CHMCMTxtMTCombatOverride", CHMultiTapCombatOverride.GetValue() as Bool, 0)
		OIDMultiTapDismountMode = self.AddTextOption("$CHMCMTxtMTFastDismount", self.TXTMultiTapDismountMode, 0)
		self.AddHeaderOption("$CHMCMTxtBoundKey", 0)
		OIDBoundKeyConsolidate = self.AddToggleOption("$CHMCMTxtBKConsolidate", CHBoundKeyConsolidate.GetValue() as Bool, 0)
		OIDBoundKeyTalk = self.AddKeyMapOption("$CHMCMTxtBKKeyTalk", CHKeyTalk.GetValue() as Int, 0)
		OIDBoundKeyHarvest = self.AddKeyMapOption("$CHMCMTxtBKKeyHarvest", CHKeyHarvest.GetValue() as Int, self.OPTION_FLAG_DISABLED * (CHBoundKeyConsolidate.GetValue() != 0.000000) as Int)
		OIDBoundKeyDismount = self.AddKeyMapOption("$CHMCMTxtBKKeyDismount", CHKeyDismount.GetValue() as Int, 0)
		OIDBoundKeyInventory = self.AddKeyMapOption("$CHMCMTxtBKKeyInventory", CHKeyInventory.GetValue() as Int, 0)
		OIDBoundKeySpecial = self.AddKeyMapOption("$CHMCMTxtBKKeySpecial", CHKeySpecial.GetValue() as Int, 0)
	elseIf Page == Pages[1]
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$CHMCMTxtHorseInventory", 0)
		OIDInventoryRecovery = self.AddTextOption("$CHMCMTxtInventoryRecovery", self.TXTInventoryRecovery, 0)
		;OIDBoundKeyInventoryMode = self.AddTextOption("$CHMCMTxtBKInventoryAccess", self.TXTBoundKeyInventoryMode, self.OPTION_FLAG_DISABLED)
		;OIDInventoryWeightLimit = self.AddSliderOption("$CHMCMTxtWeightLimit", CHHorseInventoryWeightLimit.GetValue(), "{0}", self.OPTION_FLAG_DISABLED)
		self.AddHeaderOption("$CHMCMTxtHorseAI", 0)
		OIDHorseBehaviorMode = self.AddTextOption("$CHMCMTxtCombatBehavior", self.TXTHorseBehaviorMode, 0)
		OIDHorseFollowEnable = self.AddToggleOption("$CHMCMTxtHorseFollow", CHHorseFollowEnable.GetValue() as Bool, 0)
		OIDHorseFollowMode = self.AddTextOption("$CHMCMTxtFollowMode", self.TXTHorseFollowMode, 0)
		OIDHorseFollowDistanceMode = self.AddTextOption("$CHMCMTxtFollowDist", self.TXTHorseFollowDistanceMode, 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$CHMCMTxtHorseEquipment", 0)
		OIDHorseEquipmentMode = self.AddMenuOption("$CHMCMTxtHorseEquipment", self.TXTHorseEquipmentMode, 0)
		self.AddHeaderOption("$CHMCMTxtHorseBonus", 0)
		OIDHorseBonusHealth = self.AddSliderOption("$CHMCMTxtBonusHealth", CHHorseBonusHealth.GetValue(), "$CHMCMValueInt", 0)
		OIDHorseBonusStamina = self.AddSliderOption("$CHMCMTxtBonusStamina", CHHorseBonusStamina.GetValue(), "$CHMCMValueInt", 0)
		;OIDHorseBonusSpeed = self.AddSliderOption("$CHMCMTxtBonusSpeed", CHHorseBonusSpeed.GetValue(), "$CHMCMValuePct", self.OPTION_FLAG_DISABLED)
		self.AddHeaderOption("$CHMCMTxtHorseProtection", 0)
		OIDHorseProtectionMode = self.AddTextOption("$CHMCMTxtProtectionMode", self.TXTHorseProtectionMode, 0)
		self.AddHeaderOption("$CHMCMTxtHorseCall", 0)
		OIDHorseCallFormation = self.AddToggleOption("$CHMCMTxtFormation", CHHorseCallFormationEnable.GetValue() as Bool, 0)
		OIDHorseCallFade = self.AddToggleOption("$CHMCMTxtScreenFade", CHHorseCallFadeEnable.GetValue() as Bool, 0)
	elseIf Page == Pages[2]
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$CHMCMTxtGeneral", 0)
		OIDFollowerModeEnable = self.AddToggleOption("$CHMCMTxtFollowersHorses", bFollowerHorses, 0)
		self.AddHeaderOption("$CHMCMTxtHorseRiding", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerPreferRidingEnable = self.AddToggleOption("$CHMCMTxtPreferRiding", CHFollowerPreferRidingEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerAutoRetaliateEnable = self.AddToggleOption("$CHMCMTxtAutoRetaliate", CHFollowerAutoRetaliateEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerCombatEscapeEnable = self.AddToggleOption("$CHMCMTxtCombatEscape", CHFollowerCombatEscapeEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerAutoRetaliateEnable.GetValue() != 0.000000) as Int)
		OIDFollowerDeferredDismountEnable = self.AddToggleOption("$CHMCMTxtDeferredDismount", CHFollowerDeferredDismountEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerDeferredDismountRadius = self.AddSliderOption("$CHMCMTxtDeferRadius", CHFollowerDeferredDismountRadius.GetValue() / 21.0000, "$CHMCMValueFT", self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerDeferredDismountEnable.GetValue() == 0.000000) as Int)
		OIDFollowerDeferredDismountSeconds = self.AddSliderOption("$CHMCMTxtDeferTime", CHFollowerDeferredDismountSeconds.GetValue(), "$CHMCMValueS", self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerDeferredDismountEnable.GetValue() == 0.000000) as Int)
		self.AddHeaderOption("$CHMCMTxtHorseCalling", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseRecallEnable = self.AddToggleOption("$CHMCMTxtHorseRecall", CHFollowerHorseRecallEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseCallDistanceMode = self.AddTextOption("$CHMCMTxtCallDist", self.TXTFollowerHorseCallDistanceMode, self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerHorseRecallEnable.GetValue() != 0.000000) as Int)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$CHMCMTxtMountedCombat", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerMountedCombatEnable = self.AddToggleOption("$CHMCMTxtMountedCombat", CHFollowerMountedCombatEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerMountedCombatDamage = self.AddSliderOption("$CHMCMTxtMCDamage", CHFollowerMountedCombatDamageMult.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerMountedCombatEnable.GetValue() == 0.000000) as Int)
		self.AddHeaderOption("$CHMCMTxtHorseSkins", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseGlobalSkinSelection = self.AddTextOption("$CHMCMTxtSkinSelection", self.TXTFollowerHorseGlobalSkinSelection, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseGlobalSkin = self.AddMenuOption("$CHMCMTxtGlobalSkin", self.TXTFollowerHorseGlobalSkin, self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerHorseGlobalSkinSelection.GetValue() == 0.000000) as Int)
		self.AddHeaderOption("$CHMCMTxtHorseEquipment", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseGlobalEquipmentSelection = self.AddTextOption("$CHMCMTxtEquipmentSelection", self.TXTFollowerHorseGlobalEquipmentSelection, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseGlobalEquipment = self.AddMenuOption("$CHMCMTxtGlobalEquipment", self.TXTFollowerHorseGlobalEquipment, self.OPTION_FLAG_DISABLED * (!bFollowerHorses || CHFollowerHorseGlobalEquipmentSelection.GetValue() == 0.000000) as Int)
		self.AddHeaderOption("$CHMCMTxtFeatures", self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
		OIDFollowerHorseDynamicSpeedEnable = self.AddToggleOption("$CHMCMTxtDynamicSpeed", CHFollowerHorseDynamicSpeedEnable.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (!bFollowerHorses) as Int)
	elseIf Page == Pages[3]
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$CHMCMTxtGeneral", 0)
		OIDAutoLootMode = self.AddTextOption("$CHMCMTxtAutoLootMode", self.TXTAutoLootMode, 0)
		self.AddHeaderOption("$CHMCMTxtLootRules", 0)
		OIDAutoLootEquipmentMode = self.AddTextOption("$CHMCMTxtEquipment", self.GetLooterName(CHAutoLootEquipmentMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootEquipmentEnchantedOnly = self.AddToggleOption("$CHMCMTxtEquipmentEnchOnly", CHAutoLootEquipmentEnchantedOnly.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int)
		OIDAutoLootEquipmentMinWeightValue = self.AddSliderOption("$CHMCMTxtEquipmentMinVW", CHAutoLootEquipmentMinWeightValue.GetValue(), "$CHMCMValueVW", self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int)
		OIDAutoLootSpellTomesMode = self.AddTextOption("$CHMCMTxtSpellTomes", self.GetLooterName(CHAutoLootSpellTomesMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootSpellTomesUnknownOnly = self.AddToggleOption("$CHMCMTxtSpellTomesUnknownOnly", CHAutoLootSpellTomesUnknownOnly.GetValue() as Bool, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootSpellTomesMode.GetValue() == 0.000000) as Int)
		OIDAutoLootBooksMode = self.AddTextOption("$CHMCMTxtBooks", self.GetLooterName(CHAutoLootBooksMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootBooksMinValue = self.AddSliderOption("$CHMCMTxtBooksMinValue", CHAutoLootBooksMinValue.GetValue(), "$CHMCMValueGold", self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootBooksMode.GetValue() == 0.000000) as Int)
		OIDAutoLootScrollsMode = self.AddTextOption("$CHMCMTxtScrolls", self.GetLooterName(CHAutoLootScrollsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootRecipesMode = self.AddTextOption("$CHMCMTxtRecipes", self.GetLooterName(CHAutoLootRecipesMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		self.SetCursorPosition(1)
		OIDAutoLootAnimalHidesMode = self.AddTextOption("$CHMCMTxtHides", self.GetLooterName(CHAutoLootAnimalHidesMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootOreAndIngotsMode = self.AddTextOption("$CHMCMTxtIngots", self.GetLooterName(CHAutoLootOreAndIngotsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootIngredientsMode = self.AddTextOption("$CHMCMTxtIngredients", self.GetLooterName(CHAutoLootIngredientsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootPotionsMode = self.AddTextOption("$CHMCMTxtPotions", self.GetLooterName(CHAutoLootPotionsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootPoisonsMode = self.AddTextOption("$CHMCMTxtPoisons", self.GetLooterName(CHAutoLootPoisonsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootFoodAndDrinksMode = self.AddTextOption("$CHMCMTxtFood", self.GetLooterName(CHAutoLootFoodAndDrinksMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootSoulGemsMode = self.AddTextOption("$CHMCMTxtSoulGems", self.GetLooterName(CHAutoLootSoulGemsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootPreciousGemsMode = self.AddTextOption("$CHMCMTxtJewels", self.GetLooterName(CHAutoLootPreciousGemsMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootAmmoMode = self.AddTextOption("$CHMCMTxtAmmo", self.GetLooterName(CHAutoLootAmmoMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootLightAndTorchesMode = self.AddTextOption("$CHMCMTxtLight", self.GetLooterName(CHAutoLootLightAndTorchesMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
		OIDAutoLootKeysMode = self.AddTextOption("$CHMCMTxtKeys", self.GetLooterName(CHAutoLootKeysMode.GetValue() as Int), self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int)
	elseIf Page == Pages[4]
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$CHMCMTxtGeneral", 0)
		OIDHorseCharge = self.AddToggleOption("$CHMCMTxtHorseCharge", CHHorseChargeEnable.GetValue() as Bool, 0)
		self.AddHeaderOption("$CHMCMTxtPreferences", 0)
		OIDHorseChargeImpactPrecognitionTime = self.AddSliderOption("$CHMCMTxtImpactPrecog", CHHorseChargeImpactPrecognitionTime.GetValue() * 1000.00, "$CHMCMValueMS", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeSFXMode = self.AddTextOption("$CHMCMTxtImpactSFX", self.TXTHorseChargeSFXMode, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeDamageBase = self.AddSliderOption("$CHMCMTxtDamageBase", CHHorseChargeDamageBase.GetValue(), "$CHMCMValueInt", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeDamageHealthPercent = self.AddSliderOption("$CHMCMTxtDamageHealthPercent", CHHorseChargeDamageHealthPercent.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeStaminaCostPercent = self.AddSliderOption("$CHMCMTxtStaminaCostPercent", CHHorseChargeStaminaCostPercent.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$CHMCMTxtPhysicsSimulator", 0)
		OIDHorseChargeLoadPreset = self.AddMenuOption("$CHMCMTxtLoadPreset", "", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		self.AddEmptyOption()
		OIDHorseChargeHeadingAngleTolerance = self.AddSliderOption("$CHMCMTxtAngleTolerance", CHHorseChargeHeadingAngleTolerance.GetValue(), "$CHMCMValueDeg", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeHeadingAngleScaleFactor = self.AddSliderOption("$CHMCMTxtForceDissipation", CHHorseChargeHeadingAngleScaleFactor.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargePushForceMult = self.AddSliderOption("$CHMCMTxtForceAmount", CHHorseChargePushForceMult.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargePushElevationAngle = self.AddSliderOption("$CHMCMTxtElevationAngle", CHHorseChargePushElevationAngle.GetValue(), "$CHMCMValueDeg", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeFeedbackSlowTime = self.AddSliderOption("$CHMCMTxtFeedbackDuration", CHHorseChargeFeedbackSlowTime.GetValue() * 1000.00, "$CHMCMValueMS", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
		OIDHorseChargeFeedbackSlowPercent = self.AddSliderOption("$CHMCMTxtFeedbackAmount", CHHorseChargeFeedbackSlowPercent.GetValue() * 100.000, "$CHMCMValuePct", self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int)
	endIf
endFunction

function OnConfigClose()

	if !CH.IsRunning()
		return 
	endIf
	if bConfigPower as Bool && !game.GetPlayer().HasSpell(CHConfigurationPower as form)
		game.GetPlayer().AddSpell(CHConfigurationPower, false)
	elseIf !bConfigPower && game.GetPlayer().HasSpell(CHConfigurationPower as form)
		game.GetPlayer().RemoveSpell(CHConfigurationPower)
	endIf
	if !CHLearnWhistleCompleted.GetValue()
		if CHLearnWhistleOverride.GetValue() as Bool && !game.GetPlayer().HasSpell(CHHorseWhistlePower as form)
			game.GetPlayer().AddSpell(CHHorseWhistlePower, false)
		elseIf !CHLearnWhistleOverride.GetValue() && game.GetPlayer().HasSpell(CHHorseWhistlePower as form)
			game.GetPlayer().RemoveSpell(CHHorseWhistlePower)
		endIf
	elseIf !game.GetPlayer().HasSpell(CHHorseWhistlePower as form)
		game.GetPlayer().AddSpell(CHHorseWhistlePower, false)
	endIf
	if bLatencyTest as Bool && !CHLatencyTest.IsRunning()
		CHLatencyTest.Start()
	elseIf !bLatencyTest && CHLatencyTest.IsRunning()
		CHLatencyTest.Stop()
	endIf
	if bFollowerHorses
		CHFollowerModeEnable.SetValue(1.00000)
		if !CHFollower.IsRunning()
			CHFollower.Start()
		elseIf bUpdateSkins as Bool || bUpdateEquipment as Bool
			(CHFollower as chfollowerquestscript).RegisterForHorseUpdate(bUpdateSkins, bUpdateEquipment)
		endIf
	else
		CHFollowerModeEnable.SetValue(0.000000)
		if CHFollower.IsRunning()
			CHFollower.Stop()
		endIf
	endIf
	if bRecoverInventory
		Alias_Sack.GetReference().RemoveAllItems(game.GetPlayer() as objectreference, true, true)
		CHHorseInventoryRecoveryMessage.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	endIf
	if bHorseTrackingWasDisabled as Bool && !CHHorseTrackingDisable.GetValue()
		(CH as chquestscript).SetPlayersLastRiddenMount(none, true)
	endIf
	(CH as chquestscript).UpdateBoundKeys()
endFunction

function OnOptionMenuOpen(Int Option)

	if Option == OIDHorseEquipmentMode
		self.SetMenuDialogOptions(Equipment)
		self.SetMenuDialogStartIndex(CHHorseEquipmentMode.GetValue() as Int)
		self.SetMenuDialogDefaultIndex(0)
	elseIf Option == OIDFollowerHorseGlobalSkin
		self.SetMenuDialogOptions(Skins)
		self.SetMenuDialogStartIndex(CHFollowerHorseGlobalSkin.GetValue() as Int)
		self.SetMenuDialogDefaultIndex(0)
	elseIf Option == OIDFollowerHorseGlobalEquipment
		self.SetMenuDialogOptions(Equipment)
		self.SetMenuDialogStartIndex(1 + CHFollowerHorseGlobalEquipment.GetValue() as Int)
		self.SetMenuDialogDefaultIndex(0)
	elseIf Option == OIDHorseChargeLoadPreset
		self.SetMenuDialogOptions(Presets)
	endIf
endFunction

function OnConfigOpen()

	if !CH.IsRunning()
		self.ShowMessage("$CHMCMQuestErrorMsg", false, "$CHMCMButtonOK", "$Cancel")
	endIf
	bRecoverInventory = false
	bUpdateSkins = false
	bUpdateEquipment = false
	bConfigPower = game.GetPlayer().HasSpell(CHConfigurationPower as form)
	bHorseTrackingWasDisabled = CHHorseTrackingDisable.GetValue() as Bool
	bLatencyTest = CHLatencyTest.IsRunning()
	bFollowerHorses = CHFollower.IsRunning()
	bUserWantFactionUpdate = false
	iFactionUpdateInit = CHFactionRelationsUpdate.GetValue() as Int
	iFactionModeInit = CHFactionRelationsMode.GetValue() as Int
	if (CH as chquestscript).DawnguardOK
		Equipment[10] = "$CHMCMEquipmentName11"
	else
		Equipment[10] = "$CHMCMEquipmentName00"
	endIf
endFunction

function OnOptionSelect(Int Option)

	if Option == OIDControlMode
		CHControlMode.SetValue(((CHControlMode.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDControlMode, self.TXTControlMode, false)
	elseIf Option == OIDFactionRelationsMode
		CHFactionRelationsMode.SetValue(((CHFactionRelationsMode.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDFactionRelationsMode, self.TXTFactionRelationsMode, false)
		if iFactionModeInit != CHFactionRelationsMode.GetValue() as Int
			CHFactionRelationsUpdate.SetValue(1.00000)
			self.SetTextOptionValue(OIDFactionRelationsUpdate, self.TXTFactionRelationsUpdate, false)
		elseIf iFactionUpdateInit == 0 && !bUserWantFactionUpdate
			CHFactionRelationsUpdate.SetValue(0.000000)
			self.SetTextOptionValue(OIDFactionRelationsUpdate, self.TXTFactionRelationsUpdate, false)
		endIf
	elseIf Option == OIDFactionRelationsUpdate
		CHFactionRelationsUpdate.SetValue(((CHFactionRelationsUpdate.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDFactionRelationsUpdate, self.TXTFactionRelationsUpdate, false)
		if iFactionUpdateInit == 0
			bUserWantFactionUpdate = CHFactionRelationsUpdate.GetValue() as Bool
		endIf
	elseIf Option == OIDConfigurationPower
		bConfigPower = !bConfigPower
		self.SetTextOptionValue(OIDConfigurationPower, self.TXTConfigurationPower, false)
	elseIf Option == OIDLearnWhistleOverride
		CHLearnWhistleOverride.SetValue((!CHLearnWhistleOverride.GetValue()) as Float)
		self.SetToggleOptionValue(OIDLearnWhistleOverride, CHLearnWhistleOverride.GetValue() as Bool, false)
	elseIf Option == OIDScriptLatencyTest
		bLatencyTest = !bLatencyTest
		self.SetTextOptionValue(OIDScriptLatencyTest, self.TXTScriptLatencyTest, false)
	elseIf Option == OIDInventoryRecovery
		bRecoverInventory = !bRecoverInventory
		self.SetTextOptionValue(OIDInventoryRecovery, self.TXTInventoryRecovery, false)
	elseIf Option == OIDAnimations
		CHAnimationsEnable.SetValue((!CHAnimationsEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDAnimations, CHAnimationsEnable.GetValue() as Bool, false)
	elseIf Option == OIDCameraFix
		CHMountedCombatCameraFixEnable.SetValue((!CHMountedCombatCameraFixEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDCameraFix, CHMountedCombatCameraFixEnable.GetValue() as Bool, false)
	elseIf Option == OIDHorseTracking
		CHHorseTrackingDisable.SetValue((!CHHorseTrackingDisable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDHorseTracking, CHHorseTrackingDisable.GetValue() as Bool, false)
	elseIf Option == OIDMultiTapCombatOverride
		CHMultiTapCombatOverride.SetValue((!CHMultiTapCombatOverride.GetValue()) as Float)
		self.SetToggleOptionValue(OIDMultiTapCombatOverride, CHMultiTapCombatOverride.GetValue() as Bool, false)
	elseIf Option == OIDMultiTapDismountMode
		CHMultiTapDismountMode.SetValue(((CHMultiTapDismountMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDMultiTapDismountMode, self.TXTMultiTapDismountMode, false)
	elseIf Option == OIDBoundKeyInventoryMode
		CHBoundKeyInventoryMode.SetValue(((CHBoundKeyInventoryMode.GetValue() as Int + 1) % 4) as Float)
		self.SetTextOptionValue(OIDBoundKeyInventoryMode, self.TXTBoundKeyInventoryMode, false)
	elseIf Option == OIDBoundKeyConsolidate
		CHBoundKeyConsolidate.SetValue((!CHBoundKeyConsolidate.GetValue()) as Float)
		self.SetToggleOptionValue(OIDBoundKeyConsolidate, CHBoundKeyConsolidate.GetValue() as Bool, false)
		self.SetOptionFlags(OIDBoundKeyHarvest, self.OPTION_FLAG_DISABLED * (CHBoundKeyConsolidate.GetValue() != 0.000000) as Int, false)
	elseIf Option == OIDHorseProtectionMode
		CHHorseProtectionMode.SetValue(((CHHorseProtectionMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDHorseProtectionMode, self.TXTHorseProtectionMode, false)
	elseIf Option == OIDHorseBehaviorMode
		CHHorseBehaviorMode.SetValue(((CHHorseBehaviorMode.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDHorseBehaviorMode, self.TXTHorseBehaviorMode, false)
	elseIf Option == OIDHorseFollowEnable
		CHHorseFollowEnable.SetValue((!CHHorseFollowEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDHorseFollowEnable, CHHorseFollowEnable.GetValue() as Bool, false)
	elseIf Option == OIDHorseFollowMode
		CHHorseFollowMode.SetValue(((CHHorseFollowMode.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDHorseFollowMode, self.TXTHorseFollowMode, false)
	elseIf Option == OIDHorseFollowDistanceMode
		CHHorseFollowDistanceMode.SetValue(((CHHorseFollowDistanceMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDHorseFollowDistanceMode, self.TXTHorseFollowDistanceMode, false)
	elseIf Option == OIDHorseCallFormation
		CHHorseCallFormationEnable.SetValue((!CHHorseCallFormationEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDHorseCallFormation, CHHorseCallFormationEnable.GetValue() as Bool, false)
	elseIf Option == OIDHorseCallFade
		CHHorseCallFadeEnable.SetValue((!CHHorseCallFadeEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDHorseCallFade, CHHorseCallFadeEnable.GetValue() as Bool, false)
	elseIf Option == OIDFollowerModeEnable
		bFollowerHorses = !bFollowerHorses
		self.SetToggleOptionValue(OIDFollowerModeEnable, bFollowerHorses, false)
		self.ForcePageReset()
	elseIf Option == OIDFollowerPreferRidingEnable
		CHFollowerPreferRidingEnable.SetValue((!CHFollowerPreferRidingEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerPreferRidingEnable, CHFollowerPreferRidingEnable.GetValue() as Bool, false)
	elseIf Option == OIDFollowerAutoRetaliateEnable
		CHFollowerAutoRetaliateEnable.SetValue((!CHFollowerAutoRetaliateEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerAutoRetaliateEnable, CHFollowerAutoRetaliateEnable.GetValue() as Bool, false)
		self.SetOptionFlags(OIDFollowerCombatEscapeEnable, self.OPTION_FLAG_DISABLED * (CHFollowerAutoRetaliateEnable.GetValue() != 0.000000) as Int, false)
	elseIf Option == OIDFollowerCombatEscapeEnable
		CHFollowerCombatEscapeEnable.SetValue((!CHFollowerCombatEscapeEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerCombatEscapeEnable, CHFollowerCombatEscapeEnable.GetValue() as Bool, false)
	elseIf Option == OIDFollowerHorseRecallEnable
		CHFollowerHorseRecallEnable.SetValue((!CHFollowerHorseRecallEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerHorseRecallEnable, CHFollowerHorseRecallEnable.GetValue() as Bool, false)
		self.SetOptionFlags(OIDFollowerHorseCallDistanceMode, self.OPTION_FLAG_DISABLED * (CHFollowerHorseRecallEnable.GetValue() != 0.000000) as Int, false)
	elseIf Option == OIDFollowerDeferredDismountEnable
		CHFollowerDeferredDismountEnable.SetValue((!CHFollowerDeferredDismountEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerDeferredDismountEnable, CHFollowerDeferredDismountEnable.GetValue() as Bool, false)
		self.SetOptionFlags(OIDFollowerDeferredDismountRadius, self.OPTION_FLAG_DISABLED * (CHFollowerDeferredDismountEnable.GetValue() == 0.000000) as Int, false)
		self.SetOptionFlags(OIDFollowerDeferredDismountSeconds, self.OPTION_FLAG_DISABLED * (CHFollowerDeferredDismountEnable.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDFollowerHorseCallDistanceMode
		CHFollowerHorseCallDistanceMode.SetValue(((CHFollowerHorseCallDistanceMode.GetValue() as Int + 1) % 4) as Float)
		self.SetTextOptionValue(OIDFollowerHorseCallDistanceMode, self.TXTFollowerHorseCallDistanceMode, false)
	elseIf Option == OIDFollowerMountedCombatEnable
		CHFollowerMountedCombatEnable.SetValue((!CHFollowerMountedCombatEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerMountedCombatEnable, CHFollowerMountedCombatEnable.GetValue() as Bool, false)
		self.SetOptionFlags(OIDFollowerMountedCombatDamage, self.OPTION_FLAG_DISABLED * (CHFollowerMountedCombatEnable.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDFollowerHorseGlobalSkinSelection
		CHFollowerHorseGlobalSkinSelection.SetValue((!CHFollowerHorseGlobalSkinSelection.GetValue()) as Float)
		self.SetTextOptionValue(OIDFollowerHorseGlobalSkinSelection, self.TXTFollowerHorseGlobalSkinSelection, false)
		self.SetOptionFlags(OIDFollowerHorseGlobalSkin, self.OPTION_FLAG_DISABLED * (CHFollowerHorseGlobalSkinSelection.GetValue() == 0.000000) as Int, false)
		bUpdateSkins = true
	elseIf Option == OIDFollowerHorseGlobalEquipmentSelection
		CHFollowerHorseGlobalEquipmentSelection.SetValue((!CHFollowerHorseGlobalEquipmentSelection.GetValue()) as Float)
		self.SetTextOptionValue(OIDFollowerHorseGlobalEquipmentSelection, self.TXTFollowerHorseGlobalEquipmentSelection, false)
		self.SetOptionFlags(OIDFollowerHorseGlobalEquipment, self.OPTION_FLAG_DISABLED * (CHFollowerHorseGlobalEquipmentSelection.GetValue() == 0.000000) as Int, false)
		bUpdateEquipment = true
	elseIf Option == OIDFollowerHorseDynamicSpeedEnable
		CHFollowerHorseDynamicSpeedEnable.SetValue((!CHFollowerHorseDynamicSpeedEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDFollowerHorseDynamicSpeedEnable, CHFollowerHorseDynamicSpeedEnable.GetValue() as Bool, false)
	elseIf Option == OIDAutoLootMode
		CHAutoLootMode.SetValue(((CHAutoLootMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootMode, self.TXTAutoLootMode, false)
		self.SetOptionFlags(OIDAutoLootIngredientsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootAnimalHidesMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootOreAndIngotsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootPotionsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootPoisonsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootSpellTomesMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootSpellTomesUnknownOnly, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootSpellTomesMode.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDAutoLootBooksMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootBooksMinValue, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootBooksMode.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDAutoLootLightAndTorchesMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootFoodAndDrinksMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootRecipesMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootScrollsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootSoulGemsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootPreciousGemsMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootKeysMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootAmmoMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootEquipmentMode, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000) as Int, true)
		self.SetOptionFlags(OIDAutoLootEquipmentEnchantedOnly, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDAutoLootEquipmentMinWeightValue, self.OPTION_FLAG_DISABLED * (CHAutoLootMode.GetValue() != 2.00000 || CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDAutoLootIngredientsMode
		CHAutoLootIngredientsMode.SetValue(((CHAutoLootIngredientsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootIngredientsMode, self.GetLooterName(CHAutoLootIngredientsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootAnimalHidesMode
		CHAutoLootAnimalHidesMode.SetValue(((CHAutoLootAnimalHidesMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootAnimalHidesMode, self.GetLooterName(CHAutoLootAnimalHidesMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootOreAndIngotsMode
		CHAutoLootOreAndIngotsMode.SetValue(((CHAutoLootOreAndIngotsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootOreAndIngotsMode, self.GetLooterName(CHAutoLootOreAndIngotsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootPotionsMode
		CHAutoLootPotionsMode.SetValue(((CHAutoLootPotionsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootPotionsMode, self.GetLooterName(CHAutoLootPotionsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootPoisonsMode
		CHAutoLootPoisonsMode.SetValue(((CHAutoLootPoisonsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootPoisonsMode, self.GetLooterName(CHAutoLootPoisonsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootSpellTomesMode
		CHAutoLootSpellTomesMode.SetValue(((CHAutoLootSpellTomesMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootSpellTomesMode, self.GetLooterName(CHAutoLootSpellTomesMode.GetValue() as Int), false)
		self.SetOptionFlags(OIDAutoLootSpellTomesUnknownOnly, self.OPTION_FLAG_DISABLED * (CHAutoLootSpellTomesMode.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDAutoLootSpellTomesUnknownOnly
		CHAutoLootSpellTomesUnknownOnly.SetValue((!CHAutoLootSpellTomesUnknownOnly.GetValue()) as Float)
		self.SetToggleOptionValue(OIDAutoLootSpellTomesUnknownOnly, CHAutoLootSpellTomesUnknownOnly.GetValue() as Bool, false)
	elseIf Option == OIDAutoLootBooksMode
		CHAutoLootBooksMode.SetValue(((CHAutoLootBooksMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootBooksMode, self.GetLooterName(CHAutoLootBooksMode.GetValue() as Int), false)
		self.SetOptionFlags(OIDAutoLootBooksMinValue, self.OPTION_FLAG_DISABLED * (CHAutoLootBooksMode.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDAutoLootLightAndTorchesMode
		CHAutoLootLightAndTorchesMode.SetValue(((CHAutoLootLightAndTorchesMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootLightAndTorchesMode, self.GetLooterName(CHAutoLootLightAndTorchesMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootFoodAndDrinksMode
		CHAutoLootFoodAndDrinksMode.SetValue(((CHAutoLootFoodAndDrinksMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootFoodAndDrinksMode, self.GetLooterName(CHAutoLootFoodAndDrinksMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootRecipesMode
		CHAutoLootRecipesMode.SetValue(((CHAutoLootRecipesMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootRecipesMode, self.GetLooterName(CHAutoLootRecipesMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootScrollsMode
		CHAutoLootScrollsMode.SetValue(((CHAutoLootScrollsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootScrollsMode, self.GetLooterName(CHAutoLootScrollsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootSoulGemsMode
		CHAutoLootSoulGemsMode.SetValue(((CHAutoLootSoulGemsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootSoulGemsMode, self.GetLooterName(CHAutoLootSoulGemsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootPreciousGemsMode
		CHAutoLootPreciousGemsMode.SetValue(((CHAutoLootPreciousGemsMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootPreciousGemsMode, self.GetLooterName(CHAutoLootPreciousGemsMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootKeysMode
		CHAutoLootKeysMode.SetValue(((CHAutoLootKeysMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootKeysMode, self.GetLooterName(CHAutoLootKeysMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootAmmoMode
		CHAutoLootAmmoMode.SetValue(((CHAutoLootAmmoMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootAmmoMode, self.GetLooterName(CHAutoLootAmmoMode.GetValue() as Int), false)
	elseIf Option == OIDAutoLootEquipmentMode
		CHAutoLootEquipmentMode.SetValue(((CHAutoLootEquipmentMode.GetValue() as Int + 1) % 3) as Float)
		self.SetTextOptionValue(OIDAutoLootEquipmentMode, self.GetLooterName(CHAutoLootEquipmentMode.GetValue() as Int), false)
		self.SetOptionFlags(OIDAutoLootEquipmentEnchantedOnly, self.OPTION_FLAG_DISABLED * (CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int, false)
		self.SetOptionFlags(OIDAutoLootEquipmentMinWeightValue, self.OPTION_FLAG_DISABLED * (CHAutoLootEquipmentMode.GetValue() == 0.000000) as Int, false)
	elseIf Option == OIDAutoLootEquipmentEnchantedOnly
		CHAutoLootEquipmentEnchantedOnly.SetValue((!CHAutoLootEquipmentEnchantedOnly.GetValue()) as Float)
		self.SetToggleOptionValue(OIDAutoLootEquipmentEnchantedOnly, CHAutoLootEquipmentEnchantedOnly.GetValue() as Bool, false)
	elseIf Option == OIDHorseChargeSFXMode
		CHHorseChargeSFXMode.SetValue(((CHHorseChargeSFXMode.GetValue() as Int + 1) % 2) as Float)
		self.SetTextOptionValue(OIDHorseChargeSFXMode, self.TXTHorseChargeSFXMode, false)
	elseIf Option == OIDHorseCharge
		CHHorseChargeEnable.SetValue((!CHHorseChargeEnable.GetValue()) as Float)
		self.SetToggleOptionValue(OIDHorseCharge, CHHorseChargeEnable.GetValue() as Bool, false)
		self.SetOptionFlags(OIDHorseChargeImpactPrecognitionTime, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeSFXMode, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeDamageBase, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeDamageHealthPercent, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeStaminaCostPercent, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeLoadPreset, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeHeadingAngleTolerance, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeHeadingAngleScaleFactor, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargePushForceMult, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargePushElevationAngle, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeFeedbackSlowTime, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeFeedbackSlowPercent, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeImpactPrecognitionTime, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeImpactPrecognitionTime, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, true)
		self.SetOptionFlags(OIDHorseChargeImpactPrecognitionTime, self.OPTION_FLAG_DISABLED * (CHHorseChargeEnable.GetValue() == 0.000000) as Int, false)
	endIf
endFunction

; Skipped compiler generated GetState

function OnConfigInit()

	self.InitArrays()
endFunction

function OnOptionKeyMapChange(Int Option, Int KeyCode, String ConflictControl, String ConflictName)

	Int KeyCodeOld
	if KeyCode == 1 || KeyCode == 270
		return 
	endIf
	if Option == OIDBoundKeyTalk
		KeyCodeOld = CHKeyTalk.GetValue() as Int
		CHKeyTalk.SetValue(KeyCode as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyTalk, CHKeyTalk.GetValue() as Int, false)
	elseIf Option == OIDBoundKeyHarvest
		KeyCodeOld = CHKeyHarvest.GetValue() as Int
		CHKeyHarvest.SetValue(KeyCode as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyHarvest, CHKeyHarvest.GetValue() as Int, false)
	elseIf Option == OIDBoundKeyDismount
		KeyCodeOld = CHKeyDismount.GetValue() as Int
		CHKeyDismount.SetValue(KeyCode as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyDismount, CHKeyDismount.GetValue() as Int, false)
	elseIf Option == OIDBoundKeyInventory
		KeyCodeOld = CHKeyInventory.GetValue() as Int
		CHKeyInventory.SetValue(KeyCode as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyInventory, CHKeyInventory.GetValue() as Int, false)
	elseIf Option == OIDBoundKeySpecial
		KeyCodeOld = CHKeySpecial.GetValue() as Int
		CHKeySpecial.SetValue(KeyCode as Float)
		self.SetKeyMapOptionValue(OIDBoundKeySpecial, CHKeySpecial.GetValue() as Int, false)
	endIf
	if Option != OIDBoundKeyTalk && KeyCode == CHKeyTalk.GetValue() as Int
		CHKeyTalk.SetValue(KeyCodeOld as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyTalk, CHKeyTalk.GetValue() as Int, false)
	elseIf Option != OIDBoundKeyHarvest && KeyCode == CHKeyHarvest.GetValue() as Int
		CHKeyHarvest.SetValue(KeyCodeOld as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyHarvest, CHKeyHarvest.GetValue() as Int, false)
	elseIf Option != OIDBoundKeyDismount && KeyCode == CHKeyDismount.GetValue() as Int
		CHKeyDismount.SetValue(KeyCodeOld as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyDismount, CHKeyDismount.GetValue() as Int, false)
	elseIf Option != OIDBoundKeyInventory && KeyCode == CHKeyInventory.GetValue() as Int
		CHKeyInventory.SetValue(KeyCodeOld as Float)
		self.SetKeyMapOptionValue(OIDBoundKeyInventory, CHKeyInventory.GetValue() as Int, false)
	elseIf Option != OIDBoundKeySpecial && KeyCode == CHKeySpecial.GetValue() as Int
		CHKeySpecial.SetValue(KeyCodeOld as Float)
		self.SetKeyMapOptionValue(OIDBoundKeySpecial, CHKeySpecial.GetValue() as Int, false)
	endIf
endFunction

; Skipped compiler generated GotoState

function OnOptionSliderOpen(Int Option)

	if Option == OIDInventoryWeightLimit
		self.SetSliderDialogStartValue(CHHorseInventoryWeightLimit.GetValue())
		self.SetSliderDialogDefaultValue(0.000000)
		self.SetSliderDialogRange(0.000000, 5000.00)
		self.SetSliderDialogInterval(5.00000)
	elseIf Option == OIDMultiTapDelay
		self.SetSliderDialogStartValue(CHMultiTapDelay.GetValue() * 1000.00)
		self.SetSliderDialogDefaultValue(300.000)
		self.SetSliderDialogRange(100.000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseBonusHealth
		self.SetSliderDialogStartValue(CHHorseBonusHealth.GetValue())
		self.SetSliderDialogDefaultValue(0.000000)
		self.SetSliderDialogRange(0.000000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseBonusStamina
		self.SetSliderDialogStartValue(CHHorseBonusStamina.GetValue())
		self.SetSliderDialogDefaultValue(0.000000)
		self.SetSliderDialogRange(0.000000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseBonusSpeed
		self.SetSliderDialogStartValue(CHHorseBonusSpeed.GetValue())
		self.SetSliderDialogDefaultValue(0.000000)
		self.SetSliderDialogRange(0.000000, 100.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDFollowerDeferredDismountRadius
		self.SetSliderDialogStartValue(CHFollowerDeferredDismountRadius.GetValue() / 21.0000)
		self.SetSliderDialogDefaultValue(30.0000)
		self.SetSliderDialogRange(10.0000, 100.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDFollowerDeferredDismountSeconds
		self.SetSliderDialogStartValue(CHFollowerDeferredDismountSeconds.GetValue())
		self.SetSliderDialogDefaultValue(60.0000)
		self.SetSliderDialogRange(0.000000, 300.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDFollowerMountedCombatDamage
		self.SetSliderDialogStartValue(CHFollowerMountedCombatDamageMult.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(100.000)
		self.SetSliderDialogRange(0.000000, 300.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDAutoLootBooksMinValue
		self.SetSliderDialogStartValue(CHAutoLootBooksMinValue.GetValue())
		self.SetSliderDialogDefaultValue(50.0000)
		self.SetSliderDialogRange(0.000000, 500.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDAutoLootEquipmentMinWeightValue
		self.SetSliderDialogStartValue(CHAutoLootEquipmentMinWeightValue.GetValue())
		self.SetSliderDialogDefaultValue(25.0000)
		self.SetSliderDialogRange(0.000000, 500.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeImpactPrecognitionTime
		self.SetSliderDialogStartValue(CHHorseChargeImpactPrecognitionTime.GetValue() * 1000.00)
		self.SetSliderDialogDefaultValue(100.000)
		self.SetSliderDialogRange(0.000000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeHeadingAngleTolerance
		self.SetSliderDialogStartValue(CHHorseChargeHeadingAngleTolerance.GetValue())
		self.SetSliderDialogDefaultValue(20.0000)
		self.SetSliderDialogRange(5.00000, 90.0000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeHeadingAngleScaleFactor
		self.SetSliderDialogStartValue(CHHorseChargeHeadingAngleScaleFactor.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(66.0000)
		self.SetSliderDialogRange(0.000000, 100.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargePushForceMult
		self.SetSliderDialogStartValue(CHHorseChargePushForceMult.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(100.000)
		self.SetSliderDialogRange(0.000000, 300.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargePushElevationAngle
		self.SetSliderDialogStartValue(CHHorseChargePushElevationAngle.GetValue())
		self.SetSliderDialogDefaultValue(0.000000)
		self.SetSliderDialogRange(-90.0000, 90.0000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeDamageBase
		self.SetSliderDialogStartValue(CHHorseChargeDamageBase.GetValue())
		self.SetSliderDialogDefaultValue(20.0000)
		self.SetSliderDialogRange(0.000000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeDamageHealthPercent
		self.SetSliderDialogStartValue(CHHorseChargeDamageHealthPercent.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(20.0000)
		self.SetSliderDialogRange(0.000000, 100.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeStaminaCostPercent
		self.SetSliderDialogStartValue(CHHorseChargeStaminaCostPercent.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(20.0000)
		self.SetSliderDialogRange(0.000000, 100.000)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeFeedbackSlowTime
		self.SetSliderDialogStartValue(CHHorseChargeFeedbackSlowTime.GetValue() * 1000.00)
		self.SetSliderDialogDefaultValue(400.000)
		self.SetSliderDialogRange(0.000000, 1000.00)
		self.SetSliderDialogInterval(1.00000)
	elseIf Option == OIDHorseChargeFeedbackSlowPercent
		self.SetSliderDialogStartValue(CHHorseChargeFeedbackSlowPercent.GetValue() * 100.000)
		self.SetSliderDialogDefaultValue(99.0000)
		self.SetSliderDialogRange(0.000000, 99.0000)
		self.SetSliderDialogInterval(1.00000)
	endIf
endFunction
