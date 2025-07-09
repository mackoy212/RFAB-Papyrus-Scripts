Scriptname RFAB_CastSpell_BetweenBoxes extends ActiveMagicEffect  

ObjectReference[] Property Box  Auto  
SPELL[] Property mySpell  Auto  
Actor Property Player  Auto  
Int Property Delay Auto
Int Property MaxDistance Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	int i = 0
	int a = 0

		while akTarget.isInCombat() 
			
			while akTarget.GetDistance(Player as ObjectReference) > 1400 && akTarget.isInCombat( )&& akTarget.GetDistance(Game.GetPlayer()) < MaxDistance && !Game.GetPlayer().IsInInterior() && a<10
				Utility.wait(0.5)
				a+=1
			endwhile

			while a>=10
				Box[i].MoveTo(Player as ObjectReference, 0 as float, 0 as float, 1500 as float)
				Box[i+1].MoveTo(Player as ObjectReference, 0 as float, 0 as float, 0 as float)
				Myspell[i].Cast(Box[i], Box[i+1])
				Utility.wait(Delay)
				Myspell[i+1].Cast( Box[i+1])
				a = 0	
			endwhile

		endwhile

endevent
