Scriptname SP_InducedCharge extends activemagiceffect  
Hazard property shockwall auto

Event oneffectstart(actor aktarget, actor akcaster)
Aktarget.placeatme(shockwall)
endevent