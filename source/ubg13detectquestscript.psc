Scriptname UBG13DetectQuestScript extends Quest
{This quest has 100ish aliases, which get filled in by
references to book objects by the Story Manager.
The script attached to these references does the glowing.

The attachment of book object reference to alias also
changes the book's display name as long as the alias
is active.
}

; Properties
Keyword Property UBGStartDetectQuestKeyword Auto

; Found by using TESSNIP, since the editor doesn't show Alias ids.	Be
; careful adding/removing aliases in the editor, to ensure that the
; ids are all sequential.
int FirstAliasIdx = 778
int LastAliasIdx = 877

; Functions
Function RestartQuest()
	{Stop all books glowing, then restart this quest.

	This is hacky.	I wish there was a way for the aliases to cleanup
	themselves.}

	GotoState("Busy") ; Avoid threading issues

	int idx = FirstAliasIdx
	while idx <= LastAliasIdx
		ReferenceAlias a = GetAlias(idx) as ReferenceAlias
		if a != None
			ObjectReference ref = a.GetReference()
			if ref != None
				UBG13DetectQuestBookRefAliasScript al = (a as UBG13DetectQuestBookRefAliasScript)
				if al != None && al.SelectedEffectShader != None
					;Debug.Trace("Stopping Glow on idx " + (idx as string))
					al.SelectedEffectShader.Stop(ref)
					al.Clear()
				endIf
			endIf
		endIf
		idx += 1
	endWhile

	; Actually stop quest now
	Stop()

	; Tell Story Manager to restart it
	UBGStartDetectQuestKeyword.SendStoryEvent()

	GotoState("")
EndFunction

State Busy
	Function RestartQuest()
		; Nop
	EndFunction
endState
