scriptName REQ_AttributeSystem extends REQ_PlayerAlias
{This script controls the derived attributes, they are updated each time the skills menu is closed.
The contributions are computed as prefactor * sqrt( weighted base attribute sum - threshold). Negative 
arguments to the square root have no contribution.}

;-- Properties --------------------------------------

Float[] property threshold auto
{minimum value the weighted attribute sum must reach to give any bonus to the specified derived stat}


Float[] property prefactor auto
{scaling prefactors for the attributes}
Float[] property weight_magicka auto
{weighting factors for base magicka}

Float[] property prefactor_shouts auto
{the weighting prefactors for the shout cooldown bonus components}
String[] property derived auto
{list of derived stats to mod}

String[] property shout_derived auto
{the individual components (game misc stats) that make up the shout cooldown reduction}
Float[] property weight_health auto
{weighting factors for base health}


Float[] property shout_thresholds auto
{the minimum value the misc stat must have to contribute at all}

Float property Magicka_Threshold1 auto
Float property Magicka_Threshold2 auto
Float property Magicka_Threshold3 auto

Float property Health_Threshold1 auto
Float property Health_Threshold2 auto
Float property Health_Threshold3 auto


Float property Stamina_Threshold1 auto
Float property Stamina_Threshold2 auto
Float property Stamina_Threshold3 auto

Float property Health_MagickaThreshold1 auto
Float property Health_MagickaThreshold2 auto
Float property Health_MagickaThreshold3 auto


Float property Health_StaminaThreshold1 auto
Float property Health_StaminaThreshold2 auto
Float property Health_StaminaThreshold3 auto

spell property health_bonus1 auto
spell property health_bonus2 auto
spell property health_bonus3 auto

spell property magicka_bonus1 auto
spell property magicka_bonus2 auto
spell property magicka_bonus3 auto

spell property stamina_bonus1 auto
spell property stamina_bonus2 auto
spell property stamina_bonus3 auto


spell property health_magicka_bonus1 auto
spell property health_magicka_bonus2 auto
spell property health_magicka_bonus3 auto

spell property health_stamina_bonus1 auto
spell property health_stamina_bonus2 auto
spell property health_stamina_bonus3 auto


Float[] property modifiers auto
{the current computed actorvalue modifiers}

Float[] property mods_Shout auto
{the current shout modifiers}



Float[] property weight_stamina auto
{weighting factors for base stamina}






;-- Variables ---------------------------------------
Bool doagain = false

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function UpdateAttributeBonuses()

	Int i = 0
	Float magicka = Player.GetBaseAV("magicka")
	Float stamina = Player.GetBaseAV("stamina")
	Float health = Player.GetBaseAV("health")
	if health >= Health_Threshold1 && health < Health_Threshold2
		Player.addspell(health_bonus1, true)
	elseIf health >= Health_Threshold2 && health < Health_Threshold3
		Player.removespell(health_bonus1)
		Player.addspell(health_bonus2, true)
	elseIf health >= Health_Threshold3
		Player.removespell(health_bonus1)
		Player.removespell(health_bonus2)
		Player.addspell(health_bonus3, true)
	endIf
	if stamina >= Stamina_Threshold1 && stamina < Stamina_Threshold2
		Player.addspell(stamina_bonus1, true)
	elseIf stamina >= Stamina_Threshold2 && stamina < Stamina_Threshold3
		Player.removespell(stamina_bonus1)
		Player.addspell(stamina_bonus2, true)
	elseIf stamina >= Stamina_Threshold3
		Player.removespell(stamina_bonus1)
		Player.removespell(stamina_bonus2)
		Player.addspell(stamina_bonus3, true)
	endIf
	if magicka >= Magicka_Threshold1 && magicka < Magicka_Threshold2
		Player.addspell(magicka_bonus1, true)
	elseIf magicka >= Magicka_Threshold2 && magicka < Magicka_Threshold3
		Player.removespell(magicka_bonus1)
		Player.addspell(magicka_bonus2, true)
	elseIf magicka >= Magicka_Threshold3
		Player.removespell(magicka_bonus1)
		Player.removespell(magicka_bonus2)
		Player.addspell(magicka_bonus3, true)
	endIf

	if (health >= Health_MagickaThreshold1 && magicka >= Health_MagickaThreshold1) && (health < Health_MagickaThreshold2 || magicka < Health_MagickaThreshold2)
		Player.addspell(health_magicka_bonus1, true)
	elseif health >= Health_MagickaThreshold2 && magicka >= Health_MagickaThreshold2 && (health < Health_MagickaThreshold3 || magicka < Health_MagickaThreshold3)
		Player.removespell(health_magicka_bonus1)
		Player.addspell(health_magicka_bonus2, true)
	elseif health >= Health_MagickaThreshold3 && magicka >= Health_MagickaThreshold3
		Player.removespell(health_magicka_bonus1)
		Player.removespell(health_magicka_bonus2)
		Player.addspell(health_magicka_bonus3, true)
	endIf

	if (health >= Health_StaminaThreshold1 && stamina >= Health_StaminaThreshold1) && (health < Health_StaminaThreshold2 || stamina < Health_StaminaThreshold2)
		Player.addspell(health_stamina_bonus1, true)
	elseif health >=Health_StaminaThreshold2 && stamina >= Health_StaminaThreshold2 && (health < Health_StaminaThreshold3 || stamina < Health_StaminaThreshold3)
		Player.removespell(health_stamina_bonus1)
		Player.addspell(health_stamina_bonus2, true)
	elseif health >= Health_StaminaThreshold3 && stamina >= Health_StaminaThreshold3
		Player.removespell(health_stamina_bonus1)
		Player.removespell(health_stamina_bonus2)
		Player.addspell(health_stamina_bonus3, true)
	endIf
