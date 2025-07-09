Scriptname UBG20ConfigMenuQuestScript extends SKI_ConfigBase 
{ The script is the MCM configuration menu for Unread Books Glow }

; Properties

Quest Property UBGQuest Auto
Quest Property UBG13DetectQuest Auto

; Script variables

; OIDs
int brightnessOID = 0
int spellBooksOID = 0
int skillBooksOID = 0
int questBooksOID = 0
int otherBooksOID = 0

; Functions

int function GetVersion()
    return 220 ; == mod version 2.1.0
endFunction

; Events

event OnConfigInit()
    {Initialization code}
endEvent

event OnConfigOpen()
    {Called when the config menu is opened.}
    ; Remove old settings spell, use MCM instead
    Actor player = Game.GetPlayer()
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    if player.HasSpell(q.UBGSettingsSpell)
        player.RemoveSpell(q.UBGSettingsSpell)
    endIf
endEvent

event OnConfigClose()
    { Called when the config menu is closed }
    (UBG13DetectQuest as UBG13DetectQuestScript).RestartQuest()
endEvent

event OnPageReset(string page)
    {Called when a new page is selected, including the initial empty page}
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)
    brightnessOID = AddTextOption("$UBG Book Glow", q.GetBrightnessString())
    AddEmptyOption()
    spellBooksOID = AddToggleOption("$UBG Spell Books", q.SpellBooksOption)
    skillBooksOID = AddToggleOption("$UBG Skill Books", q.SkillBooksOption)
    questBooksOID = AddToggleOption("$UBG Quest Books", q.QuestBooksOption)
    otherBooksOID = AddToggleOption("$UBG Plain Books", q.OtherBooksOption)
    AddEmptyOption()
endEvent

event OnOptionDefault(int option)
    {Reset an option to its default value}
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    if option == brightnessOID
        q.SetBrightness(2)
        SetTextOptionValue(brightnessOID, q.GetBrightnessString())
    elseIf (option == spellBooksOID)
        q.SpellBooksOption = true
        SetToggleOptionValue(spellBooksOID, q.SpellBooksOption)
    elseIf (option == skillBooksOID)
        q.SkillBooksOption = true
        SetToggleOptionValue(skillBooksOID, q.SkillBooksOption)
    elseIf (option == questBooksOID)
        q.QuestBooksOption = true
        SetToggleOptionValue(questBooksOID, q.QuestBooksOption)
    elseIf (option == otherBooksOID)
        q.OtherBooksOption = true
        SetToggleOptionValue(otherBooksOID, q.OtherBooksOption)
    endIf
endEvent

event OnOptionSelect(int option)
    {Called when a non-interactive option has been selected}
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    if option == brightnessOID
        ; Cycle through brightness levels 0 to 3
        q.SetBrightness((q.BrightnessOption + 1) % 4)
        SetTextOptionValue(brightnessOID, q.GetBrightnessString())
    elseIf (option == spellBooksOID)
        q.SpellBooksOption = !q.SpellBooksOption
        SetToggleOptionValue(spellBooksOID, q.SpellBooksOption)
    elseIf (option == skillBooksOID)
        q.SkillBooksOption = !q.SkillBooksOption
        SetToggleOptionValue(skillBooksOID, q.SkillBooksOption)
    elseIf (option == questBooksOID)
        q.QuestBooksOption = !q.QuestBooksOption
        SetToggleOptionValue(questBooksOID, q.QuestBooksOption)
    elseIf (option == otherBooksOID)
        q.OtherBooksOption = !q.OtherBooksOption
        SetToggleOptionValue(otherBooksOID, q.OtherBooksOption)
    endIf
endEvent
