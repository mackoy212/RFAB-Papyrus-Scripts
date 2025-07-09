ScriptName zzzSXPWorkerKillActor Extends Quest

Import Game
Import StringUtil

zzzSXPController Property XPC Auto
Keyword Property ImmuneParalysis Auto
float[] Property SXPActor Auto Hidden
Armor Property TonarRing Auto

Actor[] Victims

Function GameInit()
	GarbageCollection()
EndFunction

Function GameReloaded()
	GarbageCollection()
EndFunction

Function GarbageCollection()
	Victims = new Actor[20]
EndFunction

function PostVictim(Actor pVictim)

	Int Index = Victims.find(none, 0)
	Victims[Index] = pVictim
	Actor pActor = Victims[Index]
	Victims[Index] = none
	if pActor.GetLeveledActorBase().GetName()
		XPC.GainXPMessage(55, self.CalcXP(pActor), "Lv." + pActor.GetLevel() as String + " " + pActor.GetLeveledActorBase().GetName() + ":", true)
	else
		XPC.GainXPMessage(55, self.CalcXP(pActor), "", true)
	endIf
endFunction

Float Function CalcXP(Actor pActor)
	Float SXP_MOUNT = 1 as Float
	If GetPlayer().IsOnMount()
		SXP_MOUNT = 0.75
	EndIf
	
	Float ForswornBonus = 1.0
	If game.GetPlayer().IsEquipped(TonarRing)
		if Find(pActor.GetFactions(0,127), "00043599") >= 0 || Find(pActor.GetFactions(0,127), "000E3609") >= 0
			ForswornBonus = 1.1
		EndIf
	EndIf

	Float UniqueActXP = UniqueXP(pActor.GetBaseObject().GetFormID())
	If UniqueActXP > -1.0
		Return UniqueActXP * SXP_MOUNT * ForswornBonus
	EndIf

	UniqueActXP = UniqueXPMods(pActor.GetBaseObject() as Form)
	If UniqueActXP > -1.0
		Return UniqueActXP *  SXP_MOUNT * ForswornBonus
	EndIf

	Race pRace = pActor.GetRace()
	If Find(pActor.GetFactions(0,127), "0002E894") >= 0 && Find(pRace, "Riekling") <= 0 || Find(pRace, "Mammoth") > 0 || Find(pRace, "DLC2Netch") > 0 ;������� ����� � ����
		Return 0.0
	EndIf

	float fBase = pActor.GetBaseActorValue("Health")
	If Find(pRace, "DragonRace") > 0 ;���� ��� ���� Deadly Dragons
		fBase *= 3.0 ;1.75
	EndIf
	fBase += pActor.GetLevel() * 10.0
	If Find(pRace, "Vampire") > 0 && pActor.GetBaseActorValue("Health") > 1500.0 ;���������� �������
		fBase *= 2.25 ;3.0
	ElseIf Find(pRace, "HighElfRace") > 0 && pActor.GetBaseActorValue("Health") > 999.0 && Find(pRace, "Vampire") <= 0 ;�������� ��������
		fBase *= 1.5 ;3.0
	ElseIf Find(pRace, "Draugr") > 0 && pActor.GetLevel() >= 88
        fBase *= 0.83	
	EndIf

	If pActor.GetBaseObject().GetFormID() == 781797 ;��������� �������
		fBase *= 0.33	
	EndIf

	If pActor.IsInFaction(game.GetFormFromFile(22414, "RFAB_AE.esp") as Faction) || pActor.IsInFaction(game.GetFormFromFile(341934, "RFAB_AE.esp") as Faction) ;����� � �����
		fBase *= 2.5
	EndIf

	float fMult = 1.0
	fMult *= 1.0 + (20.0 / 19.0) * Value(pActor, "DamageResist") * 0.0012
	fMult *= 1.0 + (5.0 / 9.0) * Value(pActor, "MagicResist") * 0.01
	fMult *= 1.0 + (5.0 / 9.0) * Value(pActor, "AbsorbChance") * 0.01
	fMult *= 1.0 + (5.0 / 27.0) * Value(pActor, "FireResist") * 0.01
	fMult *= 1.0 + (5.0 / 27.0) * Value(pActor, "ElectricResist") * 0.01
	fMult *= 1.0 + (5.0 / 27.0) * Value(pActor, "FrostResist") * 0.01
	fMult *= 1.0 + (5.0 / 45.0) * Value(pActor, "PoisonResist") * 0.01
	fMult += RaceMult(pRace, pActor)
	fMult += FactionMult(pActor.GetFactions(0,127))
	fMult += pActor.GetLevel() / 50.0
	If pRace != None
		If pRace.IsPlayable()
			If pRace.HasKeyword(ImmuneParalysis)
				fMult += 0.1
			EndIf
			If !pRace.NoKnockdowns()
				fMult += 0.15
			EndIf
			If pRace.IsNotPushable()
				fMult += 0.1
			EndIf
		EndIf
	Endif

	Float Dbuff = 0.75
	if Find(pActor.GetFactions(0,127), "0001BCC0") >= 0 ;����������
		Dbuff = 1.0
	EndIf

	Return fBase * fMult * SXP_MOUNT * ForswornBonus * Dbuff
