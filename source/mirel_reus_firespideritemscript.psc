ScriptName Mirel_REUS_FirespiderItemScript Extends ActiveMagicEffect
 
Ingredient Property ItemToAdd Auto
Ingredient Property ItemToAdd2 Auto
Ingredient Property ItemToRemove Auto
Ingredient Property ItemToRemove2 Auto
Int Property ItemCount = 1 Auto
Bool Property Silent = False Auto
 
Event OnEffectStart(Actor Target, Actor Caster)
    Caster.RemoveItem(ItemToRemove, ItemCount, Silent)
	Caster.RemoveItem(ItemToRemove2, ItemCount, Silent)
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
    Caster.AddItem(ItemToAdd, ItemCount, Silent)
	Caster.AddItem(ItemToAdd2, ItemCount, Silent)
EndEvent