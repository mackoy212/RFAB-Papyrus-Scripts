Scriptname WB_FrozenOrb_Script extends ObjectReference  

; ------

Spell Property WB_S_D100_FrozenOrb_Spell Auto

Activator Property FXEmptyActivator Auto
Float Property WB_StartHeight Auto
Float Property WB_AttackRate Auto

Static Property WB_DestructionFrost_Static_FrozenOrb Auto

Explosion Property WB_DestructionFrost_Explosion_FrozenOrbEnd Auto

Float Property WB_Speed Auto
Int  Property WB_StallDuration Auto

Actor Property PlayerRef Auto

; ------

ObjectReference TheOrb
ObjectReference RandomBox
Int TicksStationary = 0
Bool KeepShooting = true
;Float FrozenOrbAngle = 0.0

; ------

Event OnLoad()

	RandomBox = PlayerRef.placeAtMe(FXEmptyActivator)
	TheOrb = PlayerRef.PlaceAtMe(WB_DestructionFrost_Static_FrozenOrb)
	TheOrb.SetAngle(0,0,0)
	TheOrb.MoveTo(PlayerRef,0,0,WB_StartHeight)
	TheOrb.SetActorCause(PlayerRef)
	Utility.Wait(0.1)

	RegisterForUpdate(WB_AttackRate)
	TheOrb.TranslateToRef(Self,WB_Speed)

EndEvent

; ------

Event OnUpdate()

	If TheOrb != NONE
		If KeepShooting == true
			; the orb is still live

			RandomBox.MoveTo(TheOrb,Utility.RandomInt(-1000,1000),Utility.RandomInt(-1000,1000),Utility.RandomInt(-250,250))
		;	FrozenOrbAngle += 286
		;	RandomBox.MoveTo(TheOrb,Math.Sin(FrozenOrbAngle) * 1000,Math.Cos(FrozenOrbAngle) * 1000,Utility.RandomInt(-250,250))
			WB_S_D100_FrozenOrb_Spell.RemoteCast(TheOrb, PlayerRef, RandomBox)

			If TheOrb.GetDistance(Self) < 200
				; orb reached its destination and stalls
				TicksStationary += 1
				If TicksStationary == 1
					; it just arrived so stop it in place
					TheOrb.StopTranslation()
				EndIf
				If TicksStationary >= WB_StallDuration
					; stall duration runs out so set a flag to stop updating and detonate the orb
					KeepShooting = false
				EndIf
			EndIf
		Else
			; the orb should explode
			UnregisterForUpdate()
			TheOrb.PlaceAtMe(WB_DestructionFrost_Explosion_FrozenOrbEnd)
			OnUnload()
		EndIf
	EndIf

EndEvent

; -----

Event OnUnload()

	UnregisterForUpdate()
	TheOrb.Delete()
	Self.Delete()

EndEvent

; -----