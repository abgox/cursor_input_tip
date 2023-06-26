/**
 *
 * @param {any} new 本身不存在，需要通过链接生成的文件
 * @param {any} old 本身存在，被链接的文件
 * @param {string} model 默认为f，当为f时，即使文件存在，也会删除文件强制执行
 */
file_link(new, old, model := "f") {
    pos := RegExMatch(new, "\\[^\\]*$")    ; 匹配最后一个 \
    subP1 := SubStr(new, 1, pos - 1)
    if (FileExist(subP1)) {    ; 如果存在指定文件的上一级目录
        if (FileExist(new) && model = "f") {    ; 如果指定文件也存在，且指定为强制模式
            RunWait("cmd /c del " new)
            MsgBox(new "-->  已经存在,文件删除成功", "删除提示", "T30")
        } else if (FileExist(new)) {
            MsgBox(new "-->  已经存在,函数退出", "删除提示", "T30")
            return
        }
    } else {
        RunWait("cmd /c mkdir " subP1, , "Hide")    ; 创建上一级目录
    }
    RunWait("cmd /c mklink " new " " old, , "Hide")    ; 创建文件链接
}

/**
 *
 * @param {any} new 本身不存在，需要链接的目录
 * @param {any} old 本身存在，被链接的目录
 * @param {string} model 默认为f，当为f时，即使目录存在，也会删除目录强制执行
 */
dir_link(new, old, model := "f") {
    pos := RegExMatch(new, "\\[^\\]*$")    ; 匹配最后一个 \
    subP1 := SubStr(new, 1, pos - 1)
    if (FileExist(subP1)) {
        if (FileExist(new) && model = "f") {
            MsgBox(new "-->   已经存在,正在删除目录", "删除提示", "T30")
            RunWait("cmd /c rmdir /s " new)
        } else if (FileExist(new)) {
            MsgBox(new "-->   已经存在，函数退出执行，请检查目录", "删除提示", "T30")
            return
        }
    } else {
        RunWait("cmd /c mkdir " subP1, , "Hide")    ; 创建上一级目录
        FileExist(subP1)
            ? MsgBox(subP1 "-->   目录创建成功")
            : MsgBox(subP1 "-->   目录创建失败")
    }
    Sleep(1000)
    RunWait("cmd /c mklink /J " new " " old, , "Hide")    ; 创建目录链接
}


/**
 * 文件链接函数
 * @Tip 此函数仅做备份，并未完成封装
 * @param {any} GuiName Gui名称(因为限制，需要先生成一个 Gui)
 * @param {any} obj     链接对象数组 {文件a:[链接文件,被链接文件]}
 * @param {number} rowNum  每行显示数量
 */
; link(GuiName, obj, rowNum := 2) {
;     %GuiName%.SetFont("q5 s12 w500", "Microsoft YaHei")
;     %GuiName%.AddText("", "选择以下文件，确定是否进行自动化链接")
;     %GuiName%.AddText("", "----------------文件---------------------")
;     %GuiName%.AddButton("yp", "反选").OnEvent("Click", CheckAll_file)

;     GetObjectByRecusion(File_Link, GuiName, rowNum)
;     %GuiName%.AddButton("xs", "确认").OnEvent("Click", resultSubmit)
;     %GuiName%.Show()

;     GetObjectByRecusion(obj, GuiName, rowNum) {
;         global MakeVar := Map()
;         for key, value in obj.OwnProps() {
;             static num := 0
;             if (Mod(num, rowNum)) {
;                 MakeVar[GuiName "_" key] := %GuiName%.AddCheckbox("yp w220", key)
;             } else {
;                 MakeVar[GuiName "_" key] := %GuiName%.AddCheckbox("xs w220", key)
;             }
;             num++
;         }
;     }
;     CheckAll_file(*) {
;         for key, value in File_Link.OwnProps() {
;             if (MakeVar[GuiName "_" key].Value) {
;                 MakeVar[GuiName "_" key].Value := 0
;             } else {
;                 MakeVar[GuiName "_" key].Value := 1
;             }
;         }
;     }
;     resultSubmit(*) {
;         MsgBox MakeVar[GuiName "_gitconfig"].Value
;     }
; }
