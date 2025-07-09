;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF__0E00593E Extends Quest Hidden

;BEGIN ALIAS PROPERTY Shahvee
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Shahvee Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Amulet
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Amulet Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Container
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Container Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveCompleted(15)

Alias_Shahvee.GetRef().AddItem(Alias_Amulet.GetRef(), abSilent = true)
XP.OnQuestComplete(self)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveCompleted(10)
setObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

RFAB_XP_Handler Property XP Auto
