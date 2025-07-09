Scriptname zTeleport extends activemagiceffect  

ObjectReference property teleDest auto

VisualEffect Property VFX  Auto  

VisualEffect Property VFX2  Auto  

VisualEffect Property VFX3  Auto  

VisualEffect Property VFX4  Auto  


Event OnEffectStart(Actor target, Actor caster)
   VFX.Play(Game.GetPlayer())
   Utility.Wait(1.0)
   VFX2.Play(Game.GetPlayer())
   Utility.Wait(1.0)
   VFX3.Play(Game.GetPlayer())
   Utility.Wait(1.0)
   Game.FadeOutGame(False, True, 2.0, 1.0)
   Game.GetPlayer().MoveTo(teleDest)
   Game.EnableFastTravel()
   Game.FastTravel(teleDest)
   VFX.Stop(Game.GetPlayer())
   VFX2.Stop(Game.GetPlayer())
   VFX3.Stop(Game.GetPlayer())
EndEvent

Event OnEffectFinish(Actor target, Actor caster)
   VFX3.Play(Game.GetPlayer())
   VFX2.Play(Game.GetPlayer())
   VFX4.Play(Game.GetPlayer())
   Utility.Wait(2.0)
   VFX3.Stop(Game.GetPlayer())
   VFX2.Stop(Game.GetPlayer())
   VFX4.Stop(Game.GetPlayer())
EndEvent



