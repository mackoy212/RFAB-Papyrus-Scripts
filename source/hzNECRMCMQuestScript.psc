Scriptname hzNECRMCMQuestScript extends SKI_ConfigBase

hzNECRAliasScript Property hzNECRAS Auto

GlobalVariable Property hzNECRAutoReload Auto
GlobalVariable Property hzNECRStaminaMult Auto

Int OID_AutoReload
Int OID_StaminaMult
Int OID_ForceInit

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Non-Exploitable Crossbow Reload - Options")
	OID_AutoReload = AddToggleOption("Auto Reload", hzNECRAutoReload.GetValueInt())
	OID_StaminaMult = AddSliderOption("Stamina Drain Mult", hzNECRStaminaMult.GetValue(), "{1}")
	if hzNECRAS.GetState() != "Main"
		SetCursorPosition(22)
		OID_ForceInit = AddTextOption("Force Initialization", "No")
	endif
EndEvent

Event OnOptionSelect(int option)
	if option == OID_AutoReload
		if hzNECRAutoReload.GetValueInt() == 1
			hzNECRAutoReload.SetValueInt(0)
			SetToggleOptionValue(option, 0)
		elseIf hzNECRAutoReload.GetValueInt() == 0
			hzNECRAutoReload.SetValueInt(1)
			SetToggleOptionValue(option, 1)
		endIf
	elseif option == OID_ForceInit
		SetTextOptionValue(option, "Queued, exit MCM")
		SetOptionFlags(option, OPTION_FLAG_DISABLED)
		hzNECRAS.GoToState("Main")
	endif
EndEvent

Event OnOptionSliderOpen(int option)
	if option == OID_StaminaMult
		SetSliderDialogStartValue(hzNECRStaminaMult.GetValue())
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0, 5)
		SetSliderDialogInterval(0.1)
	endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if option == OID_StaminaMult
		hzNECRStaminaMult.SetValue(value)
		SetSliderOptionValue(option, value, "{1}")
	endif
EndEvent

Event OnOptionHighlight(int option)
	if option == OID_AutoReload
		SetInfoText("With this enabled, xbows will reload automatically - similar to vanilla, but will still use anti-exploit & stamina drain functionality of this mod.")
	elseif option == OID_StaminaMult
		SetInfoText("The higher this number is, the more stamina will be consumed on each reload.\n'1.0' should provide an optimal balance for Requiem, '0.0' will disable stamina drain.")
	elseif option == OID_ForceInit
		SetInfoText("Click here if you want to initialize right now.\nOtherwise NECR will auto-initialize when you equip xbow for the first time.")
	endif
EndEvent

Event OnOptionDefault(int option)
	if option == OID_AutoReload
		hzNECRAutoReload.SetValueInt(0)
		SetToggleOptionValue(option, 0)
	elseif option == OID_StaminaMult
		hzNECRStaminaMult.SetValue(0)
		SetSliderOptionValue(option, 0.0, "{1}")
	endif
EndEvent
