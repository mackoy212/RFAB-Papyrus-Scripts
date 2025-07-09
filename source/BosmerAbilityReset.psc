Scriptname BosmerAbilityReset extends ActiveMagicEffect

Spell Property BuffSpell Auto
Spell Property CloackSpell Auto
ReferenceAlias Property Animal Auto

Event OnEffectStart(actor akTarget, actor akCaster)

    Actor AnimalRef = Animal.GetRef() as Actor
    If akTarget == AnimalRef
        akTarget.AddSpell(BuffSpell, false)
        akTarget.AddSpell(CloackSpell, false)
    EndIf
EndEvent