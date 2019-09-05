# Android-APK-LogInject
Auto inject log to smali, at method begin and end

此工具可以自动插入log，在每个Java方法的开始和结束。

#Log格式：
[时间戳] [类] [方法] [start/end]

#环境：
linux + python2.7

#使用方法:
python inject.py xx.apk
会在 workspace/out 目录下生成 target_*.apk[未签名]、 target_*.signed.apk[debug签名]

#感谢
log4a : https://github.com/pqpo/Log4a