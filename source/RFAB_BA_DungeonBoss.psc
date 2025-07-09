Scriptname RFAB_BA_DungeonBoss extends Actor  

int Property StageWhenNotActual = 212 Auto
{
	1. ������� � �����
	2. ����� � ��������
	3. �������
	4. �������
	5. �������
	6. �������
	7. �������
}

Auto State Ready
	Event OnLoad()
		if BizarreAdventure.GetDungeonScript().StageNumber.GetValueInt() >= StageWhenNotActual
			GoToState("")
		else
			SendEvent("RFAB_BA_Event_BossLoad") 
		endif
	EndEvent

	Event OnDying(Actor akKiller)
	   	GoToState("")
		SendEvent("RFAB_BA_Event_BossSlain") 
	EndEvent
EndState

Function SendEvent(string asEventName)
	int iHandle = ModEvent.Create(asEventName)
	if (iHandle)
		ModEvent.PushForm(iHandle, self)
		ModEvent.Send(iHandle)
	endIf
EndFunction