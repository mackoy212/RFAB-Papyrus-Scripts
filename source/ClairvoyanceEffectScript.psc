scriptName ClairvoyanceEffectScript extends ActiveMagicEffect

Event OnEffectStart(Actor akTarget, Actor akCaster)

    String ActorValues = "��������:                          "+akTarget.GetAV("Health") as Int+"\n�����:                            "+akTarget.GetAV("Magicka") as Int+"\n����� ���:                          "+akTarget.GetAV("Stamina") as Int+"\n�����:                               "+akTarget.GetAV("DamageResist") as Int+"\n������������� �����:             "+akTarget.GetAV("MagicResist") as Int+"%"+"\n������������� ����:              "+akTarget.GetAV("FireResist") as Int+"%"+"\n������������� ������:            "+akTarget.GetAV("FrostResist") as Int+"%"+"\n������������� �������������:      "+akTarget.GetAV("ElectricResist") as Int+"%"+"\n������������� ����:                "+akTarget.GetAV("PoisonResist") as Int+"%"+"\n������������� ��������:             "+akTarget.GetAV("DiseaseResist") as Int+"%"+"\n���� ����������:                "+akTarget.GetAV("AbsorbChance") as Int+"%"
    debug.MessageBox(ActorValues)
EndEvent