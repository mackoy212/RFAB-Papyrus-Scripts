Scriptname BosmerAbilityScript extends ActiveMagicEffect

ReferenceAlias Property Animal Auto
GlobalVariable Property AnimalCount Auto
Spell Property AnimalBuff Auto
Spell Property CloackSpell Auto
Spell Property ResetCloack Auto
ReferenceAlias[] Property SkeleportQueue Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)

    Actor AnimalRef = Animal.GetRef() as Actor
    If AnimalCount.GetValue() < 1
        If  game.GetPlayer().HasSpell(ResetCloack) == 0
            game.GetPlayer().AddSpell(ResetCloack, false)
        EndIf
        AnimalCount.SetValue(1)
        akTarget.StopCombat()
        akTarget.SetPlayerTeammate(true, false)
        Animal.ForceRefTo(akTarget)
        akTarget.RestoreAV("Health", 99999)
        akTarget.AddSpell(CloackSpell, false)
        akTarget.AddSpell(AnimalBuff, false)
    ElseIf akTarget.IsHostileToActor(game.GetPlayer()) != 1 && akTarget == AnimalRef
        AnimalCount.SetValue(0) 
        akTarget.SetPlayerTeammate(false, false)
        Animal.Clear()
        Int i = 0
        Actor TempActor
	    While i < SkeleportQueue.Length
            If SkeleportQueue[i]
                TempActor = SkeleportQueue[i].GetRef() as Actor
                If TempActor
                    SkeleportQueue[i].Clear()
                EndIf
            EndIf
        i += 1
        EndWhile
        akTarget.RemoveSpell(CloackSpell)
        akTarget.RemoveSpell(AnimalBuff)
        akTarget.StopCombat()
        akTarget.EnableAI(false)
        utility.wait(3.0)
        akTarget.EnableAI(true)
    ElseIf akTarget.IsHostileToActor(game.GetPlayer()) == 1 && akTarget == AnimalRef
        akTarget.StopCombat()
    EndIf
EndFunction