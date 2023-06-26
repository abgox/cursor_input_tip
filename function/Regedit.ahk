/**
 * 添加注册表
 * @param {string} reg  注册表目录
 * @param {string} key 键
 * @param {string} value  值
 * @param {string} valueType 值的类型
 * @param {string} model 添加模式(f/d)，默认为 f(强制模式，若存在即覆盖)，d(是否覆盖需确认)
 * @return {string} 返回添加的键
 * @example regAdd("HKEY_CURRENT_USER\Environment","path",env,"REG_SZ") ; 用 env 的值覆盖用户变量中 path的值
 */
regAdd(reg,key,value:="",valueType:="REG_SZ",model:="f"){
    if(model= "f"){
        A_Clipboard:="cmd /c reg add " '"' reg '"' " /v " '"' key '"' " /t " valueType " /d " '"' value '"' " /f "
        RunWait("cmd /c reg add " '"' reg '"' " /v " '"' key '"' " /t " valueType " /d " '"' value '"' " /f ",,"Hide")
    }else if(model ="d"){
        RunWait("cmd /k reg add " '"' reg '"' " /v " '"' key '"' " /t " valueType " /d " '"' value '"' " ")
    }
    return RegRead(reg,key)
}

/**
 * 删除注册表
 * @param {string} reg  注册表目录
 * @param {string} key 键
 * @param {string} model 删除模式(f/d)，默认为 f(强制删除无需确认)，d(需确认删除)
 * @example regDel("HKEY_CURRENT_USER\Environment","path") ; 用 env 的值覆盖用户变量中 path的值
 */
regDel(reg,key,value:="",model:="f"){
    if(model= "f"){
        RunWait("cmd /c reg delete " '"' reg '"' " /v " '"' key '"' " /f",,"Hide")
    }else if(model ="d"){
        RunWait("cmd /k reg delete " '"' reg '"' " /v " '"' key '"' "")
    }
}




