Scriptname RFAB_Origin_Main extends Quest  

RFAB_DifficultyMenu Property DifficultyMenu Auto

RFAB_DoomStoneMenu Property DoomStoneMenu Auto

RFAB_OriginsMenu Property OriginsMenu Auto

REQ_AutoUpdater property ReqInitScripts Auto
REQ_QuestRestarter property ReqQuestRestarter Auto

ImageSpaceModifier property Fadeout auto

Cell OriginCell

Event OnInit()
	RegisterForMenu("RaceSex Menu")
EndEvent

Event OnMenuClose(String MenuName)
	if (!OriginCell)
		OriginCell = Game.GetPlayer().GetParentCell()
	elseif (Game.GetPlayer().GetParentCell() != OriginCell)
		return
	endif

	Game.DisablePlayerControls()
	Utility.Wait(1.0)
	
	; Удаляем шмотки пленника
	Game.GetPlayer().RemoveItem(Game.GetForm(0x0003C9FE), 1, true)
	Game.GetPlayer().RemoveItem(Game.GetForm(0x0003CA00), 1, true)

	Fadeout.ApplyCrossFade(1.0)

  	DifficultyMenu.Open()
	DoomStoneMenu.Open()
	ImageSpaceModifier.RemoveCrossFade(1.00000)
	OriginsMenu.Open()
	
	(ReqQuestRestarter as Quest).Start()
 	ReqQuestRestarter.SetupCheck()
	ReqInitScripts.InitScripts()

	Game.EnablePlayerControls()
EndEvent