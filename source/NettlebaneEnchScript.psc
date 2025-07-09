scriptName NettlebaneEnchScript extends activemagiceffect

Float Property Percent Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
    Float Damage = (akTarget.GetAV("Health") * Percent / 100)
    akTarget.DamageAV("Health", Damage)
EndFunction