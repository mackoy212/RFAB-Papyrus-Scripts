;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE016_UmbraAliasScript.psc
Modified : 2019-02-15 23:48:17
Compiled : 2019-03-07 22:30:00
User     : builds
Computer : RKVBGSBUILD05
/;
scriptName ccbgssse016_umbraenchcast extends activemagiceffect

spell property spl Auto
globalvariable property stacks Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Game.Getplayer().HasMagicEffectWithKeyword(keyword.getkeyword("ccBGSSSE016_BuffKW")))
		stacks.mod(1.0)
	else
		stacks.setvalue(1.0)
	EndIf
	Game.Getplayer().dispelspell(spl)
	spl.cast(Game.Getplayer(), Game.Getplayer())
EndEvent
