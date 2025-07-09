Scriptname SmartTrainingUdpadeOnLoadGame extends ReferenceAlias

GlobalVariable Property SmartTrainingPerLvl Auto
GlobalVariable Property SmartTrainingLevelCheck Auto

Event OnPlayerLoadGame()

    Int CurrentLevel = game.GetPlayer().GetLevel()
    Int TimesTrained = Game.QueryStat("Training Sessions")
    Int CurrentCap = ((CurrentLevel * SmartTrainingPerLvl.GetValueInt()) - (TimesTrained))

    If CurrentCap < SmartTrainingPerLvl.GetValueInt()
        CurrentCap = SmartTrainingPerLvl.GetValueInt()
    Endif

    Game.SetGameSettingInt("iTrainingNumAllowedPerLevel", CurrentCap)
    Utility.wait(0.5)
    SmartTrainingLevelCheck.SetValue(CurrentLevel)
EndEvent