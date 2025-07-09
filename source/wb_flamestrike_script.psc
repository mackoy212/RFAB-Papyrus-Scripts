Scriptname WB_Flamestrike_Script extends ActiveMagicEffect  

; ------

Float Property WB_SpawnerZOffset Auto		; bomb height

Spell Property WB_S_D100_Flamestrike_Spell Auto

Activator Property FXEmptyActivator Auto

Float Property WB_DistanceInFront Auto
Float Property WB_DistanceInFrontAdd Auto
Int Property WB_NumberOfShards Auto
Float Property WB_PositionDelta = 0.0 Auto
Float Property WB_AttackRate Auto

; ------

ObjectReference StarterBox
ObjectReference FinisherBox
Actor TheTarget
Actor TheCaster
Int ShardsCast

Float EndLocX
Float EndLocY
Float DistanceInFront
Float CasterAngle
Float CasterAngleSin
Float CasterAngleCos
Float CasterPosX
Float CasterPosY
Float CasterPosZ

; ------

Event OnEffectStart(Actor akTarget, Actor akCaster)

	StarterBox = akCaster.placeAtMe(FXEmptyActivator)
	FinisherBox = akCaster.placeAtMe(FXEmptyActivator)

	ShardsCast = 0

	CasterPosX = akCaster.GetPositionX()
	CasterPosY = akCaster.GetPositionY()
	CasterPosZ = akCaster.GetPositionZ()

	CasterAngle = akCaster.GetAngleZ()

	CasterAngleSin = Math.Sin(CasterAngle)
	CasterAngleCos = Math.Cos(CasterAngle)

	DistanceInFront = WB_DistanceInFront

	TheTarget = akTarget
	TheCaster = akCaster

	RegisterForUpdate(WB_AttackRate)

EndEvent

; -----

Event OnUpdate()

	If ShardsCast < WB_NumberOfShards
		EndLocX = DistanceInFront * CasterAngleSin
		EndLocY = DistanceInFront * CasterAngleCos
		StarterBox.SetPosition(CasterPosX + EndLocX + Utility.RandomFloat(-WB_PositionDelta,WB_PositionDelta), CasterPosY + EndLocY + Utility.RandomFloat(-WB_PositionDelta,WB_PositionDelta), CasterPosZ + WB_SpawnerZOffset)
		FinisherBox.SetPosition(CasterPosX + EndLocX, CasterPosY + EndLocY, CasterPosZ)
		WB_S_D100_Flamestrike_Spell.RemoteCast(StarterBox, TheCaster, FinisherBox)
		ShardsCast += 1
		DistanceInFront += WB_DistanceInFrontAdd
	Else
		UnregisterForUpdate()
		Dispel()
	EndIf

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Utility.Wait(3.0)
	StarterBox.Delete()
	FinisherBox.Delete()

EndEvent

; ------

