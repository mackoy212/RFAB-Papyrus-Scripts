Scriptname WB_Battlemage_Spell_Script extends ActiveMagicEffect  

; -----

Spell[] Property WB_Spell Auto
VisualEffect[] Property WB_ConjurationDwemer_VFX_Battlemage Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Element Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Element_Max Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_DamageBonusPct Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_SpellBonusPct Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_Health Auto
GlobalVariable Property WB_Conjuration_ConjureBattlemage_Global_Upgrade_Magicka Auto
Float Property WB_BaseStats Auto

; -----

Int TheInt

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	TheInt = Utility.RandomInt(0, WB_Conjuration_ConjureBattlemage_Global_Element_Max.GetValue() as Int)
	Spell TheSpell = WB_Spell[TheInt]
	akTarget.AddSpell(TheSpell)
	akTarget.EquipSpell(TheSpell, 0)
	akTarget.EquipSpell(TheSpell, 1)
	WB_ConjurationDwemer_VFX_Battlemage[TheInt].Play(akTarget, -1)

	akTarget.SetActorValue("Variable01", WB_Conjuration_ConjureBattlemage_Global_Upgrade_DamageBonusPct.GetValue())
	akTarget.SetActorValue("Variable02", WB_Conjuration_ConjureBattlemage_Global_Upgrade_SpellBonusPct.GetValue())

	akTarget.SetActorValue("Health", WB_BaseStats + WB_Conjuration_ConjureBattlemage_Global_Upgrade_Health.GetValue())
	akTarget.SetActorValue("Magicka", WB_BaseStats + WB_Conjuration_ConjureBattlemage_Global_Upgrade_Magicka.GetValue())

EndEvent

; -----

Event OnDeath(Actor akKiller)

	WB_ConjurationDwemer_VFX_Battlemage[TheInt].Stop(GetTargetActor())

EndEvent

; -----

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	WB_ConjurationDwemer_VFX_Battlemage[TheInt].Stop(akTarget)

EndEvent

; -----