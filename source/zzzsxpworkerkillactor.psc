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
	If Find(pActor.GetFactions(0,127), "0002E894") >= 0 && Find(pRace, "Riekling") <= 0 || Find(pRace, "Mammoth") > 0 || Find(pRace, "DLC2Netch") > 0 ;Мамонты нетчи и дичь
		Return 0.0
	EndIf

	float fBase = pActor.GetBaseActorValue("Health")
	If Find(pRace, "DragonRace") > 0 ;Фикс для мода Deadly Dragons
		fBase *= 3.0 ;1.75
	EndIf
	fBase += pActor.GetLevel() * 10.0
	If Find(pRace, "Vampire") > 0 && pActor.GetBaseActorValue("Health") > 1500.0 ;Эбонитовые вампиры
		fBase *= 2.25 ;3.0
	ElseIf Find(pRace, "HighElfRace") > 0 && pActor.GetBaseActorValue("Health") > 999.0 && Find(pRace, "Vampire") <= 0 ;Призраки фалмеров
		fBase *= 1.5 ;3.0
	ElseIf Find(pRace, "Draugr") > 0 && pActor.GetLevel() >= 88
        fBase *= 0.83	
	EndIf

	If pActor.GetBaseObject().GetFormID() == 781797 ;Одержимый беженец
		fBase *= 0.33	
	EndIf

	If pActor.IsInFaction(game.GetFormFromFile(22414, "RFAB_AE.esp") as Faction) || pActor.IsInFaction(game.GetFormFromFile(341934, "RFAB_AE.esp") as Faction) ;Бойцы с арены
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
	if Find(pActor.GetFactions(0,127), "0001BCC0") >= 0 ;Исключение
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
	If Find(tRace, "Mirel_RfaDK_LifeWeaponRace") > 0 ;Раса волшебного оружия
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Mirel_RfaDK_RaceLifeGloves") > 0 ;Раса волшебных перчаток
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1VampireBeastRace") > 0 ;Вампир-лорд
		Return 2.5 ;5.0
	ElseIf Find(tRace, "AtronachFlameRace") > 0 ;Огненные атронахи
		Return 1.5 ;3.0
	ElseIf Find(tRace, "AtronachFrostRace") > 0 ;Морозные атронахи
		Return 2.0 ;4.0
	ElseIf Find(tRace, "AtronachStormRace") > 0 ;Грозовые атронахи
		Return 2.5 ;5.0
	ElseIf Find(tRace, "ChaurusReaperRace") > 0 ;Корус-Жнец
		Return 1.4 ;2.75
	ElseIf Find(tRace, "DLC1ChaurusHunterRace") > 0 ;Корус-охотник
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1_BF_ChaurusRace") > 0 ;Замороженный корус
		Return 1.9 ;3.75
	ElseIf Find(tRace, "ChaurusRace") > 0 ;Корус
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DLC1DeathHoundRace") > 0 ;Гончая смерти
		Return 2.0 ;4.0
	ElseIf Find(tRace, "DLC1SabreCatGlowRace") > 0 ;Долинный саблезуб
		Return 1.75
	ElseIf Find(tRace, "SabreCatSnowyRace") > 0 ;Снежный саблезуб
		Return 1.75
	ElseIf Find(tRace, "SabreCatRace") > 0 ;Саблезуб
		Return 1.75
	ElseIf Find(tRace, "DLC1SoulCairnKeeperRace") > 0 ;Смотритель
		Return 2.5 ;5.0
	ElseIf Find(tRace, "DLC1BlackSkeletonRace") > 0 ;Костяной человек
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSkeletonArmorRace") > 0 ;Яростный человек
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSkeletonNecroRace") > 0 ;Туманный человек
		Return 0.9 ;1.75
	ElseIf Find(tRace, "DLC1SoulCairnSoulWispRace") > 0 ;Шепчущий дух
		Return 0.3 ;0.5
	ElseIf Find(tRace, "dlc2AshGuardianRace") > 0 ;Пепельный страж
		Return 0.3 ;0.5
	ElseIf Find(tRace, "DLC2AshHopperRace") > 0 ;Пепельный прыгун
		Return 0.2
	ElseIf Find(tRace, "DLC2AshSpawnRace") > 0 ;Порождение пепла
		Return 0.3 ;0.5
	ElseIf Find(tRace, "DLC2BoarRace") > 0 ;Щетиноспины, дурзоги
		Return 0.3
	ElseIf Find(tRace, "DLC2DwarvenBallistaRace") > 0 ;Двемерская балиста
		Return 0.4 ;0.75
	ElseIf Find(tRace, "DLC2LurkerRace") > 0 ;Луркер
		Return 1.0 ;2.0
	ElseIf Find(tRace, "DLC2MountedRieklingRace") > 0 ;Риклинг-наездник
		Return 3.0 ;6.0
	ElseIf Find(tRace, "DLC2Netch") > 0 ;Нетч
		Return 0.2 ;0.3
	ElseIf Find(tRace, "DLC2SeekerRace") > 0 ;Искатель
		Return 0.8 ;1.5
	ElseIf Find(tRace, "DLC2SprigganBurntRace") > 0 ;Горелый спригган
		Return 1.0
	ElseIf Find(tRace, "SprigganEarthMotherRace") > 0
		Return 1.5
	ElseIf Find(tRace, "SprigganMatronRace") > 0 ;Сприган
		Return 1.5
	ElseIf Find(tRace, "SprigganRace") > 0 ;Сприган
		Return 1.0
	ElseIf Find(tRace, "WerebearBeast") > 0 ;Медведь-оборотень
		Return 5.0 ;10.0
	ElseIf Find(tRace, "BearBlackRace") > 0 ;Пещерный медведь
		Return 1.75
	ElseIf Find(tRace, "BearBrownRace") > 0 ;Обычный медведь
		Return 1.75
	ElseIf Find(tRace, "BearSnowRace") > 0 ;Белый медведь
		Return 2.0
	ElseIf Find(tRace, "DragonPriestRace") > 0 ;Обычные драконьи жрецы
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DraugrMagicRace") > 0 ;Драугр
		Return 0.35 ;1.0
	ElseIf Find(tRace, "DremoraRace") > 0 ;Дремора
		Return 1.5 ;3.0
	ElseIf Find(tRace, "DwarvenCenturionRace") > 0 ;Двемерский центурион
		Return 1.3 ;2.5
	ElseIf Find(tRace, "DwarvenSphereRace") > 0 ;Дветерская сфера
		Return 0.8 ;1.5
	ElseIf Find(tRace, "DwarvenSpider") > 0 ;Двемерский паук
		Return 0.4 ;0.75
	ElseIf Find(tRace, "FalmerFrozenVampRace") > 0 ;Замороженные фалмеры
		Return 0.4 ;0.75
	ElseIf Find(tRace, "FalmerRace") > 0 ;Фалмер
		If pActor.GetBaseActorValue("Health") >= 550.0 && pActor.GetLevel() >= 50.0
			Return 1.5 ;3.0
		Else
			Return 1.5 ;3.0
		EndIf
	ElseIf Find(tRace, "SpiderRaceGiant") > 0
		Return 1.3 ;2.5
	ElseIf Find(tRace, "SpiderRace") > 0
		Return 0.8 ;1.5
	ElseIf Find(tRace, "HagravenRace") > 0 ;Ворожея
		Return 0.2 ;0.3
	ElseIf Find(tRace, "InvisibleRace") > 0 ;Невидимки
		Return 2.5 ;5.0
	ElseIf Find(tRace, "SkeletonNecroRace") > 0 ;Порченые тени по квесту Меридии
		Return 0.7 ;1.25
	ElseIf Find(tRace, "ShoggothRace") > 0
		Return 1.0 ;2.0
	ElseIf Find(tRace, "DragonRace") > 0 ;Дракон
		Return 1.5 ;3.0
	ElseIf Find(tRace, "WolfRace") > 0 ;Волк
		Return 2.0
	ElseIf Find(tRace, "Vampire") > 0 ;Вампир
		Return 2.5 ;5.0
	ElseIf Find(tRace, "Gargoyle") > 0 ;Гаргулья
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Riekling") > 0 ;Риклинг
		Return 2.0 ;4.0
	ElseIf Find(tRace, "Troll") > 0 ;Тролль
		Return 1.5 ;2.25
	ElseIf Find(tRace, "Werewolf") > 0 ;Оборотень
		Return 5.0 ;10.0
	ElseIf Find(tRace, "Wisp") > 0 ;Мать-Дымок
		Return 2.0 ;3.5
	ElseIf Find(tRace, "Draugr") > 0 ;Драугр
        Return 0.13 ;0.25
	ElseIf Find(tRace, "Skeleton") > 0 ;Скелет
		Return 0.0
	ElseIf Find(tRace, "Giant") > 0 ;Великан
		Return 0.0
	ElseIf Find(tRace, "Mirel_RfaDK_DwarwenDefenderRace") > 0 ;Двемерский защитник
		Return 1.5 ;3.0
	ElseIf Find(tRace, "mihaildwarvenspinnerrace") > 0 ;Двемерский вращатель
		Return 1.5 ;3.0
	ElseIf Find(tRace, "Mirel_RfaDK_DwemerAutomatonRace") > 0 ;Двемерский Хранитель
		Return 1.0 ;2.0
	ElseIf Find(tRace, "mihaildwarventhresherrace") > 0 ;Двемерский Молотильщик
		Return 0.5 ;1.0
	ElseIf Find(tRace, "Mirel_RfaDK_DeepElfRace") > 0 ;Двемерский призрак
		Return 1.5 ;3.0
	ElseIf Find(tRace, "_00DwarvenPunisherRace") > 0 ;Двемерский каратель
		Return 2.5 ;5.0
	ElseIf Find(tRace, "IceWraith") > 0 ;Ледяное привидение
		Return 15.0
	EndIf
	Return 0.0
