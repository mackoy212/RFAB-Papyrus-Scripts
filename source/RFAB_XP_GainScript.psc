;/ Decompiled by Champollion V1.0.1
Source   : RFAB_XP_GainScript.psc
Modified : 2022-12-29 02:14:10
Compiled : 2022-12-29 02:14:17
User     : Ilya
Computer : HOME-PC
/;
scriptName RFAB_XP_GainScript extends Quest

;-- Properties --------------------------------------
race property ImperialRace auto
race property ImperialRaceVampire auto
globalvariable property RFAB_XP_Rest auto
globalvariable property RFAB_XP_Amount auto
armor property TonarRing auto
sound property RFAB_QuestCompleteSound auto

;-- Variables ---------------------------------------
Int last_index_book
book[] BookReadList

string IconPath = "skyui/icons_item_psychosteve.swf"
int BookID = 52
;-- Functions ---------------------------------------

function RFAB_XP_Kill(actor Victim)

	Int race_multiplier = 1
	Int amount_xp_gained = 0
	String Victim_name = Victim.GetLeveledActorBase().GetName()
	String Victim_race_name = (Victim.Getrace() as form).GetName()
	String BossList = "BossList.json"
	String RaceList = "RaceList.json"
	amount_xp_gained = jsonutil.GetIntValue(BossList, Victim_name, -1)
	if amount_xp_gained == -1
		race_multiplier = jsonutil.GetIntValue(RaceList, Victim_race_name, 0)
		amount_xp_gained = Victim.GetLevel() * race_multiplier
	endIf
	if Victim_name == "Изгой" && game.GetPlayer().IsEquipped(TonarRing as form)
		amount_xp_gained = math.Floor(amount_xp_gained as Float * 1.10000)
	endIf
	if amount_xp_gained != 0
		amount_xp_gained = self.RoundXPAndRestedXP(amount_xp_gained)
		RFAB_XP_Amount.SetValue(RFAB_XP_Amount.GetValue() + amount_xp_gained as Float)
		String NotificationColor = jsonutil.GetStringValue("RFAB_XP_Settings.json", "Notification color", "")
		((self as form) as uilib_1).shownotification(Victim_name + " " + "(Lvl " + Victim.GetLevel() as String + "): " + amount_xp_gained as String + " XP", NotificationColor)
	endIf
endFunction

Int function RoundXPAndRestedXP(Int amount_xp_gained)

	if RFAB_XP_Rest.GetValue() >= amount_xp_gained as Float * 0.100000
		Float xp_rest_add = amount_xp_gained as Float * 0.100000
		amount_xp_gained += math.Floor(xp_rest_add)
		RFAB_XP_Rest.SetValue((RFAB_XP_Rest.GetValue() as Int) as Float - xp_rest_add)
	else
		amount_xp_gained += RFAB_XP_Rest.GetValue() as Int
		RFAB_XP_Rest.SetValue(0 as Float)
	endIf
	if game.GetPlayer().Getrace() == ImperialRace || game.GetPlayer().Getrace() == ImperialRaceVampire
		amount_xp_gained = math.Floor(amount_xp_gained as Float * 1.10000)
	endIf
	Int LastXPDigit = stringutil.Substring(amount_xp_gained as String, stringutil.GetLength(amount_xp_gained as String) - 1, 1) as Int
	if LastXPDigit != 0 && LastXPDigit != 5
		if LastXPDigit < 5
			return amount_xp_gained - LastXPDigit + 5
		else
			return amount_xp_gained - LastXPDigit + 10
		endIf
	else
		return amount_xp_gained
	endIf
endFunction

; Skipped compiler generated GotoState

function RFAB_XP_QuestComplete(Int amount_xp_gained, Quest QuestID, String override_message)

	amount_xp_gained = self.RoundXPAndRestedXP(amount_xp_gained)
	RFAB_XP_Amount.SetValue(RFAB_XP_Amount.GetValue() + amount_xp_gained as Float)
	String NotificationColor = jsonutil.GetStringValue("RFAB_XP_Settings.json", "Notification color", "")
	RFAB_QuestCompleteSound.Play(game.GetPlayer() as objectreference)
	if override_message == ""
		if QuestID == none
			((self as form) as uilib_1).shownotification("Выполнен основной сюжетный квест: " + amount_xp_gained as String + " XP", NotificationColor)
		else
			((self as form) as uilib_1).shownotification("Выполнен квест ''" + QuestID.GetName() + "'': " + amount_xp_gained as String + " XP", NotificationColor)
		endIf
	else
		((self as form) as uilib_1).shownotification(override_message + amount_xp_gained as String + " XP", NotificationColor)
	endIf
endFunction

; Skipped compiler generated GetState

function RFAB_XP_BookRead(book thisbook)

	Int i = 0
	while i < last_index_book + 1
		if thisbook == BookReadList[i]
			i = 1000
		endIf
		i += 1
	endWhile
	if i != 1001
		Int base_book_xp = jsonutil.GetIntValue("RFAB_XP_Settings.json", "Base book xp", 0)
		Int amount_xp_gained = (game.GetPlayer().GetLevel() - 10) * 20 + base_book_xp
		if amount_xp_gained < 200
			amount_xp_gained = 200
		endIf
		if amount_xp_gained > 600
			amount_xp_gained = 600
		endIf
		amount_xp_gained = self.RoundXPAndRestedXP(amount_xp_gained)
		RFAB_XP_Amount.SetValue(RFAB_XP_Amount.GetValue() + amount_xp_gained as Float)
		String NotificationColor = jsonutil.GetStringValue("RFAB_XP_Settings.json", "Notification color", "")
		((self as form) as uilib_1).ShowNotificationIcon("Книга навыка: " + amount_xp_gained as String + " XP", IconPath, BookID, NotificationColor)
		BookReadList[last_index_book] = thisbook
		last_index_book += 1
	endIf
endFunction

function OnInit()

	BookReadList = new book[128]
endFunction
