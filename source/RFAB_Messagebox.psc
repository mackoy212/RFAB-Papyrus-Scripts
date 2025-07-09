Scriptname RFAB_MessageBox extends Quest  

Int Function MessageBox(String sMessage, String[] Buttons = none, Bool CancelIsFirstButton = true, Int FontSize = 22, Int Align = 1, Bool html = true, Bool WaitForResult = true) Global 
    If UI.IsMenuOpen("CustomMenu") 
        UI.CloseCustomMenu()  
    Endif 
   
    String[] Button = new String[1] 
    Button[0] = "$Ok"
    
    UI.OpenCustomMenu("RFAB_messageboxmenu")
    
    While (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 0) ;wait for flash to load menu 
        ;Utility.WaitMenuMode(0.1) 
    EndWhile 
    

    
   
    String[] InitParams = new String[13] 
    InitParams[0] = sMessage
    InitParams[1] = CancelIsFirstButton as int
    InitParams[2] = WaitForResult as int
    InitParams[3] =28
    InitParams[4] =1
    InitParams[5] = 15
    InitParams[6] = 54
    InitParams[7] = 42
    InitParams[8] = 276
    InitParams[9] = 277
    InitParams[10] = FontSize
    InitParams[11] = Align
    InitParams[12] = html as int
    
    UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.InitMessageBox", InitParams) 
    
    While (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") == 1) ;wait for last flash function to finish.
        ;Utility.WaitMenuMode(0.1) 
    EndWhile 
    
    if Buttons == none || Buttons.length < 1
        UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons", Button) 
    else 
        UI.InvokeStringA("CustomMenu", "_root.RFAB_MessageBoxMC.SetButtons", Buttons)
    endif
    
    If WaitForResult
        return  GetEVMMMessageBoxResult()
    Endif
EndFunction

Int Function GetEVMMMessageBoxResult() Global
    While (UI.IsMenuOpen("CustomMenu")) && (UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.Status") < 9) ;wait for user to accept or cancel
        ;Utility.WaitMenuMode(0.1) 
    EndWhile 
    
    ;int result = UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
    int result = UI.GetInt("CustomMenu", "_root.RFAB_MessageBoxMC.akCurrentFocusIndex")
    
    UI.CloseCustomMenu()
    
    return result
EndFunction