EndFunction

Float Function Value(Actor pActor, String stat)
	If pActor.GetActorValue(stat) >= pActor.GetBaseActorValue(stat) && pActor.GetActorValue(stat) >= 0.0
		Return pActor.GetActorValue(stat)
	ElseIf pActor.GetBaseActorValue(stat) >= pActor.GetActorValue(stat) && pActor.GetBaseActorValue(stat) >= 0.0
		Return pActor.GetBaseActorValue(stat)
	EndIf
	Return 0.0
EndFunction

Float Function RaceMult(Race tRace, Actor pActor)
	If Find(tRace, "Mirel_RfaDK_LifeWeaponRace") > 0 ;���� ���������� ������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Mirel_RfaDK_RaceLifeGloves") > 0 ;���� ��������� ��������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1VampireBeastRace") > 0 ;������-����
		Return 2.5 ;5.0
	ElseIf Find(tRace, "AtronachFlameRace") > 0 ;�������� ��������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "AtronachFrostRace") > 0 ;�������� ��������
		Return 2.0 ;4.0
	ElseIf Find(tRace, "AtronachStormRace") > 0 ;�������� ��������
		Return 2.5 ;5.0
	ElseIf Find(tRace, "ChaurusReaperRace") > 0 ;�����-����
		Return 1.4 ;2.75
	ElseIf Find(tRace, "DLC1ChaurusHunterRace") > 0 ;�����-�������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1_BF_ChaurusRace") > 0 ;������������ �����
		Return 1.9 ;3.75
	ElseIf Find(tRace, "ChaurusRace") > 0 ;�����
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1DeathHoundRace") > 0 ;������ ������
		Return 2.0 ;4.0
	ElseIf Find(tRace, "DLC1SabreCatGlowRace") > 0 ;�������� ��������
		Return 1.75
	ElseIf Find(tRace, "SabreCatSnowyRace") > 0 ;������� ��������
		Return 1.75
	ElseIf Find(tRace, "SabreCatRace") > 0 ;��������
		Return 1.75
	ElseIf Find(tRace, "DLC1SoulCairnKeeperRace") > 0 ;����������
		Return 2.5 ;5.0
	ElseIf Find(tRace, "DLC1BlackSkeletonRace") > 0 ;�������� �������
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSkeletonArmorRace") > 0 ;�������� �������
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSkeletonNecroRace") > 0 ;�������� �������
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSoulWispRace") > 0 ;�������� ���
		Return 0.3 ;0.5
	ElseIf Find(tRace, "dlc2AshGuardianRace") > 0 ;��������� �����
		Return 0.3 ;0.5
	ElseIf Find(tRace, "DLC2AshHopperRace") > 0 ;��������� ������
		Return 0.2
	ElseIf Find(tRace, "DLC2AshSpawnRace") > 0 ;���������� �����
		Return 0.3 ;0.5
	ElseIf Find(tRace, "DLC2BoarRace") > 0 ;�����������, �������
		Return 0.3
	ElseIf Find(tRace, "DLC2DwarvenBallistaRace") > 0 ;���������� �������
		Return 0.4 ;0.75
	ElseIf Find(tRace, "DLC2LurkerRace") > 0 ;������
		Return 1.0 ;2.0
	ElseIf Find(tRace, "DLC2MountedRieklingRace") > 0 ;�������-��������
		Return 3.0 ;6.0
	ElseIf Find(tRace, "DLC2Netch") > 0 ;����
		Return 0.2 ;0.3
	ElseIf Find(tRace, "DLC2SeekerRace") > 0 ;��������
		Return 0.8 ;1.5
	ElseIf Find(tRace, "DLC2SprigganBurntRace") > 0 ;������� ��������
		Return 1.0
	ElseIf Find(tRace, "SprigganEarthMotherRace") > 0
		Return 1.5
	ElseIf Find(tRace, "SprigganMatronRace") > 0 ;�������
		Return 1.5
	ElseIf Find(tRace, "SprigganRace") > 0 ;�������
		Return 1.0
	ElseIf Find(tRace, "WerebearBeast") > 0 ;�������-���������
		Return 5.0 ;10.0
	ElseIf Find(tRace, "BearBlackRace") > 0 ;�������� �������
		Return 1.75
	ElseIf Find(tRace, "BearBrownRace") > 0 ;������� �������
		Return 1.75
	ElseIf Find(tRace, "BearSnowRace") > 0 ;����� �������
		Return 2.0
	ElseIf Find(tRace, "DragonPriestRace") > 0 ;������� �������� �����
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DraugrMagicRace") > 0 ;������
		Return 0.35 ;1.0
	ElseIf Find(tRace, "DremoraRace") > 0 ;�������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DwarvenCenturionRace") > 0 ;���������� ���������
		Return 1.3 ;2.5
	ElseIf Find(tRace, "DwarvenSphereRace") > 0 ;���������� �����
		Return 0.8 ;1.5
	ElseIf Find(tRace, "DwarvenSpider") > 0 ;���������� ����
		Return 0.4 ;0.75
	ElseIf Find(tRace, "FalmerFrozenVampRace") > 0 ;������������ �������
		Return 0.4 ;0.75
	ElseIf Find(tRace, "FalmerRace") > 0 ;������
		If pActor.GetBaseActorValue("Health") >= 550.0 && pActor.GetLevel() >= 50.0
			Return 1.5 ;3.0
		Else
			Return 1.5 ;3.0
		EndIf
	ElseIf Find(tRace, "SpiderRaceGiant") > 0
		Return 1.3 ;2.5
	ElseIf Find(tRace, "SpiderRace") > 0
		Return 0.8 ;1.5
	ElseIf Find(tRace, "HagravenRace") > 0 ;�������
		Return 0.2 ;0.3
	ElseIf Find(tRace, "InvisibleRace") > 0 ;���������
		Return 2.5 ;5.0
	ElseIf Find(tRace, "SkeletonNecroRace") > 0 ;�������� ���� �� ������ �������
		Return 0.7 ;1.25
	ElseIf Find(tRace, "ShoggothRace") > 0
		Return 1.0 ;2.0
	ElseIf Find(tRace, "DragonRace") > 0 ;������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "WolfRace") > 0 ;����
		Return 2.0
	ElseIf Find(tRace, "Vampire") > 0 ;������
		Return 2.5 ;5.0
	ElseIf Find(tRace, "Gargoyle") > 0 ;��������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Riekling") > 0 ;�������
		Return 2.0 ;4.0
	ElseIf Find(tRace, "Troll") > 0 ;������
		Return 1.5 ;2.25
	ElseIf Find(tRace, "Werewolf") > 0 ;���������
		Return 5.0 ;10.0
	ElseIf Find(tRace, "Wisp") > 0 ;����-�����
		Return 2.0 ;3.5
	ElseIf Find(tRace, "Draugr") > 0 ;������
        Return 0.13 ;0.25
	ElseIf Find(tRace, "Skeleton") > 0 ;������
		Return 0.0
	ElseIf Find(tRace, "Giant") > 0 ;�������
		Return 0.0
	ElseIf Find(tRace, "Mirel_RfaDK_DwarwenDefenderRace") > 0 ;���������� ��������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "mihaildwarvenspinnerrace") > 0 ;���������� ���������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Mirel_RfaDK_DwemerAutomatonRace") > 0 ;���������� ���������
		Return 1.0 ;2.0
	ElseIf Find(tRace, "mihaildwarventhresherrace") > 0 ;���������� �����������
		Return 0.5 ;1.0
	ElseIf Find(tRace, "Mirel_RfaDK_DeepElfRace") > 0 ;���������� �������
		Return 1.5 ;3.0
	ElseIf Find(tRace, "_00DwarvenPunisherRace") > 0 ;���������� ��������
		Return 2.5 ;5.0
	ElseIf Find(tRace, "IceWraith") > 0 ;������� ����������
		Return 15.0
	EndIf
	Return 0.0
