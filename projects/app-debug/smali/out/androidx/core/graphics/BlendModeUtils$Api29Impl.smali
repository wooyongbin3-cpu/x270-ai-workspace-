.class Landroidx/core/graphics/BlendModeUtils$Api29Impl;
.super Ljava/lang/Object;
.source "BlendModeUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/graphics/BlendModeUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "Api29Impl"
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    return-void
.end method

.method static obtainBlendModeFromCompat(Landroidx/core/graphics/BlendModeCompat;)Ljava/lang/Object;
    .registers 3
    .param p0, "blendModeCompat"    # Landroidx/core/graphics/BlendModeCompat;

    .line 44
    sget-object v0, Landroidx/core/graphics/BlendModeUtils$1;->$SwitchMap$androidx$core$graphics$BlendModeCompat:[I

    invoke-virtual {p0}, Landroidx/core/graphics/BlendModeCompat;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_64

    .line 104
    const/4 v0, 0x0

    return-object v0

    .line 102
    :pswitch_d
    sget-object v0, Landroid/graphics/BlendMode;->LUMINOSITY:Landroid/graphics/BlendMode;

    return-object v0

    .line 100
    :pswitch_10
    sget-object v0, Landroid/graphics/BlendMode;->COLOR:Landroid/graphics/BlendMode;

    return-object v0

    .line 98
    :pswitch_13
    sget-object v0, Landroid/graphics/BlendMode;->SATURATION:Landroid/graphics/BlendMode;

    return-object v0

    .line 96
    :pswitch_16
    sget-object v0, Landroid/graphics/BlendMode;->HUE:Landroid/graphics/BlendMode;

    return-object v0

    .line 94
    :pswitch_19
    sget-object v0, Landroid/graphics/BlendMode;->MULTIPLY:Landroid/graphics/BlendMode;

    return-object v0

    .line 92
    :pswitch_1c
    sget-object v0, Landroid/graphics/BlendMode;->EXCLUSION:Landroid/graphics/BlendMode;

    return-object v0

    .line 90
    :pswitch_1f
    sget-object v0, Landroid/graphics/BlendMode;->DIFFERENCE:Landroid/graphics/BlendMode;

    return-object v0

    .line 88
    :pswitch_22
    sget-object v0, Landroid/graphics/BlendMode;->SOFT_LIGHT:Landroid/graphics/BlendMode;

    return-object v0

    .line 86
    :pswitch_25
    sget-object v0, Landroid/graphics/BlendMode;->HARD_LIGHT:Landroid/graphics/BlendMode;

    return-object v0

    .line 84
    :pswitch_28
    sget-object v0, Landroid/graphics/BlendMode;->COLOR_BURN:Landroid/graphics/BlendMode;

    return-object v0

    .line 82
    :pswitch_2b
    sget-object v0, Landroid/graphics/BlendMode;->COLOR_DODGE:Landroid/graphics/BlendMode;

    return-object v0

    .line 80
    :pswitch_2e
    sget-object v0, Landroid/graphics/BlendMode;->LIGHTEN:Landroid/graphics/BlendMode;

    return-object v0

    .line 78
    :pswitch_31
    sget-object v0, Landroid/graphics/BlendMode;->DARKEN:Landroid/graphics/BlendMode;

    return-object v0

    .line 76
    :pswitch_34
    sget-object v0, Landroid/graphics/BlendMode;->OVERLAY:Landroid/graphics/BlendMode;

    return-object v0

    .line 74
    :pswitch_37
    sget-object v0, Landroid/graphics/BlendMode;->SCREEN:Landroid/graphics/BlendMode;

    return-object v0

    .line 72
    :pswitch_3a
    sget-object v0, Landroid/graphics/BlendMode;->MODULATE:Landroid/graphics/BlendMode;

    return-object v0

    .line 70
    :pswitch_3d
    sget-object v0, Landroid/graphics/BlendMode;->PLUS:Landroid/graphics/BlendMode;

    return-object v0

    .line 68
    :pswitch_40
    sget-object v0, Landroid/graphics/BlendMode;->XOR:Landroid/graphics/BlendMode;

    return-object v0

    .line 66
    :pswitch_43
    sget-object v0, Landroid/graphics/BlendMode;->DST_ATOP:Landroid/graphics/BlendMode;

    return-object v0

    .line 64
    :pswitch_46
    sget-object v0, Landroid/graphics/BlendMode;->SRC_ATOP:Landroid/graphics/BlendMode;

    return-object v0

    .line 62
    :pswitch_49
    sget-object v0, Landroid/graphics/BlendMode;->DST_OUT:Landroid/graphics/BlendMode;

    return-object v0

    .line 60
    :pswitch_4c
    sget-object v0, Landroid/graphics/BlendMode;->SRC_OUT:Landroid/graphics/BlendMode;

    return-object v0

    .line 58
    :pswitch_4f
    sget-object v0, Landroid/graphics/BlendMode;->DST_IN:Landroid/graphics/BlendMode;

    return-object v0

    .line 56
    :pswitch_52
    sget-object v0, Landroid/graphics/BlendMode;->SRC_IN:Landroid/graphics/BlendMode;

    return-object v0

    .line 54
    :pswitch_55
    sget-object v0, Landroid/graphics/BlendMode;->DST_OVER:Landroid/graphics/BlendMode;

    return-object v0

    .line 52
    :pswitch_58
    sget-object v0, Landroid/graphics/BlendMode;->SRC_OVER:Landroid/graphics/BlendMode;

    return-object v0

    .line 50
    :pswitch_5b
    sget-object v0, Landroid/graphics/BlendMode;->DST:Landroid/graphics/BlendMode;

    return-object v0

    .line 48
    :pswitch_5e
    sget-object v0, Landroid/graphics/BlendMode;->SRC:Landroid/graphics/BlendMode;

    return-object v0

    .line 46
    :pswitch_61
    sget-object v0, Landroid/graphics/BlendMode;->CLEAR:Landroid/graphics/BlendMode;

    return-object v0

    :pswitch_data_64
    .packed-switch 0x1
        :pswitch_61
        :pswitch_5e
        :pswitch_5b
        :pswitch_58
        :pswitch_55
        :pswitch_52
        :pswitch_4f
        :pswitch_4c
        :pswitch_49
        :pswitch_46
        :pswitch_43
        :pswitch_40
        :pswitch_3d
        :pswitch_3a
        :pswitch_37
        :pswitch_34
        :pswitch_31
        :pswitch_2e
        :pswitch_2b
        :pswitch_28
        :pswitch_25
        :pswitch_22
        :pswitch_1f
        :pswitch_1c
        :pswitch_19
        :pswitch_16
        :pswitch_13
        :pswitch_10
        :pswitch_d
    .end packed-switch
.end method
