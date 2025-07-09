scriptName RFAB_WidgetUpdater extends ReferenceAlias

wm_goldcountquestscript property GoldScript auto
wm_weightcountquestscript property WeightScript auto
wm_arrowcountquestscript property ArrowScript auto
wm_attributecountquestscript property AttributeScript auto
wm_skillcountquestscript property SkillScript auto
miscobject property gold auto

actor Player
Float MaxWeight
FormList Property BlankFormList Auto

function OnInit()
	utility.wait(5 as Float)
	WeightScript.UpdateStatus()
	GoldScript.UpdateStatus()
	SkillScript.UpdateStatus()
	Player = game.GetPlayer()
	MaxWeight = Player.Getactorvalue("CarryWeight")
	self.registerforsingleupdate(1 as Float)
endFunction

Event OnPlayerLoadGame()
    Utility.Wait(1.0)
    self.RegisterForMenu("Console")
    self.RegisterForMenu("CustomMenu")
    WeightScript.UpdateStatus()
    GoldScript.UpdateStatus()
    SkillScript.UpdateStatus()
EndEvent

function OnMenuClose(String MenuName)
    SkillScript.UpdateStatus()
endFunction

function OnLevelIncrease(Int aiLevel)
	SkillScript.UpdateStatus()
endFunction

Event OnUpdate()
	if MaxWeight != Player.Getactorvalue("CarryWeight")
		MaxWeight = Player.Getactorvalue("CarryWeight")
		WeightScript.UpdateStatus()
	endIf
	self.registerforsingleupdate(1 as Float)
EndEvent
