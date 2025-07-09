Scriptname Mirel_TrackInSameLocation extends ActiveMagicEffect
 
    Actor property playerRef auto
 
    Event OnEffectStart(Actor akTarget, Actor akCaster)
        Utility.Wait(0.1) ; Обязательно
		akTarget.MoveTo(playerRef)
    EndEvent 
