Scriptname HorseOverweight extends activemagiceffect

Float SpeedWeak
REQ_MCM_DataStorage Property data Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    SpeedWeak = akTarget.GetAV("SpeedMult") - 15
    akTarget.ModAV("Speedmult", -SpeedWeak)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    akTarget.ModAV("Speedmult", SpeedWeak)
EndEvent