EndFunction

Float Function FactionMult(Faction[] tFactions)
	If Find(tFactions, "0001BCC0") >= 0 	;�������
		Return 3.5 ;6.5
	ElseIf Find(tFactions, "000622E6") >= 0 ;���� � �������� ����� ����� ����������
		Return 3.5 ;6.5
	ElseIf Find(tFactions, "0001C9FC") >= 0 ;���������������� - �������
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0001C9FD") >= 0 ;���������������� - ��
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "000215D3") >= 0 ;�������� - �� ������ �����
		Return 0.7 ;1.25
	ElseIf Find(tFactions, "00026724") >= 0 ;������� �������� (Warlock) - ������ ����
		Return 6.0 ;4.0
	ElseIf Find(tFactions, "00028848") >= 0 ;CrimeFactionImperial - ���������������� ��������� ������
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00028849") >= 0 ;CrimeFactionSons - ���������������� ������� ����
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002A451") >= 0 ;�������� � ��������� �������� ���������
		Return 0.5 ;1.0
	ElseIf Find(tFactions, "0002BF9A") >= 0 ;����� ��������� ������
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002BF9B") >= 0 ;����� ������ ����
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002EB13") >= 0 ;���������� ������
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "00034B74") >= 0 ;����������
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "000C0637") >= 0 ;������ �������� ���������� ��������
		Return 3.5 ;7.0
	ElseIf Find(tFactions, "00039F26") >= 0 ;������
		Return 3.5 ;7.0
	ElseIf Find(tFactions, "00043599") >= 0 ;�����
		Return 3.0 ;5.5
	ElseIf Find(tFactions, "000E3609") >= 0 ;����� �� ������ �������
		Return 3.0 ;5.5
	ElseIf Find(tFactions, "00043AB7") >= 0 ;��������� �� ������ ���������
		Return 2.5 ;4.75
	ElseIf Find(tFactions, "00058B3D") >= 0 ;������ � ��������� ������
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00068C8C") >= 0 ;�������� ������� �������
		Return 1.7 ;3.25
	ElseIf Find(tFactions, "0006BB1E") >= 0 ;������ ������ ����������� ����� (������� ��� ����� � ����������� ������)
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00073543") >= 0 ;������������ �������� � ������+�������
		Return 0.4 ;0.75
	ElseIf Find(tFactions, "0007A509") >= 0 ;����� �������
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "0007A50A") >= 0 ;����� �������
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "00088EE4") >= 0 ;������� ������ �����
		Return 2.0 ;3.5
	ElseIf Find(tFactions, "000A2CB0") >= 0 ;����������� � ������ �������
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "000AA0A4") >= 0 ;���������� ����
		Return 3.0 ;6.0
	ElseIf Find(tFactions, "000B3292") >= 0 ;�������� ���������
		Return 0.8 ;1.5
	ElseIf Find(tFactions, "000BC033") >= 0 ;�������� �������� ���������
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "000BA1E9") >= 0 ;���� �� ������ �������
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "000C0160") >= 0 ;������� � �������� �������
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "000DEED5") >= 0 ;�������-������ � ���������� ��������
		Return 1.0 ;2.0
	ElseIf Find(tFactions, "000E16CA") >= 0 ;���� �� ������ �������
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "020135BD") >= 0 ;����������� ��������, ��� �� ������ ���������
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "0402929A") >= 0 ;����� ����
		Return 1.0 ;2.0
	ElseIf Find(tFactions, "04034FBC") >= 0 ;��������� �������
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "040200E7") >= 0 ;��� ��� �������� ����������� � ����� ���������� ����
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "0004359E") >= 0 ;������ / ����� / �������
		Return 7.0 ;3.0
	ElseIf Find(tFactions, "00085D43") >= 0 ;������� �����(�����)
		Return 4.0 ;6.5
	EndIf
	Return 0.0
