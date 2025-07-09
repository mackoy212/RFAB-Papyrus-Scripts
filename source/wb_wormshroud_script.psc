Scriptname WB_WormShroud_Script extends ActiveMagicEffect  

; ------

VisualEffect Property WB_RestorationNecro_VFX_WormShroud Auto
Spell Property WB_S_R100_WormShroud_Spell_Proc_PC Auto
ImpactDataSet Property WB_RestorationNecro_ImpactSet Auto
ImagespaceModifier Property WB_RestorationNecro_Imod_WormShroud Auto
Activator Property WB_AshPile Auto
Float Property WB_Wait Auto

; -----

Event OnEffectStart(Actor akTarget, Actor akCaster)

	RegisterForSingleUpdate(WB_Wait)

EndEvent

; ------

Event OnUpdate()

	Actor akTarget = GetTargetActor()
	Actor akCaster = GetCasterActor()
	WB_RestorationNecro_Imod_WormShroud.Apply()
	akTarget.PlayImpactEffect(WB_RestorationNecro_ImpactSet)
	WB_RestorationNecro_VFX_WormShroud.Play(akTarget)
	akCaster.DoCombatSpellApply(WB_S_R100_WormShroud_Spell_Proc_PC, akCaster)

	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateStart)
	akTarget.SetAlpha (0.0,True)
	akTarget.AttachAshPile(WB_AshPile)
	akTarget.SetCriticalStage(akTarget.CritStage_DisintegrateEnd)

EndEvent

; -----