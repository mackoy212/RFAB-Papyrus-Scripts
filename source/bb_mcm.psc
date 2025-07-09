scriptname BB_MCM extends SKI_ConfigBase

bool MiningVal = true

int ReduceLootIndex = 0
int ReduceGoldIndex = 0
int ReduceMerchantIndex = 0

string[] ReduceLootList
string[] ReduceGoldList
string[] ReduceMerchantList

event OnConfigInit()

	ReduceLootList = new string[6]
	ReduceLootList[0] = "�� ���������"
	ReduceLootList[1] = "� 2 ���� ������"
	ReduceLootList[2] = "� 4 ���� ������"
	ReduceLootList[3] = "� 6 ��� ������"
	ReduceLootList[4] = "� 8 ��� ������"
	ReduceLootList[5] = "� 10 ��� ������"
		
	ReduceGoldList = new string[6]
	ReduceGoldList[0] = "�� ���������"
	ReduceGoldList[1] = "� 2 ���� ������"
	ReduceGoldList[2] = "� 4 ���� ������"
	ReduceGoldList[3] = "� 6 ��� ������"
	ReduceGoldList[4] = "� 8 ��� ������"
	ReduceGoldList[5] = "� 10 ��� ������"

	ReduceMerchantList = new string[6]
	ReduceMerchantList[0] = "�� ���������"
	ReduceMerchantList[1] = "� 2 ���� ������"
	ReduceMerchantList[2] = "� 4 ���� ������"
	ReduceMerchantList[3] = "� 6 ��� ������"
	ReduceMerchantList[4] = "� 8 ��� ������"
	ReduceMerchantList[5] = "� 10 ��� ������"

endEvent

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("��������� ���")
	AddMenuOptionST("ReduceLootST", "���", ReduceLootList[ReduceLootIndex])
	AddMenuOptionST("ReduceGoldST", "������", ReduceGoldList[ReduceGoldIndex])
	AddMenuOptionST("ReduceMerchantST", "��������", ReduceMerchantList[ReduceMerchantIndex])
	SetCursorPosition(1)
	AddHeaderOption("������")
	AddToggleOptionST("MiningST", "����� ��� ������ ����", MiningVal)
EndEvent 

state ReduceLootST
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ReduceLootIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ReduceLootList)
	endEvent

	event OnMenuAcceptST(int index)
		ReduceLootIndex = index
		SetMenuOptionValueST(ReduceLootList[ReduceLootIndex])
		If ReduceLootIndex == 0
			ApplyReduceLoot(1.0)
		Elseif ReduceLootIndex == 1
			ApplyReduceLoot(2.0)
		Elseif ReduceLootIndex == 2
			ApplyReduceLoot(4.0)
		Elseif ReduceLootIndex == 3
			ApplyReduceLoot(6.0)
		Elseif ReduceLootIndex == 4
			ApplyReduceLoot(8.0)
		Elseif ReduceLootIndex == 5
			ApplyReduceLoot(10.0)
		Endif
	endEvent

	event OnDefaultST()
		ReduceLootIndex = 0
		SetMenuOptionValueST(ReduceLootList[ReduceLootIndex])
		ApplyReduceLoot(1.0)
	endEvent

	event OnHighlightST()
		SetInfoText("��������� ���������� ���� � ��������� ���������� ���")
	endEvent
endState

Function ApplyReduceLoot(float x)
	FZR_0LootChanceNone.SetValueInt(100 - Math.Ceiling(100/x))
	FZR_5LootChanceNone.SetValueInt(100 - Math.Ceiling(95/x))
	FZR_20LootChanceNone.SetValueInt(100 - Math.Ceiling(80/x))
	FZR_25LootChanceNone.SetValueInt(100 - Math.Ceiling(75/x))
	FZR_50LootChanceNone.SetValueInt(100 - Math.Ceiling(50/x))
	FZR_75LootChanceNone.SetValueInt(100 - Math.Ceiling(25/x))
	FZR_80LootChanceNone.SetValueInt(100 - Math.Ceiling(20/x))
	FZR_85LootChanceNone.SetValueInt(100 - Math.Ceiling(15/x))
	FZR_90LootChanceNone.SetValueInt(100 - Math.Ceiling(10/x))
	FZR_95LootChanceNone.SetValueInt(100 - Math.Ceiling(5/x))
EndFunction

state ReduceGoldST
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ReduceGoldIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ReduceGoldList)
	endEvent

	event OnMenuAcceptST(int index)
		ReduceGoldIndex = index
		SetMenuOptionValueST(ReduceGoldList[ReduceGoldIndex])
		If ReduceGoldIndex == 0
			ApplyReduceGold(1.0)
		Elseif ReduceGoldIndex == 1
			ApplyReduceGold(2.0)
		Elseif ReduceGoldIndex == 2
			ApplyReduceGold(4.0)
		Elseif ReduceGoldIndex == 3
			ApplyReduceGold(6.0)
		Elseif ReduceGoldIndex == 4
			ApplyReduceGold(8.0)
		Elseif ReduceGoldIndex == 5
			ApplyReduceGold(10.0)
		Endif
	endEvent

	event OnDefaultST()
		ReduceGoldIndex = 0
		SetMenuOptionValueST(ReduceGoldList[ReduceGoldIndex])
		ApplyReduceGold(1.0)
	endEvent

	event OnHighlightST()
		SetInfoText("��������� ���������� ������ � ��������� ���������� ���")
	endEvent