EndFunction

Float Function FactionMult(Faction[] tFactions)
	If Find(tFactions, "0001BCC0") >= 0 	;Бандиты
		Return 3.5 ;6.5
	ElseIf Find(tFactions, "000622E6") >= 0 ;Атар и наемники возле шахты Карварстен
		Return 3.5 ;6.5
	ElseIf Find(tFactions, "0001C9FC") >= 0 ;ГражданскаяВойна - Имперцы
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0001C9FD") >= 0 ;ГражданскаяВойна - ББ
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "000215D3") >= 0 ;АликИрцы - по квесту Садии
		Return 0.7 ;1.25
	ElseIf Find(tFactions, "00026724") >= 0 ;Фракция Колдунов (Warlock) - Многие маги
		Return 6.0 ;4.0
	ElseIf Find(tFactions, "00028848") >= 0 ;CrimeFactionImperial - предположительно имперский легион
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00028849") >= 0 ;CrimeFactionSons - предположительно браться бури
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002A451") >= 0 ;Наемники и обитатели поместья Златоцвет
		Return 0.5 ;1.0
	ElseIf Find(tFactions, "0002BF9A") >= 0 ;Снова имперский легион
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002BF9B") >= 0 ;Снова братья бури
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "0002EB13") >= 0 ;Вампирские Треллы
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "00034B74") >= 0 ;Некроманты
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "000C0637") >= 0 ;Охрана северной сторожевой крепости
		Return 3.5 ;7.0
	ElseIf Find(tFactions, "00039F26") >= 0 ;Талмор
		Return 3.5 ;7.0
	ElseIf Find(tFactions, "00043599") >= 0 ;Изгои
		Return 3.0 ;5.5
	ElseIf Find(tFactions, "000E3609") >= 0 ;Изгои из пещеры Друадах
		Return 3.0 ;5.5
	ElseIf Find(tFactions, "00043AB7") >= 0 ;Одержимые по квесту Оркендора
		Return 2.5 ;4.75
	ElseIf Find(tFactions, "00058B3D") >= 0 ;Кемату и АликрИрцы Кемату
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00068C8C") >= 0 ;Наемники Черного Вереска
		Return 1.7 ;3.25
	ElseIf Find(tFactions, "0006BB1E") >= 0 ;Стража фортов гражданской войны (чубзики что сидят в захваченных фортах)
		Return 1.5 ;3.0
	ElseIf Find(tFactions, "00073543") >= 0 ;Ингвильдские призраки и драугр+Арондил
		Return 0.4 ;0.75
	ElseIf Find(tFactions, "0007A509") >= 0 ;Жрецы вермины
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "0007A50A") >= 0 ;Жрецы вермины
		Return 2.0 ;4.0
	ElseIf Find(tFactions, "00088EE4") >= 0 ;Бандиты черной крови
		Return 2.0 ;3.5
	ElseIf Find(tFactions, "000A2CB0") >= 0 ;МейлинВарен и стража мясника
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "000AA0A4") >= 0 ;Серебряная рука
		Return 3.0 ;6.0
	ElseIf Find(tFactions, "000B3292") >= 0 ;Дозорные стендарра
		Return 0.8 ;1.5
	ElseIf Find(tFactions, "000BC033") >= 0 ;Призраки гробницы Исграмора
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "000BA1E9") >= 0 ;Орки по квесту вермины
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "000C0160") >= 0 ;Бандиты с туманной заставы
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "000DEED5") >= 0 ;Соловьи-Стражи в сумеречной гробнице
		Return 1.0 ;2.0
	ElseIf Find(tFactions, "000E16CA") >= 0 ;Орки по квесту вермины
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "020135BD") >= 0 ;Очарованные дозорные, это по квесту даунгарда
		Return 1.8 ;3.5
	ElseIf Find(tFactions, "0402929A") >= 0 ;Мораг Тонг
		Return 1.0 ;2.0
	ElseIf Find(tFactions, "04034FBC") >= 0 ;Культисты Мираака
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "040200E7") >= 0 ;НПЦ что обладают иммунитетом к крику Подчинение воли
		Return 2.5 ;5.0
	ElseIf Find(tFactions, "0004359E") >= 0 ;Ведьмы / Карги / ворожеи
		Return 7.0 ;3.0
	ElseIf Find(tFactions, "00085D43") >= 0 ;Диллеры скумы(враги)
		Return 4.0 ;6.5
	EndIf
	Return 0.0
