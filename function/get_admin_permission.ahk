#Include env.ahk

/**
 * 提升为管理员权限
 * @param {string} Key
 */
get_admin_permisstion(App_key := A_ScriptName) {
    try {
        path := env_read(App_key)    ; 读取提权路径
        RegRead("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", path)    ; 尝试读取注册表值

        if (path != A_ScriptFullPath) {    ; 移动了路径或改变软件名称
            reg_delete("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", path)    ; 删除旧的管理员权限注册
            do()
        }
    } catch {
        do()
    }
    do() {
        env_Write(App_key, A_ScriptFullPath)
        reg_write("HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", A_ScriptFullPath, "RUNASADMIN")    ; 添加管理员权限
        Run("cmd /c start " A_ScriptFullPath, , "Hide")
        ExitApp()
    }
    reg_write(reg, key, value := "", valueType := "REG_SZ") {
        RunWait("cmd /c reg add " '"' reg '"' " /v " '"' key '"' " /t " valueType " /d " '"' value '"' " /f ", , "Hide")
    }
    reg_delete(reg, key) {
        RunWait("cmd /c reg delete " '"' reg '"' " /v " '"' key '"' " /f", , "Hide")
    }
}
