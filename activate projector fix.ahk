; Settings
global name := "Fullscreen Projector" ; Fullscreen Projector name
global key := "U" ; in game Reset HotKey
global delay := 300 ; monitoring delay (probably around 100 ~ 300 ms)
global monitoring := 1 ; Fullscreen Projector monitoring activation (probably 1 sec (integer))
global mousetrigger := True ; include mouse movement to the monitoring on/off trigger

; Main
Loop {
    IfWinActive, Minecraft,, {
        GetKeyState, key, %key%
        IF (key = "D") {
            WinSet, AlwaysOnTop, On, %name%
            Sleep, %delay%
            MouseGetPos, x, y
            dummy_x := x
            dummy_y := y
            time_past = % A_Now A_MSec
            IfWinNotActive, Minecraft,, {
                Loop {
                    IfWinActive, Minecraft
                        break      
                    MouseGetPos, x, y
                    If (mousetrigger and (dummy_x != x or dummy_y != y))
                        break
                    time_now = % A_Now A_MSec
                    If (time_past + floor(monitoring) * 1000 < time_now)
                        break
                }
            }
            WinSet, AlwaysOnTop, Off, %name%
        }
    }
}
