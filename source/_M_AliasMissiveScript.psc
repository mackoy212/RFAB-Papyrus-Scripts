Scriptname _M_AliasMissiveScript extends ReferenceAlias  

Message Property _M_MessageDiscard Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	if(akNewContainer == Game.GetPlayer() && GetOwningQuest().GetStage() < 20)
		GetOwningQuest().SetStage(20)
	endIf
endEvent

Event OnEquipped(Actor akActor)
	if(akActor == Game.GetPlayer() && GetOwningQuest().GetStage() > 0)
		Utility.WaitMenuMode(2)
		if(_M_MessageDiscard.Show() == 0)
			Utility.Wait(0.01)
			GetOwningQuest().SetStage(105)
		endIf
	endIf
endEvent