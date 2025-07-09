;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname PRKF_DCAU_Perk_03000805 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DCAU_Control.SolveDoor(akActor, akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DCAU_ControlScript Property DCAU_Control  Auto
