Scriptname SmartTrainingLvlUpEffect extends ActiveMagicEffect 

Actor Property pPlayerRef Auto

GlobalVariable Property SmartTrainingPerLvl Auto
GlobalVariable Property SmartTrainingLevelCheck Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
    Int CurrentLevel = pPlayerRef.GetLevel()
    Int TimesTrained = Game.QueryStat("Training Sessions")
    Int CurrentCap = ((CurrentLevel * SmartTrainingPerLvl.GetValueInt()) - (TimesTrained))

    If CurrentCap < SmartTrainingPerLvl.GetValueInt()
        CurrentCap = SmartTrainingPerLvl.GetValueInt()
    Endif

    Game.SetGameSettingInt("iTrainingNumAllowedPerLevel", CurrentCap)
;   Debug.Notification("iTrainingNumAllowedPerLevel: Update, equal "+CurrentCap)
    Utility.WaitMenuMode(1)
    SmartTrainingLevelCheck.SetValue(CurrentLevel)
EndEvent