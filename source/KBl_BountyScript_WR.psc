Scriptname KBl_BountyScript_WR extends TopicInfo  


MiscObject[] Property Trophies  Auto  
MiscObject Property Gold001  Auto  
Bool iReady = false

Function Fragment_0(ObjectReference akSpeakerRef)

    Int i = 0
    Int RewardGold = 0
	Int TrophiesValue = 1000
    While  i < Trophies.length
        If game.GetPlayer().GetItemCount(Trophies[i]) > 0
            iReady = true
            RewardGold += game.GetPlayer().GetItemCount(Trophies[i]) * TrophiesValue 
            game.GetPlayer().RemoveItem(Trophies[i], game.GetPlayer().GetItemCount(Trophies[i]), true, none)
        EndIf
        i += 1
    EndWhile
    If iReady
        game.GetPlayer().AddItem(Gold001, RewardGold, false)
    EndIf
EndFunction




