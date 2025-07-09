;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__000AB81C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.IncrementSkill("Smithing")
GetOwningQuest().SetStage(20)

XP_GainScript.RFAB_XP_QuestComplete( 3000, override_message = "Выполнен квест: " )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


RFAB_XP_GainScript Property XP_GainScript auto
