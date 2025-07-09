Scriptname CHPlayerAliasScript extends ReferenceAlias
{Script by Alek (mitchalek@yahoo.com).
Attached to a player alias, bound key mode, detect key presses and call corresponding functions.}

ReferenceAlias property Alias_Horse auto
ReferenceAlias property Alias_Sack auto
ReferenceAlias property Alias_TeleportMarker auto
ReferenceAlias property Alias_CHFollower_Player auto

; Transform races
; Race property WerewolfBeastRace auto
; Race property DLC1VampireBeastRace auto
; Latency test - stop quest on game load
Quest property CHLatencyTest auto

; Quest scripts for game load property
CHQuestScript property CH auto
CHFollowerQuestScript property CHFollower auto

; Messages
Message property CHHorseFollowEnabledMessage auto
Message property CHHorseFollowDisabledMessage auto
Message property CHErrorHorseDisabledMessage auto
Message property CHInventoryQuickTransferMenu auto
Message property CHInventoryQuickTransferStoreMenu auto
Message property CHInventoryQuickTransferRetrieveMenu auto
Message property CHInventoryQuickTransferNotification auto

; Quick inventory transfer related
FormList property CHBlacksmithingMaterialList auto
FormList property CHEnchantingMaterialList auto

; Balloon related
Spell property CHFortifyCarryWeightSpell auto
Keyword property CHMagicFortifyCarryWeight auto
MiscObject property CHBalloonKit auto
Message property CHBalloonDeploymentNotification auto

; Globals
GlobalVariable property CHKeyTalk auto
GlobalVariable property CHKeyHarvest auto
GlobalVariable property CHKeyDismount auto
GlobalVariable property CHKeyInventory auto
GlobalVariable property CHKeySpecial auto
GlobalVariable property CHBoundKeyConsolidate auto
GlobalVariable property CHHorseFollowEnable auto
GlobalVariable property CHAnimationsEnable auto
GlobalVariable property CHBoundKeyInventoryMode auto
GlobalVariable property CHFollowerDeferredDismountEnable auto

; Mounted conversations
Keyword property ActorTypeNPC auto
Keyword property ActorTypeHorse auto

; Mounted harvesting
FormList property CHHarvestableList auto

; Locations for easy inventory access
FormList property CHRidableWorldList auto
FormList property CHCityWorldList auto
Keyword property LocTypePlayerHouse auto
Keyword property LocTypeStore auto
Keyword property LocTypeCastle auto
Keyword property LocTypeGuild auto
Keyword property LocTypeInn auto

; Horse sounds
Sound property CHHorseWhineSM auto
VoiceType property CrHorseVoice auto

; Validity check supplementals
MagicEffect property CHHorseWhistleEffect auto

; Image space modifiers
ImageSpaceModifier property CHFadeIntroImod auto
ImageSpaceModifier property CHFadeMainImod auto
ImageSpaceModifier property CHFadeOutroImod auto

Actor PlayerRef
Actor DialogueTarget
Bool bKeyProcessing

Import Input
import Game
import Utility
import Math
import Debug


Event OnPlayerLoadGame()
	CH.GameLoaded = true
	CHFollower.GameLoaded = true
	CHLatencyTest.Stop()
EndEvent

; Encumbrance checks and balloon deployment
Event OnUpdate()
	PlayerRef = GetPlayer()
	if !PlayerRef.GetItemCount(CHBalloonKit)
		RegisterForSingleUpdate(10)
		return
	endif
	if !IsActivateControlsEnabled() || !IsMenuControlsEnabled()
		RegisterForSingleUpdate(1)
		return
	endif
	if PlayerRef.GetActorValue("InventoryWeight") > PlayerRef.GetActorValue("CarryWeight") && !PlayerRef.HasEffectKeyword(CHMagicFortifyCarryWeight)
		PlayerRef.RemoveItem(CHBalloonKit, 1, true)
		CHFortifyCarryWeightSpell.Cast(PlayerRef)
		CHBalloonDeploymentNotification.Show()
		RegisterForSingleUpdate(10)
		return
	endif
	RegisterForSingleUpdate(1)
