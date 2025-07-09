Scriptname RFAB_ScreamerScript extends ObjectReference  

objectreference property screamerobj auto
ImageSpaceModifier Property FadeToBlack  Auto  
Light Property ScreamerLight  Auto  
objectreference property SkeeverHead auto

Event OnActivate(ObjectReference akActionRef)
	
	FadeToBlack.applycrossfade(0.1)
	screamerobj .enable()
	utility.wait(1)
	ImageSpaceModifier.RemoveCrossFade(0.1)
	SkeeverHead.Placeatme(ScreamerLight  )
	utility.wait(1)
	FadeToBlack.applycrossfade(0.1)
	utility.wait(0.5)
	screamerobj .disable()
	ImageSpaceModifier.RemoveCrossFade(0.5)
endevent

