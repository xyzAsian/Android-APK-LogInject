.class public Lbangcle/log/DataStatistics;
.super Ljava/lang/Object;
.source "DataStatistics.java"


# static fields
.field private static dataCache:Lbangcle/log/DataCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lbangcle/log/DataCache",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lbangcle/log/DataCache;
    .registers 1

    .prologue
    .line 8
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    return-object v0
.end method

.method public static destory(Landroid/app/Application;)V
    .registers 2
    .param p0, "application"    # Landroid/app/Application;

    .prologue
    .line 38
    new-instance v0, Lbangcle/log/DataStatistics$1;

    invoke-direct {v0}, Lbangcle/log/DataStatistics$1;-><init>()V

    invoke-virtual {p0, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 76
    return-void
.end method

.method public static init(Landroid/content/Context;)V
    .registers 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 13
    new-instance v0, Lbangcle/log/DataCache;

    invoke-direct {v0}, Lbangcle/log/DataCache;-><init>()V

    sput-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    .line 14
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    invoke-virtual {v0, p0}, Lbangcle/log/DataCache;->init(Landroid/content/Context;)V

    .line 15
    return-void
.end method

.method public static methodIn(Ljava/lang/String;Ljava/lang/String;)V
    .registers 6
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;

    .prologue
    .line 21
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    if-eqz v0, :cond_34

    .line 22
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "   "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " start"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lbangcle/log/DataCache;->offer(Ljava/lang/Object;)V

    .line 25
    :cond_34
    return-void
.end method

.method public static methodOut(Ljava/lang/String;Ljava/lang/String;)V
    .registers 6
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;

    .prologue
    .line 31
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    if-eqz v0, :cond_34

    .line 32
    sget-object v0, Lbangcle/log/DataStatistics;->dataCache:Lbangcle/log/DataCache;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "   "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " end"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lbangcle/log/DataCache;->offer(Ljava/lang/Object;)V

    .line 35
    :cond_34
    return-void
.end method
