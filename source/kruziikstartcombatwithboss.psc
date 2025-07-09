Scriptname KruziikStartCombatWithBoss extends ObjectReference  

Actor Property KruziikBoss auto

Event OnTriggerEnter(ObjectReference akActionRef)
    if (akActionRef == Game.GetPlayer())
    	KruziikBoss.StartCombat(Game.GetPlayer())
    endif
EndEvent