endState

Function ApplyReduceGold(float x)
	FZR_0GoldChanceNone.SetValueInt(100 - Math.Ceiling(100/x))
	FZR_10GoldChanceNone.SetValueInt(100 - Math.Ceiling(90/x))
	FZR_50GoldChanceNone.SetValueInt(100 - Math.Ceiling(50/x))
	FZR_75GoldChanceNone.SetValueInt(100 - Math.Ceiling(25/x))
	FZR_80GoldChanceNone.SetValueInt(100 - Math.Ceiling(20/x))
EndFunction

state ReduceMerchantST
	event OnMenuOpenST()
		SetMenuDialogStartIndex(ReduceMerchantIndex)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ReduceMerchantList)
	endEvent

	event OnMenuAcceptST(int index)
		ReduceMerchantIndex = index
		SetMenuOptionValueST(ReduceMerchantList[ReduceMerchantIndex])
		If ReduceMerchantIndex == 0
			ApplyReduceMerchant(1.0)
		Elseif ReduceMerchantIndex == 1
			ApplyReduceMerchant(2.0)
		Elseif ReduceMerchantIndex == 2
			ApplyReduceMerchant(4.0)
		Elseif ReduceMerchantIndex == 3
			ApplyReduceMerchant(6.0)
		Elseif ReduceMerchantIndex == 4
			ApplyReduceMerchant(8.0)
		Elseif ReduceMerchantIndex == 5
			ApplyReduceMerchant(10.0)
		Endif
	endEvent

	event OnDefaultST()
		ReduceMerchantIndex = 0
		SetMenuOptionValueST(ReduceMerchantList[ReduceMerchantIndex])
		ApplyReduceMerchant(1.0)
	endEvent

	event OnHighlightST()
		SetInfoText("��������� ���������� ������ � ��������� ���������� ���")
	endEvent
endState

Function ApplyReduceMerchant(float x)
	FZR_0MerchantChanceNone.SetValueInt(100 - Math.Ceiling(100/x))
	FZR_10MerchantChanceNone.SetValueInt(100 - Math.Ceiling(90/x))
	FZR_25MerchantChanceNone.SetValueInt(100 - Math.Ceiling(75/x))
	FZR_50MerchantChanceNone.SetValueInt(100 - Math.Ceiling(50/x))
	FZR_75MerchantChanceNone.SetValueInt(100 - Math.Ceiling(25/x))
	FZR_85MerchantChanceNone.SetValueInt(100 - Math.Ceiling(15/x))
	FZR_95MerchantChanceNone.SetValueInt(100 - Math.Ceiling(5/x))
EndFunction

State MiningST
	event OnSelectST()
		MiningVal = !MiningVal
		SetToggleOptionValueST(MiningVal)
		MiningGV.SetValueInt(MiningVal as int)
	endEvent
	
	event OnDefaultST()
		MiningVal = true
		SetToggleOptionValueST(MiningVal)
		MiningGV.SetValueInt(MiningVal as int)
	endEvent
	
	event OnHighlightST()
		SetInfoText("����������� ����������� ������ ���� � ������ ���������� ����.\n�� ���������: ���.")
	endEvent
EndState

GlobalVariable Property FZR_0LootChanceNone Auto
GlobalVariable Property FZR_5LootChanceNone Auto
GlobalVariable Property FZR_20LootChanceNone Auto
GlobalVariable Property FZR_25LootChanceNone Auto
GlobalVariable Property FZR_50LootChanceNone Auto
GlobalVariable Property FZR_75LootChanceNone Auto
GlobalVariable Property FZR_80LootChanceNone Auto
GlobalVariable Property FZR_85LootChanceNone Auto
GlobalVariable Property FZR_90LootChanceNone Auto
GlobalVariable Property FZR_95LootChanceNone Auto

GlobalVariable Property FZR_0GoldChanceNone Auto
GlobalVariable Property FZR_10GoldChanceNone Auto
GlobalVariable Property FZR_50GoldChanceNone Auto
GlobalVariable Property FZR_75GoldChanceNone Auto
GlobalVariable Property FZR_80GoldChanceNone Auto

GlobalVariable Property FZR_0MerchantChanceNone Auto
GlobalVariable Property FZR_10MerchantChanceNone Auto
GlobalVariable Property FZR_25MerchantChanceNone Auto
GlobalVariable Property FZR_50MerchantChanceNone Auto
GlobalVariable Property FZR_75MerchantChanceNone Auto
GlobalVariable Property FZR_85MerchantChanceNone Auto
GlobalVariable Property FZR_95MerchantChanceNone Auto

GlobalVariable Property MiningGV Auto