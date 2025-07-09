Scriptname UBG15DLCQuestPlayerAliasScript extends ReferenceAlias  
{ Obsolete }

; Properties
FormList Property UBGAllBooksGlowList Auto  

; Functions
Function TraceMe(string msg)
    {Obsolete}
EndFunction

Function UpdateBooks()
    {Obsolete}
endFunction

Function AddBooksDawnguard()
    {Obsolete}
EndFunction

Function AddBookDawnguard(int formId)
    {Obsolete}
EndFunction

; Events
Event OnInit()
    {Obsolete}
EndEvent

Event OnReset()
    {Obsolete}
EndEvent

Event OnPlayerLoadGame()
    {Obsolete}
EndEvent

State Busy
    Event OnInit()
        ; nop
    EndEvent

    Event OnReset()
        ; nop
    EndEvent

    Event OnPlayerLoadGame()
        ; nop
    EndEvent
EndState

