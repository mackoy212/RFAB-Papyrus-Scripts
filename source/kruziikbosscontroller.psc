Scriptname KruziikBossController extends ObjectReference  

ObjectReference Property StartTrigger auto
ObjectReference Property Activator_Up auto
ObjectReference Property Activator_Down auto
ObjectReference[] Property TileArray auto
KruziikBossScript Property BossScript auto
float Property SpeedFloat = 20.0 auto
Int Pattern_Number
Int Last_Pattern_Number
int PatternCount
bool FightStarted

;-------PATTERN BOOLS--------;
	Bool[] Property Pattern1Array Auto
	Bool[] Property Pattern2Array Auto
	Bool[] Property Pattern3Array Auto
	Bool[] Property Pattern4Array Auto
	Bool[] Property Pattern5Array Auto
	Bool[] Property Pattern6Array Auto

Event OnActivate(ObjectReference akActionRef)
    if (akActionRef == StartTrigger)
    	FightStarted = true
    endif
EndEvent

Event OnCellAttach()
	PickPattern()
	PatternLoop()
EndEvent


Function PatternLoop()
	if (PatternCount <= 3)
		SpeedFloat = 20

		if (BossScript.GetState() != "OnGround" && FightStarted)
			BossScript.GoToState("OnGround")
		endif
		utility.wait(20)
	elseif (PatternCount > 3 && PatternCount <= 10)
		SpeedFloat = 40

		if (BossScript.GetState() != "OnTop" && FightStarted)
			BossScript.GoToState("OnTop")
		endif
		Utility.wait(8)
	else
		SpeedFloat = 20
		utility.wait(20)
		PatternCount = 0
	endif

	if (FightStarted)
		PatternCount += 1
	endif

	PickPattern()
	PatternLoop()
EndFunction

Function PickPattern()
	Debug.MessageBox("Picking Pattern")
	while (Last_Pattern_Number == Pattern_Number)
		Pattern_Number = Utility.RandomInt(1, 6)
	endwhile
	Last_Pattern_Number = Pattern_Number

	if (Pattern_Number == 1)
		Pattern1()
	elseif (Pattern_Number == 2)
		Pattern2()
	elseif (Pattern_Number == 3)
		Pattern3()
	elseif (Pattern_Number == 4)
		Pattern4()
	elseif (Pattern_Number == 5)
		Pattern5()
	elseif (Pattern_Number == 6)
		Pattern6()
	endif

EndFunction



;----------PATTERNS-----------;
	Function Pattern1()
		int i

		while (i <= 22)
			if (Pattern1Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction

	Function Pattern2()
		int i

		while (i <= 22)
			if (Pattern2Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction

	Function Pattern3()
		int i

		while (i <= 22)
			if (Pattern3Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction

	Function Pattern4()
		int i

		while (i <= 22)
			if (Pattern4Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction

	Function Pattern5()
		int i

		while (i <= 22)
			if (Pattern5Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction

	Function Pattern6()
		int i

		while (i <= 22)
			if (Pattern6Array[i])
				TileArray[i].Activate(Activator_Up)
			else
				TileArray[i].Activate(Activator_Down)
			endif

			i += 1
		endwhile

	EndFunction