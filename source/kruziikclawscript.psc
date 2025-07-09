Scriptname KruziikClawScript extends ActiveMagicEffect  

Spell Property KruziikRage auto
MagicEffect Property KruziikRageEffect auto
ActiveMagicEffect Property KruziikRageEffectRef auto
GlobalVariable Property KruziikGlobal auto
GlobalVariable Property KruziikChanceGlobal auto
Sound Property BattleCry auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	KruziikChanceGlobal.SetValue(KruziikChanceGlobal.GetValue() + 1)
	if (Utility.RandomInt(0, 150) <= KruziikChanceGlobal.GetValue() && !akCaster.HasMagicEffect(KruziikRageEffect))
		KruziikRageEffectRef = KruziikRage.Cast(akCaster, akCaster)

		KruziikChanceGlobal.SetValue(0)

		int SoundID = BattleCry.Play(akCaster)
		Sound.SetInstanceVolume(SoundID, 0.5)

	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	while (akCaster.IsInKillMove())
		Utility.wait(1)
	endwhile

	Utility.wait(1)

	if (akTarget.IsDead() && akCaster.HasMagicEffect(KruziikRageEffect) && KruziikGlobal.GetValue() == 0)
		KruziikRageEffectRef.Dispel()
		KruziikRage.Cast(akCaster, akCaster)

		int SoundID = BattleCry.Play(akCaster)
		Sound.SetInstanceVolume(SoundID, 0.15)

		KruziikChanceGlobal.SetValue(0)
		KruziikGlobal.SetValue(1)
		Utility.wait(1)
		KruziikGlobal.SetValue(0)
	endif
EndEvent