Scriptname KKruziikSpellEffect extends ActiveMagicEffect  

ImageSpaceModifier Property IS_Intro auto
ImageSpaceModifier Property IS_Main auto
ImageSpaceModifier Property IS_Outro auto
float Property WeaponSpeedMult auto
float Property LeftWeaponSpeedMult auto
float Property SpeedMult auto
float Property WeaponSpeedMultminus auto
float Property LeftWeaponSpeedMultminus auto
float Property SpeedMultminus auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.ModAV("WeaponSpeedMult", WeaponSpeedMult)
	akCaster.ModAV("LeftWeaponSpeedMult", LeftWeaponSpeedMult)
	akCaster.ModAV("SpeedMult", SpeedMult)


	IS_Intro.remove()
	IS_Main.remove()
	IS_Outro.remove()

	IS_Intro.Apply()
	utility.wait(0.83)
	IS_Intro.PopTo(IS_Main, 1.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    akCaster.ModAV("WeaponSpeedMult", WeaponSpeedMultminus)
    akCaster.ModAV("LeftWeaponSpeedMult", LeftWeaponSpeedMultminus)
    akCaster.ModAV("SpeedMult", SpeedMultminus)


	Input.HoldKey(Input.GetMappedKey("Sprint"))
	Utility.Wait(0.1)
	Input.ReleaseKey(Input.GetMappedKey("Sprint"))

    IS_Intro.Remove()
    IS_Main.PopTo(IS_Outro, 1)

EndEvent