endFunction

function Reset_Buffs()

	Int i = 0
	while i < derived.length
		Player.ModAV(derived[i], -modifiers[i])
		modifiers[i] = 0.000000
		i += 1
	endWhile
	i = 0
	while i < mods_Shout.length
		Player.ModAV("ShoutRecoveryMult", -mods_Shout[i])
		mods_Shout[i] = 0 as Float
		i += 1
	endWhile
endFunction

function ScriptShutDown(String eventName, String strArg, Float numArg, Form sender)

	while self.GetState() != ""
		utility.Wait(0.500000)
	endWhile
	Player.ModAV("ShoutRecoveryMult", -0.500000)
	self.UnregisterForAllMenus()
	Player.ModAV("ShoutRecoveryMult", -mods_Shout[0])
	Int i = 0
	while i < mods_Shout.length
		mods_Shout[i] = 0 as Float
		i += 1
	endWhile
	self.Reset_Buffs()
	parent.ScriptShutDown(eventName, strArg, numArg, sender)
endFunction

function OnMenuClose(String Menu)

	self.GotoState("working")
	if Menu != "MagicMenu"
		self.UpdateAttributeBonuses()
	endIf
	self.UpdateShoutBonuses()
	self.GotoState("")
	if doagain
		doagain = false
		self.OnMenuClose("")
	endIf
endFunction

function ScriptInit(String eventName, String strArg, Float numArg, Form sender)

	modifiers = utility.CreateFloatArray(derived.length, 0.000000)
	mods_Shout = utility.CreateFloatArray(shout_derived.length, 0.000000)
	Player.ModAV("ShoutRecoveryMult", 0.500000)
	self.Reset_Buffs()
	self.UpdateAttributeBonuses()
	self.UpdateShoutBonuses()
	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("MagicMenu")
	parent.ScriptInit(eventName, strArg, numArg, sender)
endFunction

function UpdateShoutBonuses()

	Int i = 0
	while i < shout_derived.length
		Player.ModAV("ShoutRecoveryMult", -mods_Shout[i])
		Float statValue = game.QueryStat(shout_derived[i]) as Float
		if statValue > shout_thresholds[i]
			mods_Shout[i] = -prefactor_shouts[i] * math.Pow(statValue - shout_thresholds[i], 0.500000)
		else
			mods_Shout[i] = 0.000000
		endIf
		Player.ModAV("ShoutRecoveryMult", mods_Shout[i])
		i += 1
	endWhile
endFunction

function OnPlayerLoadGame()

	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("MagicMenu")
endFunction

; Skipped compiler generated GetState

;-- State -------------------------------------------
state working

	function OnMenuClose(String Menu)

		doagain = true
	endFunction
endState
