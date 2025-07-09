Scriptname VokunHorrorScript extends ObjectReference  

actor property horror auto
objectreference property Start auto
Event OnLoad()
		

		float speed = 30
		horror.moveto(Start )
		horror .setactorvalue("speedmult", speed)
		horror.KeepOffsetFromActor(Game.GetPlayer(), 0, 0, 0)
		while !horror .isdead()
			utility.wait(1.0)
			speed = speed + 3.5
			horror .setactorvalue("speedmult", speed)
			horror.KeepOffsetFromActor(Game.GetPlayer(), 0, 0, 0)

		endwhile

endevent
