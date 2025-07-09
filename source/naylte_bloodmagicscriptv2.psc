Scriptname Naylte_BloodMagicScriptV2 extends activemagiceffect
{Attaches to the ability that gets toggled by the spell. Applies the health cost to the caster while Blood Magic is active. Prevents the player from casting spells that would be fatal.}

; -----  ----- ----- ----- ----- ----- ----- ----- ----- -----

;/+---------------------------------------------------------+
  |															|
  | Variables and Constants					 				|
  |															|
  +---------------------------------------------------------+/;

int LeftCastIndex = 0																;Used for function WaitCondition()
int RightCastIndex = 1																;Used for function WaitCondition()
int DualCastIndex = 2																;Used for function WaitCondition()
int SpellCost																		;The integer value of the cast spell's cost.
int SpellCostLeft																	;The effective magicka cost of the spell equipped on the left hand. Set by UpdateSpells().
int SpellCostRight																	;The effective magicka cost of the spell equipped on the right hand. Set by UpdateSpells().
float CostToMinHealth = 0.075														;Obtained by trial and error. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING. Used in MinConcHealthFunction().
float MinConcHealth	= 5.0															;The minimum health the player needs to cast a concentration spell. Casting is disabled below this threshold.
Spell CastSpell																		;The spell that was cast upon triggering the OnSpellCast event.
Spell SpellLeft																		;The spell equipped in the player's left hand.
Spell SpellRight														    		;The spell equipped in the player's right hand.
float AlterationModOLD														        ; Проврка стоимости каста происходит только если значение меняется
float ConjurationModOLD														    	;Проврка стоимости каста происходит только если значение меняется
float DestructionModOLD														    	;Проврка стоимости каста происходит только если значение меняется
float IllusionModOLD														    		;Проврка стоимости каста происходит только если значение меняется
float RestorationModOLD														    	;Проврка стоимости каста происходит только если значение меняется
float AlterationPowerModOLD														    ;Проврка стоимости каста происходит только если значение меняется
float ConjurationPowerModOLD														    ;Проврка стоимости каста происходит только если значение меняется
float DestructionPowerModOLD														    ;Проврка стоимости каста происходит только если значение меняется
float IllusionPowerModOLD														    	;Проврка стоимости каста происходит только если значение меняется
float RestorationPowerModOLD														    ;Проврка стоимости каста происходит только если значение меняется
float HealRateOLD														    		    ;Проврка стоимости каста происходит только если значение меняется
float InfamyOLD														    		    ;Проврка стоимости каста происходит только если значение меняется

;/+---------------------------------------------------------+
  |															|
  | Properties												|
  |															|
  +---------------------------------------------------------+/;

Actor Property PlayerRef auto														;Player reference.
ImageSpaceModifier Property ActivationIMod auto										;The image space modifier applied upon ability activation. Default: BerserkerOutroImod
Keyword Property RitualSpellEffect auto												;Set to keyword RitualSpellEffect
Sound Property ActivationSound auto													;The sound that plays upon ability activation (not deactivation). Default: 000Naylte_MAGPowerRacialBerserkerFire
Sound Property MAGFail auto															;The sound that plays when you have insufficient health. Default: MAGFail
Spell Property DamageHealthAbility auto												;Set to the health drain/magicka restore ability. Default: 000Naylte_BloodMagicConcDamageAbility
Spell Property ToggleSpell auto														;Set to the spell that toggles the ability. Default: 000Naylte_BloodMagicToggleSpell
Perk Property MagickaCostNegate auto												;Set to the perk that sets spell costs to zero. Default: 000Naylte_BloodMagicSpellCostZeroAbility
VisualEffect Property BloodSpray auto												;Set to the blood spray visual effect, which plays whenever the player casts a spell while blood magic is active. Default: 000Naylte_BloodSprayDecapEffect

bool bUpdateBlock = false
;bool bCastProcess = false
float LastCastTime = 0.0
;/+---------------------------------------------------------+
  |															|
  | Functions								 				|
  |															|
  +---------------------------------------------------------+/;

bool Function IsConcentrated(Spell s)												;Returns true if the spell is a concentration spell. Otherwise returns false.
	if (s.GetNthEffectMagicEffect(s.GetCostliestEffectIndex())).GetCastingType() == 2
		return 1
	else
		return 0
	endif
endFunction

