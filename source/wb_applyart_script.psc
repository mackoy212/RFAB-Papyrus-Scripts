Scriptname WB_ApplyArt_Script extends activemagiceffect  

; -----

VisualEffect Property WB_ConjurationDwemer_VFX_HeraldOfAyem_Ayem auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	WB_ConjurationDwemer_VFX_HeraldOfAyem_Ayem.Play(akTarget)

EndEvent

; -----