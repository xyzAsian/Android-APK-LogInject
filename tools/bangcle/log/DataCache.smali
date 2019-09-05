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
    .line 68
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    const-string v1, "DataStatistics"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    .line 69
    .local v0, "log":Ljava/io/File;
    if-nez v0, :cond_13

    .line 70
    new-instance v0, Ljava/io/File;

    .end local v0    # "log":Ljava/io/File;
    invoke-virtual {p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "DataStatistics"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 72
    .restart local v0    # "log":Ljava/io/File;
    :cond_13
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_1c

    .line 73
    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    .line 75
    :cond_1c
    return-object v0
.end method


# virtual methods
.method public destory()V
    .registers 1

    .prologue
    .line 83
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    invoke-static {}, Lme/pqpo/librarylog4a/Log4a;->flush()V

    .line 84
    return-void
.end method

.method public init(Landroid/content/Context;)V
    .registers 14
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 32
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    const/4 v3, 0x4

    .line 33
    .local v3, "level":I
    new-instance v8, Lbangcle/log/DataCache$1;

    invoke-direct {v8, p0}, Lbangcle/log/DataCache$1;-><init>(Lbangcle/log/DataCache;)V

    .line 40
    .local v8, "wrapInterceptor":Lme/pqpo/librarylog4a/interceptor/Interceptor;
    new-instance v9, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    invoke-direct {v9}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;-><init>()V

    .line 41
    invoke-virtual {v9, v3}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->setLevel(I)Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    move-result-object v9

    .line 42
    invoke-virtual {v9, v8}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->addInterceptor(Lme/pqpo/librarylog4a/interceptor/Interceptor;)Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;

    move-result-object v9

    .line 43
    invoke-virtual {v9}, Lme/pqpo/librarylog4a/appender/AndroidAppender$Builder;->create()Lme/pqpo/librarylog4a/appender/AndroidAppender;

    move-result-object v0

    .line 45
    .local v0, "androidAppender":Lme/pqpo/librarylog4a/appender/AndroidAppender;
    invoke-direct {p0, p1}, Lbangcle/log/DataCache;->getLogDir(Landroid/content/Context;)Ljava/io/File;

    move-result-object v4

    .line 46
    .local v4, "log":Ljava/io/File;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    sget-object v10, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "log.logCache"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 47
    .local v1, "buffer_path":Ljava/lang/String;
    new-instance v9, Ljava/text/SimpleDateFormat;

    const-string v10, "yyyy_MM_dd_HH_mm"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v10, Ljava/util/Date;

    invoke-direct {v10}, Ljava/util/Date;-><init>()V

    invoke-virtual {v9, v10}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v7

    .line 48
    .local v7, "time":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    sget-object v10, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ".txt"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 49
    .local v5, "log_path":Ljava/lang/String;
    new-instance v9, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    invoke-direct {v9, p1}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;-><init>(Landroid/content/Context;)V

    .line 50
    invoke-virtual {v9, v5}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setLogFilePath(Ljava/lang/String;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    .line 51
    invoke-virtual {v9, v3}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setLevel(I)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    .line 52
    invoke-virtual {v9, v8}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->addInterceptor(Lme/pqpo/librarylog4a/interceptor/Interceptor;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    .line 53
    invoke-virtual {v9, v1}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setBufferFilePath(Ljava/lang/String;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    new-instance v10, Lme/pqpo/librarylog4a/formatter/DateFileFormatter;

    invoke-direct {v10}, Lme/pqpo/librarylog4a/formatter/DateFileFormatter;-><init>()V

    .line 54
    invoke-virtual {v9, v10}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setFormatter(Lme/pqpo/librarylog4a/formatter/Formatter;)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    const/4 v10, 0x0

    .line 55
    invoke-virtual {v9, v10}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setCompress(Z)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    const v10, 0x7d000

    .line 56
    invoke-virtual {v9, v10}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->setBufferSize(I)Lme/pqpo/librarylog4a/appender/FileAppender$Builder;

    move-result-object v9

    .line 57
    invoke-virtual {v9}, Lme/pqpo/librarylog4a/appender/FileAppender$Builder;->create()Lme/pqpo/librarylog4a/appender/FileAppender;

    move-result-object v2

    .line 59
    .local v2, "fileAppender":Lme/pqpo/librarylog4a/appender/FileAppender;
    new-instance v9, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;

    invoke-direct {v9}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;-><init>()V

    .line 61
    invoke-virtual {v9, v2}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;->addAppender(Lme/pqpo/librarylog4a/appender/Appender;)Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;

    move-result-object v9

    .line 62
    invoke-virtual {v9}, Lme/pqpo/librarylog4a/logger/AppenderLogger$Builder;->create()Lme/pqpo/librarylog4a/logger/AppenderLogger;

    move-result-object v6

    .line 63
    .local v6, "logger":Lme/pqpo/librarylog4a/logger/AppenderLogger;
    invoke-static {v6}, Lme/pqpo/librarylog4a/Log4a;->setLogger(Lme/pqpo/librarylog4a/logger/Logger;)V

    .line 65
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
    .line 79
    .local p0, "this":Lbangcle/log/DataCache;, "Lbangcle/log/DataCache<TT;>;"
    .local p1, "t":Ljava/lang/Object;, "TT;"
    const-string v0, ""

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lme/pqpo/librarylog4a/Log4a;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 80
    return-void
.end method