bool Function IsRitualSpell(Spell s)												;Returns true if the spell is a ritual spell (FF or concentration). Otherwise returns false.
	if (s.GetNthEffectMagicEffect(0)).HasKeyword(RitualSpellEffect)
		return 1
	else
		return 0
	endif
endFunction

bool Function WaitCondition(int index)												;Returns the condition for applying the health cost while channeling concentration spells. Use the index variables for the parameter.
	if (index == LeftCastIndex)
		return PlayerRef.GetAnimationVariableBool("IsCastingLeft") && !(PlayerRef.GetAnimationVariableBool("IsCastingRight") && IsConcentrated(SpellRight))
	elseif (index == RightCastIndex)
		return !(PlayerRef.GetAnimationVariableBool("IsCastingLeft") && IsConcentrated(SpellLeft)) && PlayerRef.GetAnimationVariableBool("IsCastingRight")
	elseif (index == DualCastIndex)
		return PlayerRef.GetAnimationVariableBool("IsCastingLeft") && PlayerRef.GetAnimationVariableBool("IsCastingRight") || PlayerRef.GetAnimationVariableBool("IsCastingDual")
	else
		return 0
	endif
endFunction

Function UpdateSpells()																;Updates the spells that the player has equipped and records their effective cost.
	PlayerRef.RemovePerk(MagickaCostNegate)											;This allows spells to both cost 0 magicka and still be able to use GetEffectiveMagickaCost().
	if (PlayerRef.GetEquippedObject(0) as Spell)									;If the player equips something other than a spell it sets the cost to 0.
		if (SpellLeft != PlayerRef.GetEquippedSpell(0))
			SpellLeft = PlayerRef.GetEquippedSpell(0)
			SpellCostLeft = SpellLeft.GetEffectiveMagickaCost(PlayerRef)
		endif
	else
		SpellCostLeft = 0
	endif
	if (PlayerRef.GetEquippedObject(1) as Spell)
		if (SpellRight != PlayerRef.GetEquippedSpell(1))
			SpellRight = PlayerRef.GetEquippedSpell(1)
			SpellCostRight = SpellRight.GetEffectiveMagickaCost(PlayerRef)
		endif
	else
		SpellCostRight = 0
	endif
	PlayerRef.AddPerk(MagickaCostNegate)
endFunction

Function UpdateSpells2()														;Updates the spells that the player has equipped and records their effective cost.
	GoToState("Busy")
	;PlayerRef.RemovePerk(MagickaCostNegate)										;This allows spells to both cost 0 magicka and still be able to use GetEffectiveMagickaCost().
	MagickaCostNegate.SetNthEntryValue(0, 0, 200.0)
	if (PlayerRef.GetEquippedObject(0) as Spell)									;If the player equips something other than a spell it sets the cost to 0.
		SpellLeft = PlayerRef.GetEquippedSpell(0)		
		SpellCostLeft = Math.Floor(SpellLeft.GetEffectiveMagickaCost(PlayerRef) / 200.0)
	else
		SpellCostLeft = 0
	endif
	if (PlayerRef.GetEquippedObject(1) as Spell)
		SpellRight = PlayerRef.GetEquippedSpell(1)
		SpellCostRight = Math.Floor(SpellRight.GetEffectiveMagickaCost(PlayerRef) / 200.0)
	else
		SpellCostRight = 0
	endif	
	;PlayerRef.AddPerk(MagickaCostNegate)
	MagickaCostNegate.SetNthEntryValue(0, 0, 0.0)
	GoToState("")
endFunction

state Busy
	Function UpdateSpells2()
	endFunction
endState

;float Function MinConcHealthFunction(int Cost)										;Sets the threshold for stopping the player from channeling a concentration spell based
;	float Threshold = Cost * CostToMinHealth										;on the spell's cost per second multiplied by CostToMinHealth. The threshold cannot be less than MinConcHealth.
;	if Threshold <= MinConcHealth
;		return MinConcHealth
;	else
;		return Threshold
;	endif
;endFunction

;Function MonitorPlayerHealth(float minimum)											;Checks to see if it is safe for the player to cast a spell. Stops them if it is not and gives a message. In a while loop,
	;if (PlayerRef.GetActorValue("Health") < minimum)								;it monitors player's health while channeling a concentration spell and stops them
	;	PlayerRef.RemoveSpell(DamageHealthAbility)									;when their health drops below the minimum parameter (use MinConcHealthFunction() for concentration spells and SpellCost for FF spells).
	;	PlayerRef.InterruptCast()
	;	MAGFail.Play(PlayerRef)
	;	Debug.Notification("I'm too weak to cast this spell.")
	;endif
