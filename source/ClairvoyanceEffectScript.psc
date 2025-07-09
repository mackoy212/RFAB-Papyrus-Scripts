scriptName ClairvoyanceEffectScript extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)

    String ActorValues = "Здоровье:                          "+akTarget.GetAV("Health") as Int+"\nМагия:                            "+akTarget.GetAV("Magicka") as Int+"\nЗапас сил:                          "+akTarget.GetAV("Stamina") as Int+"\nБроня:                               "+akTarget.GetAV("DamageResist") as Int+"\nСопротивление магии:             "+akTarget.GetAV("MagicResist") as Int+"%"+"\nСопротивление огню:              "+akTarget.GetAV("FireResist") as Int+"%"+"\nСопротивление холоду:            "+akTarget.GetAV("FrostResist") as Int+"%"+"\nСопротивление электричеству:      "+akTarget.GetAV("ElectricResist") as Int+"%"+"\nСопротивление ядам:                "+akTarget.GetAV("PoisonResist") as Int+"%"+"\nСопротивление болезням:             "+akTarget.GetAV("DiseaseResist") as Int+"%"+"\nШанс поглощения:                "+akTarget.GetAV("AbsorbChance") as Int+"%"
    debug.MessageBox(ActorValues)
EndEvent