Scriptname REQ_MCM_DataStorage extends REQ_PlayerAlias
{A storage script containing all the MCM settings data.}

;REQ_MCM Property mcm Auto
;/ REQ_MCM_Skills Property mcm_skills Auto /;

int Property iHoursToRespawnCell Auto
int Property iHoursToRespawnCellCleared Auto
float Property fPlayerDeathReloadTime Auto
float Property fDiffMultHPByPCL Auto
float Property fDiffMultHPToPCL Auto
GlobalVariable Property WIWaitDragon Auto
float Property fPlayerHealthHeartbeatSlow Auto
float Property fJumpHeightMin Auto
GlobalVariable Property REQ_Skills_RateFactor Auto
GlobalVariable Property TimeScale Auto
GlobalVariable Property REQ_Debug_ArmorTraining Auto
GlobalVariable Property REQ_Compatibility_AttackSpeed Auto
GlobalVariable Property REQ_Combat_NoDragonFear Auto
GlobalVariable Property REQ_Combat_EssentialAgain Auto
GlobalVariable Property REQ_Combat_NoOnHitDisarm Auto
GlobalVariable Property REQ_Atmosphere_AllowFastTravel Auto
GlobalVariable Property REQ_Combat_NoFearAndYield Auto
GlobalVariable Property REQ_Debug_OnHit Auto
GlobalVariable Property REQ_Combat_NoHorseTrample Auto
GlobalVariable Property REQ_Compatibility_NonCriticalWarnOverride Auto
GlobalVariable Property REQ_Atmosphere_NoPoisonISM Auto
GlobalVariable Property REQ_Skills_HideClutterRecipes Auto
GlobalVariable Property REQ_Atmosphere_SlowerHorses Auto
GlobalVariable Property REQ_Skills_NoSmithingBooks Auto
GlobalVariable Property REQ_Debug_ExhaustionReset Auto
Perk Property REQ_MechanicsPerk_Stress_Exhaustion Auto
GlobalVariable Property REQ_Atmosphere_VampireRandomCarnage Auto
GlobalVariable Property REQ_Combat_NoDeathHandling Auto
GlobalVariable Property REQ_Debug_MassEffectReset Auto
GlobalVariable Property REQ_Atmosphere_KillmoveHealthThreshold Auto
GlobalVariable Property REQ_Disable_Bless_Message Auto

Bool Property initdone = False Auto

Event ScriptInit(string eventName, string strArg, float numArg, Form sender)
    REQ_AutoUpdater UpdateControl = GetOwningQuest().GetAlias(0) as REQ_AutoUpdater
    Int index = UpdateControl.Scripts.find(self)
    UpdateControl.ShutdownReady[index] = False
    initdone = true
EndEvent

Event ScriptShutDown(string eventName, string strArg, float numArg, Form sender)
    REQ_AutoUpdater UpdateControl = GetOwningQuest().GetAlias(0) as REQ_AutoUpdater
    Int index = UpdateControl.Scripts.find(self)
    UpdateControl.ShutdownReady[index] = True
EndEvent
