Scriptname favor109disablerS extends ObjectReference  


Quest Property questToCheck Auto
Int Property stageRequired Auto

Function OnQuestStage()
    if (questToCheck.GetStage() >= stageRequired)
        Disable()
    endIf
EndFunction