Scriptname RFAB_MarkRecallScript extends ActiveMagicEffect  

objectreference property Mark auto
message property  MarkOrRecall auto
cell property qasmoke auto

Event OnEffectStart(Actor Caster, Actor Target)
	if 	Mark.GetParentCell() != qasmoke 
		int choice = MarkOrRecall.Show()
		if choice == 0
			Game.Getplayer().Moveto(Mark)
		else
			Mark.Moveto(Game.GetPlayer())
		endif
	else
		Mark.Moveto(Game.GetPlayer())
	endif

endevent