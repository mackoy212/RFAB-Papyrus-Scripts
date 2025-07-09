ScriptName ColdEyeCloackScript Extends objectreference

Spell Property FrostCloack auto
Spell Property FrostCloack2 auto
Perk Property FrostMastery auto

Event OnEquipped(Actor akActor)
  if akActor.HasSpell(FrostCloack) && akActor.HasPerk(FrostMastery)
    akActor.RemoveSpell(FrostCloack)
    akActor.AddSpell(FrostCloack2, false)
  endIf
EndEvent

Event OnUnequipped(Actor akActor)
  if akActor.HasSpell(FrostCloack2)
    akActor.RemoveSpell(FrostCloack2)
    akActor.AddSpell(FrostCloack, false)
  endif
EndEvent
