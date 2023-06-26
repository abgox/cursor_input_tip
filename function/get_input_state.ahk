/**
 * 检测输入状态
 * @returns {number} 0 >>> 英文 其他数字 >>> 中文
 */
get_input_state() {
    try {
        DetectHiddenWindows True
        result := SendMessage(
            0x283,    ; Message : WM_IME_CONTROL
            0x001,    ; wParam  : IMC_GETCONVERSIONMODE
            0,    ; lParam  ： (NoArgs)
            ,    ; Control ： (Window)
            ; 获取当前输入法的模式
            "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", WinGetID("A"), "Uint")
        )
        DetectHiddenWindows False
        ; 搜狗,微软拼音
        ; 0 >>> 英
        ; 1025 >>> 中
        ; 讯飞始终返回1025，暂无解决方案
        ; return result
        return result
    } catch {
        return "null"
    }
}
/**
 * 检测输入状态(仅适用于搜狗输入法)
 * @returns {number} 中文 -- 1，英文 -- 0
 */
; get_input_state() {
;     try {
;         hWnd := WinGetID("A")
;         if (hWnd) {
;             DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
;             DetectSave := A_DetectHiddenWindows
;             DetectHiddenWindows(true)
;             ErrorLevel := SendMessage(0x283, 0x005, 0, , "ahk_id " DefaultIMEWnd)
;             DetectHiddenWindows(DetectSave)
;             Return ErrorLevel
;         } else {
;             return 1
;         }
;     } catch {
;         return 1
;     }
; }


; get_input_state() {
;     try{
;         hWnd := WinGetID("A")
;         if(hWnd){
;             DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
;             DetectSave := A_DetectHiddenWindows
;             DetectHiddenWindows(true)
;             ErrorLevel := SendMessage(0x283, 0x005, 0, , "ahk_id " DefaultIMEWnd)
;             DetectHiddenWindows(DetectSave)
;             Return ErrorLevel
;         }else{
;             return 1
;         }
;     }catch{
;         return 1
;     }
; }
