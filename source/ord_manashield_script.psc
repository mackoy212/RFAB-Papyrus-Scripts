;/ Decompiled by Champollion V1.0.1
Source   : ORD_ManaShield_Script.psc
Modified : 2017-04-15 16:09:59
Compiled : 2017-04-15 16:10:00
User     : Maximilian
Computer : MARUNAE
/;
scriptName ORD_ManaShield_Script extends activemagiceffect

;-- Properties --------------------------------------
actor property PlayerRef auto
Float property ORD_DrainMult auto
String property ORD_StatToDrain auto
Float property ORD_UpdateRate auto
Float property ORD_CutoffPoint auto

;-- Variables ---------------------------------------
Float CurrentHealth
Float LastHealth

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function OnUpdate()

	CurrentHealth = PlayerRef.GetActorValue("Health")
	if CurrentHealth < LastHealth
		PlayerRef.DamageActorValue(ORD_StatToDrain, (LastHealth - CurrentHealth) * ORD_DrainMult)
	endIf
	LastHealth = CurrentHealth
	self.RegisterForSingleUpdate(ORD_UpdateRate)
endFunction

function OnEffectStart(actor akTarget, actor akCaster)

	LastHealth = PlayerRef.GetActorValue("Health")
	self.RegisterForSingleUpdate(ORD_UpdateRate)
endFunction
