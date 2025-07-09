Scriptname APT_TuumSystem extends activemagiceffect

Float property Percent auto
Spell Property Shoutspell auto

Float Mult
Actor Player

Function OnEffectStart(Actor akTarget, Actor akCaster)

	Player = akCaster
	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("MagicMenu")
	self.UpdateShoutBonuses()
EndFunction

function OnPlayerLoadGame()

	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("MagicMenu")
	self.UpdateShoutBonuses()
endFunction

function ScriptInit(String eventName, String strArg, Float numArg, Form sender)

	self.UpdateShoutBonuses()
	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("MagicMenu")
endFunction

function OnMenuClose(String Menu)

	if Menu != "MagicMenu"
		self.UpdateShoutBonuses()
	endIf
endFunction


function UpdateShoutBonuses()
	Mult = Player.GetAV("Speechcraft") * Percent as Float
	Shoutspell.SetNthEffectMagnitude(0, Mult as float)
	Player.RemoveSpell(Shoutspell)
	utility.Wait(0.1)
	Player.AddSpell(Shoutspell, false)
endFunction
