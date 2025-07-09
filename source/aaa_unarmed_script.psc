       ; Скрипт для надевания кастетов.
       ; Автор Dimitry
       ;-----------------------
       Scriptname aaa_Unarmed_Script extends ObjectReference  
       
        ;----Property--------
         Armor Property Cestus Auto
       
        ;----Event----------
         Event OnEquipped(Actor akActor)
                   akActor.EquipItem(Cestus, false, true)
         EndEvent
         
         Event OnUnequipped(Actor akActor)
                   akActor.UnequipItem(Cestus, false, true)
         EndEvent
         
