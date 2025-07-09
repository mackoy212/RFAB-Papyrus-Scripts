Scriptname RFAB_ModActorValueScript extends ActiveMagicEffect

String property ActorValue auto

bool property detrimental = false auto
bool property Divided = false auto

Float Modifier

function OnEffectStart(Actor akTarget, Actor akCaster)
	Modifier = self.GetMagnitude()
	if (Divided)
		Modifier /= 100.0
	endif
	if (detrimental)
		Modifier *= -1 
	endif
	akTarget.ModActorValue(ActorValue, Modifier)
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModActorValue(ActorValue, -Modifier)
endFunction