EndEvent

; Registered for LOS when using whistle while horse is too far away
; Forces player to look at the horse and play few voice comments when it finally arrives
Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	PlayerRef = GetPlayer()
	if akViewer != Alias_Horse.GetActorReference() || akTarget != PlayerRef
		return
	endif

	if akViewer.GetVoiceType() == CrHorseVoice
		CHHorseWhineSM.Play(akViewer)
	endif

	if !CHAnimationsEnable.GetValue() || !PlayerRef.GetAnimationVariableBool("bVoiceReady") || PlayerRef.HasLOS(akViewer) || PlayerRef.HasMagicEffect(CHHorseWhistleEffect) || !IsLookingControlsEnabled()
		return
	endif

	PlayerRef.SetGhost(True)
	DisablePlayerControls(abMovement = false, abFighting = false, abCamSwitch = True, abLooking = PlayerRef.GetAnimationVariableBool("i1stPerson"), abSneaking = True, abMenu = true, abActivate = true, abJournalTabs = false)
	SetPlayerAIDriven(True)
	PlayerRef.SetLookAt(akViewer, true)
	Wait(pow(abs(PlayerRef.GetHeadingAngle(akViewer)), 0.6) * 0.1)
	PlayerRef.ClearLookAt()
	SetPlayerAIDriven(False)
	EnablePlayerControls()
	PlayerRef.SetGhost(False)
EndEvent

; Auto State Passive
	; Event OnUpdate()
	; EndEvent
; EndState

State BoundKey
	Event OnBeginState()
		PlayerRef = GetPlayer()
		int NumKeysRegistered
		if CHKeyTalk.GetValue() as Int > 1
			RegisterForKey(CHKeyTalk.GetValue() as Int)
			NumKeysRegistered += 1
		endif
		if CHKeyHarvest.GetValue() as Int > 1
			RegisterForKey(CHKeyHarvest.GetValue() as Int)
			NumKeysRegistered += 1
		endif
		if CHKeyDismount.GetValue() as Int > 1
			RegisterForKey(CHKeyDismount.GetValue() as Int)
			NumKeysRegistered += 1
		endif
		if CHKeyInventory.GetValue() as Int > 1
			RegisterForKey(CHKeyInventory.GetValue() as Int)
			NumKeysRegistered += 1
		endif
		if CHKeySpecial.GetValue() as Int > 1
			RegisterForKey(CHKeySpecial.GetValue() as Int)
			NumKeysRegistered += 1
		endif
		Trace("========== Convenient Horses: Registered for " + NumKeysRegistered + " key press events.")
	EndEvent

	Event OnKeyDown(Int KeyCode)
		if IsInMenuMode() || bKeyProcessing
			return
		endif
		bKeyProcessing = true
		if KeyCode == CHKeyInventory.GetValue() as Int
			HorseInventory(KeyCode)
		elseif KeyCode == CHKeyTalk.GetValue() as Int
			if DialogueTarget
				if DialogueTarget.IsInDialogueWithPlayer()
					return
				endif
			endif
			DialogueTarget = Talk(KeyCode)
			if !DialogueTarget && CHBoundKeyConsolidate.GetValue()
				Harvest(KeyCode)
			endif
		elseif KeyCode == CHKeyHarvest.GetValue() as Int
			if !CHBoundKeyConsolidate.GetValue()
				Harvest(KeyCode)
			endif
		elseif KeyCode == CHKeyDismount.GetValue() as Int
			FastDismount(KeyCode)
		elseif KeyCode == CHKeySpecial.GetValue() as Int
			HorseSpecial(KeyCode)
		endif
		bKeyProcessing = false
	EndEvent

	Event OnEndState()
		UnregisterForAllKeys()
		Trace("========== Convenient Horses: Unregistered for all key press events.")
	EndEvent
