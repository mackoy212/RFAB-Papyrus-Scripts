Scriptname _M_AliasMissiveDeliverScript extends ReferenceAlias  

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
			if(GetOwningQuest().GetStage() == 20)
				GetOwningQuest().SetStage(105)
			else
				GetOwningQuest().SetStage(103)
			endIf
		endIf
	endIf
endEvent