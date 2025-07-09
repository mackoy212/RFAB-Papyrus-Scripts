Scriptname WB_StartStopQuestR_Script extends activemagiceffect  

; -----

Quest Property WB_QuestToStart Auto
Float Property WB_TickUpdate Auto
Sound PRoperty WB_Sound Auto
Sound PRoperty WB_SoundEnd Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	WB_QuestToStart.Stop()
	WB_Sound.Play(akTarget)
	While WB_QuestToStart.IsStopping()
		Utility.Wait(WB_TickUpdate)
	EndWhile
	WB_QuestToStart.Start()

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	WB_QuestToStart.Stop()
	WB_SoundEnd.Play(akTarget)

EndEvent

; -----