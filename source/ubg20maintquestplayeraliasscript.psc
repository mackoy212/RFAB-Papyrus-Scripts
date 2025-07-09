Scriptname UBG20MaintQuestPlayerAliasScript extends ReferenceAlias
{This script is attached to an alias attached to the Player.

It handles maintenance every time a game is loaded.}

; Properties
Quest Property UBGQuest Auto

; Script Variables

; What is the last version of the mod that was run?
int LastVersion = 0

; Functions
Function TraceMe(string msg)
    Debug.Trace("UBG20MaintQuestPlayerAliasScript "+ msg)
EndFunction

Function Maintenance()
    TraceMe("Maintenance")

    ; Constants
    ; Put here instead of as script variable to avoid versioning issues
    int currentVersion = 220 ; == mod version 2.2.0
    int minSKSERelease = 34

    UBGQuestScript q = (UBGQuest as UBGQuestScript)

    ; Detect SKSE
    int skseRelease = SKSE.GetVersionRelease()
    if skseRelease == 0
        TraceMe("SKSE not detected")
        q.HaveSKSE = false
    elseIf skseRelease < minSKSERelease
        TraceMe("SKSE out of date")
        q.HaveSKSE = false
    elseIf (SKSE.GetScriptVersionRelease() != skseRelease)
        TraceMe("SKSE scripts out of date")
        q.HaveSKSE = false
    else
        TraceMe("SKSE installed, release " + skseRelease)
        q.HaveSKSE = true
    endIf

    if q.HaveSKSE
        q.HaveSKSEBookGetSkill = true
        q.HaveSKSEBookGetSpell = true
        ; Book.IsRead() was added but broken in SKSE 1.6.6
        ; Book.IsRead() was fixed in SKSE 1.6.8 (release 36)
        q.HaveSKSEBookIsRead = (skseRelease >= 36)
    else
        q.HaveSKSEBookGetSkill = false
        q.HaveSKSEBookGetSpell = false
        q.HaveSKSEBookIsRead = false
    endIf

    ; Detect ourselves
    Actor selfref = self.GetActorReference()
    if LastVersion != currentVersion
        TraceMe("Current Version " + currentVersion + ", Last Version " + LastVersion)
      
        ; 0 -> 220
        if LastVersion < 220
            ; Announce ourselves
            if q.HaveSKSE
                q.UBGNotification1LocalizedMsg.Show()
            else
                q.UBGNotification1Msg.Show()
            endIf

            ; Start detect quest
            q.UBGStartDetectQuestKeyword.SendStoryEvent()

            ; Add spell to access the settings the old way
            if !selfref.HasSpell(q.UBGSettingsSpell)
                ;q.UBGNotification2Msg.Show()
                selfref.AddSpell(q.UBGSettingsSpell, false)
            endIf

            LastVersion = 220
        endIf
    endIf
EndFunction

; Events

Event OnInit()
    TraceMe("OnInit")

    ; Hack: This used to call Maintenance() directly.  Hopefully this
    ; delay should be long enough for everything else to initialize so
    ; that we can avoid the following:
    ;   "Error: Cannot SendStoryEvent before start up quests have been initialized."
    RegisterForSingleUpdate(1)
EndEvent

Event OnPlayerLoadGame()
    TraceMe("OnPlayerLoadGame")
    GotoState("Busy")
    Maintenance()
    GotoState("")
EndEvent

Event OnUpdate()
    TraceMe("OnUpdate")
    GotoState("Busy")
    Maintenance()
    GotoState("")
EndEvent

State Busy
    Event OnInit()
        ; nop
    EndEvent

    Event OnPlayerLoadGame()
        ; nop
    EndEvent

    Event OnUpdate()
        ; nop
    EndEvent
endState
