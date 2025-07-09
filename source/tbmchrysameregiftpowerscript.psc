Scriptname tbmChrysamereGiftPowerScript extends ActiveMagicEffect  

Spell Property tbmChrysamerePowerSpell Auto
Message Property tbmChrysamereNoChargeMsg Auto
Sound Property MAGFail Auto
Weapon Property tbmChrysamere Auto
Weapon Property tbmChrysamereS Auto
Message Property tbmChrysamereNoEquipMsg Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float chryPower = akCaster.GetActorValue("RightItemCharge")

	If (!akCaster.IsEquipped(tbmChrysamere) && !akCaster.IsEquipped(tbmChrysamereS))
		tbmChrysamereNoEquipMsg.Show()
		return
	EndIf

	If (chryPower >= 250.0)
		akCaster.DamageActorValue("RightItemCharge", 250.0)
		tbmChrysamerePowerSpell.Cast(akCaster, akCaster)
	Else
		tbmChrysamereNoChargeMsg.Show()
		MAGFail.Play(akCaster)
	EndIf

EndEvent