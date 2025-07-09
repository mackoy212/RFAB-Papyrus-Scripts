Scriptname PerkDexterityScript extends ActiveMagicEffect

Float Property BonusDamageMult Auto
Float Property BonusDamageCap Auto
Float Property BonusDamageThreshold Auto
Float Property UpTime Auto
GlobalVariable Property Desc Auto

Float LastSM
Float BonusDmg
Actor Caster
Bool isReady = false

Function OnEffectStart(Actor akTarget, Actor akCaster)

    Caster = akCaster
    isReady = true
    self.RegisterForUpdate(UpTime)
EndFunction

Function OnUpdate()

    If isReady && LastSM != Caster.GetAV("SpeedMult")

        Caster.ModAV("AttackDamageMult", -BonusDmg)
        LastSM = Caster.GetAV("SpeedMult")
        BonusDmg = ((Caster.GetAV("SpeedMult") - BonusDamageThreshold) * BonusDamageMult) / 100
        If BonusDmg >= BonusDamageCap / 100
            BonusDmg = BonusDamageCap / 100
        ElseIf Caster.GetAV("SpeedMult") <= BonusDamageThreshold
            BonusDmg = 0
        EndIf
        Caster.ModAV("AttackDamageMult", BonusDmg)
        If Caster == game.GetPlayer()
            Desc.SetValue(BonusDmg * 100)
        EndIf
    EndIf
EndFunction

Function OnEffectFinish(Actor akTarget, Actor akCaster)
    
    isReady = false
    self.UnregisterForUpdate()
    Caster.ModAV("AttackDamageMult", -BonusDmg)
EndFunction