EndFunction

Float Function UniqueXP(Int BaseID)
	If BaseID == 67258601		;Азидал
		Return 200000.0
	ElseIf BaseID == 207764		;Алдуин
		Return 500000.0
	ElseIf BaseID == 208285		;Алдуин
		Return 500000.0
	ElseIf BaseID == 276351		;Алдуин
		Return 500000.0
	ElseIf BaseID == 279114		;Алдуин
		Return 500000.0
	ElseIf BaseID == 582897		;Алдуин
		Return 500000.0
	ElseIf BaseID == 321980		;Алдуин
		Return 500000.0
	ElseIf BaseID == 110708		;Ален Дюфон
		Return 10000.0
	ElseIf BaseID == 124887		;Анкано
		Return 100000.0
	ElseIf BaseID == 228736		;Арондил
		Return 40000.0
	ElseIf BaseID == 668650		;Башнаг
		Return 50000.0
	ElseIf BaseID == 866292		;Бледная Леди
		Return 50000.0
	ElseIf BaseID == 841292		;Брандиш
		Return 70000.0
	ElseIf BaseID == 67226325	;Валок Тюремщик
		Return 500000.0
	ElseIf BaseID == 106470		;Валс Веран
		Return 70000.0
	ElseIf BaseID == 33570051	;Ваник
		Return 150000.0
	ElseIf BaseID == 482431		;Велек Сейн
		Return 50000.0
	ElseIf BaseID == 67207812	;Вендил Северин
		Return 60000.0
	ElseIf BaseID == 374832		;Вигхар
		Return 150000.0
	ElseIf BaseID == 33568648	;Викарий Виртур
		Return 300000.0
	ElseIf BaseID == 206786		;Вокун
		Return 150000.0
	ElseIf BaseID == 361219		;Волчий дух Кодлака
		Return 50000.0
	ElseIf BaseID == 268592		;Вольсунг
		Return 100000.0
	ElseIf BaseID == 33623705	;Восларум
		Return 250000.0
	ElseIf BaseID == 518855		;Вультурьйол
		Return 150000.0
	ElseIf BaseID == 315974		;Вызывающая
		Return 70000.0
	ElseIf BaseID == 82216		;Галмор Каменный Кулак
		Return 30000.0
	ElseIf BaseID == 853360		;Галмор Каменный Кулак
		Return 30000.0
	ElseIf BaseID == 959874		;Галмор Каменный Кулак
		Return 30000.0
	ElseIf BaseID == 78462		;Генерал Туллий
		Return 30000.0
	ElseIf BaseID == 853367		;Генерал Туллий
		Return 30000.0
	ElseIf BaseID == 67216740	;Генерал Фалкс Карий
		Return 70000.0
	ElseIf BaseID == 78477		;Джари-Ра
		Return 30000.0
	ElseIf BaseID == 78440		;Диджа
		Return 40000.0
	ElseIf BaseID == 652128		;Дознаватель крепости
		Return 40000.0
	ElseIf BaseID == 596268		;Дракон-скелет
		Return 150000.0
	ElseIf BaseID == 67258593	;Дукан
		Return 200000.0
	ElseIf BaseID == 943661		;Дух-страж волка
		Return 70000.0
	ElseIf BaseID == 943659		;Дух-страж грязевого краба
		Return 70000.0
	ElseIf BaseID == 943662		;Дух-страж злокрыса
		Return 70000.0
	ElseIf BaseID == 949935		;Дух-страж мамонта
		Return 70000.0
	ElseIf BaseID == 949929		;Дух-страж медведя
		Return 70000.0
	ElseIf BaseID == 949933		;Дух-страж саблезуба
		Return 70000.0
	ElseIf BaseID == 949938		;Дух-страж тролля
		Return 70000.0
	ElseIf BaseID == 33566936	;Дюрневир
		Return 300000.0
	ElseIf BaseID == 33605402	;Дюрневир (призванный)
		Return 0.0
	ElseIf BaseID == 33662782	;Жнец
		Return 500000.0
	ElseIf BaseID == 67258600	;Закрисош
		Return 200000.0
	ElseIf BaseID == 67204923	;Илдари Саротрил
		Return 70000.0
	ElseIf BaseID == 119993		;Император
		Return 100000.0
	ElseIf BaseID == 119994		;Император, фэйк
		Return 10000.0
	ElseIf BaseID == 123787		;Капитан Харгар
		Return 30000.0
	ElseIf BaseID == 67212901	;Карстааг
		Return 70000.0
	ElseIf BaseID == 1055174	;Квенел (босс Волундруда)
		Return 70000.0
	ElseIf BaseID == 136705		;Кемату
		Return 30000.0
	ElseIf BaseID == 236471		;Корнал
		Return 40000.0
	ElseIf BaseID == 792840		;Красный Орел
		Return 70000.0
	ElseIf BaseID == 1050471	;Кросис
		Return 70000.0
	ElseIf BaseID == 297813		;Куралмил
		Return 50000.0
	ElseIf BaseID == 78497		;Легат Рикке
		Return 30000.0
	ElseIf BaseID == 853363		;Легат Рикке
		Return 30000.0
	ElseIf BaseID == 513657		;Линви
		Return 10000.0
	ElseIf BaseID == 33617151	;Локил
		Return 150000.0
	ElseIf BaseID == 33569703	;Лорд Харкон
		Return 500000.0
	ElseIf BaseID == 33614876	;Лорд Харкон
		Return 500000.0
	ElseIf BaseID == 33614986	;Лорд Харкон
		Return 500000.0
	ElseIf BaseID == 33663293	;Лорд Харкон
		Return 500000.0
	ElseIf BaseID == 144186		;Луа Аль-Скавен
		Return 70000.0
	ElseIf BaseID == 33570053	;Малк
		Return 150000.0
	ElseIf BaseID == 641894		;Малкоран
		Return 70000.0
	ElseIf BaseID == 33641473	;Мастер-Кузнец
		Return 150000.0
	ElseIf BaseID == 165106		;Мастер Ритуалов
		Return 40000.0
	ElseIf BaseID == 166611		;Мейлин Варен
		Return 60000.0
	ElseIf BaseID == 110716		;Мерсер Фрей
		Return 50000.0
	ElseIf BaseID == 702207		;Микрул Голдурсон
		Return 50000.0
	ElseIf BaseID == 33634339	;Минорна
		Return 30000.0
	ElseIf BaseID == 67205430	;Мирак
		Return 500000.0
	ElseIf BaseID == 67205432	;Мирак
		Return 500000.0
	ElseIf BaseID == 67207037	;Мирак
		Return 500000.0
	ElseIf BaseID == 67207041	;Мирак
		Return 500000.0
	ElseIf BaseID == 67238296	;Мирак
		Return 500000.0
	ElseIf BaseID == 67238808	;Мирак
		Return 500000.0
	ElseIf BaseID == 67240153	;Мирак
		Return 500000.0
	ElseIf BaseID == 572305		;Моварт
		Return 70000.0
	ElseIf BaseID == 1001836	;Морокеи
		Return 200000.0
	ElseIf BaseID == 1016987	;Накрин
		Return 200000.0
	ElseIf BaseID == 272294		;Нарис Порочный
		Return 40000.0
	ElseIf BaseID == 33623708	;Насларум
		Return 250000.0
	ElseIf BaseID == 67238288	;Огненный змей
		Return 0.0
	ElseIf BaseID == 286584		;Оркендор
		Return 70000.0
	ElseIf BaseID == 630575		;Освобожденный дремора
		Return 40000.0
	ElseIf BaseID == 1062043	;Останки Потемы
		Return 70000.0
	ElseIf BaseID == 226874		;Отар Безумный
		Return 200000.0
	ElseIf BaseID == 217937		;Рагот
		Return 200000.0
	ElseIf BaseID == 237343		;Рулиндил
		Return 40000.0
	ElseIf BaseID == 115941		;Себастьян Лорт
		Return 60000.0
	ElseIf BaseID == 682050		;Сигдис Голдурсон
		Return 50000.0
	ElseIf BaseID == 682056		;Сигдис Голдурсон (подделка)
		Return 0.0
	ElseIf BaseID == 307374		;Сильвия
		Return 40000.0
	ElseIf BaseID == 334207		;Сильд Чернокнижник
		Return 40000.0
	ElseIf BaseID == 79532		;Синдинг, оборотень
		Return 20000.0
	ElseIf BaseID == 67228910	;Смотритель Нчардака
		Return 70000.0
	ElseIf BaseID == 401704		;Старый орк
		Return 70000.0
	ElseIf BaseID == 225886		;Страж Сирек
		Return 50000.0
	ElseIf BaseID == 225841		;Страж Торстен
		Return 50000.0
	ElseIf BaseID == 966190		;Тень Малкорана
		Return 70000.0
	ElseIf BaseID == 213503		;Торек
		Return 40000.0
	ElseIf BaseID == 684859		;Туран
		Return 150000.0
	ElseIf BaseID == 82253		;Ульфрик Буревестник
		Return 30000.0
	ElseIf BaseID == 853365		;Ульфрик Буревестник
		Return 30000.0
	ElseIf BaseID == 959873		;Ульфрик Буревестник
		Return 30000.0
	ElseIf BaseID == 591673		;Фьола
		Return 20000.0
	ElseIf BaseID == 67216243	;Хакнир Печать Смерти
		Return 70000.0
	ElseIf BaseID == 121860		;Халдин
		Return 40000.0
	ElseIf BaseID == 317159		;Хевнорак
		Return 150000.0
	ElseIf BaseID == 412444		;Холдир
		Return 50000.0
	ElseIf BaseID == 537854		;Чемпион Боэтии
		Return 70000.0
	ElseIf BaseID == 67274179	;Эбонитовый воин
		Return 200000.0
	ElseIf BaseID == 216471		;Эстормо
		Return 10000.0
	ElseIf BaseID == 113448		;Юрик Голдурсон
		Return 50000.0
	ElseIf BaseID == 79481		;Гунзул
		Return 40000.0
	ElseIf BaseID == 947913		;Дрелас
		Return 10000.0
	ElseIf BaseID == 244774		;Вождь Йамарз
		Return 40000.0
	ElseIf BaseID == 724615		;Поклонник Боэтии
		Return 40000.0
	ElseIf BaseID == 925569		;Хайварр Железная Рука
		Return 10000.0
	ElseIf BaseID == 67205046	;Пепельный страж
		Return 0.0
	ElseIf BaseID == 885310		;Мясник
		Return 20000.0
	ElseIf BaseID == 548164		;Орини Дрел
		Return 10000.0
	ElseIf BaseID == 548161		;Сартис Идрен
		Return 10000.0
	ElseIf BaseID == 655180		;Изгой с красным орлом
		Return 30000.0
	ElseIf BaseID == 117253		;Мирмулнир (раненый дракон)
		Return 70000.0
	ElseIf BaseID == 114100		;Астрид
		Return 10000.0
	ElseIf BaseID == 114096		;Арнбьорн
		Return 10000.0
	ElseIf BaseID == 638127	    ;Цицерон
		Return 10000.0
	ElseIf BaseID == 115627	    ;Назир
		Return 10000.0
	ElseIf BaseID == 115626	    ;Визара
		Return 10000.0
	ElseIf BaseID == 114104	    ;Габриэлла
		Return 10000.0
	ElseIf BaseID == 114098	    ;Фестус Крекс
		Return 10000.0
	EndIf
	Return -1.1
