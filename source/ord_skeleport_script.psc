Scriptname ORD_Skeleport_Script extends activemagiceffect  

; -----

Actor Property PlayerRef Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	akTarget.MoveTo(PlayerRef)

EndEvent

; -----

