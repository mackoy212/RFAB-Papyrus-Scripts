Scriptname RFAB_FalmerSummon extends Actor  

Event OnDying(Actor akKiller)
    RemoveAllItems()
    SetCriticalStage(CritStage_DisintegrateStart)
    Disable()
    Delete()
EndEvent