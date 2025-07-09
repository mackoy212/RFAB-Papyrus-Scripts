scriptName RFAB_ModActorValueScriptArray extends ActiveMagicEffect

String[] property ActorValues auto

bool property detrimental = false auto
bool property Divided = false auto

Float Modifier
bool running = false

function OnEffectStart(Actor akTarget, Actor akCaster)
	if running
		return
	endif
	running = true
	
	Modifier = self.GetMagnitude()
	if (Divided)
		Modifier /= 100.0
	endif

	if (detrimental)
		Modifier *= -1 
	endif

	Int i = 0
	while i < ActorValues.length
		akTarget.ModActorValue(ActorValues[i], Modifier)
		i += 1
	endWhile
endFunction

function OnEffectFinish(Actor akTarget, Actor akCaster)
	running = false;
	Int i = 0
	while i < ActorValues.length
		akTarget.ModActorValue(ActorValues[i], -Modifier)
		i += 1
	endWhile
endFunction

