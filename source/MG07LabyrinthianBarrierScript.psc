Scriptname MG07LabyrinthianBarrierScript extends ObjectReference  
{Small script to do some setup handling for the MG07 Boss Scene}

spell property VampireDrain01 auto
objectReference property Target01 auto
objectReference property Target02 auto
objectReference property castSource auto
weapon property MG07StaffofMagnus auto
objectReference property Morokei auto
objectReference property Barrier auto

objectReference[] property collisionmarkers auto



Actor Property Thrall1  Auto  
Actor Property Thrall2  Auto  


EVENT onLoad()
	while self.is3Dloaded() == FALSE
		utility.wait(1.0)
	endWhile


	Barrier.playAnimation("playAnim02")

;	(Morokei as actor).equipItem(MG07StaffofMagnus, TRUE)
	(Morokei as actor).setghost(true)
	Thrall1.SetDontMove()
	Thrall2.SetDontMove()

	Thrall1.EnableAI(false)
	Thrall2.EnableAI(false)

	(Morokei as actor).EnableAI(false)
	VampireDrain01.cast(Target01 ,castSource )
	VampireDrain01.cast( Target02 , castSource )

	while !Thrall1.IsDead() || !Thrall2.IsDead()
		if Thrall1.IsDead() 
			Target01 .interruptcast()
		elseif Thrall2.IsDead() 
			Target02 .interruptcast()
		endif
		utility.wait(0.5)
			
	endwhile

	int i = 0
	while i < collisionmarkers.length
		collisionmarkers[i].delete()
		i = i + 1
	endwhile
	Target01 .interruptcast()
	Target02 .interruptcast()
	Barrier.playAnimation("playAnim01")
	utility.wait(1.0)
	(Morokei as actor).EnableAI()
	(Morokei as actor).setghost(false)
	(Morokei as actor).StartCombat(game.getplayer())
	Barrier.delete()	
	
endEVENT


