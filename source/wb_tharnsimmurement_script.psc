Scriptname WB_TharnsImmurement_Script extends activemagiceffect  

; -----

ReferenceAlias Property WB_Victim Auto
ObjectReference Property WB_Destination Auto
Activator Property FXEmptyActivator Auto
Sound Property WB_AlterationBaleful_Marker_Explosion_Subsonic Auto
Hazard Property WB_AlterationEarth_Hazard_Immurement Auto
Explosion Property WB_AlterationEarth_Explosion_Immurement Auto
EffectShader Property WB_AlterationEarth_FXS_DancingStones_EQ Auto
Float Property WB_HeightMultSink Auto
Float Property WB_HeightMultScale Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.PlaceAtMe(WB_AlterationEarth_Explosion_Immurement)
	Float TargetHeight = akTarget.GetHeight()

	Actor PreviousVictim = WB_Victim.GetActorReference()
	PreviousVictim.StopTranslation()
	WB_Victim.ForceRefTo(akTarget)

	ObjectReference TheBox = akTarget.PlaceAtMe(WB_AlterationEarth_Hazard_Immurement)
	TheBox.SetScale(TargetHeight * WB_HeightMultScale)
	ObjectReference TheBoxDeep = akTarget.PlaceAtMe(FXEmptyActivator)
	TheBoxDeep.MoveTo(TheBox, 0,0, -500)

	WB_AlterationBaleful_Marker_Explosion_Subsonic.Play(TheBox)

	akTarget.TranslateToRef(TheBoxDeep, TargetHeight * WB_HeightMultSink)

	Utility.Wait(3.0)

	If akTarget == WB_Victim.GetActorReference()		; making sure someone else hasn't been immured in the meantime
		akTarget.MoveTo(WB_Destination)
	EndIf
	akTarget.StopTranslation()

	If PreviousVictim
		PreviousVictim.Disable()
		PreviousVictim.MoveTo(TheBox)
		PreviousVictim.PlaceAtMe(WB_AlterationEarth_Explosion_Immurement)
		PreviousVictim.Enable(true)
		WB_AlterationEarth_FXS_DancingStones_EQ.Play(PreviousVictim)
		PreviousVictim.StartCombat(akCaster)
	EndIf

	TheBox.Disable(true)
	Utility.Wait(2.0)
	TheBox.Delete()
	TheBoxDeep.Delete()

EndEvent

; -----