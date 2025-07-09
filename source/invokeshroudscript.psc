scriptName InvokeShroudScript extends activemagiceffect

Keyword property MagicDamageFrost auto
Keyword property SoulWinterWaveBlock auto
Keyword property REQ_KW_SpellConcentration auto
Spell property Breath auto
MagicEffect property SoulOfWinterIsActive auto
Actor Caster

Event OnEffectStart(Actor akTarget, Actor akCaster)
	PO3_Events_AME.RegisterForMagicEffectApplyEx(self, MagicDamageFrost, true)
	Caster = akCaster
EndEvent

Event OnMagicEffectApplyEx(ObjectReference akCaster, MagicEffect akEffect, Form akSource, bool abApplied)
	if !akEffect.HasKeyword(SoulWinterWaveBlock) && !akEffect.HasKeyword(REQ_KW_SpellConcentration) && Caster.HasMagicEffect(SoulOfWinterIsActive)
		Breath.Cast(Caster)
	endif
EndEvent