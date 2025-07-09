Scriptname _M_AliasBossScript extends ReferenceAlias  

int Property Stage Auto

Event OnDeath(Actor akKiller)
	if(Stage > 100 || GetOwningQuest().GetStage() > 0)
		GetOwningQuest().SetStage(Stage)
	endIf
EndEvent