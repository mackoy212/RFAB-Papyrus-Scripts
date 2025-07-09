Scriptname WISkillIncrease02 extends Quest  

Event OnStoryIncreaseSkill (string asSkill)
	; === Alteration ===
	If Game.GetPlayer().GetBaseAV("Alteration") >= PCSkillMaster.GetValue()
		PCAlterationMaster.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Alteration") >= PCSkillExpert.GetValue()
		PCAlterationExpert.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Alteration") >= PCSkillAdept.GetValue()
		PCAlterationAdept.SetValue(0)
	EndIf

	; === Conjuration ===
	If Game.GetPlayer().GetBaseAV("Conjuration") >= PCSkillMaster.GetValue()
		PCConjurationMaster.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Conjuration") >= PCSkillExpert.GetValue()
		PCConjurationExpert.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Conjuration") >= PCSkillAdept.GetValue()
		PCConjurationAdept.SetValue(0)
	EndIf

	; === Destruction ===
	If Game.GetPlayer().GetBaseAV("Destruction") >= PCSkillMaster.GetValue()
		PCDestructionMaster.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Destruction") >= PCSkillExpert.GetValue()
		PCDestructionExpert.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Destruction") >= PCSkillAdept.GetValue()
		PCDestructionAdept.SetValue(0)
	EndIf

	; === Illusion ===
	If Game.GetPlayer().GetBaseAV("Illusion") >= PCSkillMaster.GetValue() - 10
		PCIllusionMaster.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Illusion") >= PCSkillExpert.GetValue() - 10
		PCIllusionExpert.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Illusion") >= PCSkillAdept.GetValue() - 10
		PCIllusionAdept.SetValue(0)
	EndIf	

	; === Restoration ===
	If Game.GetPlayer().GetBaseAV("Restoration") >= PCSkillMaster.GetValue()
		PCRestorationMaster.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Restoration") >= PCSkillExpert.GetValue()
		PCRestorationExpert.SetValue(0)
	EndIf
	If Game.GetPlayer().GetBaseAV("Restoration") >= PCSkillAdept.GetValue()
		PCRestorationAdept.SetValue(0)
	EndIf

	Stop()
EndEvent

GlobalVariable Property PCSkillAdept  Auto  
GlobalVariable Property PCSkillExpert  Auto  
GlobalVariable Property PCSkillMaster  Auto  

GlobalVariable Property PCAlterationAdept  Auto  
GlobalVariable Property PCAlterationExpert  Auto  
GlobalVariable Property PCAlterationMaster  Auto  

GlobalVariable Property PCConjurationAdept  Auto  
GlobalVariable Property PCConjurationExpert  Auto  
GlobalVariable Property PCConjurationMaster  Auto  

GlobalVariable Property PCDestructionAdept  Auto  
GlobalVariable Property PCDestructionExpert  Auto  
GlobalVariable Property PCDestructionMaster  Auto  

GlobalVariable Property PCIllusionAdept  Auto  
GlobalVariable Property PCIllusionExpert  Auto  
GlobalVariable Property PCIllusionMaster  Auto  

GlobalVariable Property PCRestorationAdept  Auto  
GlobalVariable Property PCRestorationExpert  Auto  
GlobalVariable Property PCRestorationMaster  Auto  


