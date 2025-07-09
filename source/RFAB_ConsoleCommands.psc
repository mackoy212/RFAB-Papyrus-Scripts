Scriptname RFAB_ConsoleCommands extends ReferenceAlias  

string Property Console = "Console" AutoReadOnly
int Property Enter = 0x1C AutoReadOnly

Actor Player

int LastCommandID = -1

Event OnInit()
	Player = Game.GetPlayer()
	RegisterForMenu(Console)
EndEvent

Event OnPlayerLoadGame()
	RegisterForMenu(Console)  
EndEvent

Event OnMenuOpen(string asMenuName)
	RegisterForKey(Enter)
EndEvent

Event OnMenuClose(string asMenuName)
	UnregisterForAllKeys()
EndEvent

Event OnKeyDown(int aiKey)
	int iCommandID = UI.GetInt(Console, "_global.Console.ConsoleInstance.Commands.length") - 1
	string sUserInput = UI.GetString(Console, "_global.Console.ConsoleInstance.Commands." + iCommandID)

	string sCommand = StringUtil.Split(sUserInput, " ")[0]
	string[] sArguments = StringUtil.Split(StringUtil.SubString(sUserInput, StringUtil.GetLength(sCommand)), " ")

	GoToState(sCommand)
	RunCommand(sArguments)
	GoToState("")
EndEvent

Function RemoveErrorMessage()
	string History = UI.GetString(Console, "_global.Console.ConsoleInstance.CommandHistory.text")
	int i = StringUtil.GetLength(History) - 1
	while i > 0
		i -= 1
		string char = StringUtil.GetNthChar(History, i)
		if StringUtil.AsOrd(char) == 13
			i = -i
		endif
	endwhile
	History = StringUtil.Substring(History, 0, -i + 1)
	UI.SetString(Console, "_global.Console.ConsoleInstance.CommandHistory.text", History)
EndFunction

Function Print(string asText)
	UI.InvokeString(Console, "_global.Console.AddHistory", asText)
EndFunction

Function CommandAccept()
	RemoveErrorMessage()
EndFunction

; Команды ===========================================================================================

Function RunCommand(string[] asArguments)
EndFunction

State GiveExp
	Function RunCommand(string[] asArguments)
		CommandAccept()
		(Quest.GetQuest("RFAB_XP") as RFAB_XP_Handler).ModXP(asArguments[0] as int)
	EndFunction
EndState

State Test
	Function RunCommand(string[] asArguments)
		CommandAccept()
		Weapon Vorpal = PO3_SKSEFunctions.GetFormFromEditorID("REQ_NULL_testVorpalSword") as Weapon
		if Player.GetItemCount(Vorpal) == 0
			Player.AddItem(Vorpal)
		endif
		Player.EquipItem(Vorpal)
		(Quest.GetQuest("RFAB_MCM").GetAliasByID(0) as RFAB_MCM_Alias).IsFastTravelAllowed = true
		Debug.SetGodMode(true)    
	EndFunction
EndState

State Deja
	Function RunCommand(string[] asArguments)
		CommandAccept()
		RFAB_PapyrusFunctions.ShowQuestNotification("Mackoy чмо, а Deja красава")
	EndFunction
EndState

State GetResist
	Function RunCommand(string[] asArguments)
		CommandAccept()
		Actor Target = Game.GetCurrentConsoleRef() as Actor
		if !Target
			return
		endif
		string Body = ""
		Body += Target.GetDisplayName() + "\n"
		Body += "Броня = " + (Target.GetActorValue("DamageResist") as int) + "\n"
		Body += "Сопротивление болезням = " + (Target.GetActorValue("DiseaseResist") as int) + "\n"
		Body += "Сопротивление ядам = " + (Target.GetActorValue("PoisonResist") as int) + "\n"
		Body += "Сопротивление магии = " + (Target.GetActorValue("MagicResist") as int) + "\n"    
		Body += "Сопротивление огню = " + (Target.GetActorValue("FireResist") as int) + "\n"
		Body += "Сопротивление холоду = " + (Target.GetActorValue("FrostResist") as int) + "\n"
		Body += "Сопротивление электричеству = " + (Target.GetActorValue("ElectricResist") as int) + "\n"
		Body += "Шанс поглощения заклинаний = " + (Target.GetActorValue("AbsorbChance") as int) + "\n"         
		SkyMessage.Show(Body, "OK")
	EndFunction
EndState

State Heal
	Function RunCommand(string[] asArguments)
		CommandAccept()
		Actor Target = Game.GetCurrentConsoleRef() as Actor
		if !Target
			return
		endif
		if (asArguments[0] as int) as bool
			Target.RestoreActorValue("Health", Target.GetActorValueMax("Health"))
		endif
		if (asArguments[1] as int) as bool
			Target.RestoreActorValue("Magicka", Target.GetActorValueMax("Magicka"))
		endif
		if (asArguments[2] as int) as bool
			Target.RestoreActorValue("Stamina", Target.GetActorValueMax("Stamina"))
		endif
	EndFunction
EndState

State Push
	Function RunCommand(string[] asArguments)
		CommandAccept()
		ObjectReference kRef = Game.GetCurrentConsoleRef()
		if (kRef)
			MiscUtil.WriteToFile("PushedObjects.txt", kRef + " " + kRef.GetDisplayName() + "\n")
		endif
	EndFunction
EndState