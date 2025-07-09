Scriptname RFAB_Mounts extends Quest Conditional

import PO3_SKSEFunctions

Keyword[] Property CitiesLocations Auto
{Кейворды локаций, где игрок может открыть инвентарь маунта}
WorldSpace[] Property AllowedWorlds Auto
{Миры, где игрок может призвать маунта}

Sound[] Property Whistles Auto
float Property Loudness = 1.0 Auto Hidden

ObjectReference Property SaveMarker Auto

RFAB_Mounts_Alias Property MountsAlias Auto

Actor Property Mount Auto Hidden

string _MountName = "Моя лошадь"
string Property MountName Hidden
	string Function Get()
		return _MountName
	EndFunction
	Function Set(string asName)
		_MountName = asName
		UpdateWeightInName()
	EndFunction
EndProperty

bool Property IsShowWeightInMenu Auto Hidden

bool _IsShowWeightInName = false
bool Property IsShowWeightInName Hidden
	bool Function Get()
		return _IsShowWeightInName
	EndFunction
	Function Set(bool abValue)
		_IsShowWeightInName = abValue
		UpdateWeightInName()
	EndFunction
EndProperty

int Property MountCarryWeight = 250 Auto Hidden Conditional
int Property MountSpeed = 150 Auto Hidden Conditional

int _HotKey = 21 ; Y
int Property HotKey Hidden 
	int Function Get()
		return _HotKey
	EndFunction
	Function Set(int aiValue)
		if aiValue != _HotKey
			UnregisterForKey(_HotKey)
			_HotKey = aiValue
			RegisterForKey(_HotKey)
			JsonUtil.SetIntValue("RFAB_Mounts_Settings.json", "HotKey", _HotKey)
			JsonUtil.Save("RFAB_Mounts_Settings.json")
		endif
	EndFunction
EndProperty

Actor Player

Event OnInit()
    Player = Game.GetPlayer()
	RegisterForKey(_HotKey)
EndEvent

Event OnKeyDown(int aiKeyCode)
	Mount = Game.GetPlayersLastRiddenHorse()

	if !Mount || IsInMenu()
		return
	endif

	int MountState = GetMountState()
	if MountState == -1
		return
	endif

	int time = 0
	while Input.IsKeyPressed(aiKeyCode) && time < 20
		time += 1
		utility.wait(0.01)
	endWhile

	if time > 3 && (MountState == 1 || MountState == 2)
		Mount.MoveTo(SaveMarker)
		PlayWhistle(0)
	elseif time < 3
		if MountState == 1
			Mount.MoveTo(Player, -250, -250)
			Mount.Enable()
			PlayWhistle(Utility.RandomInt(0, 9))
		elseif MountState == 2
			if (IsShowWeightInMenu || IsShowWeightInName)
				MountsAlias.RegisterForMenu("ContainerMenu")
			endif
			Mount.OpenInventory(true)
		endIf
	endIf
EndEvent

; 1 - Телепортировать лошадь к игроку
; 2 - Открыть инвентарь

Function PlayWhistle(int ID)
	int whistleID = Whistles[ID].Play(Player)
	Sound.SetInstanceVolume(whistleID, Loudness)
EndFunction

int Function GetMountState()
	if (Mount.IsDead())
		return -1
	endif
	UpdateMountStats()
	float Distance = Player.GetDistance(Mount)

	if (!IsPlayerOnMount() && Distance > 500 && !Player.IsInInterior() && IsCanSummonMount())
		return 1
	elseif (Distance < 500 || PlayerIsInCity() || Player.GetCurrentLocation().IsCleared())
		return 2
	endif
	return -1
EndFunction

bool Function IsPlayerOnMount()
	return PO3_SKSEFunctions.GetMount(Player) == Mount
EndFunction

bool Function PlayerIsInCity()
	Location CurrentLocation = Player.GetCurrentLocation()
	int i = 0
	while i < CitiesLocations.Length
		if (CurrentLocation.HasKeyword(CitiesLocations[i]))
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsCanSummonMount()
	WorldSpace CurrentWorld = Player.GetWorldSpace()
	int i = 0
	while i < AllowedWorlds.Length
		if (CurrentWorld == AllowedWorlds[i])
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsInMenu()
	return ui.ismenuopen("BarterMenu") || ui.ismenuopen("Book Menu") || ui.ismenuopen("Console") || ui.ismenuopen("Console Native UI Menu") || ui.ismenuopen("ContainerMenu") || ui.ismenuopen("Crafting Menu") || ui.ismenuopen("Dialogue Menu") || ui.ismenuopen("FavoritesMenu") || ui.ismenuopen("GiftMenu") || ui.ismenuopen("InventoryMenu") || ui.ismenuopen("Journal Menu") || ui.ismenuopen("LevelUp Menu") || ui.ismenuopen("MagicMenu") || ui.ismenuopen("MapMenu") || ui.ismenuopen("MessageBoxMenu") || ui.ismenuopen("RaceSex Menu") || ui.ismenuopen("Sleep/Wait Menu") || ui.ismenuopen("StatsMenu") || ui.ismenuopen("Training Menu")
EndFunction

Function AddWeight(int aiValue = 250)
	MountCarryWeight += aiValue
	UpdateMountStats()
	UpdateWeightInName()
EndFunction

Function AddSpeed(int aiValue = 25)
	MountSpeed += aiValue
	UpdateMountStats()
EndFunction

Function UpdateMountStats()
	Mount = Game.GetPlayersLastRiddenHorse()
	Mount.SetActorValue("CarryWeight", MountCarryWeight)
	Mount.SetActorValue("SpeedMult", MountSpeed)
EndFunction

Function UpdateWeightInMenu()
	if (IsShowWeightInMenu)
    	UI.SetString("ContainerMenu", "_root.Menu_mc.inventoryLists.tabBar.leftLabel.htmlText", GetNameWithWeight())
    else
		UI.SetString("ContainerMenu", "_root.Menu_mc.inventoryLists.tabBar.leftLabel.htmlText", MountName)
    endif
EndFunction

Function UpdateWeightInName()
	if (IsShowWeightInName)
	    Mount.SetDisplayName(GetNameWithWeight(), true)
	else
		Mount.SetDisplayName(MountName, true)
   	endif
	PO3_SKSEFunctions.UpdateCrosshairs()
EndFunction

string Function GetNameWithWeight()
    int TotalItemWeight = Mount.GetTotalItemWeight() as int
    int CarryWeight = Mount.GetActorValue("CarryWeight") as int
    return MountName + " (" + TotalItemWeight + "/" + CarryWeight + ")"
EndFunction
