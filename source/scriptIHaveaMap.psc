Scriptname scriptIHaveaMap extends TopicInfo  

Quest Property NewProperty  Auto  

if newproperty.getstagedone(30)!=1
GetOwningQuest().SetObjectiveDisplayed(35)
GetOwningQuest().SetStage(35)
endif

endevent
