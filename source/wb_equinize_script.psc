Scriptname WB_Equinize_Script extends activemagiceffect  

; -----

Race Property HorseRace Auto

; -----

Race OldRace

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Utility.Wait(0.05)
	OldRace = akTarget.GetRace()
	akTarget.SetRace(HorseRace) 

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.SetRace(OldRace) 

EndEvent

; -----