Scriptname RFAB_CastSpellOnSelfOnEffectFinish extends ActiveMagicEffect  

spell property spellToCast auto
spell property spellToDispel auto


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	spellToCast .cast(akTarget, akTarget)
	akTarget.DispelSpell(spellToDispel )
endevent