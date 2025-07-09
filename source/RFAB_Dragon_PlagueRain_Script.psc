Scriptname RFAB_Dragon_PlagueRain_Script extends ActiveMagicEffect  

ObjectReference[] Property Box  Auto  

SPELL[] Property mySpell  Auto  

Actor Property Player  Auto  

Float Property Period Auto

Int Property MaxCount Auto

Int Property MaxDistance Auto



Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	while akTarget.isInCombat() && akTarget.GetDistance(Game.GetPlayer()) < MaxDistance && !Game.GetPlayer().IsInInterior() && !Game.GetPlayer().HasMagicEffect(ClearSkiesEffect)

		Float Cooldown = Utility.RandomFloat(20.0, 35.0)
		Utility.wait(Cooldown)

		int Count = 0
		int i = 0

		while akTarget.isInCombat() && Count<MaxCount && !Game.GetPlayer().HasMagicEffect(ClearSkiesEffect)
			Float X = Utility.RandomFloat(-600.0, 600.0)
			Float Y = Utility.RandomFloat(-600.0, 600.0)
			Box[i].MoveTo(Player as ObjectReference, X as float, Y as float, 3500 as float)
			Box[i+1].MoveTo(Player as ObjectReference, X as float, Y as float, 0 as float)
			int Type = Utility.RandomInt(0, MySpell.length)
			Myspell[Type].Cast(Box[i], Box[i+1])
			Utility.wait(Period)
			Count+=1
		endwhile

	endwhile

endevent

		
MagicEffect Property ClearSkiesEffect  Auto  
