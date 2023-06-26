#Include link.ahk

check_AHK_data_file(){
    link_path:=A_AppDataCommon "\_AHK_data.ini"
    path:= "D:\computer_config\computer_init\init_package\.userFiles\_AHK_data.ini"
    if(!FileExist(link_path)){ ; 如果不存在文件或类型不为链接文件
        if(FileExist(path)){
            file_link(link_path,path)
        }else{
            IniWrite(A_UserName,link_path,"current_user_info","user_name")
        }
    }
}
check_AHK_data_file()

; 存放自定义ahk相关数据，便于使用 iniRead 读取
AHK_data := A_AppDataCommon "\_AHK_data.ini"
;
; flag, 用于接受通过cmd重定向的临时数据
AHK_data_flag := A_AppDataCommon "\flag"


; 每一次重新运行，写入0
IniWrite(0,AHK_data,"current_user_info","is_Run_without_userInfo")
