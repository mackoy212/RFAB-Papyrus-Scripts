Scriptname ALP_QP_QuestMonitor_Script extends ActiveMagicEffect
{Common script used as a template by all monitor perks}


Actor Property PlayerRef Auto

Perk Property SelfMonitorPerk Auto

Perk Property PerkRef = None Auto

Spell Property SpellRef = None Auto

Spell Property SpellRef2 = None Auto

Message Property MessageRef = None Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; Debug.Notification("Quest Monitor starting")
	if(PerkRef != None)
		; Debug.Notification("Added a perk")
		PlayerRef.AddPerk(PerkRef)
	EndIf
	if(SpellRef != None)
		; Debug.Notification("Added a spell/power silently")
		PlayerRef.AddSpell(SpellRef, False)
		PlayerRef.AddSpell(SpellRef2, False)
	EndIf
	if(MessageRef != None)
		MessageRef.Show()
	EndIf
	PlayerRef.RemovePerk(SelfMonitorPerk)
EndEvent