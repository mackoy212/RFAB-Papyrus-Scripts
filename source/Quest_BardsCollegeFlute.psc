;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Quest_BardsCollegeFlute Extends Quest Hidden

;BEGIN ALIAS PROPERTY BossContainer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BossContainer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PanteasFlute
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PanteasFlute Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pantea
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pantea Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dungeon
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Dungeon Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
;Inge has given the quest to the player

SetObjectiveDisplayed(20, 1)
If GetStageDone(15) == 1
    SetStage(40)
Else
    MapMarker.AddToMap()
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
;Lute has been recovered

SetObjectiveCompleted(20, 1)
SetObjectiveDisplayed(40, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(40, 1)
Alias_Pantea.GetActorRef().SetRelationshipRank(Game.GetPlayer(), 1)
Game.GetPlayer().RemoveItem(Alias_PanteasFlute.GetRef(), 1, abSilent = true)

XP.OnQuestComplete(self)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
; Player picked up the flute without getting the quest.
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

string Property Alteration  Auto  

string Property Conjuration  Auto  

string Property Destruction  Auto  

string Property Illusion  Auto  

string Property Restoration  Auto  

string Property Enchanting  Auto  

ObjectReference Property MapMarker  Auto  

RFAB_XP_Handler Property XP auto
