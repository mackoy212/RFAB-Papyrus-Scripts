Scriptname UBGSettingsEffectScript extends ActiveMagicEffect

; Properties
Quest Property UBGQuest Auto
Spell Property UBGSettingsSpell Auto
Message Property UBGSettingsMsg Auto
Quest Property UBG13DetectQuest Auto

; Events
Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; Unequipping the spell has the nice side effect of preventing the
    ; player from changing the settings too quickly, which can mess up
    ; the quest sequencing.
    Game.GetPlayer().UnequipSpell(UBGSettingsSpell, 1)

    ; Show settings dialog
    int button = UBGSettingsMsg.Show()
    ;Debug.Trace("button=" + (button as string))

    ; Adjust relevant setting
    UBGQuestScript q = (UBGQuest as UBGQuestScript)
    if button == 0 ; Bright Glow
        q.SetBrightness(3)
    elseif button == 1 ; Medium Glow
        q.SetBrightness(2)
    elseif button == 2 ; Dim Glow
        q.SetBrightness(1)
    elseif button == 3 ; All Books Glow
        q.SpellBooksOption = true
        q.SkillBooksOption = true
        q.OtherBooksOption = true
    elseif button == 4 ; Only Skill Books Glow
        q.SpellBooksOption = false
        q.SkillBooksOption = true
        q.OtherBooksOption = false
    endIf

    (UBG13DetectQuest as UBG13DetectQuestScript).RestartQuest()
EndEvent
