; AutoHotkey Version : v2.0+

GetActiveTabExplorerPath() {
    activeHwnd := WinActive("ahk_class CabinetWClass")
    if (!activeHwnd)
        return

    explorer := ComObject("Shell.Application")
    for window in explorer.Windows {
        try {
            if (window.HWND == activeHwnd) {
                fullPath := window.Document.Folder.Self.Path

                pathParts := StrSplit(fullPath, "\")
                lastFolder := pathParts[pathParts.Length]

                title := WinGetTitle("ahk_id " . activeHwnd)

                if InStr(title, lastFolder) {
                    return fullPath
                }
            }
        } catch {
            ; ignore non-folder windows
        }
    }
}

; ========= IDE Paths =========
global editors := Map(
    "V", "C:\Users\abpra\AppData\Local\Programs\Microsoft VS Code\Code.exe",
    "C", "S:\cursor\Cursor.exe",
    "T", "S:\Trae\Trae.exe",
    "A", "S:\Android Studio\bin\studio64.exe",
    "I", "C:\Program Files\JetBrains\IntelliJ IDEA\bin\idea64.exe",
    "G", "S:\Antigravity IDE\Antigravity IDE.exe"
)

!t:: {
    winClass := WinGetClass("A")
    systemRoot := EnvGet("SystemRoot")
    userProfile := EnvGet("USERPROFILE")
    currentPath := userProfile

    if (winClass == "CabinetWClass") {
        currentPath := GetActiveTabExplorerPath()
    } else if (winClass = 'progman') {
        currentPath := A_Desktop
    } else if (WinGetProcessName("A") = "code.exe") {
        Send("^+c")
        return
    }
    Run("pwsh", currentPath)

}

!e:: {
    winClass := WinGetClass("A")
    currentPath := ""

    if (winClass = "CabinetWClass")
        currentPath := GetActiveTabExplorerPath()
    else if (winClass = "Progman" || winClass = "WorkerW")
        currentPath := A_Desktop

    ; ========= GUI =========
    gui1 := Gui("+AlwaysOnTop -Caption +Border +ToolWindow")
    gui1.BackColor := "202020"
    gui1.SetFont("s10 cFFFFFF", "Segoe UI")

    gui1.AddText(, "Open Folder In")
    gui1.AddText(, "")
    gui1.AddText(, "[V] VS Code")
    gui1.AddText(, "[C] Cursor")
    gui1.AddText(, "[T] Trae")
    gui1.AddText(, "[A] Android Studio")
    gui1.AddText(, "[I] IntelliJ IDEA")
    gui1.AddText(, "[G] Antigravity")
    gui1.AddText(, "")
    gui1.AddText("c87CEEB", "[B] Blank Mode")
    gui1.AddText("cAAAAAA", "Esc - Cancel")

    gui1.Show("AutoSize Center")

    ih := InputHook("L1 T5")
    ih.KeyOpt("{Esc}", "E")
    ih.Start()
    ih.Wait()

    gui1.Destroy()

    if (ih.EndKey = "Escape" || ih.EndReason = "Timeout")
        return

    key := StrUpper(ih.Input)

    isBlankMode := false

    if (key = "B") {
        isBlankMode := true

        ih2 := InputHook("L1 T5")
        ih2.KeyOpt("{Esc}", "E")
        ih2.Start()
        ih2.Wait()

        if (ih2.EndKey = "Escape" || ih2.EndReason = "Timeout")
            return

        key := StrUpper(ih2.Input)
    }

    if !editors.Has(key)
        return

    if (isBlankMode)
        Run('"' editors[key] '"')
    else if (currentPath)
        Run('"' editors[key] '" "' currentPath '"')
    else
        Run('"' editors[key] '"')
}
