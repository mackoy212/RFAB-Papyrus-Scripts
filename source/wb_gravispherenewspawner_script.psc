Scriptname WB_GravisphereNewSpawner_Script extends ObjectReference  

; -----

Activator Property WB_AlterationTelekinesis_Activator_Gravisphere_Ball Auto

; -----

Event OnLoad()

	ObjectReference TheBox = PlaceAtMe(WB_AlterationTelekinesis_Activator_Gravisphere_Ball)
	TheBox.MoveTo(Self, 0, 0, 64)
	Delete()

EndEvent

; -----