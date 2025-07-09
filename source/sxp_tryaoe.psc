Scriptname SXP_TRYAOE Extends ActiveMagicEffect

zzzSXPWorkerKillActor Property XPWorker Auto
Keyword Property MagicInfluenceFrenzy Auto
Keyword Property Mirel_KW_Summon Auto

Actor VictimActor
Float Time

Auto State DoOnceState
Event OnEffectStart(Actor Target, Actor Caster)
	Time = Utility.GetCurrentRealTime()
	VictimActor = Target
EndEvent

Event onDying(actor myKiller)
	If !VictimActor.HasMagicEffectWithKeyword(Mirel_KW_Summon)
		If !myKiller
			If VictimActor.IsHostileToActor(Game.GetPlayer()) && (Time > Utility.GetCurrentRealTime() || Utility.GetCurrentRealTime() > Time + 2.0)
				XPWorker.PostVictim(VictimActor)
			EndIf
		ElseIf myKiller == Game.GetPlayer() || myKiller.IsPlayerTeammate() || myKiller.HasMagicEffectWithKeyword(MagicInfluenceFrenzy) || (StringUtil.Find(myKiller.GetRace(), "DragonRace") > 0 && !myKiller.IsHostileToActor(Game.GetPlayer()))
			XPWorker.PostVictim(VictimActor)
		EndIf
	EndIf
	GoToState("DoNothingState")
EndEvent
EndState

State DoNothingState
EndState