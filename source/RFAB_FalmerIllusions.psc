Scriptname RFAB_FalmerIllusions extends ActiveMagicEffect  

ActorBase Property Summon Auto
EffectShader Property IllusionShader Auto

int Property Count Auto

Actor Caster
Actor[] Summons

Event OnEffectStart(Actor akTarget, Actor akCaster)
    IllusionShader.Play(akCaster)
	Caster = akCaster
    Summons = PapyrusUtil.ActorArray(Count)
    SpawnIllusions()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	IllusionShader.Stop(akCaster)
    KillIllusions()
EndEvent

Function SpawnIllusions()
	int i = 0
	while i < Summons.Length
		Actor thisActor = Caster.PlaceActorAtMe(Summon)
		Summons[i] = thisActor
		IllusionShader.Play(thisActor)
		i += 1
	endwhile
EndFunction

Function KillIllusions()
	int i = 0
	while i < Summons.Length
		Summons[i].Kill()
		i += 1
	endwhile
EndFunction