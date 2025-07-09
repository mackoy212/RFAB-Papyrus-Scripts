Scriptname RFAB_ClassSystem_GetClassAbility extends ActiveMagicEffect  

String Property ImmersiveDescription Auto
String Property CancelText Auto
Spell Property GetClassAbility Auto
FormList Property PlayerClassesList Auto
Quest Property ClassSystemMasterQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	String[] Buttons = Utility.CreateStringArray(PlayerClassesList.GetSize() + 1)
	int Iteration = 0
	while Iteration < Buttons.Length - 1
		Buttons[Iteration] = PlayerClassesList.GetAt(Iteration).GetName()
		Iteration += 1
	endwhile
	Buttons[Iteration] = CancelText

	int Choose = Skymessage.ShowArray(ImmersiveDescription, Buttons, getIndex = true) as int
	if Choose != Iteration
		Game.GetPlayer().AddSpell(PlayerClassesList.GetAt(Choose) as Spell)
		Game.GetPlayer().RemoveSpell(GetClassAbility)
		ClassSystemMasterQuest.Stop()
	endif
EndEvent