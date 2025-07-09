Scriptname RFAB_BoundWeapon_ElementalDamage extends ActiveMagicEffect  

import PO3_Events_AME 

Spell[] Property ElementalDamageSpell Auto
Perk[] Property MysticalPerks Auto
;==========================================
Int Property StartValue = 0 Auto
Int[] Property DamageModificators Auto

KeyWord Property BoundKeyword Auto

Actor Caster
Event OnPlayerLoadGame()
    CalculateDamage()
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Caster = akCaster
    if Caster != Game.GetPlayer()
        return
    endif
    CalculateDamage()
    RegisterForWeaponHit(self as ActiveMagicEffect)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    UnRegisterForWeaponHit(self as ActiveMagicEffect)
EndEvent

Event OnWeaponHit(ObjectReference akTarget, Form akSource, Projectile akProjectile, Int aiHitFlagMask)
    if akSource.HasKeyword(BoundKeyword)
        int Iteration = ElementalDamageSpell.Length
        while Iteration
            Iteration -= 1
            ElementalDamageSpell[Iteration].Cast(Caster, akTarget)
        endwhile
    endif
EndEvent

Function CalculateDamage()
    int Iteration = ElementalDamageSpell.Length
    float DamageValue = Caster.GetBaseActorValue("Magicka") * GetModifier()
    while Iteration
        Iteration -= 1
        ElementalDamageSpell[Iteration].SetNthEffectMagnitude(0, DamageValue)
    endwhile
EndFunction

float Function GetModifier()
    float ReturnedValue = StartValue
    int Iteration = 0
    while Iteration < MysticalPerks.Length
        if Caster.HasPerk(MysticalPerks[Iteration])
            ReturnedValue = DamageModificators[Iteration]
        endif
        Iteration += 1
    endwhile
    return ReturnedValue / 100
EndFunction