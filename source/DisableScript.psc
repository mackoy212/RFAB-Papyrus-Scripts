Scriptname DisableScript extends ObjectReference  

ObjectReference Property Property1  Auto  

ObjectReference Property Property2  Auto  

ObjectReference Property Property3  Auto  

Event OnTriggerEnter(ObjectReference akActionRef)
if akActionRef==Varis
property1.disable()
property2.disable()
property3.disable()
endif
endevent
Actor Property Varis  Auto  
