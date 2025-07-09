Scriptname EnchWarhammer_InebriationScript extends ActiveMagicEffect

Float Property AddDamage Auto
GlobalVariable Property ChrgeCount Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    Float Dur = self.GetDuration()
    akCaster.ModAV("TwoHandedPowerMod", AddDamage)
    ChrgeCount.Mod(1)
    utility.Wait(Dur)
    akCaster.ModAV("TwoHandedPowerMod", -AddDamage)
    ChrgeCount.Mod(-1)
EndEvent