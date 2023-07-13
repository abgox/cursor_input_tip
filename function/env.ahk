/**
 * 读取环境变量(通过注册表)
 * @param {string} key
 * @return {string} 返回 key 值
 * @example env_read("path") ; 返回用户级 path 变量值
 */
env_read(key) {
    try {
        return RegRead("HKEY_CURRENT_USER\Environment", key)
    } catch {
        return 0
    }
}

/**
 * 写入环境变量(通过注册表)
 * @param {string} key
 * @param {string} value
 * @example env_Write("abc","123") ; 在用户级变量中添加 abc 变量，值为 123
 */
env_Write(key, value) {
    Run("cmd /c setx " '"' key '" ' '"' value '"', , "Hide")
}

/**
 * 删除环境变量
 * @param {string} key
 * @example env_delete("abc") ; 删除用户级变量中的 abc 变量
 */
env_delete(key) {
    try {
        RegDelete("HKEY_CURRENT_USER\Environment", key)
    }
}
