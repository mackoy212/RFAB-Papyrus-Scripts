Scriptname WB_VolcanoController_Script extends ObjectReference  

; -----

Activator Property WB_DestructionFire_Activator_VolcanoNew_Fountain Auto
Float Property WB_TotalHeight Auto
Float Property WB_FallHeight Auto
Float Property WB_MoveSpeed Auto
Float Property WB_Duration Auto
Float Property WB_UpdateRate Auto
Spell Property WB_S_D100_VolcanoNew_Spell_PC Auto
Activator Property FXEmptyActivator Auto
Float Property WB_EndLocZ Auto
Float Property WB_FireballRadius Auto
Actor Property PlayerRef Auto
Float Property WB_RumbleStrength Auto
Float Property WB_RumbleRadius Auto
Light Property WB_DestructionFire_Light_Volcano_Fountain Auto

; ------

ObjectReference TheVolcano
ObjectReference TargetBox
ObjectReference LightBox
ObjectReference StarterBox
Bool ShouldVolcanoShoot
;Float FrozenOrbAngle = 0.0

; ------

Event OnLoad()

	TargetBox = Self.PlaceAtMe(FXEmptyActivator)

	TheVolcano = Self.PlaceAtMe(WB_DestructionFire_Activator_VolcanoNew_Fountain)
	TheVolcano.SetAngle(0,0,0)

	StarterBox = Self.PlaceAtMe(FXEmptyActivator)
	StarterBox.MoveTo(Self, 0, 0, 32)

	LightBox = Self.PlaceAtMe(WB_DestructionFire_Light_Volcano_Fountain)
	LightBox.MoveTo(Self, 0, 0, 96)

	; volcano rises from the ground
	TheVolcano.TranslateTo(TheVolcano.GetPositionX(), TheVolcano.GetPositionY(), TheVolcano.GetPositionZ() + WB_TotalHeight, 0, 0, 0, WB_MoveSpeed)

	ShouldVolcanoShoot = true
	RegisterForUpdate(WB_UpdateRate)

	; duration of volcano
	Utility.Wait(WB_Duration)

	; destroy volcano
	OnUnload()

EndEvent

; -----

Event OnUnload()

	UnregisterForUpdate()
	ShouldVolcanoShoot = false

	; volcano sinks
;	TheVolcano.TranslateTo(TheVolcano.GetPositionX(), TheVolcano.GetPositionY(), TheVolcano.GetPositionZ() + WB_FallHeight, 0, 0, 0, WB_MoveSpeed)

	; delete each volcano object
	LightBox.Delete()
	TheVolcano.Disable(true)
	TheVolcano.Delete()
	StarterBox.Delete()
	Delete()

EndEvent

; -----

Event OnUpdate()

	If ShouldVolcanoShoot == true
		TargetBox.MoveTo(Self, Utility.RandomFloat(-WB_FireballRadius, WB_FireballRadius), Utility.RandomFloat(-WB_FireballRadius, WB_FireballRadius), WB_EndLocZ)
;		FrozenOrbAngle += 51
;		TargetBox.MoveTo(Self, Math.Sin(FrozenOrbAngle) * WB_FireballRadius, Math.Cos(FrozenOrbAngle) * WB_FireballRadius, WB_EndLocZ)
		WB_S_D100_VolcanoNew_Spell_PC.RemoteCast(StarterBox, PlayerRef, TargetBox)
	EndIf

	; volcano shakes the ground
;	Self.RampRumble(WB_RumbleStrength, 0.2, WB_RumbleRadius)

EndEvent

; ------