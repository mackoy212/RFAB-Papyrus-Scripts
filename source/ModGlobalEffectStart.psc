scriptName ModGlobalEffectStart extends activemagiceffect

;-- Properties --------------------------------------
globalvariable property Point auto
Int property GlobalValue auto

function oneffectStart(Actor Target, Actor Caster)
	Point.mod((GlobalValue) as float)
endFunction
