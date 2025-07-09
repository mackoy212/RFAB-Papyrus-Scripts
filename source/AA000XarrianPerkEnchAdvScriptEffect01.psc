Scriptname AA000XarrianPerkEnchAdvScriptEffect01 extends activemagiceffect

Weapon Property IronDagger auto
Soulgem Property SoulGemGrandFilled auto
Weapon Property GainedWeapon01 auto
Weapon Property GainedWeapon02 auto
Weapon Property GainedWeapon03 auto
Weapon Property GainedWeapon04 auto
Weapon Property GainedWeapon05 auto


function OnEffectStart(Actor Target, Actor Caster)

	Caster.removeitem(IronDagger as form, 5, false, none)
	Caster.removeitem(SoulGemGrandFilled as form, 1, false, none)
	
	Caster.additem(GainedWeapon01 as form, 1, false)
	Caster.additem(GainedWeapon02 as form, 1, false)
	Caster.additem(GainedWeapon03 as form, 1, false)
	Caster.additem(GainedWeapon04 as form, 1, false)
	Caster.additem(GainedWeapon05 as form, 1, false)
	
	game.advanceskill("Enchantment", 750 as Float)
endFunction