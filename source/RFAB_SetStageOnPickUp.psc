Scriptname RFAB_SetStageOnPickUp extends ReferenceAlias  

Quest Property MyQuest Auto

int Property Stage Auto

int Property PreReqStage = -1 Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
    if (akNewContainer != Game.GetPlayer())
		if PreReqStage == -1 || MyQuest.GetStageDone(preReqStage)
    		MyQuest.SetStage(Stage)
    	endif
    endif
EndEvent