EndFunction

Float Function UniqueXPMods(Form BaseForm)
	If BaseForm == GetFormFromFile(0x0067AD, "RFAB_AE.esp") ;Агнар Железная Борода
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(77431, "tbmchrysamere.esp") ;Браннсгит
		Return 120000.0
	ElseIf BaseForm == GetFormFromFile(490084, "Requiem.esp") ;Гигантская рыба убийца со щитом Дагона
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(288609, "Requiem.esp") ;Гигантский краб на острове
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(281586, "Requiem.esp") ;Горак Убийца троллей
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(2163270, "Requiem.esp") ;Гром
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E9, "RFAB_AE.esp") ;Двемерский призрак-босс в Кагрензеле
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(4922794, "Requiem.esp") ;Джон Безумец
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006779, "RFAB_AE.esp") ;За
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E6, "RFAB_AE.esp") ;Зел-Мзбаин
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E5, "RFAB_AE.esp") ;Кадак Мезалф
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352255, "Requiem.esp") ;Король Олаф Одноглазый
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x00677A, "RFAB_AE.esp") ;Крий
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(283006, "Requiem.esp") ;Кру'ул
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E8, "RFAB_AE.esp") ;Мзарк
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(3481934, "Requiem.esp") ;Рагнок
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(471506, "Requiem.esp") ;Рон Ворон
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E7, "RFAB_AE.esp") ;Смотрящий Мтансела
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(3836959, "Requiem.esp") ;Снег
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x00677B, "RFAB_AE.esp") ;Сош
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067E4, "RFAB_AE.esp") ;Тень Ингола
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FC, "RFAB_AE.esp") ;До'Сакхар
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FD, "RFAB_AE.esp") ;Шаглаг
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067F3, "RFAB_AE.esp") ;Брурид
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(0x0067AE, "RFAB_AE.esp") ;Тилоре Малорен
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(283002, "Requiem.esp") ;Улик
		Return 20000.0
	ElseIf BaseForm == GetFormFromFile(11351779, "Requiem.esp") ;Элси Спайкер
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FF, "RFAB_AE.esp") ;Ригель Сильная Рука
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0067FE, "RFAB_AE.esp") ;Крев Шкуродер
		Return 40000.0
