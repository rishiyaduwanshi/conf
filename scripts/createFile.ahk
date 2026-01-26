; ==========================================
; Quick File Creator
; Shortcut: Ctrl + Shift + F
; Function: 
;  1. Works in Windows File Explorer only
;  2. Pops up an input box to enter file name
;  3. Creates the file in the current Explorer folder
;  4. Optional '-e' flag: opens the file in your preferred editor
; ==========================================

^+f::  ; Ctrl+Shift+F hotkey
{
    ; ------------------------------------------
    ; Only run if the active window is File Explorer
    ; ------------------------------------------
    if !WinActive("ahk_class CabinetWClass") 
        return

    ; ------------------------------------------
    ; Show input box to get file name from user
    ; ------------------------------------------
    result := InputBox("Enter file name (example: hello.js or hello.js -e)", "Create File")
    if result.Result = "Cancel"  ; User pressed Cancel
        return
    
    userInput := result.Value

    ; ------------------------------------------
    ; Check for '-e' flag to open in editor
    ; ------------------------------------------
    openEditor := false
    if InStr(userInput, " -e")
    {
        openEditor := true
        userInput := StrReplace(userInput, " -e", "")  ; Remove the flag from file name
    }

    ; ------------------------------------------
    ; Get current folder path from File Explorer (Active Tab)
    ; ------------------------------------------
    ; Save current clipboard
    clipboardBackup := A_Clipboard
    A_Clipboard := ""
    
    ; Focus address bar and copy path
    Send("!d")  ; Alt+D to focus address bar
    Sleep(100)
    Send("^c")  ; Ctrl+C to copy path
    Sleep(100)
    
    ; Get the path from clipboard
    folderPath := A_Clipboard
    
    ; Restore clipboard
    A_Clipboard := clipboardBackup
    
    ; Refocus the file list area
    Send("{Escape}")
    
    if (folderPath = "")
    {
        MsgBox("Could not get folder path!`n`nMake sure you're in File Explorer.")
        return
    }

    ; ------------------------------------------
    ; Validate and clean file name
    ; ------------------------------------------
    userInput := Trim(userInput)
    if (userInput = "")
    {
        MsgBox("File name cannot be empty!")
        return
    }

    ; ------------------------------------------
    ; Construct full file path
    ; ------------------------------------------
    filePath := folderPath "\" userInput

    ; ------------------------------------------
    ; Check if file already exists
    ; ------------------------------------------
    if FileExist(filePath)
    {
        MsgBox("File already exists!")
        return
    }

    ; ------------------------------------------
    ; Create the empty file
    ; ------------------------------------------
    try
    {
        FileAppend("", filePath)
    }
    catch as err
    {
        MsgBox("Error creating file: " err.Message "`n`nPath: " filePath)
        return
    }

    ; ------------------------------------------
    ; If '-e' flag was used, open the file in editor
    ; ------------------------------------------
    if (openEditor)
    {
        ; ============================
        ; Enter your preferred editor location path below
        ; Example: Visual Studio Code
        ; editorPath := "C:\Program Files\Microsoft VS Code\Code.exe"
        ; Example: Notepad++
        ; editorPath := "C:\Program Files\Notepad++\notepad++.exe"
        ; ============================
        editorPath := "C:\Users\abpra\AppData\Local\Programs\Microsoft VS Code\Code.exe"
        Run('"' editorPath '" "' filePath '"')
    }
}
