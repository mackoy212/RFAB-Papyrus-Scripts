Scriptname _M_ActivatorScript extends ObjectReference  

GlobalVariable Property QuestChanceLow Auto
GlobalVariable Property QuestChanceMed Auto
GlobalVariable Property QuestChanceHigh Auto
GlobalVariable Property QuestChanceVeryHigh Auto

FormList Property QuestsLow Auto
FormList Property QuestsMed Auto
FormList Property QuestsHigh Auto
FormList Property QuestsVeryHigh Auto

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property RefreshRate Auto

ObjectReference Property MissiveBoard Auto

float LastUpdate = -100.0

Event OnTriggerEnter(ObjectReference akActionRef)
	if(akActionRef == Game.GetPlayer() && GameDaysPassed.GetValue() > LastUpdate + RefreshRate.GetValue())
		Debug.Trace("Missives: Update Trigger Triggered")
		LastUpdate = GameDaysPassed.GetValue()
		
		MissiveBoard.BlockActivation(true)

		UpdateQuests(QuestChanceLow.GetValue(), QuestsLow)
		UpdateQuests(QuestChanceMed.GetValue(), QuestsMed)
		UpdateQuests(QuestChanceHigh.GetValue(), QuestsHigh)
		UpdateQuests(QuestChanceVeryHigh.GetValue(), QuestsVeryHigh)

		MissiveBoard.BlockActivation(false)

		Debug.Trace("Missives: Quests Updated")
	endIf
endEvent

Function UpdateQuests(float QuestChance, FormList QuestList)
	int QuestIndex = 0
	while(QuestIndex < QuestList.GetSize())
		if(Utility.RandomInt() < QuestChance)
			Quest MissiveQuest = QuestList.GetAt(QuestIndex) as Quest

			;If the quest isn't running, start it up
			;If the quest is running, but hasn't been picked up by the player, reset it
			if(!MissiveQuest.IsRunning())
				bool Started = MissiveQuest.Start()
				if(Started)
					Debug.Trace("Missives: Starting Quest " + QuestIndex + ":" + MissiveQuest + ", in Quest List: " + QuestList)
				else
					Debug.Trace("Missives: Failed to Start Quest " + QuestIndex + ":" + MissiveQuest + ", in Quest List: " + QuestList)
				endIf
			elseif(MissiveQuest.GetStage() == 0)
				Debug.Trace("Missives: Stoping Quest " + QuestIndex + ":" + MissiveQuest + ", in Quest List: " + QuestList)
				MissiveQuest.SetStage(110)
			endIf
		endIf
		QuestIndex += 1
	endWhile
endFunction