Scriptname RFAB_ClassSystemMaster extends ReferenceAlias  

import PapyrusINIManipulator

Actor Property Player Auto
;String Property ImmersiveNotification Auto
Message Property PlayerGetClassMessage Auto
Message Property PlayerGetNewClassMessage Auto
Spell Property GetClassAbility Auto
FormList Property PlayerClassesList Auto

Event OnInit()
    RegisterForModEvent("ClassSystemEvent", "OnPlayerReadyClass")
EndEvent

Event OnPlayerLoadGame()
    RegisterForModEvent("ClassSystemEvent", "OnPlayerReadyClass")
EndEvent

Event OnPlayerReadyClass(Form akClass)
    if PlayerClassesList.GetSize() == 0 ; Проверка на первый раз
        Player.AddSpell(GetClassAbility, false)
        PlayerGetClassMessage.Show()
    else
        PlayerGetNewClassMessage.Show()
    endif
    PlayerClassesList.AddForm(akClass)
EndEvent