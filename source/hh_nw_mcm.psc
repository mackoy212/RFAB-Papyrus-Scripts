Scriptname HH_NW_MCM extends SKI_ConfigBase  
int keyMapOptionID = 0
int currentKeyCode = 48
int enableModOptionID = 0
int enableModOptionID1 = 0
bool modActive = true
bool TPon = true
Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("��������� ����")
       keyMapOptionID = AddKeymapOption("������� ��� ���������", currentKeyCode); ��� �����
	   AddEmptyOption()
	   enableModOptionID = AddToggleOption("���/���� ���", modActive)
	   AddEmptyOption()
	   enableModOptionID1 = AddToggleOption("���/���� ������ ���������", TPon)
EndEvent 

Event OnOptionKeyMapChange(int option, int keyCode, String conflictControl, String conflictName)
	If(option == keyMapOptionID)
		bool continue = true
		If(conflictControl != "")
			String mssg
			If(conflictName != "")
				mssg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			Else
				mssg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
			EndIf

			continue = ShowMessage(mssg, true, "$Yes", "$No")
		EndIf

		If(continue)
			currentKeyCode = keyCode
			SetKeyMapOptionValue(keyMapOptionID, currentKeyCode)
			HH_NW_Key.SetValueInt(currentKeyCode)
		EndIf
	EndIf
EndEvent

Event OnOptionHighlight(int option)
	If(option == keyMapOptionID)
		SetInfoText("��������� ������� ��� ������������ ����������� ��������")
		ElseIf(option == enableModOptionID)
		If(!modActive)
			SetInfoText("������� ����� �������� ���")
		Else
			SetInfoText("��� ����������� - ��������� ��� � ������� �� �������� ����, ����� ������� � ���� ��� ��� � ������� �������� ���. ����������� ��� ������ � ������ ������������� ������ ��� ��� ���������� ����")
		EndIf
	EndIf
EndEvent

Event OnOptionSelect(int option)
	If(option == enableModOptionID)
		modActive = !modActive
		SetToggleOptionValue(enableModOptionID, modActive)
		If(modActive)
		HH_NW_BQ.Start()
			debug.messagebox("��� �������")
		Else
		HH_NW_BQ.Stop()
		debug.messagebox("��� ��������")
		EndIf
	EndIf
	If option==enableModOptionID1
	TPon=!TPon
	SetToggleOptionValue(enableModOptionID1, TPon)
	if(TPon)
	HH_CR_Flag_on.SetValueInt(1)
	debug.messagebox("������ ��������� �������")
	else
	HH_CR_Flag_on.SetValueInt(0)
	debug.messagebox("������ ��������� ��������")
	endif
	endif
EndEvent
Quest Property HH_NW_BQ  Auto  
GlobalVariable Property HH_NW_Key Auto
GlobalVariable Property HH_CR_Flag_on  Auto  