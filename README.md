# Android-APK-LogInject
Auto inject log to smali, at method begin and end

此工具可以自动插入log，在每个Java方法的开始和结束。<br/>
例如<br/>
2019:09:16 19:28:29 WBangcle 1568633309652  Lcom/gotokeep/keep/KApplication;   getContext()Landroid/content/Context; start
2019:09:16 19:28:29 WBangcle 1568633309652  Lcom/gotokeep/keep/KApplication;   getContext()Landroid/content/Context; end

## Log格式：
[时间戳] [类] [方法] [start/end]

## 环境：
linux + python2.7

## 使用方法:
**python inject.py xx.apk config.conf**

会在 workspace/out 目录下生成 :<br/>
target_xx.apk ----------- 未签名apk<br/>
target_xx.signed.apk ---- debug签名apk<br/>
默认会在 /sdcard/Android/data/{package}/files/DataStatistics 目录下输出log文件

## config配置
### func_filter
配置需要打桩log的包路径<br/>
  例如：<br/>
  "com/example" 表示只对 com.example 开头的类打桩<br/>
  "!com/example/fileprovider/MyApplication" 表示不对 com.example.fileprovider.MyApplication 类打桩<br/>
### log
print: log打印开关<br/>
file: log输出文件开关

## 感谢
[log4a](https://github.com/pqpo/Log4a)
