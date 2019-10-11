.class public Lbangcle/app/BangcleLogApplication;
.super Landroid/app/Application;
.source "BangcleLogApplication.java"


# static fields
.field public static final APPNAME:Ljava/lang/String; = "REAL_APP"

.field public static realApplication:Landroid/app/Application;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .prologue
    .line 20
    const/4 v0, 0x0

    sput-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method private replaceApplication()V
    .registers 19

    .prologue
    .line 74
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lbangcle/app/BangcleLogApplication;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    .line 79
    .local v2, "baseContext":Landroid/content/Context;
    const-string v17, "android.app.ContextImpl"

    invoke-static/range {v17 .. v17}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    .line 81
    .local v3, "contextImplClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v17, "mOuterContext"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v14

    .line 82
    .local v14, "mOuterContextField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v14, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 83
    sget-object v17, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    move-object/from16 v0, v17

    invoke-virtual {v14, v2, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 90
    const-string v17, "mMainThread"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v13

    .line 91
    .local v13, "mMainThreadField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v13, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 92
    invoke-virtual {v13, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    .line 95
    .local v12, "mMainThread":Ljava/lang/Object;
    const-string v17, "android.app.ActivityThread"

    invoke-static/range {v17 .. v17}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 96
    .local v1, "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v17, "mInitialApplication"

    .line 97
    move-object/from16 v0, v17

    invoke-virtual {v1, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v11

    .line 98
    .local v11, "mInitialApplicationField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v11, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 99
    sget-object v17, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    move-object/from16 v0, v17

    invoke-virtual {v11, v12, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 102
    const-string v17, "mAllApplications"

    .line 103
    move-object/from16 v0, v17

    invoke-virtual {v1, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 104
    .local v7, "mAllApplicationsField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v7, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 105
    invoke-virtual {v7, v12}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/ArrayList;

    .line 106
    .local v6, "mAllApplications":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/Application;>;"
    move-object/from16 v0, p0

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 107
    sget-object v17, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    move-object/from16 v0, v17

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 114
    const-string v17, "mPackageInfo"

    move-object/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v16

    .line 115
    .local v16, "mPackageInfoField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    invoke-virtual/range {v16 .. v17}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 116
    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v15

    .line 117
    .local v15, "mPackageInfo":Ljava/lang/Object;
    const-string v17, "android.app.LoadedApk"

    invoke-static/range {v17 .. v17}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    .line 118
    .local v5, "loadedApkClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v17, "mApplication"

    move-object/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v8

    .line 119
    .local v8, "mApplicationField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 120
    sget-object v17, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    move-object/from16 v0, v17

    invoke-virtual {v8, v15, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 123
    const-string v17, "mApplicationInfo"

    move-object/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v10

    .line 124
    .local v10, "mApplicationInfoField":Ljava/lang/reflect/Field;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v10, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 125
    invoke-virtual {v10, v15}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/content/pm/ApplicationInfo;

    .line 126
    .local v9, "mApplicationInfo":Landroid/content/pm/ApplicationInfo;
    const-string v17, "REAL_APP"

    move-object/from16 v0, v17

    iput-object v0, v9, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;
    :try_end_ba
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_ba} :catch_bb

    .line 131
    .end local v1    # "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v2    # "baseContext":Landroid/content/Context;
    .end local v3    # "contextImplClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v5    # "loadedApkClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v6    # "mAllApplications":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/Application;>;"
    .end local v7    # "mAllApplicationsField":Ljava/lang/reflect/Field;
    .end local v8    # "mApplicationField":Ljava/lang/reflect/Field;
    .end local v9    # "mApplicationInfo":Landroid/content/pm/ApplicationInfo;
    .end local v10    # "mApplicationInfoField":Ljava/lang/reflect/Field;
    .end local v11    # "mInitialApplicationField":Ljava/lang/reflect/Field;
    .end local v12    # "mMainThread":Ljava/lang/Object;
    .end local v13    # "mMainThreadField":Ljava/lang/reflect/Field;
    .end local v14    # "mOuterContextField":Ljava/lang/reflect/Field;
    .end local v15    # "mPackageInfo":Ljava/lang/Object;
    .end local v16    # "mPackageInfoField":Ljava/lang/reflect/Field;
    :goto_ba
    return-void

    .line 128
    :catch_bb
    move-exception v4

    .line 129
    .local v4, "e":Ljava/lang/Exception;
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_ba
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .registers 9
    .param p1, "base"    # Landroid/content/Context;

    .prologue
    .line 26
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 28
    :try_start_3
    invoke-static {p0}, Landroid/support/multidex/MultiDex;->install(Landroid/content/Context;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_6} :catch_50

    .line 32
    :goto_6
    invoke-static {p1}, Lbangcle/log/DataStatistics;->init(Landroid/content/Context;)V

    .line 33
    invoke-static {p0}, Lbangcle/log/DataStatistics;->destory(Landroid/app/Application;)V

    .line 36
    :try_start_c
    const-string v2, ""

    const-string v3, "REAL_APP"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_28

    .line 37
    invoke-virtual {p0}, Lbangcle/app/BangcleLogApplication;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v2

    const-string v3, "REAL_APP"

    invoke-virtual {v2, v3}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/Application;

    sput-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_28} :catch_55

    .line 43
    :cond_28
    :goto_28
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v2, :cond_4f

    .line 45
    :try_start_2c
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "attachBaseContext"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/content/Context;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 46
    .local v0, "attachBaseContext":Ljava/lang/reflect/Method;
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 47
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    invoke-virtual {v0, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4f
    .catch Ljava/lang/Exception; {:try_start_2c .. :try_end_4f} :catch_5a

    .line 52
    .end local v0    # "attachBaseContext":Ljava/lang/reflect/Method;
    :cond_4f
    :goto_4f
    return-void

    .line 29
    :catch_50
    move-exception v1

    .line 30
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_6

    .line 39
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_55
    move-exception v1

    .line 40
    .restart local v1    # "e":Ljava/lang/Exception;
    const/4 v2, 0x0

    sput-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    goto :goto_28

    .line 48
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_5a
    move-exception v1

    .line 49
    .restart local v1    # "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_4f
.end method

.method public getApplicationContext()Landroid/content/Context;
    .registers 2

    .prologue
    .line 175
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_7

    .line 176
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    .line 178
    :goto_6
    return-object v0

    :cond_7
    invoke-super {p0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    goto :goto_6
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 3
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 144
    invoke-super {p0, p1}, Landroid/app/Application;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 146
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_c

    .line 147
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v0, p1}, Landroid/app/Application;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 150
    :cond_c
    return-void
.end method

.method public onCreate()V
    .registers 5

    .prologue
    .line 56
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 57
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v2, :cond_28

    .line 58
    invoke-direct {p0}, Lbangcle/app/BangcleLogApplication;->replaceApplication()V

    .line 59
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v2}, Landroid/app/Application;->onCreate()V

    .line 61
    invoke-virtual {p0}, Lbangcle/app/BangcleLogApplication;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 63
    .local v0, "factory":Landroid/view/LayoutInflater;
    :try_start_17
    const-class v2, Landroid/view/LayoutInflater;

    const-string v3, "mContext"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 64
    .local v1, "field":Ljava/lang/reflect/Field;
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 65
    sget-object v2, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_28} :catch_29

    .line 69
    .end local v0    # "factory":Landroid/view/LayoutInflater;
    .end local v1    # "field":Ljava/lang/reflect/Field;
    :cond_28
    :goto_28
    return-void

    .line 66
    .restart local v0    # "factory":Landroid/view/LayoutInflater;
    :catch_29
    move-exception v2

    goto :goto_28
.end method

.method public onLowMemory()V
    .registers 2

    .prologue
    .line 154
    invoke-super {p0}, Landroid/app/Application;->onLowMemory()V

    .line 155
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_c

    .line 156
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->onLowMemory()V

    .line 158
    :cond_c
    return-void
.end method

.method public onTerminate()V
    .registers 2

    .prologue
    .line 135
    invoke-super {p0}, Landroid/app/Application;->onTerminate()V

    .line 137
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_c

    .line 138
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->onTerminate()V

    .line 140
    :cond_c
    return-void
.end method

.method public onTrimMemory(I)V
    .registers 3
    .param p1, "level"    # I
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    .prologue
    .line 164
    :try_start_0
    invoke-super {p0, p1}, Landroid/app/Application;->onTrimMemory(I)V

    .line 165
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_c

    .line 166
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v0, p1}, Landroid/app/Application;->onTrimMemory(I)V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_c} :catch_d

    .line 171
    :cond_c
    :goto_c
    return-void

    .line 168
    :catch_d
    move-exception v0

    goto :goto_c
.end method

.method public registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V
    .registers 3
    .param p1, "callback"    # Landroid/app/Application$ActivityLifecycleCallbacks;
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    .prologue
    .line 184
    invoke-super {p0, p1}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 185
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    if-eqz v0, :cond_c

    .line 186
    sget-object v0, Lbangcle/app/BangcleLogApplication;->realApplication:Landroid/app/Application;

    invoke-virtual {v0, p1}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 188
    :cond_c
    return-void
.end method
