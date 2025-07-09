Scriptname RFAB_Dragon_Crystal_Script extends activemagiceffect  

Activator Property CrystalModel  Auto  
ObjectReference Property Box  Auto  
SPELL Property SpellToCast  Auto  
Actor Property Player  Auto
Int Property Timer Auto
Int Property MaxDistance Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

int a = 0

	while akTarget.isInCombat() && akTarget.IsFlying() && akTarget.GetDistance(Game.GetPlayer()) < MaxDistance && !Game.GetPlayer().IsInInterior()
	
		while akTarget.isInCombat() && akTarget.IsFlying() && akTarget.GetDistance(Game.GetPlayer()) < MaxDistance && !Game.GetPlayer().IsInInterior() && a<Timer
			Utility.wait(0.5)
			a+=1
		endwhile
		
		if (a>=Timer)

			a = 0
			Box.MoveTo(Player as ObjectReference, 0 as float, 0 as float, 80 as float)
			ObjectReference MyMarker = Box.PlaceAtMe(CrystalModel)
			MyMarker.SetScale(2.0)
			MyMarker.SetAngle(0,0,0)
			Utility.Wait(1.5)
			SpellToCast.RemoteCast(MyMarker, akTarget)
			MyMarker.Delete()


		endif

	endwhile

endevent
	