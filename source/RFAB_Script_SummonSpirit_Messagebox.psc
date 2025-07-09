Scriptname RFAB_Script_SummonSpirit_Messagebox extends ActiveMagicEffect

Message Property SummonMenu  Auto  
SPELL[] Property SummonSpell  Auto
SPELL[] Property AuraSpell  Auto   
String[] Property PetList Auto
SPELL Property CooldownSpell  Auto  
MagicEffect Property Cooldown Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !akTarget.HasMagicEffect(Cooldown)
		int Button = BosmerMenu()
		;debug.messagebox(Button)
			if Button == 0 ||  Button == 1 ||  Button == 2	
				int i = 0
				SendEvent()
					while i < AuraSpell.length
						akTarget.DispelSpell(AuraSpell[i])
						i += 1
					endwhile
				Utility.Wait(0.1)
				CooldownSpell.Cast(akCaster)
				SummonSpell[Button].Cast(akCaster)
				Utility.Wait(3.0)
				akTarget.AddSpell(AuraSpell[Button])
			endif
	else 
		debug.notification("Способность на перезарядке")
	endif
endevent



Int Function BosmerMenu()
    if UI.IsMenuOpen("CustomMenu")
        UI.CloseCustomMenu()
        return -1
    else
        UI.OpenCustomMenu("RFAB_BosmerMenu", 0)
        UI.Invoke("CustomMenu", "_root.RFAB_MessageBoxMC.InitMessageBox")
        UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons", PetList)
        return BosmerResult()
    endIf
EndFunction

Int Function BosmerResult()
    while UI.IsMenuOpen("CustomMenu") && UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") < 9
        Utility.Wait(0.1)
    endWhile
    if UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 9
        Int result = UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
        UI.CloseCustomMenu()
        return result
    else
        UI.CloseCustomMenu()
        return -1
    endIf
EndFunction


Function SendEvent()
    int handle = ModEvent.Create("RFAB_BosmerSummonDispel")
    if (handle)
        ModEvent.Send(handle)
    endIf
EndFunction


