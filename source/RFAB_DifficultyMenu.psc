Scriptname RFAB_DifficultyMenu extends Quest  

float[] Property DamageToPlayer Auto Hidden 
{ Урон получаемый игроком }
float[] Property DamageByPlayer Auto Hidden 
{ Урон наносимый игроком }
float Property DamageWithCurse Auto Hidden 
{ Урон наносимый проклятым игроком }

string[] Property DifficultyNames Auto Hidden
string[] Property DifficultyInfo Auto Hidden

bool Property Cursed = false Auto Hidden
int Property DifficultyIndex Auto Hidden

Event OnInit()
	DamageToPlayer = new float[3]
	DamageToPlayer[0] = 50.0 * 0.01
	DamageToPlayer[1] = 100.0 * 0.01
	DamageToPlayer[2] = 200.0 * 0.01
	DamageByPlayer = new float[3]
	DamageByPlayer[0] = 200.0 * 0.01
	DamageByPlayer[1] = 100.0 * 0.01
	DamageByPlayer[2] = 100.0 * 0.01
	DamageWithCurse = 50.0 * 0.01

	DifficultyNames = new string[3]
	DifficultyNames[0] = "Странник"
	DifficultyNames[1] = "Довакин"
	DifficultyNames[2] = "Легенда"
	
	DifficultyInfo = new string[3]
	DifficultyInfo[0] = "Рекомендуется для новичков RFAB. Враги будут прощать ваши ошибки. \nВраги наносят половину урона, а ваш урон увеличен вдвое."
	DifficultyInfo[1] = "Игра жестока, но при должном подходе вы сможете справиться с любыми трудностями.\nВраги наносят стандартный урон."
	DifficultyInfo[2] = "Враги становятся гораздо опаснее и сражения с ними требуют более тщательной подготовки.\nВраги наносят в два раза больше урона."
EndEvent

Function UpdateDifficulty()
	float _damageByPlayer

	if Cursed
		_damageByPlayer = DamageWithCurse
		Game.SetGameSettingfloat("fDiffMultHPByPCL", DamageWithCurse)
	else
		_damageByPlayer = DamageByPlayer[DifficultyIndex]
		Game.SetGameSettingfloat("fDiffMultHPByPCL", DamageByPlayer[DifficultyIndex])
	endIf

	Game.SetGameSettingFloat("fDiffMultHPByPCVE", _damageByPlayer)
	Game.SetGameSettingFloat("fDiffMultHPByPCE", _damageByPlayer)
	Game.SetGameSettingFloat("fDiffMultHPByPCN", _damageByPlayer)
	Game.SetGameSettingFloat("fDiffMultHPByPCH", _damageByPlayer)
	Game.SetGameSettingFloat("fDiffMultHPByPCVH", _damageByPlayer)

	Game.SetGameSettingFloat("fDiffMultHPToPCL", DamageToPlayer[DifficultyIndex])
	Game.SetGameSettingFloat("fDiffMultHPToPCVE", DamageToPlayer[DifficultyIndex])
	Game.SetGameSettingFloat("fDiffMultHPToPCE", DamageToPlayer[DifficultyIndex])
	Game.SetGameSettingFloat("fDiffMultHPToPCN", DamageToPlayer[DifficultyIndex])
	Game.SetGameSettingFloat("fDiffMultHPToPCH", DamageToPlayer[DifficultyIndex])
	Game.SetGameSettingFloat("fDiffMultHPToPCVH", DamageToPlayer[DifficultyIndex])
EndFunction

Function SetDifficulty(int aiIndex)
	DifficultyIndex = aiIndex
	UpdateDifficulty()
EndFunction

Function SetCurse(bool abCursed)
	Cursed = abCursed
	UpdateDifficulty()
EndFunction

Function Open()
	DifficultyIndex = GetMenuIndex()
	UpdateDifficulty()
EndFunction

int Function GetMenuIndex()
	if ui.IsMenuOpen("CustomMenu")
		ui.CloseCustomMenu()
		return -1
	else
		ui.OpenCustomMenu("RFAB_DifficultyMenu", 0)
		String[] InitParams = new String[14]
		InitParams[0] = "Выбор сложности"
		InitParams[1] = true as String
		InitParams[2] = 1 as String
		InitParams[3] = 28 as String
		InitParams[4] = 1 as String
		InitParams[5] = 15 as String
		InitParams[6] = 54 as String
		InitParams[7] = 42 as String
		InitParams[8] = 276 as String
		InitParams[9] = 277 as String
		InitParams[10] = 22 as String
		InitParams[11] = 1 as String
		InitParams[12] = 1 as String
		ui.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.InitMessageBox", InitParams)
		ui.Invoke("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons")
		return DifficultyMenuResult()
	endIf
EndFunction

int function DifficultyMenuResult()
	while ui.IsMenuOpen("CustomMenu") && ui.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") < 9
		Utility.Wait(0.2)
	endWhile
	if ui.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 9
		Int result = ui.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
		Cursed = ui.GetBool("CustomMenu", "_root.RFAB_MessageBoxMC.Cursed")
		ui.CloseCustomMenu()
		return result
	else
		ui.CloseCustomMenu()
		return -1
	endIf
EndFunction
