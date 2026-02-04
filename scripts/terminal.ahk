; AutoHotkey Version : v2.0+

!t:: {
    winClass := WinGetClass("A")
    systemRoot := EnvGet("SystemRoot")
    userProfile := EnvGet("USERPROFILE")
    currentPath := userProfile

    if (winClass = "CabinetWClass") {
        Send("!d")
        Sleep(100)
        Send("^c")
        Sleep(100)
        currentPath := A_Clipboard
    } else if (winClass = 'progman') {
        currentPath := A_Desktop
    } else if (WinGetProcessName("A") = "code.exe") {
        Send("^+c")
        return
    }
    Run(systemRoot . "\System32\WindowsPowerShell\v1.0\powershell.exe", currentPath)

}
