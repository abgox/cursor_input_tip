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
