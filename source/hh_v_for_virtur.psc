Scriptname HH_V_FOR_VIRTUR extends ReferenceAlias  

Actor Property Virtur  Auto  
VisualEffect Property Summon  Auto  
ObjectReference Property Throne  Auto  
ObjectReference Property To_tp  Auto  
SPELL Property Bats  Auto  
int count = 0 
SPELL Property HH_for_v  Auto  

Event OnInIt()
RegisterForAnimationEvent(Virtur, "weaponSwing")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		if (akSource == Virtur) && (asEventName == "weaponSwing") && (Game.GetPlayer().GetCombatState() == 1)&& Game.GetPlayer().GetDistance(Virtur)>=200
		RegisterForSingleUpdate(10.0)
   		int random5 = Utility.RandomInt(0, 25)
		if random5 ==1
		;Virtur.StartCombat(Game.GetPlayer())
		Virtur.DoCombatSpellApply(Bats, Virtur)
		Virtur.SetPosition((Game.GetPlayer().GetPositionX()- 100 * Math.Sin(Game.GetPlayer().GetAngleZ())) , (Game.GetPlayer().GetPositionY()- 100 * Math.Cos(Game.GetPlayer().GetAngleZ())) , Game.GetPlayer().GetPositionZ())
		Utility.WaitMenuMode(1)
		if (Virtur.GetPositionZ()) < 8771.0 || (Virtur.GetPositionZ()) > 9027.0
			Virtur.DoCombatSpellApply(Bats, Virtur)
			Utility.WaitMenuMode(0.5)
			Virtur.MoveTo(To_tp)
		endif
	endif
	EndIf
	if (akSource == Virtur) && (asEventName == "weaponSwing") && (Game.GetPlayer().GetCombatState() == 1)&& count == 0 
	count=1 
	;Debug.MessageBox("count=1")
	RegisterForSingleUpdate(10.0)
	EndIf
endEvent

Event OnSpellCast(Form akSpell)
	;Debug.MessageBox("OnSpellCast!")
	int random1 = Utility.RandomInt(0, 10)
	if random1 ==1 && (Game.GetPlayer().GetCombatState() == 1)
		;Virtur.StartCombat(Game.GetPlayer())
		Virtur.DoCombatSpellApply(Bats, Virtur)
		Virtur.SetPosition((Game.GetPlayer().GetPositionX()- 100 * Math.Sin(Game.GetPlayer().GetAngleZ())) , (Game.GetPlayer().GetPositionY()- 100 * Math.Cos(Game.GetPlayer().GetAngleZ())) , Game.GetPlayer().GetPositionZ())
		Utility.WaitMenuMode(1)
		if (Virtur.GetPositionZ()) < 8771.0 || (Virtur.GetPositionZ()) > 9027.0
			Virtur.DoCombatSpellApply(Bats, Virtur)
			Utility.WaitMenuMode(0.5)
			Virtur.MoveTo(To_tp)
		endif
	endif
	RegisterForSingleUpdate(10.0)
endEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
  int random2 = Utility.RandomInt(0, 25)
	if random2 ==1 && ( Game.GetPlayer().GetCombatState() == 1 )&& Game.GetPlayer().GetDistance(Virtur)>=200
		;Virtur.StartCombat(Game.GetPlayer())
		Virtur.DoCombatSpellApply(Bats, Virtur)
		Virtur.SetPosition((Game.GetPlayer().GetPositionX()- 100 * Math.Sin(Game.GetPlayer().GetAngleZ())) , (Game.GetPlayer().GetPositionY()- 100 * Math.Cos(Game.GetPlayer().GetAngleZ())) , Game.GetPlayer().GetPositionZ())
		Utility.WaitMenuMode(1)
		if (Virtur.GetPositionZ()) < 8771.0 || (Virtur.GetPositionZ()) > 9027.0
			Virtur.DoCombatSpellApply(Bats, Virtur)
			Utility.WaitMenuMode(0.5)
			Virtur.MoveTo(To_tp)
		endif
	endif
	RegisterForSingleUpdate(10.0)
  ;Debug.MessageBox("OnHit!")
  if Virtur.GetDistance(Throne)>=3225
  ;Debug.MessageBox("GetDistance(Throne)>=3225!")
  Virtur.DoCombatSpellApply(Bats, Virtur)
  Utility.WaitMenuMode(0.5)
  Virtur.MoveTo(To_tp)
  endif
EndEvent

Event OnUpdate() ; This event occurs every five seconds		
	int random3 = Utility.RandomInt(0, 3)
	if random3 ==1 && ( Game.GetPlayer().GetCombatState() == 1 )&& Game.GetPlayer().GetDistance(Virtur)>=200 && Game.GetPlayer().GetDistance(Throne)<=3100
		;Virtur.StartCombat(Game.GetPlayer())
		Virtur.DoCombatSpellApply(Bats, Virtur)
		Virtur.SetPosition((Game.GetPlayer().GetPositionX()- 100 * Math.Sin(Game.GetPlayer().GetAngleZ())) , (Game.GetPlayer().GetPositionY()- 100 * Math.Cos(Game.GetPlayer().GetAngleZ())) , Game.GetPlayer().GetPositionZ())
		Utility.WaitMenuMode(1)
		if (Virtur.GetPositionZ()) < 8771.0 || (Virtur.GetPositionZ()) > 9027.0
			Virtur.DoCombatSpellApply(Bats, Virtur)
			Utility.WaitMenuMode(0.5)
			Virtur.MoveTo(To_tp)
		endif
		endif
	RegisterForSingleUpdate(2.0)
	Virtur.DoCombatSpellApply(HH_for_v, Virtur)
EndEvent

Event OnDying(Actor akKiller)
UnregisterForUpdate()
UnregisterForAnimationEvent(Virtur, "weaponSwing")
;Debug.MessageBox("умер")
EndEvent