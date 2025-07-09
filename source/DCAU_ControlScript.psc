Scriptname DCAU_ControlScript extends Quest Conditional

Bool Property bDCAUBusy = False Auto Hidden Conditional

GlobalVariable Property DCAUSpeed Auto	;new in version 1.1
DCAU_Thread01 Property Thread01 Auto	;new in version 1.1
DCAU_Thread02 Property Thread02 Auto	;new in version 1.1
DCAU_Thread03 Property Thread03 Auto	;new in version 1.1

Function SolveDoor(Actor akActor, ObjectReference KeyholeRef)
	if akActor.GetItemCount((KeyholeRef as HallofStoriesKeyholeScript).myMiscObject) >= 1
		bDCAUBusy = True
		if DCAUSpeed.GetValue() == 1.0														;new in version 1.1, Sequential Solve
			while (KeyholeRef as HallofStoriesKeyholeScript).numRingsSolved < 3
				SolveRing((KeyholeRef as HallofStoriesKeyholeScript).largeRing, akActor)
				SolveRing((KeyholeRef as HallofStoriesKeyholeScript).mediumRing, akActor)
				SolveRing((KeyholeRef as HallofStoriesKeyholeScript).smallRing, akActor)
				Utility.Wait(0.1)
			endwhile
		elseif DCAUSpeed.GetValue() == 2.0													;new in version 1.1, Simultaneous Solve
			Thread01.CueRing(KeyholeRef, (KeyholeRef as HallofStoriesKeyholeScript).largeRing, akActor)
			Thread02.CueRing(KeyholeRef, (KeyholeRef as HallofStoriesKeyholeScript).mediumRing, akActor)
			Thread03.CueRing(KeyholeRef, (KeyholeRef as HallofStoriesKeyholeScript).smallRing, akActor)
			while (KeyholeRef as HallofStoriesKeyholeScript).numRingsSolved < 3
				Utility.Wait(0.1)
			endwhile
			while (((KeyholeRef as HallofStoriesKeyholeScript).largeRing) as HallofStoriesDiskScript).GetState() == "busy" || (((KeyholeRef as HallofStoriesKeyholeScript).mediumRing) as HallofStoriesDiskScript).GetState() == "busy" || (((KeyholeRef as HallofStoriesKeyholeScript).smallRing) as HallofStoriesDiskScript).GetState() == "busy"
				Utility.Wait(0.1)	;need to wait whilst rings are translating, since the numRingsSolved variable gets updated at the top of the function
			endwhile
		elseif DCAUSpeed.GetValue() == 3.0													;new in version 1.1, Instant Solve
			(KeyholeRef as HallofStoriesKeyholeScript).activationAlwaysSucceeds = True
		endif
		CompletePuzzleDoor(KeyholeRef)
		bDCAUBusy = False
	else
		(KeyholeRef as HallofStoriesKeyholeScript).OnActivate(akActor)
	endif
EndFunction

Function SolveRing(ObjectReference Ring, Actor akActor)
	Int iSolveState = (Ring as HallofStoriesDiskScript).solveState
	string sSolveState = "position0"+iSolveState
	if (Ring as HallofStoriesDiskScript).GetState() == sSolveState
		;already in solved state
	else
		(Ring as HallofStoriesDiskScript).OnActivate(akActor)	;sending this during the "busy" state is fine, good even.
	endif
EndFunction

Function CompletePuzzleDoor(ObjectReference KeyholeRef)
	(KeyholeRef as HallofStoriesKeyholeScript).GoToState("busy")
	(KeyholeRef as HallofStoriesKeyholeScript).PlayAnimation("Trigger01")
	Utility.Wait(3.0)
	(KeyholeRef as HallofStoriesKeyholeScript).checkSuccess()
EndFunction