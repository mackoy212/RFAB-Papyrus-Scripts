Scriptname WB_PathOfPillars_Spawner_Script extends ObjectReference  

; ------

Actor Property PlayerRef Auto
Float Property WB_Speed Auto
Float Property WB_Z Auto
Activator[] Property WB_AlterationAlt_Activator_NaturalBarrier_Tree Auto

; ------

ObjectReference ThePillar

; -----

Event OnLoad()

	ThePillar = Self.PlaceAtMe(WB_AlterationAlt_Activator_NaturalBarrier_Tree[Utility.RandomInt(0,2)], 1, false, true)
	ThePillar.MoveTo(Self, 0, 0, WB_Z)
	ThePillar.SetScale(Utility.RandomFloat(0.35, 0.45))
	ThePillar.Enable()
	ThePillar.TranslateToRef(Self, WB_Speed)
	ThePillar.MoveTo(Self)
	Delete()

EndEvent

; ------