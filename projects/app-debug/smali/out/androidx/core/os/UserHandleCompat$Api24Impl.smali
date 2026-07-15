.class Landroidx/core/os/UserHandleCompat$Api24Impl;
.super Ljava/lang/Object;
.source "UserHandleCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/os/UserHandleCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Api24Impl"
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    return-void
.end method

.method static getUserHandleForUid(I)Landroid/os/UserHandle;
    .registers 2
    .param p0, "uid"    # I

    .line 78
    invoke-static {p0}, Landroid/os/UserHandle;->getUserHandleForUid(I)Landroid/os/UserHandle;

    move-result-object v0

    return-object v0
.end method
