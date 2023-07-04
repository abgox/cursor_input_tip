![license](https://img.shields.io/github/license/abgox/cursor_input_tip)
![code size](https://img.shields.io/github/languages/code-size/abgox/cursor_input_tip.svg)
![repo size](https://img.shields.io/github/repo-size/abgox/cursor_input_tip.svg)

### 介绍

-   一个基于 `AutoHotKey` 编写的一个小工具
-   在光标处实时显示当前输入法中英文状态
-   缓解日常文字输入中经常输入错误回删这样的降低效率与输入体验的场景
-   如何隐藏
    -   直接停止此工具 `InputTip.exe`
    -   鼠标处于屏幕边缘
    -   配置文件中配置隐藏应用

### 使用示例

![demo](/demo.gif)

### 使用

-   下载并运行 `InputTip.exe` 即可

### 配置文件(可更改)

-   所在位置：`InputTip.exe` 的同级目录下

    -   启动软件后会检查配置文件，如果不存在会自动创建

-   文件名：`InputTip_config.ini`

    -   与软件名对应，如您将软件名改为`aaa.exe`,则会自动创建`aaa_config.ini`
    -   此时旧的配置文件`InputTip_config.ini`**请自行删除**

-   配置说明(可按需更改)
    -   `font_family=SimHei` 字体显示
    -   `font_size=18` 字体大小(显示大小)
    -   `font_weight=900` 字体粗细
    -   `font_color=ffffff` 字体颜色(16 进制)
    -   `font_bgcolor=474E68` 背景颜色(16 进制)
    -   `windowTransparent=222` 透明度(0-255)
    -   `CN_Text=中` 中文状态显示
    -   `EN_Text=英` 英文状态显示
    -   `offset_x=50` X 轴显示位置偏移量
    -   `offset_y=-80` Y 轴显示位置偏移量
    -   `window_no_display=Notepad.exe` 不显示的应用列表(默认写入 Notepad.exe，因为记事本中英文获取会错误)
        -   具体写法：
            1. 找到不希望显示的应用窗口的 exe 文件
            2. 填写到这一个配置中，以 `,` 间隔
                - `window_no_display=Notepad.exe,App1.exe,App2.exe`

### 兼容情况

-   已知
    -   可用输入法
        -   微软/搜狗/百度
    -   不可用输入法
        -   讯飞