EndFunction

Float Function UniqueXP(Int BaseID)
	If BaseID == 67258601		;������
		Return 200000.0
	ElseIf BaseID == 207764		;������
		Return 500000.0
	ElseIf BaseID == 208285		;������
		Return 500000.0
	ElseIf BaseID == 276351		;������
		Return 500000.0
	ElseIf BaseID == 279114		;������
		Return 500000.0
	ElseIf BaseID == 582897		;������
		Return 500000.0
	ElseIf BaseID == 321980		;������
		Return 500000.0
	ElseIf BaseID == 110708		;���� �����
		Return 10000.0
	ElseIf BaseID == 124887		;������
		Return 100000.0
	ElseIf BaseID == 228736		;�������
		Return 40000.0
	ElseIf BaseID == 668650		;������
		Return 50000.0
	ElseIf BaseID == 866292		;������� ����
		Return 50000.0
	ElseIf BaseID == 841292		;�������
		Return 70000.0
	ElseIf BaseID == 67226325	;����� ��������
		Return 500000.0
	ElseIf BaseID == 106470		;���� �����
		Return 70000.0
	ElseIf BaseID == 33570051	;�����
		Return 150000.0
	ElseIf BaseID == 482431		;����� ����
		Return 50000.0
	ElseIf BaseID == 67207812	;������ �������
		Return 60000.0
	ElseIf BaseID == 374832		;������
		Return 150000.0
	ElseIf BaseID == 33568648	;������� ������
		Return 300000.0
	ElseIf BaseID == 206786		;�����
		Return 150000.0
	ElseIf BaseID == 361219		;������ ��� �������
		Return 50000.0
	ElseIf BaseID == 268592		;��������
		Return 100000.0
	ElseIf BaseID == 33623705	;��������
		Return 250000.0
	ElseIf BaseID == 518855		;�����������
		Return 150000.0
	ElseIf BaseID == 315974		;����������
		Return 70000.0
	ElseIf BaseID == 82216		;������ �������� �����
		Return 30000.0
	ElseIf BaseID == 853360		;������ �������� �����
		Return 30000.0
	ElseIf BaseID == 959874		;������ �������� �����
		Return 30000.0
	ElseIf BaseID == 78462		;������� ������
		Return 30000.0
	ElseIf BaseID == 853367		;������� ������
		Return 30000.0
	ElseIf BaseID == 67216740	;������� ����� �����
		Return 70000.0
	ElseIf BaseID == 78477		;�����-��
		Return 30000.0
	ElseIf BaseID == 78440		;�����
		Return 40000.0
	ElseIf BaseID == 652128		;����������� ��������
		Return 40000.0
	ElseIf BaseID == 596268		;������-������
		Return 150000.0
	ElseIf BaseID == 67258593	;�����
		Return 200000.0
	ElseIf BaseID == 943661		;���-����� �����
		Return 70000.0
	ElseIf BaseID == 943659		;���-����� ��������� �����
		Return 70000.0
	ElseIf BaseID == 943662		;���-����� ��������
		Return 70000.0
	ElseIf BaseID == 949935		;���-����� �������
		Return 70000.0
	ElseIf BaseID == 949929		;���-����� �������
		Return 70000.0
	ElseIf BaseID == 949933		;���-����� ���������
		Return 70000.0
	ElseIf BaseID == 949938		;���-����� ������
		Return 70000.0
	ElseIf BaseID == 33566936	;��������
		Return 300000.0
	ElseIf BaseID == 33605402	;�������� (����������)
		Return 0.0
	ElseIf BaseID == 33662782	;����
		Return 500000.0
	ElseIf BaseID == 67258600	;��������
		Return 200000.0
	ElseIf BaseID == 67204923	;������ ��������
		Return 70000.0
	ElseIf BaseID == 119993		;���������
		Return 100000.0
	ElseIf BaseID == 119994		;���������, ����
		Return 10000.0
	ElseIf BaseID == 123787		;������� ������
		Return 30000.0
	ElseIf BaseID == 67212901	;��������
		Return 70000.0
	ElseIf BaseID == 1055174	;������ (���� ����������)
		Return 70000.0
	ElseIf BaseID == 136705		;������
		Return 30000.0
	ElseIf BaseID == 236471		;������
		Return 40000.0
	ElseIf BaseID == 792840		;������� ����
		Return 70000.0
	ElseIf BaseID == 1050471	;������
		Return 70000.0
	ElseIf BaseID == 297813		;��������
		Return 50000.0
	ElseIf BaseID == 78497		;����� �����
		Return 30000.0
	ElseIf BaseID == 853363		;����� �����
		Return 30000.0
	ElseIf BaseID == 513657		;�����
		Return 10000.0
	ElseIf BaseID == 33617151	;�����
		Return 150000.0
	ElseIf BaseID == 33569703	;���� ������
		Return 500000.0
	ElseIf BaseID == 33614876	;���� ������
		Return 500000.0
	ElseIf BaseID == 33614986	;���� ������
		Return 500000.0
	ElseIf BaseID == 33663293	;���� ������
		Return 500000.0
	ElseIf BaseID == 144186		;��� ���-������
		Return 70000.0
	ElseIf BaseID == 33570053	;����
		Return 150000.0
	ElseIf BaseID == 641894		;��������
		Return 70000.0
	ElseIf BaseID == 33641473	;������-������
		Return 150000.0
	ElseIf BaseID == 165106		;������ ��������
		Return 40000.0
	ElseIf BaseID == 166611		;������ �����
		Return 60000.0
	ElseIf BaseID == 110716		;������ ����
		Return 50000.0
	ElseIf BaseID == 702207		;������ ���������
		Return 50000.0
	ElseIf BaseID == 33634339	;�������
		Return 30000.0
	ElseIf BaseID == 67205430	;�����
		Return 500000.0
	ElseIf BaseID == 67205432	;�����
		Return 500000.0
	ElseIf BaseID == 67207037	;�����
		Return 500000.0
	ElseIf BaseID == 67207041	;�����
		Return 500000.0
	ElseIf BaseID == 67238296	;�����
		Return 500000.0
	ElseIf BaseID == 67238808	;�����
		Return 500000.0
	ElseIf BaseID == 67240153	;�����
		Return 500000.0
	ElseIf BaseID == 572305		;������
		Return 70000.0
	ElseIf BaseID == 1001836	;�������
		Return 200000.0
	ElseIf BaseID == 1016987	;������
		Return 200000.0
	ElseIf BaseID == 272294		;����� ��������
		Return 40000.0
	ElseIf BaseID == 33623708	;��������
		Return 250000.0
	ElseIf BaseID == 67238288	;�������� ����
		Return 0.0
	ElseIf BaseID == 286584		;��������
		Return 70000.0
	ElseIf BaseID == 630575		;������������� �������
		Return 40000.0
	ElseIf BaseID == 1062043	;������� ������
		Return 70000.0
	ElseIf BaseID == 226874		;���� ��������
		Return 200000.0
	ElseIf BaseID == 217937		;�����
		Return 200000.0
	ElseIf BaseID == 237343		;��������
		Return 40000.0
	ElseIf BaseID == 115941		;��������� ����
		Return 60000.0
	ElseIf BaseID == 682050		;������ ���������
		Return 50000.0
	ElseIf BaseID == 682056		;������ ��������� (��������)
		Return 0.0
	ElseIf BaseID == 307374		;�������
		Return 40000.0
	ElseIf BaseID == 334207		;����� ������������
		Return 40000.0
	ElseIf BaseID == 79532		;�������, ���������
		Return 20000.0
	ElseIf BaseID == 67228910	;���������� ��������
		Return 70000.0
	ElseIf BaseID == 401704		;������ ���
		Return 70000.0
	ElseIf BaseID == 225886		;����� �����
		Return 50000.0
	ElseIf BaseID == 225841		;����� �������
		Return 50000.0
	ElseIf BaseID == 966190		;���� ���������
		Return 70000.0
	ElseIf BaseID == 213503		;�����
		Return 40000.0
	ElseIf BaseID == 684859		;�����
		Return 150000.0
	ElseIf BaseID == 82253		;������� �����������
		Return 30000.0
	ElseIf BaseID == 853365		;������� �����������
		Return 30000.0
	ElseIf BaseID == 959873		;������� �����������
		Return 30000.0
	ElseIf BaseID == 591673		;�����
		Return 20000.0
	ElseIf BaseID == 67216243	;������ ������ ������
		Return 70000.0
	ElseIf BaseID == 121860		;������
		Return 40000.0
	ElseIf BaseID == 317159		;��������
		Return 150000.0
	ElseIf BaseID == 412444		;������
		Return 50000.0
	ElseIf BaseID == 537854		;������� ������
		Return 70000.0
	ElseIf BaseID == 67274179	;���������� ����
		Return 200000.0
	ElseIf BaseID == 216471		;�������
		Return 10000.0
	ElseIf BaseID == 113448		;���� ���������
		Return 50000.0
	ElseIf BaseID == 79481		;������
		Return 40000.0
	ElseIf BaseID == 947913		;������
		Return 10000.0
	ElseIf BaseID == 244774		;����� ������
		Return 40000.0
	ElseIf BaseID == 724615		;��������� ������
		Return 40000.0
	ElseIf BaseID == 925569		;������� �������� ����
		Return 10000.0
	ElseIf BaseID == 67205046	;��������� �����
		Return 0.0
	ElseIf BaseID == 885310		;������
		Return 20000.0
	ElseIf BaseID == 548164		;����� ����
		Return 10000.0
	ElseIf BaseID == 548161		;������ �����
		Return 10000.0
	ElseIf BaseID == 655180		;����� � ������� �����
		Return 30000.0
	ElseIf BaseID == 117253		;��������� (������� ������)
		Return 70000.0
	ElseIf BaseID == 114100		;������
		Return 10000.0
	ElseIf BaseID == 114096		;��������
		Return 10000.0
	ElseIf BaseID == 638127	    ;�������
		Return 10000.0
	ElseIf BaseID == 115627	    ;�����
		Return 10000.0
	ElseIf BaseID == 115626	    ;������
		Return 10000.0
	ElseIf BaseID == 114104	    ;���������
		Return 10000.0
	ElseIf BaseID == 114098	    ;������ �����
		Return 10000.0
	EndIf
	Return -1.1
