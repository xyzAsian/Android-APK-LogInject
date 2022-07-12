# Android-APK-LogInject
Auto inject code to smali, at method begin and end

在每个Java方法的开始和结束插入代码，用来记录函数执行次数以及平均执行时间.

---
## OutPut JSON
```
{
    'className':'com.test.Test',
    'methodName':'test',
    'parameterLength':0,
    'duration':12,
    'numberOfTimes':22
}
```
---
## Environment
Ubuntu Linux/MacOS + python3

---
## Cmd
**python inject.py xx.apk config.conf**

### Apk OutPut

workspace/out/target_xx.apk

workspace/out/target_xx.signed.apk

### Log OutPut

/sdcard/Android/data/{package}/files/DataStatistics_{time}

---
## config
### func_filter

eg: 
```
'data_statistics': {
    'func_filter':[
        'com/example',
        '!com/example/fileprovider/MyApplication'
    ]
}

```

---
## Sort

### Cmd
**python Sort.py log.txt**

### OutPut
duration_log.txt

numberOfTimes_log.txt