EndState

Function FastDismount(Int KeyPressed)
	if !KeyPressed
		return
	endif
	if !IsActivateControlsEnabled()
		return
	endif
	Actor HorseRef = GetPlayersLastRiddenHorse()
	if !HorseRef
		return
	endif
	if !HorseRef.IsBeingRidden() || !PlayerRef.IsOnMount()
		return
	endif
	if !PlayerRef.GetAnimationVariableBool("bIsRiding")
		return
	endif
	if HorseRef.GetAnimationVariableBool("bInJumpState") || HorseRef.GetAnimationVariableInt("iState") == 63	; iState 63 is swimming state
		return
	endif

	bool PreventSheathe
	int WeaponDrawState
	;int leftHandType = PlayerRef.GetEquippedItemType(0)
	int rightHandType = PlayerRef.GetEquippedItemType(1)
	float distance = HorseRef.GetLength() * 0.85 * HorseRef.GetScale()

	if PlayerRef.IsWeaponDrawn()
		WeaponDrawState = 2
		; if leftHandType == 1 || leftHandType == 2 || leftHandType == 3 || leftHandType == 4 || (leftHandType >= 8 && leftHandType <= 11)
			; WeaponDrawState = 1
		; else
			; WeaponDrawState = 2
		; endif
		PreventSheathe = True
		SendAnimationEvent(PlayerRef, "MountedSwimStart")	; Prevent sheathe animation
	elseif PlayerRef.IsInCombat()
		if rightHandType < 8 || rightHandType == 12
			WeaponDrawState = 2
		else
			WeaponDrawState = 3
		endif
	endif

	; Initiate
	PlayerRef.Dismount()

	; Safety checks - make sure dismounting has started
	int loopNumPasses = 50
	while PlayerRef.GetSitState() != 4
		if loopNumPasses == 0
			if PreventSheathe
				SendAnimationEvent(PlayerRef, "MountedSwimStop")
			endif
			return
		endif
		loopNumPasses -= 1
	endwhile

	(GetForm(0x000388f7) as sound).Play(PlayerRef)

	; Replace dismount animation
	SendAnimationEvent(PlayerRef, "JumpStandingStart")
	if WeaponDrawState == 1
		SendAnimationEvent(PlayerRef, "WeapOutLeftReplaceForceEquip")
	elseif WeaponDrawState == 2
		SendAnimationEvent(PlayerRef, "WeapOutRightReplaceForceEquip")
	elseif WeaponDrawState == 3
		SendAnimationEvent(PlayerRef, "MagicForceEquip")
	endif

	; Simulate backward jump ending up just behind the horse
	PlayerRef.TranslateTo(( PlayerRef.GetPositionX() - distance * sin(PlayerRef.GetAngleZ()) ), ( PlayerRef.GetPositionY() - distance * cos(PlayerRef.GetAngleZ()) ), HorseRef.GetPositionZ(), 0, 0, 0, distance * 3)

	; Deferred dismount - set player dismount values
	if CHFollowerDeferredDismountEnable.GetValue()
		if Alias_CHFollower_Player.GetOwningQuest().IsRunning()
			(Alias_CHFollower_Player as CHFollowerPlayerAliasScript).SetPlayerDismountValues()
		endif
	endif

	; Speed up weapon draw animation
	if WeaponDrawState == 2
		loopNumPasses = 50
		; Wait for weapon to get attached to hand node
		while !PlayerRef.IsWeaponDrawn() && loopNumPasses
			loopNumPasses -= 1
		endwhile
		if loopNumPasses
			SendAnimationEvent(PlayerRef, "WeapEquip_Out")
		endif
	endif

	; Prevent being stuck in sprint state
	if PlayerRef.IsSprinting()
		SendAnimationEvent(PlayerRef, "SprintStop")
	endif
EndFunction

