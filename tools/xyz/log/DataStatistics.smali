.class public Lxyz/log/DataStatistics;
.super Ljava/lang/Object;
.source "DataStatistics.java"


# static fields
.field private static final START_TIME_MAP:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static sActivityCount:I

.field private static sDataCache:Lxyz/log/DataCache;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .prologue
    .line 28
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lxyz/log/DataStatistics;->START_TIME_MAP:Ljava/util/Map;

    .line 63
    const/4 v0, 0x0

    sput v0, Lxyz/log/DataStatistics;->sActivityCount:I

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()I
    .registers 1

    .prologue
    .line 15
    sget v0, Lxyz/log/DataStatistics;->sActivityCount:I

    return v0
.end method

.method static synthetic access$008()I
    .registers 2

    .prologue
    .line 15
    sget v0, Lxyz/log/DataStatistics;->sActivityCount:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lxyz/log/DataStatistics;->sActivityCount:I

    return v0
.end method

.method static synthetic access$010()I
    .registers 2

    .prologue
    .line 15
    sget v0, Lxyz/log/DataStatistics;->sActivityCount:I

    add-int/lit8 v1, v0, -0x1

    sput v1, Lxyz/log/DataStatistics;->sActivityCount:I

    return v0
.end method

.method static synthetic access$100()Lxyz/log/DataCache;
    .registers 1

    .prologue
    .line 15
    sget-object v0, Lxyz/log/DataStatistics;->sDataCache:Lxyz/log/DataCache;

    return-object v0
.end method

.method public static destory(Landroid/app/Application;)V
    .registers 3
    .param p0, "application"    # Landroid/app/Application;

    .prologue
    .line 65
    if-nez p0, :cond_a

    .line 66
    const-string v0, "DataStatistics"

    const-string v1, "Application is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 105
    :goto_9
    return-void

    .line 69
    :cond_a
    new-instance v0, Lxyz/log/DataStatistics$1;

    invoke-direct {v0}, Lxyz/log/DataStatistics$1;-><init>()V

    invoke-virtual {p0, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    goto :goto_9
.end method

.method private static getUniqueKey(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;
    .registers 5
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "parameterLen"    # I

    .prologue
    .line 59
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 60
    .local v0, "key":Ljava/lang/String;
    return-object v0
.end method

.method public static init(Landroid/content/Context;)V
    .registers 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 20
    new-instance v1, Lxyz/log/DataCache;

    invoke-direct {v1}, Lxyz/log/DataCache;-><init>()V

    sput-object v1, Lxyz/log/DataStatistics;->sDataCache:Lxyz/log/DataCache;

    .line 22
    :try_start_7
    sget-object v1, Lxyz/log/DataStatistics;->sDataCache:Lxyz/log/DataCache;

    invoke-virtual {v1, p0}, Lxyz/log/DataCache;->init(Landroid/content/Context;)V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_c} :catch_d

    .line 26
    :goto_c
    return-void

    .line 23
    :catch_d
    move-exception v0

    .line 24
    .local v0, "e":Ljava/io/IOException;
    const-string v1, "DataStatistics"

    const-string v2, "init data cache error "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_c
.end method

.method public static methodIn(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 7
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "parameterLen"    # I

    .prologue
    .line 35
    sget-object v0, Lxyz/log/DataStatistics;->START_TIME_MAP:Ljava/util/Map;

    invoke-static {p0, p1, p2}, Lxyz/log/DataStatistics;->getUniqueKey(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 36
    return-void
.end method

.method public static methodOut(Ljava/lang/String;Ljava/lang/String;I)V
    .registers 13
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "parameterLen"    # I

    .prologue
    .line 42
    invoke-static {p0, p1, p2}, Lxyz/log/DataStatistics;->getUniqueKey(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 43
    .local v1, "uniqueKey":Ljava/lang/String;
    sget-object v6, Lxyz/log/DataStatistics;->START_TIME_MAP:Ljava/util/Map;

    invoke-interface {v6, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2f

    .line 44
    sget-object v6, Lxyz/log/DataStatistics;->sDataCache:Lxyz/log/DataCache;

    if-eqz v6, :cond_2a

    .line 45
    sget-object v6, Lxyz/log/DataStatistics;->START_TIME_MAP:Ljava/util/Map;

    invoke-interface {v6, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 46
    .local v0, "aLong":Ljava/lang/Long;
    if-eqz v0, :cond_2a

    .line 47
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 48
    .local v4, "startTime":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 49
    .local v2, "endTime":J
    sget-object v6, Lxyz/log/DataStatistics;->sDataCache:Lxyz/log/DataCache;

    sub-long v8, v2, v4

    long-to-int v7, v8

    invoke-virtual {v6, p0, p1, p2, v7}, Lxyz/log/DataCache;->offer(Ljava/lang/String;Ljava/lang/String;II)V

    .line 54
    .end local v0    # "aLong":Ljava/lang/Long;
    .end local v2    # "endTime":J
    .end local v4    # "startTime":J
    :cond_2a
    sget-object v6, Lxyz/log/DataStatistics;->START_TIME_MAP:Ljava/util/Map;

    invoke-interface {v6, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 56
    :cond_2f
    return-void
.end method
