;/ Decompiled by Champollion V1.0.1
Source   : REQ_AlcoholScript.psc
Modified : 2021-08-23 21:49:36
Compiled : 2021-08-23 21:51:44
User     : User
Computer : PC
/;
scriptName REQ_AlcoholScript extends ActiveMagicEffect
{Keeps track of the current drunk level and applies the visual drunk effect to the player.}

;-- Properties --------------------------------------
imagespacemodifier property DrunkISM auto
faction property Storage auto
globalvariable Property FactionRank Auto
;-- Variables ---------------------------------------
Float mag

;-- Functions ---------------------------------------

function OnEffectStart(Actor akTarget, Actor akCaster)

	mag = self.GetMagnitude()
	if mag <= 0
		mag = 1
	endIf
	FactionRank.Setvalue(FactionRank.Getvalue() + mag)
	akTarget.AddToFaction(Storage)
	if akTarget.GetFactionRank(Storage) + mag < 127
		akTarget.ModFactionRank(Storage, math.Floor(mag))
	else
		akTarget.SetFactionRank(Storage, 127)
	endIf
	if akTarget.GetFactionRank(Storage) > 50
		self.Dispel()
	endIf
	if akTarget == game.GetPlayer()
		DrunkISM.Remove()
		DrunkISM.Apply((akTarget.GetFactionRank(Storage) as Float / 50.0000 - akTarget.GetBaseActorValue("Health") / 1000 as Float) * utility.RandomFloat(0.800000, 1.20000))
	endIf
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnEffectFinish(Actor akTarget, Actor akCaster)
	FactionRank.Setvalue(FactionRank.Getvalue() - mag)
	akTarget.ModFactionRank(Storage, -1 * math.Floor(mag))
	if akTarget.GetFactionRank(Storage) <= 0
		akTarget.RemoveFromFaction(Storage)
		FactionRank.Setvalue(0)
	endIf
	if akTarget == game.GetPlayer()
		DrunkISM.Remove()
		if akTarget.GetFactionRank(Storage) > 0
			DrunkISM.Apply((akTarget.GetFactionRank(Storage) as Float / 50.0000 - akTarget.GetBaseActorValue("Health") / 1000 as Float) * utility.RandomFloat(0.800000, 1.20000))
		endIf
	endIf
endFunction
