; Settings
global name := "Fullscreen Projector" ; Fullscreen Projector name
global key := "U" ; in game Reset HotKey
global delay := 300 ; monitoring start delay (probably around 100 ~ 300 ms)
global monitoring := 1000 ; Fullscreen Projector monitoring activation (probably 1000 ms)
global mousetrigger := True ; include mouse movement to the monitoring close

#Persistent

; Main
Loop {
    IfWinActive, Minecraft,, {
        GetKeyState, key, %key%
        IF (key = "D") {
            WinSet, AlwaysOnTop, On, %name%
            Sleep, %delay%
            IfWinNotActive, Minecraft,, {
                MouseGetPos, dummy_x, dummy_y
                time_past = % A_Now A_MSec
                Loop {
                    IfWinActive, Minecraft
                        break      
                    MouseGetPos, x, y
                    If (mousetrigger and (dummy_x != x or dummy_y != y))
                        break
                    time_now = % A_Now A_MSec
                    If (time_difference + 40001 <= time_now - time_past)
                        time_difference := time_now - time_past - 40001
                    Else
                        time_difference := time_now - time_past
                    If (time_now - time_past >= monitoring)
                        break
                }
            }
            WinSet, AlwaysOnTop, Off, %name%
        }
    }
}
