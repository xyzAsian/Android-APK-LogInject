.class Lxyz/log/DataCache$1;
.super Ljava/lang/Object;
.source "DataCache.java"

# interfaces
.implements Lme/pqpo/librarylog4a/interceptor/Interceptor;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lxyz/log/DataCache;->init(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lxyz/log/DataCache;


# direct methods
.method constructor <init>(Lxyz/log/DataCache;)V
    .registers 2
    .param p1, "this$0"    # Lxyz/log/DataCache;

    .prologue
    .line 33
    .local p0, "this":Lxyz/log/DataCache$1;, "Lxyz/log/DataCache$1;"
    iput-object p1, p0, Lxyz/log/DataCache$1;->this$0:Lxyz/log/DataCache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public intercept(Lme/pqpo/librarylog4a/LogData;)Z
    .registers 4
    .param p1, "logData"    # Lme/pqpo/librarylog4a/LogData;

    .prologue
    .line 36
    .local p0, "this":Lxyz/log/DataCache$1;, "Lxyz/log/DataCache$1;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " xyz "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Lme/pqpo/librarylog4a/LogData;->tag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lme/pqpo/librarylog4a/LogData;->tag:Ljava/lang/String;

    .line 37
    const/4 v0, 0x1

    return v0
.end method
