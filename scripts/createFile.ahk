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
    result := InputBox("Enter file name (example: hello.js, hello.js -e, hello.js -e notepad)", "Create File")
    if result.Result = "Cancel"  ; User pressed Cancel
        return

    userInput := result.Value

    ; ------------------------------------------
    ; Check for '-e' flag (optional editor after it)
    ; ------------------------------------------
    defaultEditorPath := "C:\Users\abpra\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    openEditor := false
    customEditor := ""

    eFlagPos := InStr(userInput, " -e", false, -1)
    if (eFlagPos) {
        flagTail := SubStr(userInput, eFlagPos + 3)
        if (flagTail = "" || SubStr(flagTail, 1, 1) = " ") {
            openEditor := true
            customEditor := Trim(flagTail)
            userInput := Trim(SubStr(userInput, 1, eFlagPos - 1))
        }
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

    if (folderPath = "") {
        MsgBox("Could not get folder path!`n`nMake sure you're in File Explorer.")
        return
    }

    ; ------------------------------------------
    ; Validate and clean file name
    ; ------------------------------------------
    userInput := Trim(userInput)
    if (userInput = "") {
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
    if FileExist(filePath) {
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
    catch as err {
        MsgBox("Error creating file: " err.Message "`n`nPath: " filePath)
        return
    }

    ; ------------------------------------------
    ; If '-e' flag was used, open the file in editor
    ; ------------------------------------------
    if (openEditor) {
        if (customEditor = "") {
            Run('"' defaultEditorPath '" "' filePath '"')
        }
        else {
            try
            {
                Run(customEditor ' "' filePath '"')
            }
            catch {
                try
                {
                    Run('"' customEditor '" "' filePath '"')
                }
                catch as err {
                    MsgBox("Could not open editor command: " customEditor "`n`n" err.Message)
                }
            }
        }
    }
}
