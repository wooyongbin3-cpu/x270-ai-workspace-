.class final Landroidx/core/view/WindowInsetsCompat$TypeImpl30;
.super Ljava/lang/Object;
.source "WindowInsetsCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/view/WindowInsetsCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "TypeImpl30"
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 2268
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static toPlatformType(I)I
    .registers 4
    .param p0, "typeMask"    # I

    .line 2276
    const/4 v0, 0x0

    .line 2277
    .local v0, "result":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_2
    const/16 v2, 0x200

    if-gt v1, v2, :cond_41

    .line 2278
    and-int v2, p0, v1

    if-eqz v2, :cond_3e

    .line 2279
    sparse-switch v1, :sswitch_data_42

    goto :goto_3e

    .line 2302
    :sswitch_e
    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I

    move-result v2

    or-int/2addr v0, v2

    goto :goto_3e

    .line 2299
    :sswitch_14
    invoke-static {}, Landroid/view/WindowInsets$Type;->tappableElement()I

    move-result v2

    or-int/2addr v0, v2

    .line 2300
    goto :goto_3e

    .line 2296
    :sswitch_1a
    invoke-static {}, Landroid/view/WindowInsets$Type;->mandatorySystemGestures()I

    move-result v2

    or-int/2addr v0, v2

    .line 2297
    goto :goto_3e

    .line 2293
    :sswitch_20
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemGestures()I

    move-result v2

    or-int/2addr v0, v2

    .line 2294
    goto :goto_3e

    .line 2290
    :sswitch_26
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I

    move-result v2

    or-int/2addr v0, v2

    .line 2291
    goto :goto_3e

    .line 2287
    :sswitch_2c
    invoke-static {}, Landroid/view/WindowInsets$Type;->captionBar()I

    move-result v2

    or-int/2addr v0, v2

    .line 2288
    goto :goto_3e

    .line 2284
    :sswitch_32
    invoke-static {}, Landroid/view/WindowInsets$Type;->navigationBars()I

    move-result v2

    or-int/2addr v0, v2

    .line 2285
    goto :goto_3e

    .line 2281
    :sswitch_38
    invoke-static {}, Landroid/view/WindowInsets$Type;->statusBars()I

    move-result v2

    or-int/2addr v0, v2

    .line 2282
    nop

    .line 2277
    :cond_3e
    :goto_3e
    shl-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 2307
    .end local v1    # "i":I
    :cond_41
    return v0

    :sswitch_data_42
    .sparse-switch
        0x1 -> :sswitch_38
        0x2 -> :sswitch_32
        0x4 -> :sswitch_2c
        0x8 -> :sswitch_26
        0x10 -> :sswitch_20
        0x20 -> :sswitch_1a
        0x40 -> :sswitch_14
        0x80 -> :sswitch_e
    .end sparse-switch
.end method
