Scriptname RFAB_VokunScript extends ObjectReference  

ObjectReference Property HorrorMarker  Auto  
actor property Vokun auto
spell property ShadowNova auto

Event OnActivate(ObjectReference akActionRef)
if akActionRef != Game.GetPlayer()
bool horror_stage = false
	while !horror_stage
	utility.wait(0.5)
	if Vokun .getactorvalue("health") <= 3000
		horror_stage = true
		ShadowNova.cast(Game.GetPlayer())
		utility.wait(1)
		Vokun .disable()
		debug.messagebox("����� ��������� ���� �������� � ������!")
		Game.GetPlayer().Moveto(HorrorMarker)
	endif

	endwhile
endif
endevent