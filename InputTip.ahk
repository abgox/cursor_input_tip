#Requires AutoHotkey v2.0
CoordMode "Mouse", "Screen"
#Include function\get_admin_permission.ahk
#Include function\get_input_state.ahk
#SingleInstance Force

script_name := SubStr(A_ScriptName, 1, RegExMatch(A_ScriptName, "\.") - 1)
config_file := script_name "_config.ini"
if (!FileExist(config_file)) {
    set_config(key, value) {
        IniWrite(value, config_file, "Config", key)
    }
    set_config("font_family", "SimHei")
    set_config("font_size", 18)
    set_config("font_weight", 900)
    set_config("font_color", "ffffff")
    set_config("font_bgcolor", "474E68")
    set_config("windowTransparent", 222)
    set_config("CN_Text", "中")
    set_config("EN_Text", "英")
    set_config("offset_x", 50)
    set_config("offset_y", -80)
}
get_config(key) {
    try{
        return IniRead("InputTip_config.ini", "Config", key)
    }catch{
        MsgBox("配置文件丢失，软件强制退出，请重启恢复配置文件")
        ExitApp()
    }
}
get_admin_permisstion()

Edge_width := A_ScreenWidth - 100, Edge_height := A_ScreenHeight - 200

makeGUi(Text) {
    make_gui := Gui("-Caption  AlwaysOnTop ToolWindow OwnDialogs +LastFound")
    make_gui.SetFont("s" get_config("font_size") " c" get_config("font_color") " w" get_config("font_weight") " q5", get_config("font_family"))
    make_gui.BackColor := get_config("font_bgcolor")
    make_gui.MarginX := "5"
    make_gui.MarginY := "5"
    WinSetTransparent(get_config("windowTransparent"))
    make_gui.AddText(, Text)
    return make_gui
}

CNTipGui := makeGUi(get_config("CN_Text")), ENTipGUi := makeGUi(get_config("EN_Text"))

while true {
    Sleep(15), MouseGetPos(&Xpos, &Ypos)
    InputState := get_input_state()
    if (InputState = "null") {
        ENTipGui.Hide(), CNTipGui.Hide()
        continue
    }
    if ((Xpos < 5) || (Xpos > Edge_width && Xpos < 3000)) {
        ENTipGui.Hide(), CNTipGui.Hide()
    } else {
        InputState
            ? (ENTipGui.Hide(), CNTipGui.Show("NA AutoSize X" Xpos + get_config("offset_x") " Y" Ypos + get_config("offset_y") " "))
            : (CNTipGui.Hide(), ENTipGui.Show("NA AutoSize X" Xpos + get_config("offset_x") " Y" Ypos + get_config("offset_y") " "))
    }
}
