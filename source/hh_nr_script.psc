Scriptname HH_NR_Script extends ActiveMagicEffect 
 
EffectShader property MagicEffectShader auto ;shockdisintegrate01fxs
activator property AshPileObject auto
MiscObject Property Misc1  Auto

Auto State DoOnceState
	Event onEffectStart(actor Target, actor Caster)
		
		If Target.IsDead()
			MagicEffectShader.Play(Target, 10)
			Utility.Wait(2)
			Target.AttachAshPile(AshPileObject as form)
			Target.SetAlpha(0.000000, true)
			Target.SetCriticalStage(Target.CritStage_DisintegrateEnd)
			if Target.getItemCount(Misc1) == 0
				Target.additem(Misc1,1)
			endif
		endif
	  
	GoToState ("DoNothingState")

	EndEvent
EndState

State DoNothingState
EndState
 

 