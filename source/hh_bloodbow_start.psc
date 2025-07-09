Scriptname HH_Bloodbow_start extends ActiveMagicEffect  
SPELL Property HH_HP_DRAIN  Auto 
float fDiffMultHPToPCL
Float setM
float skill ; 8 \ 7 \ 6 \ 5 при  0-25 \ 25-50 \ 50-75 \ 75+
Event OnEffectStart(Actor akTarget, Actor akCaster)
fDiffMultHPToPCL = Game.GetGameSettingfloat("fDiffMultHPToPCL")
skill = akTarget.GetBaseActorValue("Marksman")
if skill>=0&&skill<25
 setM = 9/fDiffMultHPToPCL
  elseif  skill>=25&&skill<50
  setM = 8/fDiffMultHPToPCL
   elseif  skill>=50&&skill<75
     setM = 7/fDiffMultHPToPCL
	  elseif skill>=75
       setM = 6/fDiffMultHPToPCL
endif
HH_HP_DRAIN.SetNthEffectMagnitude(0, setM)
akTarget.AddSpell(HH_HP_DRAIN, False)
endevent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
akTarget.RemoveSpell(HH_HP_DRAIN)
EndEvent