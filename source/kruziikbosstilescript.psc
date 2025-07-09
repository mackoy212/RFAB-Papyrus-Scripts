Scriptname KruziikBossTileScript extends ObjectReference  

ObjectReference Property Activator_Up auto
ObjectReference Property Activator_Down auto
ObjectReference Property NavCutter auto
KruziikBossController Property ControllerScript auto

bool IsDown
float zOffset = 200.0

Event OnActivate(ObjectReference akActionRef)
    if (akActionRef == Activator_Up && IsDown)
    	Self.TranslateTo(self.GetPositionX(), self.GetPositionY(), -202, self.GetAngleX(), self.GetAngleY(), self.GetAngleZ(), ControllerScript.SpeedFloat, 0)
    	self.GetLinkedRef().TranslateTo(self.GetPositionX(), self.GetPositionY(), -202, self.GetAngleX(), self.GetAngleY(), self.GetAngleZ(), ControllerScript.SpeedFloat, 0)
    	utility.wait(3)	
    	IsDown = false
    	NavCutter.Disable()
    elseif (akActionRef == Activator_Down && !IsDown)
    	Self.TranslateTo(self.GetPositionX(), self.GetPositionY(), -402, self.GetAngleX(), self.GetAngleY(), self.GetAngleZ(), ControllerScript.SpeedFloat, 0)
    	self.GetLinkedRef().TranslateTo(self.GetPositionX(), self.GetPositionY(), -402, self.GetAngleX(), self.GetAngleY(), self.GetAngleZ(), ControllerScript.SpeedFloat, 0)
    	utility.wait(3)
    	IsDown = true
    	NavCutter.Enable()
    endif
EndEvent