Scriptname RFAB_ActorVisual extends ActiveMagicEffect  

VisualEffect[] Property Visuals Auto
EffectShader[] Property Shaders Auto

Actor Caster

Event OnEffectStart(Actor akTarget, Actor akCaster)	
	Caster = akCaster
	PlayVisual()
	PlayShaders()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	StopVisual()
	StopShaders()
EndEvent

Event OnDying(actor myKiller)	
	StopVisual()
	StopShaders()
EndEvent

Function PlayShaders()
	int i = 0
	while i < Shaders.Length
		Shaders[i].Play(Caster)
		i += 1
	endwhile
EndFunction

Function StopShaders()
	int i = 0
	while i < Shaders.Length
		Shaders[i].Stop(Caster)
		i += 1
	endwhile
EndFunction

Function PlayVisual()
	int i = 0
	while i < Visuals.Length
		Visuals[i].Play(Caster)
		i += 1
	endwhile
EndFunction

Function StopVisual()
	int i = 0
	while i < Visuals.Length
		Visuals[i].Stop(Caster)
		i += 1
	endwhile
EndFunction