Actor Function Talk(Int KeyPressed)
	if !KeyPressed
		return None
	endif
	if !IsActivateControlsEnabled()
		return None
	endif
	Actor HorseRef = GetPlayersLastRiddenHorse()
	if !HorseRef
		return None
	endif
	if !HorseRef.IsBeingRidden() || !PlayerRef.IsOnMount()
		return None
	endif
	if !PlayerRef.GetAnimationVariableBool("bIsRiding")
		return None
	endif
	float radiusOffset = 40
	float angleOffset = 40
	float playerX = PlayerRef.GetPositionX()
	float playerY = PlayerRef.GetPositionY()
	float angleZ = PlayerRef.GetAngleZ()
	float horseZ = HorseRef.GetPositionZ()
	float radius = (180 + PlayerRef.GetPositionZ() - horseZ) / 2
	Actor Rider
	float newX = playerX + (radius + radiusOffset) * sin(angleZ - angleOffset)
	float newY = playerY + (radius + radiusOffset) * cos(angleZ - angleOffset)
	Actor NPC = FindClosestActor(newX, newY, horseZ, radius)
	if NPC
		if NPC.IsDisabled()
			NPC = None	; clear if disabled
		elseif !NPC.IsDead()	; keep dead actors so we can loot the corpse
			if NPC.HasKeyword(ActorTypeHorse) && NPC != HorseRef && NPC.IsBeingRidden()	; If we found a horse try to find a rider
				Rider = FindClosestActor(NPC.GetPositionX(), NPC.GetPositionY(), NPC.GetPositionZ()+NPC.GetHeight(), NPC.GetHeight())
				if Rider
					if Rider.IsOnMount()
						NPC = Rider	; rider override
					endif
				endif
			endif
			if NPC == PlayerRef || !NPC.HasKeyword(ActorTypeNPC)
				NPC = None	; clear if no valid ref
			endif
		endif
	endif

	newX = playerX + (radius + radiusOffset) * sin(angleZ + angleOffset)
	newY = playerY + (radius + radiusOffset) * cos(angleZ + angleOffset)
	Actor NPC2 = FindClosestActor(newX, newY, horseZ, radius)
	if NPC2
		if NPC2.IsEnabled()
			if !NPC2.IsDead()
				if NPC2.HasKeyword(ActorTypeHorse) && NPC2 != HorseRef && NPC2.IsBeingRidden()	; If we found a horse try to find a rider
					Rider = FindClosestActor(NPC2.GetPositionX(), NPC2.GetPositionY(), NPC2.GetPositionZ()+NPC2.GetHeight(), NPC2.GetHeight())
					if Rider
						if Rider.IsOnMount()
							NPC2 = Rider	;rider override
						endif
					endif
				endif
			endif
			if NPC2.IsDead() || ( NPC2 != PlayerRef && NPC2.HasKeyword(ActorTypeNPC) )
				if NPC
					if NPC.GetDistance(PlayerRef) > NPC2.GetDistance(PlayerRef)
						NPC = NPC2	; proximity override
					endif
				else
					NPC = NPC2	; validity override
				endif
			endif
		endif
	endif

	if NPC
		NPC.Activate(PlayerRef)
		Wait(1)
		if NPC.IsDead()
			NPC = None
		endif
	endif

	return NPC
EndFunction