;endFunction

Function ApplyConcHealthCost(int Cost, int WaitIndex)								;Applies an ability that constantly damages health 
	float fDiffMultHPToPCL = Game.GetGameSettingfloat("fDiffMultHPToPCL")
	DamageHealthAbility.SetNthEffectMagnitude(0, Cost / fDiffMultHPToPCL)			;at a rate equal to a concentration spell's cost per second.
	PlayerRef.AddSpell(DamageHealthAbility, false)									;Use LeftCastIndex, RightCastIndex, or DualCastIndex for WaitIndex.
	while (WaitCondition(WaitIndex))
		;Wait for the player to change the casting conditions.
		;MonitorPlayerHealth(MinConcHealthFunction(Cost))
		Utility.Wait(0.1)
	endwhile
	PlayerRef.RemoveSpell(DamageHealthAbility)
endFunction

Function ApplyFFHealthCost(int Cost)												;Applies health damage based on the cost of an FF spell.
	PlayerRef.DamageActorValue("Health", Cost)
endFunction

;/+---------------------------------------------------------+
  |															|
  | Events													|
  |															|
  +---------------------------------------------------------+/;

Event OnEffectStart(Actor akTarget, Actor akCaster)									;On effect start:
	ActivationSound.Play(akTarget)													;Play the activation sound.
	ActivationIMod.Apply(0.6)														;Apply the activation image space modifier.
	UpdateSpells()																	;Update the equipped spells saved by the script.
	;RegisterForAnimationEvent(PlayerRef, "BeginCastLeft")							;Register animation events.
	;RegisterForAnimationEvent(PlayerRef, "BeginCastRight")
	LastCastTime = Utility.GetCurrentRealTime()
	;RegisterForSingleUpdate(3.0)
endEvent

Event OnUpdate()
	;UpdateSpells2()
	;Debug.Notification("Spell cost has been updated.")
	;RegisterForSingleUpdate(3.0)
	
	;float time = Utility.GetCurrentRealTime()
	;if(time > LastCastTime + 1.0)
		bUpdateBlock = false 
		AlterationModOLD = PlayerRef.GetActorValue("AlterationMod") ; 1после апдейта запоминаем текущие значения параметров
		ConjurationModOLD = PlayerRef.GetActorValue("ConjurationMod");2
		IllusionModOLD = PlayerRef.GetActorValue("IllusionMod");3
		RestorationModOLD = PlayerRef.GetActorValue("RestorationMod"); 4
		DestructionModOLD = PlayerRef.GetActorValue("DestructionMod") ; 5
		AlterationPowerModOLD = PlayerRef.GetActorValue("AlterationPowerMod") ;6
		ConjurationPowerModOLD = PlayerRef.GetActorValue("AlterationPowerMod") ;7
		DestructionPowerModOLD = PlayerRef.GetActorValue("AlterationPowerMod") ;8
		IllusionPowerModOLD = PlayerRef.GetActorValue("AlterationPowerMod") ;9 
		RestorationPowerModOLD = PlayerRef.GetActorValue("AlterationPowerMod") ; 10
		InfamyOLD = PlayerRef.GetActorValue("Infamy") ; 11 
		HealRateOLD = PlayerRef.GetActorValue("HealRate"); 12
		;else
	;	RegisterForSingleUpdate(1.0)
	;endif	
EndEvent



Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)				;When something is equipped: 
	UpdateSpells2()																	;Update spells.
endEvent



