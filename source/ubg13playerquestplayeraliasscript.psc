Scriptname UBG13PlayerQuestPlayerAliasScript extends ReferenceAlias
{This script is attached to an alias attached to the Player.

It kicks the UBG13DetectQuest whenever the player goes to a new cell.}

; Properties
Quest Property UBG13DetectQuest Auto

; Functions
Function Trace(string msg)
	Debug.Trace("UBG13PlayerQuestPlayerAliasScript "+ msg)
EndFunction

; Events

Event OnCellLoad()
	GotoState("BusyState")
	;Trace("OnCellLoad")
	(UBG13DetectQuest as UBG13DetectQuestScript).RestartQuest()
	GotoState("")
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	GotoState("BusyState")
	;Trace("OnLocationChange(" + \
	;		(akOldLoc as string) + ", " + \
	;		(akNewLoc as string) + ")")
	(UBG13DetectQuest as UBG13DetectQuestScript).RestartQuest()
	GotoState("")
EndEvent

State BusyState
	Event OnCellLoad()
		;Trace("BusyState OnCellLoad")
		; Nop
	EndEvent

	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
		;Trace("BusyState OnLocationChange(" + \
		;		(akOldLoc as string) + ", " + \
		;		(akNewLoc as string) + ")")
		; Nop
	EndEvent
endState
