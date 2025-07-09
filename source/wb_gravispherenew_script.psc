Scriptname WB_GravisphereNew_Script extends ActiveMagicEffect  

; -----

ReferenceAlias Property WB_Gravisphere Auto
Float Property WB_PushForce Auto
Float Property WB_UpdateRate Auto
Float Property WB_InitialWait Auto

; -----

ObjectReference TheBox
Actor TheTarget

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheBox = WB_Gravisphere.GetReference()
	TheTarget = akTarget
	Utility.Wait(WB_InitialWait)
	RegisterForUpdate(WB_UpdateRate)

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)



EndEvent

; -----

Event OnUpdate()

	TheBox.PushActorAway(TheTarget,WB_PushForce)

EndEvent

; -----