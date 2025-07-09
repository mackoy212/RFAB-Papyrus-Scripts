Scriptname RFAB_PerfectPotion extends ActiveMagicEffect  

string Property ActorValue Auto

RFAB_AttributeBonuses Property AttributeSystem Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    akTarget.SetActorValue(ActorValue, akTarget.GetBaseActorValue(ActorValue) + GetMagnitude())
    AttributeSystem.UpdateAttributeBonuses()
EndEvent