EndFunction

Float Function UniqueXPMods(Form BaseForm)
	If BaseForm == GetFormFromFile(0x0067AD, "RFAB_AE.esp") ;����� �������� ������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(77431, "tbmchrysamere.esp") ;���������
		Return 120000.0
	ElseIf BaseForm == GetFormFromFile(490084, "Requiem.esp") ;���������� ���� ������ �� ����� ������
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(288609, "Requiem.esp") ;���������� ���� �� �������
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(281586, "Requiem.esp") ;����� ������ �������
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(2163270, "Requiem.esp") ;����
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E9, "RFAB_AE.esp") ;���������� �������-���� � ����������
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(4922794, "Requiem.esp") ;���� �������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006779, "RFAB_AE.esp") ;��
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E6, "RFAB_AE.esp") ;���-������
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E5, "RFAB_AE.esp") ;����� ������
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352255, "Requiem.esp") ;������ ���� ����������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x00677A, "RFAB_AE.esp") ;����
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(283006, "Requiem.esp") ;���'��
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E8, "RFAB_AE.esp") ;�����
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(3481934, "Requiem.esp") ;������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(471506, "Requiem.esp") ;��� �����
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E7, "RFAB_AE.esp") ;��������� ��������
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(3836959, "Requiem.esp") ;����
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x00677B, "RFAB_AE.esp") ;���
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E4, "RFAB_AE.esp") ;���� ������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FC, "RFAB_AE.esp") ;��'������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FD, "RFAB_AE.esp") ;������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067F3, "RFAB_AE.esp") ;������
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067AE, "RFAB_AE.esp") ;������ �������
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(283002, "Requiem.esp") ;����
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(11351779, "Requiem.esp") ;���� �������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FF, "RFAB_AE.esp") ;������ ������� ����
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FE, "RFAB_AE.esp") ;���� ��������
		Return 40000.0
