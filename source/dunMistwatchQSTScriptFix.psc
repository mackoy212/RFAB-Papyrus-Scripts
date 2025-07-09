Scriptname dunMistwatchQSTScriptFix extends QF_dunMistwatchQST_00030B36  

function FixQuestStage_85()
    Actor Christer = alias_Christer.GetActorReference()

    Christer.setav("Confidence",3)
    Christer.StartCombat(game.GetPlayer())

    setObjectiveCompleted(75,1)
endFunction

function FixQuestStage_90()
    setObjectiveCompleted(75,1)

    Actor Fjola = Alias_Fjola.GetActorReference()

    if (Fjola.IsDead())
        setObjectiveCompleted(75,1)
        self.SetStage(100)
    else
        setObjectiveDisplayed(85,1)
    endif
endFunction