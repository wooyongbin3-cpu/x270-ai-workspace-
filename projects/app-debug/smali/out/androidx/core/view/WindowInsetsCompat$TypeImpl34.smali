.class final Landroidx/core/view/WindowInsetsCompat$TypeImpl34;
.super Ljava/lang/Object;
.source "WindowInsetsCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/view/WindowInsetsCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "TypeImpl34"
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 2313
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static toPlatformType(I)I
    .registers 4
    .param p0, "typeMask"    # I

    .line 2321
    const/4 v0, 0x0

    .line 2322
    .local v0, "result":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_2
    const/16 v2, 0x200

    if-gt v1, v2, :cond_47

    .line 2323
    and-int v2, p0, v1

    if-eqz v2, :cond_44

    .line 2324
    sparse-switch v1, :sswitch_data_48

    goto :goto_44

    .line 2350
    :sswitch_e
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemOverlays()I

    move-result v2

    or-int/2addr v0, v2

    goto :goto_44

    .line 2347
    :sswitch_14
    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I

    move-result v2

    or-int/2addr v0, v2

    .line 2348
    goto :goto_44

    .line 2344
    :sswitch_1a
    invoke-static {}, Landroid/view/WindowInsets$Type;->tappableElement()I

    move-result v2

    or-int/2addr v0, v2

    .line 2345
    goto :goto_44

    .line 2341
    :sswitch_20
    invoke-static {}, Landroid/view/WindowInsets$Type;->mandatorySystemGestures()I

    move-result v2

    or-int/2addr v0, v2

    .line 2342
    goto :goto_44

    .line 2338
    :sswitch_26
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemGestures()I

    move-result v2

    or-int/2addr v0, v2

    .line 2339
    goto :goto_44

    .line 2335
    :sswitch_2c
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result v2

    or-int/2addr v0, v2

    .line 2336
    goto :goto_44

    .line 2332
    :sswitch_32
    invoke-static {}, Landroid/view/WindowInsets$Type;->captionBar()I

    move-result v2

    or-int/2addr v0, v2

    .line 2333
    goto :goto_44

    .line 2329
    :sswitch_38
    invoke-static {}, Landroid/view/WindowInsets$Type;->navigationBars()I

    move-result v2

    or-int/2addr v0, v2

    .line 2330
    goto :goto_44

    .line 2326
    :sswitch_3e
    invoke-static {}, Landroid/view/WindowInsets$Type;->statusBars()I

    move-result v2

    or-int/2addr v0, v2

    .line 2327
    nop

    .line 2322
    :cond_44
    :goto_44
    shl-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 2355
    .end local v1    # "i":I
    :cond_47
    return v0

    :sswitch_data_48
    .sparse-switch
        0x1 -> :sswitch_3e
        0x2 -> :sswitch_38
        0x4 -> :sswitch_32
        0x8 -> :sswitch_2c
        0x10 -> :sswitch_26
        0x20 -> :sswitch_20
        0x40 -> :sswitch_1a
        0x80 -> :sswitch_14
        0x200 -> :sswitch_e
    .end sparse-switch
.end method
