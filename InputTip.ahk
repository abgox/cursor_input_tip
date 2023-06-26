#Requires AutoHotkey v2.0
CoordMode "Mouse", "Screen"
#Include function\get_admin_permission.ahk
#Include function\get_input_state.ahk
#SingleInstance Force

; 配置项
Options := {
    font_family: "SimHei",    ;字体
    font_size: 18,    ; 字体大小
    font_weight: 900,    ; 字体粗细
    font_color: "ffffff",    ; 字体颜色
    font_bgcolor: "474E68",    ; 背景颜色
    windowTransparent: 222,    ; 透明度
    ; 输入状态显示文字
    CN_Text: "中", ; 中文显示
    EN_Text: "英", ; 英文显示
    ; 显示框偏移量
    offset_x: 50,
    offset_y: -80,
}

get_admin_permisstion()

Edge_width := A_ScreenWidth - 100, Edge_height := A_ScreenHeight - 200

makeGUi(Text, options) {
    make_gui := Gui("-Caption  AlwaysOnTop ToolWindow OwnDialogs +LastFound")
    make_gui.SetFont("s" options.font_size " c" options.font_color " w" options.font_weight " q5", options.font_family)
    make_gui.BackColor := options.font_bgcolor
    make_gui.MarginX := "5"
    make_gui.MarginY := "5"
    WinSetTransparent(options.windowTransparent)    ; 设置透明度
    make_gui.AddText(, Text)
    return make_gui
}

CNTipGui := makeGUi(Options.CN_Text, Options), ENTipGUi := makeGUi(Options.EN_Text, Options)

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
            ? (ENTipGui.Hide(), CNTipGui.Show("NA AutoSize X" Xpos + Options.offset_x " Y" Ypos + Options.offset_y " "))
            : (CNTipGui.Hide(), ENTipGui.Show("NA AutoSize X" Xpos + Options.offset_x " Y" Ypos + Options.offset_y " "))
    }
}
