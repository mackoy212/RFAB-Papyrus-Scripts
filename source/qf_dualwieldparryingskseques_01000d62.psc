;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_DualWieldParryingSKSEQues_01000D62 Extends Quest Hidden

;BEGIN ALIAS PROPERTY DualWieldParrySKSEPlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DualWieldParrySKSEPlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE DualWieldParryingSKSEQuestScript
Quest __temp = self as Quest
DualWieldParryingSKSEQuestScript kmyQuest = __temp as DualWieldParryingSKSEQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.InitializeMod()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
