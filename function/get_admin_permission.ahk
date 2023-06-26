#Include Regedit.ahk
#Include AHK_data.ahk

/**
 * 提权
 * @param {string} Key 定义提权的 key
 */
get_admin_permisstion(Key := A_ScriptName) {
    try {
        path := IniRead(AHK_data, "permisstion_admin", Key)    ; 读取提权路径
        RegRead("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers",path) ; 尝试读取注册表值
        if (path != A_ScriptFullPath) {    ; 移动了路径或改变软件名称
            IniWrite(A_ScriptFullPath, AHK_data, "permisstion_admin", key)    ; 写入 ini
            ; 删除旧的管理员权限注册，并添加新的
            regDel("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", path)    ; 删除旧的管理员权限注册
            regAdd("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", A_ScriptFullPath, "RUNASADMIN")
            ; 重启应用使注册表生效
            Run("cmd /c start " A_ScriptFullPath, , "Hide")
        }
    } catch {
        IniWrite(A_ScriptFullPath, AHK_data, "permisstion_admin", key)    ; 写入 ini
        regAdd("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", A_ScriptFullPath, "RUNASADMIN")    ; 添加管理员权限
        Run("cmd /c start " A_ScriptFullPath, , "Hide")
    }
}
