Scriptname RFAB_SetBonus extends ActiveMagicEffect  

Actor Owner

Keyword[] Property ActiveSets Auto
{������� �� ������ ������ ����}
Spell[] Property ActiveBonuses Auto
{������ �� ���� �����}

string PrefixSetKeyword = "RFAB_KW_Set"
string PrefixSetSpell = "RFAB_Spell_Set"

bool IsNeedUpdate = false

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Owner = akTarget
	ActiveSets = new Keyword[9]
	ActiveBonuses = new Spell[9]
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	int i = 0
	while (i < ActiveBonuses.Length)
		Owner.RemoveSpell(ActiveBonuses[i])
		i += 1
	endwhile
EndEvent

Event OnBeginState()
    if IsNeedUpdate
    	IsNeedUpdate = false
		FullEvaluate()
    endif
EndEvent

Event OnObjectEquipped(Form akObject, ObjectReference akReference)
	if (akObject as Armor || akObject as Weapon) && GetSetKeyword(akObject)
		FullEvaluate()
	endif
EndEvent

Event OnObjectUnequipped(Form akObject, ObjectReference akReference)
	if (akObject as Armor || akObject as Weapon) && GetSetKeyword(akObject)
		FullEvaluate()
	endif
EndEvent

State Busy
	Event OnObjectEquipped(Form akObject, ObjectReference akReference)
		if (akObject as Armor || akObject as Weapon) && GetSetKeyword(akObject)
			IsNeedUpdate = true
		endif
	EndEvent

	Event OnObjectUnEquipped(Form akObject, ObjectReference akReference)
		if (akObject as Armor || akObject as Weapon) && GetSetKeyword(akObject)
			IsNeedUpdate = true
		endif
	EndEvent
EndState

Function FullEvaluate()
	GoToState("Busy")
	Evaluate()
	GoToState("")
EndFunction

Function Evaluate()
	Form[] kEquipped = GetEquipped()
	Keyword[] kNewSets = new Keyword[9]

	int i = 0
	while (i < kEquipped.Length)
		Keyword kSetKeyword = GetSetKeyword(kEquipped[i])
		if kSetKeyword
			int iEmptyID = kNewSets.Find(None)
			kNewSets[iEmptyID] = kSetKeyword
		endif
		i += 1
	endwhile

	i = 0
	while (i < ActiveSets.Length)
		Keyword kActiveSet = ActiveSets[i]
		Keyword kNewSet = kNewSets[i]
		if (kActiveSet != kNewSet)
			if (kNewSets.Find(kActiveSet) == -1)
				Owner.RemoveSpell(ActiveBonuses[i])
				ActiveBonuses[i] = None
			endif			
			if (ActiveSets.Find(kNewSet) == -1)
				Spell kNewSetAbility = GetSpellFromKeyword(kNewSet)
				Owner.AddSpell(kNewSetAbility, false)
				ActiveBonuses[i] = kNewSetAbility
			endif
		endif
		i += 1
	endwhile
	ActiveSets = kNewSets
EndFunction

; ///////////////////////////////////////////////////////////////////////////////

Spell Function GetSpellFromKeyword(Keyword akKeyword)
	string sKeywordString = akKeyword.GetString()
	string sSetName = StringUtil.Substring(sKeywordString, StringUtil.GetLength(PrefixSetKeyword), StringUtil.GetLength(sKeywordString))
	return PO3_SKSEFunctions.GetFormFromEditorID(PrefixSetSpell + sSetName) as Spell
EndFunction

Keyword Function GetSetKeyword(Form akForm)
	Keyword[] kKeywords = akForm.GetKeywords()
	int i = 0
	while (i < kKeywords.Length)
		if StringUtil.Find(kKeywords[i].GetString(), PrefixSetKeyword) != -1	
			return kKeywords[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

Form[] Function GetEquipped()
	Form[] kEquipped = New Form[9]
	kEquipped[0] = Owner.GetEquippedArmorInSlot(30)  ; ������
	kEquipped[1] = Owner.GetEquippedArmorInSlot(32)  ; ����
	kEquipped[2] = Owner.GetEquippedArmorInSlot(33)  ; ����
	kEquipped[3] = Owner.GetEquippedArmorInSlot(35)  ; ������	
	kEquipped[4] = Owner.GetEquippedArmorInSlot(36)  ; ������
	kEquipped[5] = Owner.GetEquippedArmorInSlot(37)  ; ����
	kEquipped[6] = Owner.GetEquippedArmorInSlot(42)  ; �����
	kEquipped[7] = Owner.GetEquippedObject(0)        ; ����� ����
	kEquipped[8] = Owner.GetEquippedObject(1)        ; ������ ����
	return kEquipped
EndFunction