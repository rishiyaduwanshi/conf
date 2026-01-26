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
    InputBox, userInput, Create File, Enter file name (example: hello.js or hello.js -e)
    if ErrorLevel  ; User pressed Cancel
        return

    ; ------------------------------------------
    ; Check for '-e' flag to open in editor
    ; ------------------------------------------
    openEditor := false
    if InStr(userInput, " -e")
    {
        openEditor := true
        StringReplace, userInput, userInput,  -e,, All  ; Remove the flag from file name
    }

    ; ------------------------------------------
    ; Get current folder path from File Explorer
    ; ------------------------------------------
    folderPath := ""
    for window in ComObjCreate("Shell.Application").Windows
    {
        if (window.hwnd = WinActive("A"))
        {
            folderPath := window.Document.Folder.Self.Path
            break
        }
    }

    if (folderPath = "")
    {
        MsgBox, Could not determine current folder path.
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
        MsgBox, File already exists!
        return
    }

    ; ------------------------------------------
    ; Create the empty file
    ; ------------------------------------------
    FileAppend,, %filePath%

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
        Run, "%editorPath%" "%filePath%"
    }
}
return
