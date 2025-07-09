Scriptname WB_DaedricCrescent_Script extends ActiveMagicEffect  


; -----

Weapon Property WB_DaedricCrescent1h_Weapon_Enchanted Auto

; -----

Float OriginalStat

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Utility.Wait(0.1)
	akTarget.AddItem(WB_DaedricCrescent1h_Weapon_Enchanted,1,true)
	akTarget.EquipItem(WB_DaedricCrescent1h_Weapon_Enchanted, true, true)

	Float TargetSkill = akTarget.GetActorValue("OneHanded")
	OriginalStat = TargetSkill
	If akTarget.GetActorValue("TwoHanded") > TargetSkill
		TargetSkill = akTarget.GetActorValue("TwoHanded")
	EndIf
	If akTarget.GetActorValue("Destruction") > TargetSkill
		TargetSkill = akTarget.GetActorValue("Destruction")
	EndIf
	If akTarget.GetActorValue("Archery") > TargetSkill
		TargetSkill = akTarget.GetActorValue("Archery")
	EndIf

	akTarget.SetActorValue("OneHanded",TargetSkill)

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.RemoveItem(WB_DaedricCrescent1h_Weapon_Enchanted,akTarget.GetItemCount(WB_DaedricCrescent1h_Weapon_Enchanted),true)
	akTarget.SetActorValue("OneHanded",OriginalStat)

EndEvent

; -----