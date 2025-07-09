Scriptname wezFloorTileScript extends ObjectReference  

ObjectReference[] Property TheLinker auto
ObjectReference Property IntroTrigger auto
hazard Property FireHazard auto
ObjectReference Property FireHazardRef auto

auto State IntroState
	Event OnActivate(ObjectReference akActionRef)
	    if (akActionRef == TheLinker[0] || akActionRef == TheLinker[1] || akActionRef == TheLinker[2] || akActionRef == TheLinker[3] || akActionRef == IntroTrigger)
	    	self.TranslateTo(self.GetPositionX(), self.GetPositionY(), self.GetPositionZ() + 125, 0.0, 0.0, 0.0, 35.0)
	    	ResolveLeveledHazard()
	    endif
	    GoToState("OnState")
	EndEvent
EndState

State OnState
	Event OnActivate(ObjectReference akActionRef)
	    if (akActionRef == TheLinker[0] || akActionRef == TheLinker[1] || akActionRef == TheLinker[2] || akActionRef == TheLinker[3])
	    	FireHazardRef = PlaceAtMe(FireHazard, 1)
	    	FireHazardRef.SetScale(2.0)
	    	GoToState("OffState")
	    endif
	EndEvent
EndState

State OffState
	Event OnActivate(ObjectReference akActionRef)
	    if (akActionRef == TheLinker[0] || akActionRef == TheLinker[1] || akActionRef == TheLinker[2] || akActionRef == TheLinker[3])
	    	FireHazardRef.Disable()
	    	GoToState("OnState")
	    endif
	EndEvent
EndState

int property LvlThreshold1 auto
int property LvlThreshold2 auto
int property LvlThreshold3 auto
int property LvlThreshold4 auto
int property LvlThreshold5 auto
hazard property TrapFirePlateFXHazDUPLICATE002 auto
hazard property TrapFirePlateFXHazDUPLICATE003 auto
hazard property TrapFirePlateFXHazDUPLICATE004 auto
hazard property TrapFirePlateFXHazDUPLICATE005 auto
hazard property TrapFirePlateFXHazDUPLICATE006 auto
hazard property TrapFirePlateFXHazDUPLICATE007 auto
hazard Property LvlHazard auto hidden


Function ResolveLeveledHazard()
	LvlHazard = TrapFirePlateFXHazDUPLICATE002

	if (LvlThreshold1 > Game.GetPlayer().GetLevel())
		LvlHazard = TrapFirePlateFXHazDUPLICATE003
	endif

	if (LvlThreshold2 > Game.GetPlayer().GetLevel())
		LvlHazard = TrapFirePlateFXHazDUPLICATE004
	endif

	if (LvlThreshold3 > Game.GetPlayer().GetLevel())
		LvlHazard = TrapFirePlateFXHazDUPLICATE005
	endif

	if (LvlThreshold4 > Game.GetPlayer().GetLevel())
		LvlHazard = TrapFirePlateFXHazDUPLICATE006
	endif

	if (LvlThreshold5 > Game.GetPlayer().GetLevel())
		LvlHazard = TrapFirePlateFXHazDUPLICATE007
	endif

	FireHazard = LvlHazard
EndFunction