.class public Lbangcle/log/DataCache;
.super Ljava/lang/Object;
.source "DataCache.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# static fields
.field private static final BUFFER_SIZE:I = 0x7d000

.field private static final DEFAULT_DIR:Ljava/lang/String; = "DataStatistics"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 24
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getLogDir(Landroid/content/Context;)Ljava/io/File;
    .registers 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 65
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    const-string v1, "DataStatistics"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    .line 66
    .local v0, "log":Ljava/io/File;
    if-nez v0, :cond_13

    .line 67
    new-instance v0, Ljava/io/File;

    .end local v0    # "log":Ljava/io/File;
    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "DataStatistics"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 69
    .restart local v0    # "log":Ljava/io/File;
    :cond_13
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1c

    .line 70
    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    .line 72
    :cond_1c
    return-object v0
.end method

.method private swich(Ljava/lang/String;)Z
    .registers 3
    .param p1, "_swich"    # Ljava/lang/String;

    .prologue
    .line 84
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    if-eqz p1, :cond_c

    const-string v0, "TRUE"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    const/4 v0, 0x1

    :goto_b
    return v0

    :cond_c
    const/4 v0, 0x0

    goto :goto_b
.end method


# virtual methods
.method public destory()V
    .registers 1

    .prologue
    .line 80
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    invoke-static {}, Lme/pqpo/librarylog4a/Log4a;->flush()V

    .line 81
    return-void
.end method

.method public init(Landroid/content/Context;)V
    .registers 15
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 32
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    const/4 v3, 0x4

    .line 33
    .local v3, "level":I
    new-instance v9, Lbangcle/log/CustomInterceptor;

    invoke-direct {v9}, Lbangcle/log/CustomInterceptor;-><init>()V

    .line 34
    .local v9, "wrapInterceptor":Lme/pqpo/librarylog4a/interceptor/Interceptor;
    new-instance v10, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    invoke-direct {v10}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;-><init>()V

    .line 35
    invoke-virtual {v10, v3}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->setLevel(I)Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    move-result-object v10

    new-instance v11, Lbangcle/log/CustomInterceptor;

    invoke-direct {v11}, Lbangcle/log/CustomInterceptor;-><init>()V

    .line 36
    invoke-virtual {v10, v11}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->addInterceptor(Lme/pqpo/librarylog4a/interceptor/Interceptor;)Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    move-result-object v10

    .line 37
    invoke-virtual {v10}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->create()Lme/pqpo/librarylog4a/appender/AndroidAppender;

    move-result-object v0

    .line 39
    .local v0, "androidAppender":Lme/pqpo/librarylog4a/appender/AndroidAppender;
    invoke-direct {p0, p1}, Lbangcle/log/DataCache;->getLogDir(Landroid/content/Context;)Ljava/io/File;

    move-result-object v4

    .line 40
    .local v4, "log":Ljava/io/File;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "log.logCache"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 41
    .local v1, "buffer_path":Ljava/lang/String;
    new-instance v10, Ljava/text/SimpleDateFormat;

    const-string v11, "yyyy_MM_dd_HH_mm"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v12

    invoke-direct {v10, v11, v12}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v11, Ljava/util/Date;

    invoke-direct {v11}, Ljava/util/Date;-><init>()V

    invoke-virtual {v10, v11}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v8

    .line 42
    .local v8, "time":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ".txt"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 43
    .local v5, "log_path":Ljava/lang/String;
    new-instance v10, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    invoke-direct {v10, p1}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;-><init>(Landroid/content/Context;)V

    .line 44
    invoke-virtual {v10, v5}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setLogFilePath(Ljava/lang/String;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    .line 45
    invoke-virtual {v10, v3}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setLevel(I)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    .line 46
    invoke-virtual {v10, v9}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->addInterceptor(Lme/pqpo/librarylog4a/interceptor/Interceptor;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    .line 47
    invoke-virtual {v10, v1}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setBufferFilePath(Ljava/lang/String;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    new-instance v11, Lme/pqpo/librarylog4a/formatter/DateFileFormatter;

    invoke-direct {v11}, Lme/pqpo/librarylog4a/formatter/DateFileFormatter;-><init>()V

    .line 48
    invoke-virtual {v10, v11}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setFormatter(Lme/pqpo/librarylog4a/formatter/Formatter;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    const/4 v11, 0x0

    .line 49
    invoke-virtual {v10, v11}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setCompress(Z)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    const v11, 0x7d000

    .line 50
    invoke-virtual {v10, v11}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setBufferSize(I)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v10

    .line 51
    invoke-virtual {v10}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->create()Lme/pqpo/librarylog4a/appender/FileAppender;

    move-result-object v2

    .line 53
    .local v2, "fileAppender":Lme/pqpo/librarylog4a/appender/FileAppender;
    new-instance v7, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;

    invoke-direct {v7}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;-><init>()V

    .line 54
    .local v7, "loggerBuild":Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;
    sget-object v10, Lbangcle/log/DataStatistics;->LOG_PRINT:Ljava/lang/String;

    invoke-direct {p0, v10}, Lbangcle/log/DataCache;->swich(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_b0

    .line 55
    invoke-virtual {v7, v0}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;->addAppender(Lme/pqpo/librarylog4a/appender/Appender;)Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;

    .line 57
    :cond_b0
    sget-object v10, Lbangcle/log/DataStatistics;->LOG_FILE:Ljava/lang/String;

    invoke-direct {p0, v10}, Lbangcle/log/DataCache;->swich(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_bb

    .line 58
    invoke-virtual {v7, v2}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;->addAppender(Lme/pqpo/librarylog4a/appender/Appender;)Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;

    .line 60
    :cond_bb
    invoke-virtual {v7}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;->create()Lme/pqpo/librarylog4a/logger/AppenderLogger;

    move-result-object v6

    .line 61
    .local v6, "logger":Lme/pqpo/librarylog4a/logger/AppenderLogger;
    invoke-static {v6}, Lme/pqpo/librarylog4a/Log4a;->setLogger(Lme/pqpo/librarylog4a/logger/Logger;)V

    .line 62
    return-void
.end method

.method public offer(Ljava/lang/Object;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .prologue
    .line 76
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    .local p1, "t":Ljava/lang/Object;, "TT;"
    const-string v0, ""

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lme/pqpo/librarylog4a/Log4a;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    return-void
.end method
