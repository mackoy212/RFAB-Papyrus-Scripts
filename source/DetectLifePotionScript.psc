Scriptname DetectLifePotionScript extends ActiveMagicEffect

Spell Property DetectLifeSpell Auto

Event OnEffectStart(actor akTarget, actor akCaster)

    Int i = 0
    While i < 4
        DetectLifeSpell.SetNthEffectDuration(i, self.GetMagnitude() as Int)
        i += 1
    EndWhile
    DetectLifeSpell.Cast(akCaster)
EndEvent