Event OnSpellCast(Form akSpell)													;This event applies the health cost.
	
	CastSpell = akSpell as Spell
	if CastSpell != ToggleSpell && (CastSpell == SpellLeft || CastSpell == SpellRight)		
		bool bDual = (PlayerRef.GetAnimationVariableBool("IsCastingLeft") && PlayerRef.GetAnimationVariableBool("IsCastingRight") || PlayerRef.GetAnimationVariableBool("IsCastingDual"))
		bool bDualFF = PlayerRef.GetAnimationVariableBool("IsCastingDual")
		;BloodSpray.Play(PlayerRef)
		;bCastProcess = true
		if(!bUpdateBlock) && AlterationModOLD != PlayerRef.GetActorValue("AlterationMod") || ConjurationModOLD != PlayerRef.GetActorValue("ConjurationMod")|| IllusionModOLD != PlayerRef.GetActorValue("IllusionMod") || RestorationModOLD != PlayerRef.GetActorValue("RestorationMod")|| DestructionModOLD != PlayerRef.GetActorValue("DestructionMod") || AlterationPowerModOLD != PlayerRef.GetActorValue("AlterationPowerMod") || ConjurationPowerModOLD != PlayerRef.GetActorValue("AlterationPowerMod") || DestructionPowerModOLD != PlayerRef.GetActorValue("AlterationPowerMod") || IllusionPowerModOLD != PlayerRef.GetActorValue("AlterationPowerMod") || RestorationPowerModOLD != PlayerRef.GetActorValue("AlterationPowerMod") || InfamyOLD != PlayerRef.GetActorValue("Infamy") || HealRateOLD != PlayerRef.GetActorValue("HealRate")
			UpdateSpells2()
			bUpdateBlock = true
			RegisterForSingleUpdate(0.75)
			;Utility.Wait(0.1)
		endif			
		;LastCastTime = Utility.GetCurrentRealTime()		
		;bCastProcess = false
		
		if (IsConcentrated(CastSpell))											;Check if the spell is concentrated.
			if(IsRitualSpell(CastSpell) && bDual)								;Ritual concentration spells do not have their cost doubled.
				SpellCost = SpellCostLeft
				ApplyConcHealthCost(SpellCost, DualCastIndex)
			elseif(bDual && IsConcentrated(SpellRight) && IsConcentrated(SpellLeft))
				SpellCost = SpellCostLeft + SpellCostRight						;The total cost is the sum whether the spells are double cast, dual cast, or 2 different concentration spells.
				ApplyConcHealthCost(SpellCost, DualCastIndex)
				
				if PlayerRef.GetAnimationVariableBool("IsCastingLeft")
					CastSpell = SpellLeft
				elseif PlayerRef.GetAnimationVariableBool("IsCastingRight")
					CastSpell = SpellRight
				endif
			endif 
			
			if(CastSpell == SpellLeft && PlayerRef.GetAnimationVariableBool("IsCastingLeft"))			;Using left hand ONLY.
				SpellCost = SpellCostLeft
				ApplyConcHealthCost(SpellCost, LeftCastIndex)
			elseif (CastSpell == SpellRight && PlayerRef.GetAnimationVariableBool("IsCastingRight"))	;Using right hand ONLY.
				SpellCost = SpellCostRight
				ApplyConcHealthCost(SpellCost, RightCastIndex)
			endif
		else																		;If not concentrated, FF spell.
			if (bDualFF)
				SpellCost = SpellCostLeft * 2
			elseif (CastSpell == SpellLeft)											;Single cast FF spell. Check if left hand.
				SpellCost = SpellCostLeft
			elseif (CastSpell == SpellRight)										;Otherwise single cast FF spell from right hand.
				SpellCost = SpellCostRight
			endif
			ApplyFFHealthCost(SpellCost)
		endif
	endif
endEvent



;Event OnAnimationEvent(ObjectReference akSource, string asEventName)				;This event applies the protection system.
;	if (akSource == PlayerRef)
;		;if(bCastProcess && (asEventName == "BeginCastLeft" || asEventName == "BeginCastRight") )
;		;	PlayerRef.InterruptCast()
;		;endif
;		if (asEventName == "BeginCastLeft")											;This event occurs if you cast with the left hand OR dual cast.
;			;UpdateSpells2()
;			if (IsConcentrated(SpellLeft))
;				if (PlayerRef.GetAnimationVariableBool("IsCastingDual") && !IsRitualSpell(SpellLeft))
;					MonitorPlayerHealth(MinConcHealthFunction(SpellCostLeft * 2))
;				else
;					MonitorPlayerHealth(MinConcHealthFunction(SpellCostLeft))
;				endif
;			elseif (PlayerRef.GetAnimationVariableBool("IsCastingDual"))
;				MonitorPlayerHealth(SpellCostLeft * 2)
;			else
;				MonitorPlayerHealth(SpellCostLeft)
;			endif
;		elseif (asEventName == "BeginCastRight")
;			;UpdateSpells2()
;			if (IsConcentrated(SpellRight))
;				MonitorPlayerHealth(MinConcHealthFunction(SpellCostRight))
;			else
;				MonitorPlayerHealth(SpellCostRight)
;			endif
;		endif
;	endif
;endEvent



Event OnEffectFinish(Actor akTarget, Actor akCaster)
	PlayerRef.RemovePerk(MagickaCostNegate)
endEvent