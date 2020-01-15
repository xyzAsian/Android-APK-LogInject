.class public Lxyz/log/MethodExecRecord;
.super Ljava/lang/Object;
.source "MethodExecRecord.java"


# instance fields
.field private className:Ljava/lang/String;

.field private duration:I

.field private methodName:Ljava/lang/String;

.field private numberOfTimes:I

.field private parameterLength:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;II)V
    .registers 6
    .param p1, "className"    # Ljava/lang/String;
    .param p2, "methodName"    # Ljava/lang/String;
    .param p3, "parameterLength"    # I
    .param p4, "duration"    # I

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput-object p1, p0, Lxyz/log/MethodExecRecord;->className:Ljava/lang/String;

    .line 21
    iput-object p2, p0, Lxyz/log/MethodExecRecord;->methodName:Ljava/lang/String;

    .line 22
    iput p3, p0, Lxyz/log/MethodExecRecord;->parameterLength:I

    .line 23
    iput p4, p0, Lxyz/log/MethodExecRecord;->duration:I

    .line 24
    const/4 v0, 0x1

    iput v0, p0, Lxyz/log/MethodExecRecord;->numberOfTimes:I

    .line 25
    return-void
.end method


# virtual methods
.method public refresh(I)V
    .registers 3
    .param p1, "duration"    # I

    .prologue
    .line 28
    iget v0, p0, Lxyz/log/MethodExecRecord;->numberOfTimes:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lxyz/log/MethodExecRecord;->numberOfTimes:I

    .line 29
    iget v0, p0, Lxyz/log/MethodExecRecord;->duration:I

    add-int/2addr v0, p1

    div-int/lit8 v0, v0, 0x2

    iput v0, p0, Lxyz/log/MethodExecRecord;->duration:I

    .line 30
    return-void
.end method

.method public toString()Ljava/lang/String;
    .registers 3

    .prologue
    .line 34
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{\'className\':\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lxyz/log/MethodExecRecord;->className:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\',\'methodName\':\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lxyz/log/MethodExecRecord;->methodName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\',\'parameterLength\':"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lxyz/log/MethodExecRecord;->parameterLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",\'duration\':"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lxyz/log/MethodExecRecord;->duration:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",\'numberOfTimes\':"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lxyz/log/MethodExecRecord;->numberOfTimes:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
