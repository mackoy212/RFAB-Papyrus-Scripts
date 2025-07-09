Scriptname UBG13DetectQuestBookRefAliasScript extends ReferenceAlias
{This script handles an alias to a single Book as part of the UBG13DetectQuest

Note: Book.GetSkill() returns 0 for skill books that have already been read.

}

; Properties
Quest Property UBGQuest Auto
EffectShader Property SelectedEffectShader Auto
FormList Property ReadBooksList Auto
FormList Property EffectShaderList Auto
FormList Property ShouldGlowList Auto ; Obsolete

; Script variables
int shaderIdx = -1
int updateTime = 3 ; Seconds
int firstUpdateTime = 1 ; Seconds
int playTime = 4 ; Seconds, >= updateTime
bool isSpellBook = false
bool isSkillBook = false
bool isQuestBook = false

; Functions
Function TraceMe(string msg)
    ObjectReference selfref = self.GetReference()
    if selfref == None
        return
    endIf
    Debug.Trace("UBG13DetectQuestBookRefAliasScript " + msg + " " + \
                (selfref as string) + " " + \
                (selfref.GetFormID() as string) + " " + \
                (selfref.GetBaseObject() as string) + " " + \
                (selfref.GetCurrentLocation() as string) + " " + \
                (selfref.getParentCell() as string) + " " + \
                (selfref.GetWorldSpace() as string))
EndFunction

Function StartGlow(ObjectReference selfref)
    {Start Glowing}
    ;TraceMe("StartGlow")

    if (EffectShaderList == None) || (EffectShaderList.GetSize() < 1)
        ; In case main quest not initialized yet
        return
    endIf
    if !selfref.Is3DLoaded()
        ; Not exactly sure when/why this happens, but it does
        return
    endIf

    ; Pick random shader effect
    shaderIdx = Utility.RandomInt(0, EffectShaderList.GetSize() - 1)
    ;TraceMe("Picked shader " + shaderIdx)
    SelectedEffectShader = (EffectShaderList.GetAt(shaderIdx) as EffectShader)
    if SelectedEffectShader != None
        SelectedEffectShader.Play(selfref)
    endIf
EndFunction

Function StopGlow(ObjectReference selfref)
    ;TraceMe("StopGlow")
    if SelectedEffectShader != None
        SelectedEffectShader.Stop(selfref)
        SelectedEffectShader = None
    endIf
EndFunction

bool Function ShouldGlow(ObjectReference selfref)
    Book selfbo = (selfref.GetBaseObject() as Book)
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    ;TraceMe("q " + (q as string))

    if HaveRead(selfbo)
        ;TraceMe("ShouldGlow - HaveRead == true")
        return false
    else
        ;TraceMe("ShouldGlow - HaveRead == false")
        if isSpellBook
            return q.SpellBooksOption
        elseIf isSkillBook
            return q.SkillBooksOption
        elseIf isQuestBook
            return q.QuestBooksOption
        else
            return q.OtherBooksOption
        endIf
    endIf
endFunction

bool Function HaveRead(Book selfbo)
    UBGQuestScript q = (UBGQuest as UBGQuestScript)

    ; This formlist has none of the unread books but potentially only
    ; some of the read books.
    bool read = ReadBooksList.HasForm(selfbo)
    
    ; Augment with SKSE in various ways
    if q.HaveSKSEBookIsRead
        read = read || selfbo.IsRead()
    endIf
    if isSpellBook && q.HaveSKSEBookGetSpell
        Spell theSpell = selfbo.GetSpell()
        read = read || (Game.GetPlayer().HasSpell(theSpell))
    endIf

    ; Update form list if necessary
    if read
        MarkRead(selfbo)
    endIf

    return read
endFunction

Function MarkRead(Book selfbo)
    if !ReadBooksList.HasForm(selfbo)
        ReadBooksList.AddForm(selfbo)
    endIf
endFunction

; Events

Event OnInit()
    {Have as little code as possible in OnInit to avoid blocking}
    ;TraceMe("OnInit")
    RegisterForSingleUpdate(firstUpdateTime)
EndEvent

Event OnUpdate()
    ObjectReference selfref = self.GetReference()
    if selfref == None ; Should never happen
        GotoState("Done")
        ; Clear alias so that book name reverts to normal
        self.Clear()
        return
    endIf

    ; Get current settings from quest
    UBGQuestScript q = (UBGQuest as UBGQuestScript)

    Book selfbo = (selfref.GetBaseObject() as Book)

    ; What kind of book are we?
    isSpellBook = false
    if q.HaveSKSEBookGetSpell
        isSpellBook = (selfbo.GetSpell() != None)
    endIf

    isSkillBook = (q.UBGSkillBooksGlowList.HasForm(selfbo))
    if q.HaveSKSEBookGetSkill
        isSkillBook = isSkillBook || (selfbo.GetSkill() != 0)
    endIf

    isQuestBook = (q.UBGQuestBooksList.HasForm(selfbo))

    ; Which color should it glow?
    if isSpellBook
        EffectShaderList = q.SpellEffectShaderList
    elseIf isSkillBook
        EffectShaderList = q.SkillEffectShaderList
    else
        ; Quest books don't get special colors
        EffectShaderList = q.EffectShaderList
    endIf

    ; Glow or stop
    if ShouldGlow(selfref)
        StartGlow(selfref)
        GotoState("Glowing")

        ; Check everything again in a bit
        RegisterForSingleUpdate(updateTime)
    else
        GotoState("Done")
        ; Clear alias so that book name reverts to normal
        self.Clear()
    endIf
EndEvent

State Glowing
    Event OnRead()
        {Mark book as read, stop glowing, stop updating}
        ;TraceMe("OnRead")

        ObjectReference selfref = GetReference()
        Book selfbo = (selfref.GetBaseObject() as Book)

        MarkRead(selfbo)

        StopGlow(selfref)
        UnregisterForUpdate()
        GotoState("Done")

        ; Clear alias so that book name reverts to normal
        self.Clear()
    EndEvent

    Event OnUpdate()
        {Check if some other copy of this book has been read, refresh glow otherwise}
        ;TraceMe("OnUpdate")

        ObjectReference selfref = GetReference()
        if selfref == None
            ; Alias has been cleared, so just shut down
            UnregisterForUpdate()
            GotoState("Done")
            self.Clear()
            return
        endIf

        Book selfbo = (selfref.GetBaseObject() as Book)
        if !HaveRead(selfbo)
            ; Still unread, check again later
            RegisterForSingleUpdate(updateTime)
        else
            ; Player read another copy of this book
            StopGlow(selfref)
            UnregisterForUpdate()
            GotoState("Done")

            ; Clear alias so that book name reverts to normal
            self.Clear()
        endIf
    EndEvent
EndState

; Prevent spurious updates from doing anything
State Done
    Event OnUpdate()
        ; Nop
    EndEvent
EndState
