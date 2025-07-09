Scriptname WB_MilestonesSpawner_Script extends ObjectReference  

; -----

ReferenceAlias[] Property WB_Milestone Auto
ReferenceAlias[] Property WB_MilestoneGlow Auto
GlobalVariable[] Property WB_InUse Auto
Message Property WB_AlterationAlt_Message_Milestones_Spawner Auto
Message Property WB_AlterationAlt_Message_Milestones_Fail Auto
Float Property WB_Z Auto
Float Property WB_Scale Auto

; -----

Event OnLoad()

	If (WB_InUse[0].GetValue() == 1 && WB_InUse[1].GetValue() == 1 && WB_InUse[2].GetValue() == 1 && WB_InUse[3].GetValue() == 1 && WB_InUse[4].GetValue() == 1)
		WB_AlterationAlt_Message_Milestones_Fail.Show()
		Delete()
	Else
		Int WhichStone = WB_AlterationAlt_Message_Milestones_Spawner.Show()
		WB_InUse[WhichStone].SetValue(1)
		Float ZAngle = Game.GetPlayer().GetAngleZ() + 180
		ObjectReference TheStone = WB_Milestone[WhichStone].GetReference()
		ObjectReference TheGlow = WB_MilestoneGlow[WhichStone].GetReference()
		TheStone.MoveTo(Self)
		TheStone.SetAngle(0,0,ZAngle)
		TheGlow.MoveTo(Self, 0, 0, WB_Z)
		TheGlow.SetScale(WB_Scale)
		TheGlow.Enable()
		Delete()
	EndIf

EndEvent

; -----