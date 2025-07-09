Scriptname RFAB_MCM_Alias extends ReferenceAlias  
{��������� �������� RFAB MCM ����� ������ ������������ ����, ��������� �����-�� ��������}

RFAB_MCM Property MCM Auto

bool Property IsBlessingMessageOn = true Auto Hidden
{����������� ��������� � ������ � �������������� �����������}
bool Property IsFastTravelAllowed = false Auto Hidden
{���������� �� ������� �����������, �������������� � RFAB_FastTravelControl}

Event OnInit()
    GoToState("Ready")
EndEvent

State Ready

Event OnPlayerLoadGame()
    MCM.DifficultyMenu.UpdateDifficulty()
EndEvent

EndState

Event OnPlayerLoadGame()
	; ��������
EndEvent