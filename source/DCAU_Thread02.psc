Scriptname DCAU_Thread02 extends Quest  

ObjectReference KeyholeRef
ObjectReference RingRef
String sSolveState
Actor akActor

Function CueRing(ObjectReference Keyhole, ObjectReference Ring, Actor ActorRef)
	KeyholeRef = Keyhole
	akActor = ActorRef
	RingRef = Ring
	sSolveState = "position0"+(RingRef as HallofStoriesDiskScript).solveState
	RegisterForSingleUpdate(0.01)
EndFunction

Event OnUpdate()
	while (RingRef as HallofStoriesDiskScript).GetState() != sSolveState
		(RingRef as HallofStoriesDiskScript).OnActivate(akActor)
		Utility.Wait(0.1)
	endwhile
	sSolveState = ""		;cleanup
	KeyholeRef = None
	RingRef = None
	akActor = None
EndEvent