# Android-APK-LogInject
Auto inject log to smali, at method begin and end

此工具可以插入代码，在每个Java方法的开始和结束，用来记录函数执行次数以及平均执行时间。<br/>

## 输出数据格式 json：
{<br/>
    'className':'com.test.Test', // 类名<br/>
    'methodName':'test',         // 方法名<br/>
    'parameterLength':0,         // 参数长度<br/>
    'duration':12,               // 平均执行时间<br/>
    'numberOfTimes':22           // 执行次数<br/>
}

## 环境：
linux + python2.7 (目前只支持linux环境)

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
