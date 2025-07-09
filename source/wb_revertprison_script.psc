Scriptname WB_RevertPrison_Script extends ObjectReference  

; -----

Spell Property WB_A050_LocateObject_Spell_PC Auto
Actor Property PlayerRef Auto
VisualEffect Property WB_AlterationAlt_VFX_Collapse Auto
Sound Property WB_AlterationBaleful_Marker_Explosion_Subsonic Auto
ReferenceAlias Property WB_Victim Auto

; -----

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	If akOldContainer == PlayerRef && akNewContainer != PlayerRef
		akNewContainer.RemoveItem(Self.GetBaseObject(), 1)
		Actor PreviousVictim = WB_Victim.GetActorReference()
		PreviousVictim.MoveTo(PlayerRef)
		WB_AlterationBaleful_Marker_Explosion_Subsonic.Play(PreviousVictim)
		PreviousVictim.PlaceAtMe(WB_AlterationAlt_VFX_Collapse)
		PreviousVictim.StartCombat(PlayerRef)
	EndIf

EndEvent

; -----