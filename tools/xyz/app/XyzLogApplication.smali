.class public Lxyz/app/XyzLogApplication;
.super Landroid/app/Application;
.source "XyzLogApplication.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 12
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .registers 2
    .param p1, "base"    # Landroid/content/Context;

    .prologue
    .line 16
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 17
    invoke-static {p1}, Lxyz/log/DataStatistics;->init(Landroid/content/Context;)V

    .line 18
    invoke-static {p0}, Lxyz/log/DataStatistics;->destory(Landroid/app/Application;)V

    .line 19
    return-void
.end method

.method public onCreate()V
    .registers 9

    .prologue
    .line 23
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 25
    :try_start_3
    const-string v6, "android.app.ActivityThread"

    invoke-static {v6}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 26
    .local v1, "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v6, "currentActivityThread"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Class;

    invoke-virtual {v1, v6, v7}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 27
    .local v2, "currentActivityThread":Ljava/lang/reflect/Method;
    const/4 v6, 0x1

    invoke-virtual {v2, v6}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 28
    const/4 v6, 0x0

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v2, v6, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 30
    .local v0, "activityThread":Ljava/lang/Object;
    const-string v6, "mInitialApplication"

    invoke-virtual {v1, v6}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    .line 31
    .local v4, "mInitialApplicationField":Ljava/lang/reflect/Field;
    const/4 v6, 0x1

    invoke-virtual {v4, v6}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 32
    invoke-virtual {v4, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 33
    .local v5, "o":Ljava/lang/Object;
    instance-of v6, v5, Landroid/app/Application;

    if-eqz v6, :cond_35

    .line 34
    check-cast v5, Landroid/app/Application;

    .end local v5    # "o":Ljava/lang/Object;
    invoke-static {v5}, Lxyz/log/DataStatistics;->destory(Landroid/app/Application;)V
    :try_end_35
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_35} :catch_36

    .line 39
    .end local v0    # "activityThread":Ljava/lang/Object;
    .end local v1    # "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v2    # "currentActivityThread":Ljava/lang/reflect/Method;
    .end local v4    # "mInitialApplicationField":Ljava/lang/reflect/Field;
    :cond_35
    :goto_35
    return-void

    .line 36
    :catch_36
    move-exception v3

    .line 37
    .local v3, "e":Ljava/lang/Exception;
    const-string v6, "DataStatistics"

    const-string v7, ""

    invoke-static {v6, v7, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_35
.end method
