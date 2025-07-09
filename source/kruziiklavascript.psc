Scriptname KruziikLavaScript extends ObjectReference  

keyword property dunCGMagicHeavyFire auto
explosion property dunCGTrapFireTriggerExplosion01 auto
actor Property Guardian_Of_Kruziik auto
KruziikBossScript Property BossScript auto
GlobalVariable Property KruziikTeleportGlobal auto

event onTrigger(objectReference triggerRef)
	if triggerRef as actor && !(triggerRef as actor).isDead() && (triggerRef as actor) != Guardian_Of_Kruziik
		if !(triggerRef as actor).HasMagicEffectWithKeyword(dunCGMagicHeavyFire)
			triggerRef.placeAtMe(dunCGTrapFireTriggerExplosion01)
			(triggerRef as actor).SetAV("health", ((triggerRef as actor).GetAV("health") - ((triggerRef as actor).GetBaseAV("health") * 0.33)))
		endif
	elseif (triggerRef as actor) == Guardian_Of_Kruziik && KruziikTeleportGlobal.GetValue() == 0
		BossScript.Teleport_To_Player()
	endif
endEvent