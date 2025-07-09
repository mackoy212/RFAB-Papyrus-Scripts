;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname PRKF_WB_ConjureBattlemage_Pe_010BDF96 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
; show upgrade dialog
Int Option = -1
Int PlayerGold = akActor.GetItemCount(Gold001)
Int GoldDrained = 0
While Option < 2
	If GoldDrained == 0
		Option = WB_ConjurationDwemer_Message_ConjureBattlemage.Show(GoldDrained, PlayerGold)
	Else
		Option = WB_ConjurationDwemer_Message_ConjureBattlemage_CancelAllowed.Show(GoldDrained, PlayerGold)
	EndIf
	If Option == 0
		; upgrades
		Option = -1
		While Option < 4

			Option = WB_ConjurationDwemer_Message_ConjureBattlemage_Upgrades.Show(GoldDrained, PlayerGold, WB_Conjuration_ConjureBattlemage_Global_Upgrade_Health.GetValue(), WB_Conjuration_ConjureBattlemage_Global_Upgrade_Magicka.GetValue(), WB_Conjuration_ConjureBattlemage_Global_Upgrade_DamageBonusPct.GetValue(), WB_Conjuration_ConjureBattlemage_Global_Upgrade_SpellBonusPct.GetValue())
			If Option == 0
				; health
				If PlayerGold - GoldDrained >= 5000
					GoldDrained += 5000
					WB_Conjuration_ConjureBattlemage_Global_Upgrade_Health.Mod(25)
		;		Else
		;			WB_ConjurationDwemer_Message_ConjureBattlemage_Fail.Show()
				EndIf

			ElseIf Option == 1
				; magicka
				If PlayerGold - GoldDrained >= 5000
					GoldDrained += 5000
					WB_Conjuration_ConjureBattlemage_Global_Upgrade_Magicka.Mod(50)
		;		Else
		;			WB_ConjurationDwemer_Message_ConjureBattlemage_Fail.Show()
				EndIf

			ElseIf Option == 2
				; weapon damage
				If PlayerGold - GoldDrained >= 5000
					GoldDrained += 5000
					WB_Conjuration_ConjureBattlemage_Global_Upgrade_DamageBonusPct.Mod(20)
		;		Else
		;			WB_ConjurationDwemer_Message_ConjureBattlemage_Fail.Show()
				EndIf

			ElseIf Option == 3
				; spell damage
				If PlayerGold - GoldDrained >= 5000
					GoldDrained += 5000
					WB_Conjuration_ConjureBattlemage_Global_Upgrade_SpellBonusPct.Mod(5)
		;		Else
		;			WB_ConjurationDwemer_Message_ConjureBattlemage_Fail.Show()
				EndIf

			EndIf
		EndWhile
		Option = -1

	ElseIf Option == 1
		; unlock spells
		If PlayerGold - GoldDrained >= 250000
			GoldDrained += 250000
			WB_Conjuration_ConjureBattlemage_Global_Element_Max.SetValue(8)
	;	Else
	;		WB_ConjurationDwemer_Message_ConjureBattlemage_Fail.Show()
		EndIf

	EndIf

EndWhile

If Option != 4
;	If GoldDrained > 0
		akActor.RemoveItem(Gold001, GoldDrained)
;	EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property WB_ConjurationDwemer_Message_ConjureBattlemage  Auto  

MiscObject Property Gold001  Auto  

GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Element_Max  Auto  

GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_DamageBonusPct  Auto  

GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_Health  Auto  

GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_Magicka  Auto  

GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_SpellBonusPct  Auto  

Message Property WB_ConjurationDwemer_Message_ConjureBattlemage_Fail  Auto  

Message Property WB_ConjurationDwemer_Message_ConjureBattlemage_Upgrades  Auto  

GlobalVariable Property WB_ConjurationDwemer_ConjureBattlemage_Global_Upgrade_Cancel  Auto  

Message Property WB_ConjurationDwemer_Message_ConjureBattlemage_CancelAllowed  Auto  