;=====================================�����������===========================================================
ElseIf BaseForm == GetFormFromFile(11352772, "Requiem.esp") ;������� (������)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352725, "Requiem.esp") ;�������� (������ �����)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352728, "Requiem.esp") ;�������� (�������� ��������)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352726, "Requiem.esp") ;������ (����� �������)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(4434135, "Requiem.esp") ;������� (��������� ������)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352771, "Requiem.esp") ;����� (����� ���)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x00679D, "RFAB_AE.esp") ;������� (�������)
		Return 30000.0
;===========================================================================================================
	ElseIf BaseForm == GetFormFromFile(0x006802, "RFAB_AE.esp") ;������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x006803, "RFAB_AE.esp") ;�������
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x006805, "RFAB_AE.esp") ;���'���
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006808, "RFAB_AE.esp") ;����'���
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x006807, "RFAB_AE.esp") ;��������� ��������-������
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(0x006809, "RFAB_AE.esp") ;��� ������
		Return 0.0
	ElseIf BaseForm == GetFormFromFile(0x006685, "RFAB_AE.esp") ;����������� ��������
		Return 0.0
	ElseIf BaseForm == GetFormFromFile(0x006825, "RFAB_AE.esp") ;������ ׸���� ������
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x006826, "RFAB_AE.esp") ;����� ������
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x006828, "RFAB_AE.esp") ;������ ��������
		Return 40000.0
	ElseIf BaseForm == GetFormFromFile(0x006829, "RFAB_AE.esp") ;������� �����
		Return 500000.0
	ElseIf BaseForm == GetFormFromFile(0x00682B, "RFAB_AE.esp") ;�������� �������
		Return 40000.0
	ElseIf BaseForm == GetFormFromFile(0x006736, "RFAB_AE.esp") ;�������� ������
		Return 60000.0
