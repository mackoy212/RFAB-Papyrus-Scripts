Scriptname Varis_kostil extends ObjectReference  

Actor Property yobaproperty  Auto  

Event OnActivate(ObjectReference akActionRef)

yobaproperty.moveto(varis_marker)
Baglag.moveto(baglag_marker)
BanditProperty.moveto(kostil_marker)
Talen.moveto(talen_marker)

endevent

ObjectReference Property kostil_marker  Auto  


Actor Property Baglag  Auto  

ObjectReference Property Baglag_marker  Auto  

Actor Property BanditProperty  Auto  

ObjectReference Property Varis_marker  Auto  

Actor Property Talen  Auto  

ObjectReference Property Talen_marker  Auto  
