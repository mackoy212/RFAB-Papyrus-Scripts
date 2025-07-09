Scriptname RFAB_ClassSystem extends ActiveMagicEffect

Spell Property ClassSpell Auto
{Спелл, который представляет класс}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SendClassEvent()
EndEvent

Function SendClassEvent()
    int handle = ModEvent.Create("ClassSystemEvent")
    if (handle)
        ModEvent.PushForm(handle, ClassSpell as Form)
        ModEvent.Send(handle)
    endIf
EndFunction