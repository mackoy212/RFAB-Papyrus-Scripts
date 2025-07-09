Scriptname WB_Seal_Script_Dispell extends ActiveMagicEffect  

Spell Property WB_S_Sealed_Spell_Main Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	akCaster.DispelSpell(WB_S_Sealed_Spell_Main)

EndEvent