ScriptName Mirel_REUS_RemoveItemCairnSummonScript Extends ActiveMagicEffect
 
MiscObject Property ItemToAdd Auto
MiscObject Property ItemToAdd2 Auto
MiscObject Property ItemToRemove Auto
MiscObject Property ItemToRemove2 Auto
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