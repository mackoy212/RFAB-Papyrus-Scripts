scriptName APT_sXPSkillBook extends ObjectReference

globalvariable property BookIsRead auto
globalvariable property XpOnBook auto
globalvariable property Xp auto
zzzSXPController Property XPC Auto

function OnRead()

	Float Percent = 10 * (game.GetPlayer().GetLevel() - 10)
	Float AddXP = XpOnBook.GetValue() * (1 + Percent / 100) as Float
	int BookXP = AddXP as int
	int BaseXpOnBook = XpOnBook.GetValue() as int

	if BookIsRead.GetValue() == 0 as Float
		BookIsRead.SetValue(1 as Float)
		if game.GetPlayer().GetLevel() > 10
			XPC.GainModXPMessage(AddXP as float, " нига навыка:", true)
		Else
			XPC.GainModXPMessage(XpOnBook.GetValue() as float, " нига навыка:", true)
		endIf
	endIf
endFunction