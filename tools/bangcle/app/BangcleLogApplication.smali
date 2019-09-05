.class public Lbangcle/app/BangcleLogApplication;
.super Landroid/app/Application;
.source "BangcleLogApplication.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 8
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .registers 2
    .param p1, "base"    # Landroid/content/Context;

    .prologue
    .line 12
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 13
    invoke-static {p1}, Lbangcle/log/DataStatistics;->init(Landroid/content/Context;)V

    .line 14
    invoke-static {p0}, Lbangcle/log/DataStatistics;->destory(Landroid/app/Application;)V

    .line 15
    return-void
.end method
