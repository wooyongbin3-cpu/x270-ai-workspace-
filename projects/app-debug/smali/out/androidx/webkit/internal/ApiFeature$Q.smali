.class public Landroidx/webkit/internal/ApiFeature$Q;
.super Landroidx/webkit/internal/ApiFeature;
.source "ApiFeature.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/webkit/internal/ApiFeature;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Q"
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .registers 3
    .param p1, "publicFeatureValue"    # Ljava/lang/String;
    .param p2, "internalFeatureValue"    # Ljava/lang/String;

    .line 205
    invoke-direct {p0, p1, p2}, Landroidx/webkit/internal/ApiFeature;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 206
    return-void
.end method


# virtual methods
.method public final isSupportedByFramework()Z
    .registers 3

    .line 210
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    return v0
.end method
