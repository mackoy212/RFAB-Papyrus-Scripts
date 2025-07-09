Scriptname RFAB_BA_DoorTeleport extends ObjectReference  
{����� �� ��������� ����}

FormList Property StartedQuestList Auto

Event OnTriggerEnter(ObjectReference akRef)
	if akRef == Game.GetPlayer()
		MoveToQuestLocation()
	endif
EndEvent

Function MoveToQuestLocation()
	if StartedQuestList.GetSize() != 0
		string[] Buttons = new string[3]
		Buttons[0] = "� ����"
		Buttons[1] = "�� �������"
		Buttons[2] = "������"

		int iChoiceID = SkyMessage.ShowArray("���� �����������?", Buttons, getIndex = true) as int
		if iChoiceID == 0
			BizarreAdventure.GetDungeonScript().GoToNewDungeon()
		elseif iChoiceID == 1
			ShowQuests()
		endif
	else
		string[] Buttons = new string[2]
		Buttons[0] = "� ����"
		Buttons[1] = "������"

		int iChoiceID = SkyMessage.ShowArray("���� �����������?", Buttons, getIndex = true) as int
		if iChoiceID == 0
			BizarreAdventure.GetDungeonScript().GoToNewDungeon()
		endif
	endif
EndFunction

Function ShowQuests()
	int Size = StartedQuestList.GetSize()
	string[] Buttons = Utility.CreateStringArray(Size + 1, "")

	int i = 0
	while i < Size
		Quest ThisQuest = StartedQuestList.GetAt(i) as Quest
		ObjectReference LocationMarker = (ThisQuest.GetAliasByName("LocationMarker") as ReferenceAlias).GetReference()
		Buttons[i] = LocationMarker.GetCurrentLocation().GetName() + "\n" + "(" + ThisQuest.GetName() + ")"
		i += 1
	endwhile
	Buttons[i] = "������"

	int iChoiceID = SkyMessage.ShowArray("���� ������ �����������?", Buttons, getIndex = true) as int
	if iChoiceID != i
		Quest ThisQuest = StartedQuestList.GetAt(iChoiceID) as Quest
		RFAB_BA_Quest QuestScript = ThisQuest as RFAB_BA_Quest

		QuestScript.SetTravelStageIfNeed()
		QuestScript.TeleportToLocation()
		Game.RequestSave()
	endif
EndFunction