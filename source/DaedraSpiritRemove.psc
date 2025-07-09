Scriptname DaedraSpiritRemove extends Actor

float property timer auto
EffectShader property NecroDeathFXS auto

EVENT onLoad()
	self.SetPlayerTeammate(true, true)
	NecroDeathFXS.play(self, 1.0)
	utility.wait(timer)

  self.kill()
ENDEVENT

Event OnDying(Actor akKiller)
	NecroDeathFXS.play(self)
	utility.wait(1.0)
  self.Delete()
EndEvent
