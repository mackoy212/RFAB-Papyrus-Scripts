Scriptname UBGQuestScript extends Quest
{Main script for Unread Books Glow mod.

We purposely have only data, and almost no code, in this script.
}

; Properties

; If a book is on this list, it has been read by the player
FormList Property ReadBooksList Auto

; Currently selected list for non-spell, non-skill books
FormList Property EffectShaderList Auto

; Obsolete
FormList Property ShouldGlowList Auto

; Messages show when mod is first initialized
Message Property UBGNotification1Msg Auto
Message Property UBGNotification2Msg Auto
Message Property UBGNotification1LocalizedMsg Auto

; The pre-MCM configuration spell
Spell Property UBGSettingsSpell Auto

; This keyword kicks UBG13DetectQuest every time the player enters a new cell
Keyword Property UBGStartDetectQuestKeyword Auto

; Various options the player can configure
; For brightness, 0 = off, 1 = dim, 2 = normal, 3 = bright
int Property BrightnessOption = 2 Auto
bool Property SpellBooksOption = true Auto ; true = spell books glow
bool Property SkillBooksOption = true Auto ; true = skill books glow
bool Property OtherBooksOption = true Auto ; true = all other books glow
bool Property QuestBooksOption = true Auto ; books giving quests

; Can we use SKSE-provided functions?
bool Property HaveSKSE = false Auto ; true = present and acceptable version
bool Property HaveSKSEBookGetSkill = false Auto ; true = can use function
bool Property HaveSKSEBookGetSpell = false Auto ; true = can use function
bool Property HaveSKSEBookIsRead = false Auto ; true = can use function

; Currently selected list for spell books
FormList Property SpellEffectShaderList Auto

; Currently selected list for skill books
FormList Property SkillEffectShaderList Auto

; List of all vanilla skill books
FormList Property UBGSkillBooksGlowList Auto
; List of all vanilla quest books
FormList Property UBGQuestBooksList Auto

; Various shader choices
FormList Property UBGBrightEffectShaderList Auto
FormList Property UBGBrightSkillEffectShaderList Auto
FormList Property UBGBrightSpellEffectShaderList Auto
FormList Property UBGMediumEffectShaderList Auto
FormList Property UBGMediumSkillEffectShaderList Auto
FormList Property UBGMediumSpellEffectShaderList Auto
FormList Property UBGDimEffectShaderList Auto
FormList Property UBGDimSkillEffectShaderList Auto
FormList Property UBGDimSpellEffectShaderList Auto

; Functions
Function Setup()
    {Obsolete}
EndFunction

string Function GetBrightnessString()
    int opt = BrightnessOption
    if opt == 0
        return "$UBG Off"
    elseIf opt == 1
        return "$UBG Dim"
    elseIf opt == 2
        return "$UBG Normal"
    elseIf opt == 3
        return "$UBG Bright"
    endIf
    return "$UBG Normal"
endFunction

Function SetBrightness(int opt)
    BrightnessOption = opt
    if opt == 0
        EffectShaderList = None
        SpellEffectShaderList = None
        SkillEffectShaderList = None
    elseIf opt == 1
        EffectShaderList = UBGDimEffectShaderList
        SpellEffectShaderList = UBGDimSpellEffectShaderList
        SkillEffectShaderList = UBGDimSkillEffectShaderList
    elseIf opt == 2
        EffectShaderList = UBGMediumEffectShaderList
        SpellEffectShaderList = UBGMediumSpellEffectShaderList
        SkillEffectShaderList = UBGMediumSkillEffectShaderList
    elseif opt == 3
        EffectShaderList = UBGBrightEffectShaderList
        SpellEffectShaderList = UBGBrightSpellEffectShaderList
        SkillEffectShaderList = UBGBrightSkillEffectShaderList
    endIf
endFunction

