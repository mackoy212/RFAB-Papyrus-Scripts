Scriptname WB_Shroudwalk_Script extends ActiveMagicEffect  

; -----

Float Property WB_UpdateRate Auto
Spell Property WB_S_I100_Shroudwalk_Spell Auto
Keyword Property MagicInvisibility Auto
GlobalVariable Property WB_Illusion_Shroudwalk_Global_BreakCount Auto

; -----

Actor TheTarget
Int NumberOfBreaks

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheTarget = akTarget
	NumberOfBreaks = 0
	OnUpdate()

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akTarget.DispelSpell(WB_S_I100_Shroudwalk_Spell)

EndEvent

; -----

Event OnUpdate()

	If !TheTarget.HasEffectKeyword(MagicInvisibility)
		If NumberOfBreaks <= WB_Illusion_Shroudwalk_Global_BreakCount.GetValue() as Int
			WB_S_I100_Shroudwalk_Spell.Cast(TheTarget)
			NumberOfBreaks += 1
			RegisterForSingleUpdate(WB_UpdateRate)
		Else
			Dispel()
		EndIf
	Else
		RegisterForSingleUpdate(WB_UpdateRate)
	EndIf

EndEvent

; -----