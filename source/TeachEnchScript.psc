ScriptName TeachEnchScript Extends ActiveMagicEffect

Enchantment[] Property EnchArr Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	int i = 0
	While i < EnchArr.length
		EnchArr[i].SetPlayerKnows(true)
		i += 1
	EndWhile
EndEvent