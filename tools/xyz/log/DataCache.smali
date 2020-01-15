.class public Lxyz/log/DataCache;
.super Ljava/lang/Object;
.source "DataCache.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lxyz/log/DataCache$SaveThread;
    }
.end annotation


# static fields
.field private static final DEFAULT_DIR:Ljava/lang/String; = "DataStatistics"

.field private static final RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap",
            "<",
            "Ljava/lang/String;",
            "Lxyz/log/MethodExecRecord;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mLogDir:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .prologue
    .line 28
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lxyz/log/DataCache;)Ljava/io/File;
    .registers 2
    .param p0, "x0"    # Lxyz/log/DataCache;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 24
    invoke-direct {p0}, Lxyz/log/DataCache;->getLogFile()Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method private getLogFile()Ljava/io/File;
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 86
    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy_MM_dd_HH_mm_ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    .line 87
    .local v1, "time":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    iget-object v2, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".txt"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 88
    .local v0, "log":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_37

    .line 89
    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    .line 91
    :cond_37
    return-object v0
.end method

.method private static getUniqueKey(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;
    .registers 5
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "parameterLen"    # I

    .prologue
    .line 81
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

    .line 82
    .local v0, "key":Ljava/lang/String;
    return-object v0
.end method

.method private initLogDir(Landroid/content/Context;)Ljava/io/File;
    .registers 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 40
    iget-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    if-eqz v1, :cond_7

    .line 41
    iget-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    .line 48
    :goto_6
    return-object v1

    .line 43
    :cond_7
    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v2, "yyyy_MM_dd_HH_mm_ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 44
    .local v0, "time":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DataStatistics_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    iput-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    .line 45
    iget-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_41

    .line 46
    iget-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 48
    :cond_41
    iget-object v1, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    goto :goto_6
.end method

.method private save()V
    .registers 4

    .prologue
    .line 65
    sget-object v1, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result v1

    const/16 v2, 0x2710

    if-lt v1, v2, :cond_23

    .line 66
    monitor-enter p0

    .line 67
    :try_start_b
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 68
    .local v0, "map":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Lxyz/log/MethodExecRecord;>;"
    sget-object v1, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->putAll(Ljava/util/Map;)V

    .line 69
    sget-object v1, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 70
    new-instance v1, Lxyz/log/DataCache$SaveThread;

    invoke-direct {v1, p0, v0}, Lxyz/log/DataCache$SaveThread;-><init>(Lxyz/log/DataCache;Ljava/util/Map;)V

    invoke-virtual {v1}, Lxyz/log/DataCache$SaveThread;->start()V

    .line 71
    monitor-exit p0

    .line 73
    .end local v0    # "map":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Lxyz/log/MethodExecRecord;>;"
    :cond_23
    return-void

    .line 71
    :catchall_24
    move-exception v1

    monitor-exit p0
    :try_end_26
    .catchall {:try_start_b .. :try_end_26} :catchall_24

    throw v1
.end method


# virtual methods
.method public destory()V
    .registers 4

    .prologue
    .line 76
    const-string v0, "DataStatistics"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "App exit, save all result to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lxyz/log/DataCache;->mLogDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 77
    new-instance v0, Lxyz/log/DataCache$SaveThread;

    sget-object v1, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0, p0, v1}, Lxyz/log/DataCache$SaveThread;-><init>(Lxyz/log/DataCache;Ljava/util/Map;)V

    invoke-virtual {v0}, Lxyz/log/DataCache$SaveThread;->start()V

    .line 78
    return-void
.end method

.method public init(Landroid/content/Context;)V
    .registers 4
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 31
    if-nez p1, :cond_a

    .line 32
    const-string v0, "DataStatistics"

    const-string v1, "Context is null, can\'t init storage dir"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 36
    :goto_9
    return-void

    .line 35
    :cond_a
    invoke-direct {p0, p1}, Lxyz/log/DataCache;->initLogDir(Landroid/content/Context;)Ljava/io/File;

    goto :goto_9
.end method

.method public offer(Ljava/lang/String;Ljava/lang/String;II)V
    .registers 9
    .param p1, "className"    # Ljava/lang/String;
    .param p2, "methodName"    # Ljava/lang/String;
    .param p3, "parameterLen"    # I
    .param p4, "duction"    # I

    .prologue
    .line 52
    invoke-static {p1, p2, p3}, Lxyz/log/DataCache;->getUniqueKey(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 53
    .local v1, "uniqueKey":Ljava/lang/String;
    sget-object v2, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, v1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_18

    .line 54
    sget-object v2, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lxyz/log/MethodExecRecord;

    .line 55
    .local v0, "methodExecRecord":Lxyz/log/MethodExecRecord;
    invoke-virtual {v0, p4}, Lxyz/log/MethodExecRecord;->refresh(I)V

    .line 62
    .end local v0    # "methodExecRecord":Lxyz/log/MethodExecRecord;
    :goto_17
    return-void

    .line 57
    :cond_18
    monitor-enter p0

    .line 58
    :try_start_19
    sget-object v2, Lxyz/log/DataCache;->RECORD_MAP:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v3, Lxyz/log/MethodExecRecord;

    invoke-direct {v3, p1, p2, p3, p4}, Lxyz/log/MethodExecRecord;-><init>(Ljava/lang/String;Ljava/lang/String;II)V

    invoke-virtual {v2, v1, v3}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    monitor-exit p0
    :try_end_24
    .catchall {:try_start_19 .. :try_end_24} :catchall_28

    .line 60
    invoke-direct {p0}, Lxyz/log/DataCache;->save()V

    goto :goto_17

    .line 59
    :catchall_28
    move-exception v2

    :try_start_29
    monitor-exit p0
    :try_end_2a
    .catchall {:try_start_29 .. :try_end_2a} :catchall_28

    throw v2
.end method
