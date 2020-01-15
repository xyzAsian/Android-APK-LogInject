.class Lxyz/log/DataCache$SaveThread;
.super Ljava/lang/Thread;
.source "DataCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lxyz/log/DataCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SaveThread"
.end annotation


# instance fields
.field private mMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lxyz/log/MethodExecRecord;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lxyz/log/DataCache;


# direct methods
.method public constructor <init>(Lxyz/log/DataCache;Ljava/util/Map;)V
    .registers 3
    .param p1, "this$0"    # Lxyz/log/DataCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lxyz/log/MethodExecRecord;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 98
    .local p2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lxyz/log/MethodExecRecord;>;"
    iput-object p1, p0, Lxyz/log/DataCache$SaveThread;->this$0:Lxyz/log/DataCache;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 99
    iput-object p2, p0, Lxyz/log/DataCache$SaveThread;->mMap:Ljava/util/Map;

    .line 100
    return-void
.end method


# virtual methods
.method public run()V
    .registers 10

    .prologue
    .line 104
    const/4 v1, 0x0

    .line 105
    .local v1, "fileWriter":Ljava/io/FileWriter;
    const/4 v5, 0x0

    .line 107
    .local v5, "writer":Ljava/io/BufferedWriter;
    :try_start_2
    iget-object v7, p0, Lxyz/log/DataCache$SaveThread;->this$0:Lxyz/log/DataCache;

    invoke-static {v7}, Lxyz/log/DataCache;->access$000(Lxyz/log/DataCache;)Ljava/io/File;

    move-result-object v3

    .line 108
    .local v3, "logFile":Ljava/io/File;
    new-instance v2, Ljava/io/FileWriter;

    invoke-direct {v2, v3}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_d} :catch_8a
    .catchall {:try_start_2 .. :try_end_d} :catchall_6d

    .line 109
    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .local v2, "fileWriter":Ljava/io/FileWriter;
    :try_start_d
    new-instance v6, Ljava/io/BufferedWriter;

    invoke-direct {v6, v2}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_12} :catch_8c
    .catchall {:try_start_d .. :try_end_12} :catchall_83

    .line 110
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .local v6, "writer":Ljava/io/BufferedWriter;
    :try_start_12
    iget-object v7, p0, Lxyz/log/DataCache$SaveThread;->mMap:Ljava/util/Map;

    invoke-interface {v7}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_1c
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_44

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lxyz/log/MethodExecRecord;

    .line 111
    .local v4, "record":Lxyz/log/MethodExecRecord;
    invoke-virtual {v4}, Lxyz/log/MethodExecRecord;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 112
    invoke-virtual {v6}, Ljava/io/BufferedWriter;->newLine()V
    :try_end_32
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_32} :catch_33
    .catchall {:try_start_12 .. :try_end_32} :catchall_86

    goto :goto_1c

    .line 116
    .end local v4    # "record":Lxyz/log/MethodExecRecord;
    :catch_33
    move-exception v0

    move-object v5, v6

    .end local v6    # "writer":Ljava/io/BufferedWriter;
    .restart local v5    # "writer":Ljava/io/BufferedWriter;
    move-object v1, v2

    .line 117
    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .end local v3    # "logFile":Ljava/io/File;
    .local v0, "e":Ljava/io/IOException;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    :goto_36
    :try_start_36
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_39
    .catchall {:try_start_36 .. :try_end_39} :catchall_6d

    .line 119
    if-eqz v1, :cond_3e

    .line 121
    :try_start_3b
    invoke-virtual {v1}, Ljava/io/FileWriter;->close()V
    :try_end_3e
    .catch Ljava/io/IOException; {:try_start_3b .. :try_end_3e} :catch_63

    .line 126
    :cond_3e
    :goto_3e
    if-eqz v5, :cond_43

    .line 128
    :try_start_40
    invoke-virtual {v5}, Ljava/io/BufferedWriter;->close()V
    :try_end_43
    .catch Ljava/io/IOException; {:try_start_40 .. :try_end_43} :catch_68

    .line 134
    .end local v0    # "e":Ljava/io/IOException;
    :cond_43
    :goto_43
    return-void

    .line 114
    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v3    # "logFile":Ljava/io/File;
    .restart local v6    # "writer":Ljava/io/BufferedWriter;
    :cond_44
    :try_start_44
    invoke-virtual {v6}, Ljava/io/BufferedWriter;->flush()V

    .line 115
    invoke-virtual {v6}, Ljava/io/BufferedWriter;->close()V
    :try_end_4a
    .catch Ljava/io/IOException; {:try_start_44 .. :try_end_4a} :catch_33
    .catchall {:try_start_44 .. :try_end_4a} :catchall_86

    .line 119
    if-eqz v2, :cond_4f

    .line 121
    :try_start_4c
    invoke-virtual {v2}, Ljava/io/FileWriter;->close()V
    :try_end_4f
    .catch Ljava/io/IOException; {:try_start_4c .. :try_end_4f} :catch_57

    .line 126
    :cond_4f
    :goto_4f
    if-eqz v6, :cond_8f

    .line 128
    :try_start_51
    invoke-virtual {v6}, Ljava/io/BufferedWriter;->close()V
    :try_end_54
    .catch Ljava/io/IOException; {:try_start_51 .. :try_end_54} :catch_5c

    move-object v5, v6

    .end local v6    # "writer":Ljava/io/BufferedWriter;
    .restart local v5    # "writer":Ljava/io/BufferedWriter;
    move-object v1, v2

    .line 131
    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_43

    .line 122
    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v6    # "writer":Ljava/io/BufferedWriter;
    :catch_57
    move-exception v0

    .line 123
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4f

    .line 129
    .end local v0    # "e":Ljava/io/IOException;
    :catch_5c
    move-exception v0

    .line 130
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    move-object v5, v6

    .end local v6    # "writer":Ljava/io/BufferedWriter;
    .restart local v5    # "writer":Ljava/io/BufferedWriter;
    move-object v1, v2

    .line 131
    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_43

    .line 122
    .end local v3    # "logFile":Ljava/io/File;
    :catch_63
    move-exception v0

    .line 123
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3e

    .line 129
    :catch_68
    move-exception v0

    .line 130
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_43

    .line 119
    .end local v0    # "e":Ljava/io/IOException;
    :catchall_6d
    move-exception v7

    :goto_6e
    if-eqz v1, :cond_73

    .line 121
    :try_start_70
    invoke-virtual {v1}, Ljava/io/FileWriter;->close()V
    :try_end_73
    .catch Ljava/io/IOException; {:try_start_70 .. :try_end_73} :catch_79

    .line 126
    :cond_73
    :goto_73
    if-eqz v5, :cond_78

    .line 128
    :try_start_75
    invoke-virtual {v5}, Ljava/io/BufferedWriter;->close()V
    :try_end_78
    .catch Ljava/io/IOException; {:try_start_75 .. :try_end_78} :catch_7e

    .line 133
    :cond_78
    :goto_78
    throw v7

    .line 122
    :catch_79
    move-exception v0

    .line 123
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_73

    .line 129
    .end local v0    # "e":Ljava/io/IOException;
    :catch_7e
    move-exception v0

    .line 130
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_78

    .line 119
    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v3    # "logFile":Ljava/io/File;
    :catchall_83
    move-exception v7

    move-object v1, v2

    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_6e

    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v6    # "writer":Ljava/io/BufferedWriter;
    :catchall_86
    move-exception v7

    move-object v5, v6

    .end local v6    # "writer":Ljava/io/BufferedWriter;
    .restart local v5    # "writer":Ljava/io/BufferedWriter;
    move-object v1, v2

    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_6e

    .line 116
    .end local v3    # "logFile":Ljava/io/File;
    :catch_8a
    move-exception v0

    goto :goto_36

    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v3    # "logFile":Ljava/io/File;
    :catch_8c
    move-exception v0

    move-object v1, v2

    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_36

    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .restart local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v6    # "writer":Ljava/io/BufferedWriter;
    :cond_8f
    move-object v5, v6

    .end local v6    # "writer":Ljava/io/BufferedWriter;
    .restart local v5    # "writer":Ljava/io/BufferedWriter;
    move-object v1, v2

    .end local v2    # "fileWriter":Ljava/io/FileWriter;
    .restart local v1    # "fileWriter":Ljava/io/FileWriter;
    goto :goto_43
.end method
