Scriptname WB_SustainSpell_Script extends ActiveMagicEffect  

; -----

Float Property WB_UpdateRate Auto
Spell Property WB_I050_PaleMoon_Spell Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdate(WB_UpdateRate)

EndEvent

; -----

Event OnUpdate()

	If GetCasterActor().GetAV("Magicka") < 1.0
		GetCasterActor().DispelSpell(WB_I050_PaleMoon_Spell)
		Dispel()
	Else
		RegisterForSingleUpdate(WB_UpdateRate)
	EndIf

EndEvent

; -----