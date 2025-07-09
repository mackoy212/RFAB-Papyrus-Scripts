Scriptname RFAB_Script_AlduinFogScene_OnEffectStart extends ActiveMagicEffect  

Scene Property myScene  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	myScene.Start()
endevent