;=====================================ОТВЕРЖЕННЫЕ===========================================================
ElseIf BaseForm == GetFormFromFile(11352772, "Requiem.esp") ;Вайалаг (Мидден)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352725, "Requiem.esp") ;Райцейра (Звезда азуры)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352728, "Requiem.esp") ;Киррхала (Крепость Феллглоу)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352726, "Requiem.esp") ;Оберот (Крыло Пелагия)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(4434135, "Requiem.esp") ;Миморот (Святилище Дагона)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(11352771, "Requiem.esp") ;Сирот (Каирн Душ)
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x00679D, "RFAB_AE.esp") ;Разофот (Апокриф)
		Return 30000.0
;===========================================================================================================
	ElseIf BaseForm == GetFormFromFile(0x006802, "RFAB_AE.esp") ;Альрик
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x006803, "RFAB_AE.esp") ;Косолап
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x006805, "RFAB_AE.esp") ;Сэй'Жин
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006808, "RFAB_AE.esp") ;Дрег'Тал
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x006807, "RFAB_AE.esp") ;Хранитель Каркетта-Вампир
		Return 60000.0
	ElseIf BaseForm == GetFormFromFile(0x006809, "RFAB_AE.esp") ;Дух Даэдра
		Return 0.0
	ElseIf BaseForm == GetFormFromFile(0x006685, "RFAB_AE.esp") ;Призываемый Искатель
		Return 0.0
	ElseIf BaseForm == GetFormFromFile(0x006825, "RFAB_AE.esp") ;Рэйгар Чёрная Смерть
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x006826, "RFAB_AE.esp") ;Страж Крипты
		Return 50000.0
	ElseIf BaseForm == GetFormFromFile(0x006828, "RFAB_AE.esp") ;Первый помощник
		Return 40000.0
	ElseIf BaseForm == GetFormFromFile(0x006829, "RFAB_AE.esp") ;Снежный Принц
		Return 500000.0
	ElseIf BaseForm == GetFormFromFile(0x00682B, "RFAB_AE.esp") ;Королева корусов
		Return 40000.0
	ElseIf BaseForm == GetFormFromFile(0x006736, "RFAB_AE.esp") ;Тельдрин Терано
		Return 60000.0
