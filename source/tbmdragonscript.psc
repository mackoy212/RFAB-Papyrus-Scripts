Scriptname tbmDragonScript extends Actor

Event OnInit()
	;debug.trace("dragon init has been fired")
	self.SetAllowFlying(false)
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	If (aeCombatState == 1)
		self.SetAllowFlying(false)
		
		RegisterForUpdate(5)
	Else
		UnregisterForUpdate()
	EndIf
EndEvent

Event OnUpdate()
	If (self.IsDead())
		UnregisterForUpdate()
	EndIf

	If (Utility.RandomFloat() > GetActorValuePercentage("health"))
		healSpell.Cast(self, self)
		return
	EndIf

	If (Utility.RandomFloat() > 0.8)
		meteorShowerSpell.Cast(self, Game.GetPlayer())
		return
	EndIf
EndEvent

SPELL Property meteorShowerSpell  Auto
Spell Property healSpell Auto

