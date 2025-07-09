Scriptname RFAB_HumanDragonPriest_Resurrect extends ObjectReference  

Actor property DragonPriest auto


Explosion Property ResExplosion  Auto  
Explosion Property ResExplosion2  Auto  

SoulGem Property SoulGemForTriggerCloak  Auto  

Event OnActivate(ObjectReference akActionRef)
	int i = 0
	if akActionRef != Game.GetPlayer()
		DragonPriest .placeatme(ResExplosion  )	

		utility.wait(0.5)
		DragonPriest .enable(true)

		DragonPriest .placeatme(ResExplosion2 )	
		while i<4
			utility.wait(0.2)
			DragonPriest .placeatme(ResExplosion  )	
			i = i+1
		endwhile
		DragonPriest .resurrect()
		DragonPriest .additem(SoulGemForTriggerCloak  ,1)
	endif
	
	


endevent