;===========================================================================================================
	ElseIf BaseForm == GetFormFromFile(0x0066C1, "RFAB_AE.esp") ;Бестия Дро-Ра
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x0066BE, "RFAB_AE.esp") ;Смертник Им-Шей
		Return 30000.0
	ElseIf BaseForm == GetFormFromFile(0x0066BF, "RFAB_AE.esp") ;Дурзол гро-Ягарз
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x0066C3, "RFAB_AE.esp") ;Сьорта Полутролль
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x0066C0, "RFAB_AE.esp") ;Капитан Гилейнский Волк
		Return 70000.0
	ElseIf BaseForm == GetFormFromFile(0x00672F, "RFAB_AE.esp") ;Сир Жермен
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006727, "RFAB_AE.esp") ;Уршамасу
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006730, "RFAB_AE.esp") ;Дотиэль
		Return 150000.0
	ElseIf BaseForm == GetFormFromFile(0x006708, "RFAB_AE.esp") ;Кадрайн
		Return 200000.0
;=====================================БОССЫБАНДИТЫСЛАГЕРЕЙ==================================================
	ElseIf BaseForm == GetFormFromFile(0x006810, "RFAB_AE.esp") ;Вангар Одичалый
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006812, "RFAB_AE.esp") ;Драгс
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006811, "RFAB_AE.esp") ;Древори
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x00681A, "RFAB_AE.esp") ;Нарикус Бронин
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006814, "RFAB_AE.esp") ;Наркобарон Каммона Тонг
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006815, "RFAB_AE.esp") ;Уркар
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x006C92, "RFAB_AE.esp") ;Военачальник Гатрик
		Return 50000.0
;=====================================УМБРА==================================================
	ElseIf BaseForm == GetFormFromFile(0x000801, "Umbra RFAB Edition.esp") ;Умбра
		Return 500000.0
;=====================================ИЗ SKYRIM.ESM==================================================
	ElseIf BaseForm == GetFormFromFile(0x0812FC, "Skyrim.esm") ;Ульфр Слепой
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x01C902, "Skyrim.esm") ;Халвар Нетрезвый
		Return 10000.0
	ElseIf BaseForm == GetFormFromFile(0x04D8D3, "Skyrim.esm") ;Поклонница Боэтии из Святилища
		Return 7000.0
	ElseIf BaseForm == GetFormFromFile(0x04D8D4, "Skyrim.esm") ;Поклонник Боэтии из Святилища
		Return 7000.0

	EndIf
	Return -1.1
EndFunction