Function Harvest(Int KeyPressed)
	if !KeyPressed
		return
	endif
	if !IsActivateControlsEnabled()
		return
	endif
	Actor HorseRef = GetPlayersLastRiddenHorse()
	if !HorseRef
		return
	endif
	if !HorseRef.IsBeingRidden() || !PlayerRef.IsOnMount()
		return
	endif
	if !PlayerRef.GetAnimationVariableBool("bIsRiding")
		return
	endif
	ObjectReference Harvestable
	int curSector
	int numSectors = 8
	float playerX
	float playerY
	float angleZ
	float Zdiff = PlayerRef.GetPositionZ() - HorseRef.GetPositionZ()	; How high is player above the ground when mounted
	float radius = 180 + Zdiff
	float newZ

	while IsKeyPressed(KeyPressed)	; repeat while holding the harvest key
		Harvestable = FindClosestReferenceOfAnyTypeInListFromRef(CHHarvestableList, PlayerRef, radius)
		if Harvestable
			if !Harvestable.IsDisabled() && !Harvestable.IsHarvested()
				Harvestable.Activate(PlayerRef)
			endif
		endif
		; if stops moving but still holding the key
		if HorseRef.GetAnimationVariableFloat("Speed") == 0
			curSector = 0
			playerX = PlayerRef.GetPositionX()
			playerY = PlayerRef.GetPositionY()
			angleZ = PlayerRef.GetAngleZ()
			newZ = PlayerRef.GetPositionZ() - Zdiff / 2	; because we use half radius we also lower Z by half way to the ground

			while IsKeyPressed(KeyPressed) && HorseRef.GetAnimationVariableFloat("Speed") == 0	; do circular multi-pass search
				if curSector < numSectors
					Harvestable = FindClosestReferenceOfAnyTypeInList(CHHarvestableList, playerX+(radius/2)*sin(angleZ+(360/numSectors)*curSector), playerY+(radius/2)*cos(angleZ+(360/numSectors)*curSector), newZ, radius/2)
					curSector += 1
				else	; after circular pass is complete continue with random search
					Harvestable = FindRandomReferenceOfAnyTypeInListFromRef(CHHarvestableList, PlayerRef, radius)
				endif

				if Harvestable
					if !Harvestable.IsDisabled() && !Harvestable.IsHarvested()
						Harvestable.Activate(PlayerRef)
					endif
				endif
			endwhile
		endif
	endwhile
EndFunction