;===========================================================================================================
	ElseIf BaseForm == GetFormFromFile(0x0066C1, "RFAB_AE.esp") ;������ ���-��
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0066BE, "RFAB_AE.esp") ;�������� ��-���
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x0066BF, "RFAB_AE.esp") ;������ ���-�����
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x0066C3, "RFAB_AE.esp") ;������ ����������
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x0066C0, "RFAB_AE.esp") ;������� ���������� ����
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x00672F, "RFAB_AE.esp") ;��� ������
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006727, "RFAB_AE.esp") ;��������
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006730, "RFAB_AE.esp") ;�������
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006708, "RFAB_AE.esp") ;�������
		Return 200000.0
;=====================================��������������������==================================================
	ElseIf BaseForm == GetFormFromFile(0x006810, "RFAB_AE.esp") ;������ ��������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006812, "RFAB_AE.esp") ;�����
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006811, "RFAB_AE.esp") ;�������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x00681A, "RFAB_AE.esp") ;������� ������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006814, "RFAB_AE.esp") ;���������� ������� ����
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006815, "RFAB_AE.esp") ;�����
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006C92, "RFAB_AE.esp") ;������������ ������
		Return 50000.0
;=====================================�����==================================================
	ElseIf BaseForm == GetFormFromFile(0x000801, "Umbra RFAB Edition.esp") ;�����
		Return 500000.0
;=====================================�� SKYRIM.ESM==================================================
	ElseIf BaseForm == GetFormFromFile(0x0812FC, "Skyrim.esm") ;����� ������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x01C902, "Skyrim.esm") ;������ ���������
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x04D8D3, "Skyrim.esm") ;���������� ������ �� ���������
		Return 7000.0
	ElseIf BaseForm == GetFormFromFile(0x04D8D4, "Skyrim.esm") ;��������� ������ �� ���������
		Return 7000.0

	EndIf
	Return -1.1
EndFunction