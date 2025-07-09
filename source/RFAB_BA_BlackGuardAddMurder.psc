Scriptname RFAB_BA_BlackGuardAddMurder extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	game.IncrementStat("murders", 1)
endevent