Function HorseInventory(Int KeyPressed)
	if !KeyPressed
		return
	endif
	if !IsMenuControlsEnabled() || !IsActivateControlsEnabled()
		return
	endif

	bool WantQuickTransfer = IsInventoryModifierPressed()

	; Absolute mode override
	if CHBoundKeyInventoryMode.GetValue() as Int == 3
		if WantQuickTransfer
			ShowInventoryQuickTransferMenu()
		else
			;Alias_Sack.GetReference().Activate(PlayerRef)
			CH.OpenHorseInventory()
		endif
		return
	endif

	; Horse checks
	Actor HorseRef = Alias_Horse.GetActorReference()
	if !HorseRef
		return
	endif
	if HorseRef.IsDisabled() && CHBoundKeyInventoryMode.GetValue() as Int != 2
		CHErrorHorseDisabledMessage.Show()
		Wait(2)
		return
	endif

	; Local, Travel and Remote modes
	if PlayerRef.GetDistance(HorseRef) < 500	; Always open if near
		if WantQuickTransfer
			ShowInventoryQuickTransferMenu()
		else
			;Alias_Sack.GetReference().Activate(PlayerRef)
			CH.OpenHorseInventory()
		endif
		return
	elseif CHBoundKeyInventoryMode.GetValue() as Int > 0	; Travel/Remote modes - check for location restrictions first
		Bool CanOpenInventory
		Location PlayerLocation = PlayerRef.GetCurrentLocation()
		if PlayerLocation
			CanOpenInventory = PlayerLocation.HasKeyword(LocTypePlayerHouse) || PlayerLocation.HasKeyword(LocTypePlayerHouse) || PlayerLocation.HasKeyword(LocTypeStore) || PlayerLocation.HasKeyword(LocTypeCastle) || PlayerLocation.HasKeyword(LocTypeGuild) || PlayerLocation.HasKeyword(LocTypeInn)
		endif
		CanOpenInventory = CanOpenInventory || (PlayerRef.GetDistance(HorseRef) < 500) || CHCityWorldList.HasForm(PlayerRef.GetWorldSpace())
		if !CanOpenInventory
			return
		endif
		
		if CHBoundKeyInventoryMode.GetValue() as Int == 1	; Auto fast travel access
			; Hold key delay - to make sure teleport is not accidental
			float timeStart = GetCurrentRealTime()
			while IsKeyPressed(KeyPressed) && (GetCurrentRealTime() - timeStart) < 1
			endwhile
			if !IsKeyPressed(KeyPressed)
				return
			endif

			; Validity checks
			if !(IsCamSwitchControlsEnabled() && IsMovementControlsEnabled()) || PlayerRef.IsInCombat() || !PlayerRef.GetAnimationVariableBool("bVoiceReady")
				return
			endif

			; Prepare for teleport
			DisablePlayerControls(True, False, True, True, False, False, True, False)	; Disable movement, pov, look and activate controls
			HorseRef.SetRestrained(True)	; Make sure horse doesn't move
			CHFadeIntroImod.Apply()
			Wait(1)
			CHFadeIntroImod.PopTo(CHFadeMainImod)

			; Switch to 1st person because it is important where the horse will apear on the screen, for those who care about these litle things
			bool IsIn3rdPerson = !(PlayerRef.GetAnimationVariableInt("i1stPerson") as bool)
			if IsIn3rdPerson
				ForceFirstPerson()
			endif
					
			Alias_TeleportMarker.GetReference().MoveTo(PlayerRef)	; Mark starting position so we can come back to it later
			; Move the player to the horse so it always appears on the right side of the screen while left side of the screen is reserved for inventory
			; Also take into account size of the horse in case player is using a large mount
			PlayerRef.MoveTo(HorseRef, (((HorseRef.GetWidth() * HorseRef.GetScale()) / 2) + 60) * Sin(HorseRef.GetAngleZ() - 90) + ((HorseRef.GetLength() * HorseRef.GetScale()) / 4) * Sin(HorseRef.GetAngleZ() - 180), (((HorseRef.GetWidth() * HorseRef.GetScale()) / 2) + 60) * Cos(HorseRef.GetAngleZ() - 90) + ((HorseRef.GetLength() * HorseRef.GetScale()) / 4) * Cos(HorseRef.GetAngleZ() - 180))
			PlayerRef.SetAngle(0, 0, HorseRef.GetAngleZ() + 10)
			while !HorseRef.Is3DLoaded()
				wait(0.1)
			endwhile

			CHFadeMainImod.PopTo(CHFadeOutroImod)
			Wait(1)

			; Open inventory
			if WantQuickTransfer
				ShowInventoryQuickTransferMenu()
			else
				;Alias_Sack.GetReference().Activate(PlayerRef)
				CH.OpenHorseInventory()
			endif

			CHFadeIntroImod.Apply()
			Wait(1)	; Thanks to being latent function, this 'wait' will also make sure that we pause here as long as inventory menu is open
			CHFadeIntroImod.PopTo(CHFadeMainImod)

			if IsIn3rdPerson
				ForceThirdPerson()
			endif

			PlayerRef.MoveTo(Alias_TeleportMarker.GetReference())	; Go back to starting position
			Alias_TeleportMarker.GetReference().MoveToMyEditorLocation()	; I hate leaving markers scattered through the world

			CHFadeMainImod.PopTo(CHFadeOutroImod)
			HorseRef.SetRestrained(False)
			EnablePlayerControls()

		elseif CHBoundKeyInventoryMode.GetValue() as Int == 2	; Remote instant acess
			if WantQuickTransfer
				ShowInventoryQuickTransferMenu()
			else
				;Alias_Sack.GetReference().Activate(PlayerRef)
				CH.OpenHorseInventory()
			endif
			return
		endif
	endif
EndFunction

