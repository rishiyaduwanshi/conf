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
    Run(systemRoot . "\System32\WindowsPowerShell\v1.0\powershell.exe", currentPath)

}
