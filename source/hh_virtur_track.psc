Scriptname HH_virtur_track extends activemagiceffect  
ObjectReference Property Throne  Auto  
ObjectReference Property To_tp  Auto  
ObjectReference Property Cent Auto  
SPELL Property Bats  Auto 


Event OnEffectStart(Actor akTarget, Actor akCaster)
;Debug.MessageBox("OnEffectStart")
		if (akTarget.GetPositionZ()) > 9027.0
			akTarget.DoCombatSpellApply(Bats, akTarget)
			Utility.WaitMenuMode(0.5)
			akTarget.MoveTo(To_tp)
		endIf
 		if (akTarget.GetPositionZ()) < 8770.0
			akTarget.DoCombatSpellApply(Bats, akTarget)
			Utility.WaitMenuMode(0.5)
			akTarget.MoveTo(To_tp)
		endIf
 		if akTarget.GetDistance(Cent)<=200
			akTarget.DoCombatSpellApply(Bats, akTarget)
			Utility.WaitMenuMode(0.5)
			akTarget.MoveTo(To_tp)
		endIf
EndEvent