Function HorseSpecial(Int KeyPressed)
	if !KeyPressed
		return
	endif

	; Override with camera fix if player is riding
	if PlayerRef.IsOnMount()
		UpdateThirdPerson()
		return
	endif

	if !IsCamSwitchControlsEnabled() || !IsActivateControlsEnabled()
		return
	endif

	Actor HorseRef = Alias_Horse.GetActorReference()
	if !HorseRef
		return
	endif
	if !HorseRef.Is3DLoaded() || HorseRef.IsBeingRidden()
		return
	endif
	if HorseRef.GetAnimationVariableInt("iState") == 63	; iState 63 is swimming state
		return
	endif
	if !PlayerRef.GetAnimationVariableBool("bVoiceReady")
		return
	endif
	if !PlayerRef.HasLOS(HorseRef)
		return
	endif

	bool Animate = CHAnimationsEnable.GetValue() as Bool
	bool IsIn1stPerson = PlayerRef.GetAnimationVariableBool("i1stPerson")
	if Animate
		PlayerRef.SetGhost(True)	; We don't want player to die while playing eye-candy animation
		DisablePlayerControls(True, True, True, False, True, True, True, True)

		if IsIn1stPerson
			ForceThirdPerson()
		endif

		SetPlayerAIDriven(True)
		PlayerRef.SetLookAt(HorseRef, true)
		Wait(pow(abs(PlayerRef.GetHeadingAngle(HorseRef)), 0.6) * 0.1)	; approximation of time needed to focus on the target
		PlayerRef.ClearLookAt()
		SetPlayerAIDriven(False)

		while PlayerRef.GetAnimationVariableInt("isUnequipping")
			Wait(0.2)
		endwhile
	endif

	if CHHorseFollowEnable.GetValue()
		CHHorseFollowEnable.SetValue(0)
		if Animate
			SendAnimationEvent(PlayerRef, "IdleWave")
			wait(1.25)
		endif
		CHHorseFollowDisabledMessage.Show()
		SendAnimationEvent(HorseRef, "StandingRearUp")
		wait(1.25)
	else
		if Animate
			SendAnimationEvent(PlayerRef, "IdleComeThisWay")
			wait(1.25)
		endif
		CHHorseFollowEnabledMessage.Show()
		SendAnimationEvent(HorseRef, "StandingRearUp")
		wait(1.25)
		CHHorseFollowEnable.SetValue(1)
	endif

	if Animate
		if IsIn1stPerson
			ForceFirstPerson()
		endif

		SendAnimationEvent(PlayerRef, "IdleStop")

		EnablePlayerControls()
		PlayerRef.SetGhost(False)
	endif
EndFunction



; ***** Inventory quick transfer related

Bool Function IsInventoryModifierPressed()
	Int KeyTalk = CHKeyTalk.GetValue() as Int
	Int KeyHarvest = CHKeyHarvest.GetValue() as Int
	Int KeyDismount = CHKeyDismount.GetValue() as Int
	Int KeyInventory = CHKeyInventory.GetValue() as Int
	Int KeySpecial = CHKeySpecial.GetValue() as Int

	; Dynamic modifier - check if alt/ctrl/shift keys are in use by this mod
	if !(KeyTalk == 56 || KeyTalk == 184 || KeyHarvest == 56 || KeyHarvest == 184 || KeyDismount == 56 || KeyDismount == 184 || KeyInventory == 56 || KeyInventory == 184 || KeySpecial == 56 || KeySpecial == 184)	; ALT
		return IsKeyPressed(56) || IsKeyPressed(184)
	elseif !(KeyTalk == 29 || KeyTalk == 157 || KeyHarvest == 29 || KeyHarvest == 157 || KeyDismount == 29 || KeyDismount == 157 || KeyInventory == 29 || KeyInventory == 157 || KeySpecial == 29 || KeySpecial == 157)	; CTRL
		return IsKeyPressed(29) || IsKeyPressed(157)
	elseif !(KeyTalk == 42 || KeyTalk == 54 || KeyHarvest == 42 || KeyHarvest == 54 || KeyDismount == 42 || KeyDismount == 54 || KeyInventory == 42 || KeyInventory == 54 || KeySpecial == 42 || KeySpecial == 54)	; SHIFT
		return IsKeyPressed(42) || IsKeyPressed(54)
	else
		return false
	endif
EndFunction

