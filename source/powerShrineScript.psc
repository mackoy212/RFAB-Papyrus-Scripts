Scriptname powerShrineScript extends ObjectReference

RFAB_DoomStoneMenu Property DoomStoneController Auto

Event OnActivate(ObjectReference akRef)
	if akRef != Game.GetPlayer()
		return
	endif
	if DoomStoneController.GetDoomStoneID() != 13 ; ��� ����� ���������
		debug.notification("������ ����� �� ��������� �� ��� �������������...")		
	else	
		if SkyMessage.Show(GetStandingStoneMessage(), "� ����, ��� ��� ��� ���� ��������.", "��� �� ��� ���� ��������.", getIndex = true) == 0
			int DoomStoneId = DoomStoneController.GetDoomStoneIdByName(self.GetDisplayName())
			if DoomStoneId != -1
				DoomStoneController.SetDoomStoneById(DoomStoneId)
				PlayAnimation("playanim01")
				Game.AddAchievement(29)
			endif
		endif	
	endif
EndEvent

string Function GetStandingStoneMessage()
	string DoomStoneName = self.GetDisplayName()
	return DoomStoneController.GetTextByKey(DoomStoneName, "Immersive") + "\n\n" + DoomStoneController.GetTextByKey(DoomStoneName, "Bonus")
EndFunction