Function ShowInventoryQuickTransferMenu()
	Int Button
	bool ShowMenu = true
	while ShowMenu
		CH.QuickTransferAlchemy = false
		CH.QuickTransferBlacksmithing = false
		CH.QuickTransferEnchanting = false
		Button = CHInventoryQuickTransferMenu.Show()
		if Button == 0	; Store Items
			if !ShowInventoryQuickTransferTypeMenu(true)	; if sub-menu exit button pressed
				ShowMenu = false
			endif
		elseif Button == 1	; Retrieve Items
			if !ShowInventoryQuickTransferTypeMenu(false)	; if sub-menu exit button pressed
				ShowMenu = false
			endif
		elseif Button == 2	; Open Inventory
			Alias_Sack.GetReference().Activate(PlayerRef)
			Wait(0.1)	; Pause while in menus
		else	; Exit
			ShowMenu = false
		endif
	endwhile
EndFunction

Bool Function ShowInventoryQuickTransferTypeMenu(bool abStore)
	Int Button
	while true
		if abStore
			Button = CHInventoryQuickTransferStoreMenu.Show()
		else
			Button = CHInventoryQuickTransferRetrieveMenu.Show()
		endif
		if Button == 0	; Alchemy: Yes
			CH.QuickTransferAlchemy = false
		elseif Button == 1	; Alchemy: No
			CH.QuickTransferAlchemy = true
		elseif Button == 2	; Blacksmithing: Yes
			CH.QuickTransferBlacksmithing = false
		elseif Button == 3	; Blacksmithing: No
			CH.QuickTransferBlacksmithing = true
		elseif Button == 4	; Enchanting: Yes
			CH.QuickTransferEnchanting = false
		elseif Button == 5	; Enchanting: No
			CH.QuickTransferEnchanting = true
		elseif Button == 6	; Transfer Selected
			if CH.QuickTransferAlchemy || CH.QuickTransferBlacksmithing || CH.QuickTransferEnchanting
				QuickTransfer(abStore)
				return true
			endif
		elseif Button == 7	; Retrun
			return true
		else	; Exit
			return false
		endif
	endwhile
EndFunction

Function QuickTransfer(bool abStore)
	; Disable activation and menus while transfering items so player cannot interfere as it can take more than a few seconds to complete
	Bool MenuEnabled = IsMenuControlsEnabled()
	Bool ActivateEnabled = IsActivateControlsEnabled()
	DisablePlayerControls(False, False, False, False, False, True, True, False)

	ObjectReference SourceRef
	ObjectReference DestRef
	if abStore
		SourceRef = PlayerRef
		DestRef = Alias_Sack.GetReference()
	else
		SourceRef = Alias_Sack.GetReference()
		DestRef = PlayerRef
	endif
	
	bool doTransfer
	float timeStart
	form itemForm
	int itemCount
	int formIndex = SourceRef.GetNumItems()
	while formIndex > 0
		formIndex -= 1
		doTransfer = false
		itemForm = SourceRef.GetNthForm(formIndex)
		if itemForm
			itemCount = SourceRef.GetItemCount(itemForm)
			if itemForm.GetType() == 30	; All ingredients
				doTransfer = CH.QuickTransferAlchemy
			elseif CHBlacksmithingMaterialList.HasForm(itemForm)	; Preset blacksmithing materials
				doTransfer = CH.QuickTransferBlacksmithing
			elseif CHEnchantingMaterialList.HasForm(itemForm)	; Preset enchanting materials
				doTransfer = CH.QuickTransferEnchanting
			endif
		endif
		if doTransfer
			SourceRef.RemoveItem(itemForm, itemCount, true, DestRef)
		endif
		if (GetCurrentRealTime() - timeStart) > 4	; prevents message spam
			CHInventoryQuickTransferNotification.Show()
			timeStart = GetCurrentRealTime()
		endif
		
	endwhile
	EnablePlayerControls(False, False, False, False, False, MenuEnabled, ActivateEnabled, False)
EndFunction
