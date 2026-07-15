.class public final Landroidx/core/view/DisplayCompat;
.super Ljava/lang/Object;
.source "DisplayCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/view/DisplayCompat$Api23Impl;,
        Landroidx/core/view/DisplayCompat$ModeCompat;
    }
.end annotation


# static fields
.field private static final DISPLAY_SIZE_4K_HEIGHT:I = 0x870

.field private static final DISPLAY_SIZE_4K_WIDTH:I = 0xf00


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    return-void
.end method

.method static getCurrentDisplaySizeFromWorkarounds(Landroid/content/Context;Landroid/view/Display;)Landroid/graphics/Point;
    .registers 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "display"    # Landroid/view/Display;

    .line 185
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-ge v0, v1, :cond_d

    .line 186
    const-string v0, "sys.display-size"

    invoke-static {v0, p1}, Landroidx/core/view/DisplayCompat;->parsePhysicalDisplaySizeFromSystemProperties(Ljava/lang/String;Landroid/view/Display;)Landroid/graphics/Point;

    move-result-object v0

    goto :goto_13

    .line 187
    :cond_d
    const-string v0, "vendor.display-size"

    invoke-static {v0, p1}, Landroidx/core/view/DisplayCompat;->parsePhysicalDisplaySizeFromSystemProperties(Ljava/lang/String;Landroid/view/Display;)Landroid/graphics/Point;

    move-result-object v0

    :goto_13
    nop

    .line 188
    .local v0, "displaySize":Landroid/graphics/Point;
    if-eqz v0, :cond_17

    .line 189
    return-object v0

    .line 190
    :cond_17
    invoke-static {p0}, Landroidx/core/view/DisplayCompat;->isSonyBravia4kTv(Landroid/content/Context;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_30

    .line 195
    invoke-static {p1}, Landroidx/core/view/DisplayCompat;->isCurrentModeTheLargestMode(Landroid/view/Display;)Z

    move-result v1

    if-eqz v1, :cond_2e

    .line 196
    new-instance v2, Landroid/graphics/Point;

    const/16 v1, 0xf00

    const/16 v3, 0x870

    invoke-direct {v2, v1, v3}, Landroid/graphics/Point;-><init>(II)V

    goto :goto_2f

    .line 197
    :cond_2e
    nop

    .line 195
    :goto_2f
    return-object v2

    .line 199
    :cond_30
    return-object v2
.end method

.method private static getDisplaySize(Landroid/content/Context;Landroid/view/Display;)Landroid/graphics/Point;
    .registers 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "display"    # Landroid/view/Display;

    .line 72
    invoke-static {p0, p1}, Landroidx/core/view/DisplayCompat;->getCurrentDisplaySizeFromWorkarounds(Landroid/content/Context;Landroid/view/Display;)Landroid/graphics/Point;

    move-result-object v0

    .line 73
    .local v0, "displaySize":Landroid/graphics/Point;
    if-eqz v0, :cond_7

    .line 74
    return-object v0

    .line 77
    :cond_7
    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    .line 78
    .end local v0    # "displaySize":Landroid/graphics/Point;
    .local v1, "displaySize":Landroid/graphics/Point;
    invoke-virtual {p1, v1}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 79
    return-object v1
.end method

.method public static getMode(Landroid/content/Context;Landroid/view/Display;)Landroidx/core/view/DisplayCompat$ModeCompat;
    .registers 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "display"    # Landroid/view/Display;

    .line 61
    nop

    .line 62
    invoke-static {p0, p1}, Landroidx/core/view/DisplayCompat$Api23Impl;->getMode(Landroid/content/Context;Landroid/view/Display;)Landroidx/core/view/DisplayCompat$ModeCompat;

    move-result-object v0

    return-object v0
.end method

.method public static getRoundedCorner(Landroid/view/Display;I)Landroidx/core/view/RoundedCornerCompat;
    .registers 4
    .param p0, "display"    # Landroid/view/Display;
    .param p1, "position"    # I

    .line 235
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_f

    .line 236
    invoke-virtual {p0, p1}, Landroid/view/Display;->getRoundedCorner(I)Landroid/view/RoundedCorner;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/view/RoundedCornerCompat;->toRoundedCornerCompat(Landroid/view/RoundedCorner;)Landroidx/core/view/RoundedCornerCompat;

    move-result-object v0

    return-object v0

    .line 239
    :cond_f
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getSupportedModes(Landroid/content/Context;Landroid/view/Display;)[Landroidx/core/view/DisplayCompat$ModeCompat;
    .registers 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "display"    # Landroid/view/Display;

    .line 89
    nop

    .line 90
    invoke-static {p0, p1}, Landroidx/core/view/DisplayCompat$Api23Impl;->getSupportedModes(Landroid/content/Context;Landroid/view/Display;)[Landroidx/core/view/DisplayCompat$ModeCompat;

    move-result-object v0

    return-object v0
.end method

.method private static getSystemProperty(Ljava/lang/String;)Ljava/lang/String;
    .registers 6
    .param p0, "name"    # Ljava/lang/String;

    .line 128
    :try_start_0
    const-string v0, "android.os.SystemProperties"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 129
    .local v0, "systemProperties":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v1, "get"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 130
    .local v1, "getMethod":Ljava/lang/reflect/Method;
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_1e} :catch_1f

    return-object v2

    .line 131
    .end local v0    # "systemProperties":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v1    # "getMethod":Ljava/lang/reflect/Method;
    :catch_1f
    move-exception v0

    .line 132
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    return-object v1
.end method

.method static isCurrentModeTheLargestMode(Landroid/view/Display;)Z
    .registers 2
    .param p0, "display"    # Landroid/view/Display;

    .line 217
    nop

    .line 218
    invoke-static {p0}, Landroidx/core/view/DisplayCompat$Api23Impl;->isCurrentModeTheLargestMode(Landroid/view/Display;)Z

    move-result v0

    return v0
.end method

.method private static isSonyBravia4kTv(Landroid/content/Context;)Z
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 206
    invoke-static {p0}, Landroidx/core/view/DisplayCompat;->isTv(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_28

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 207
    const-string v1, "Sony"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_28

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 208
    const-string v1, "BRAVIA"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_28

    .line 209
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "com.sony.dtv.hardware.panel.qfhd"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_28

    const/4 v0, 0x1

    goto :goto_29

    :cond_28
    const/4 v0, 0x0

    .line 206
    :goto_29
    return v0
.end method

.method private static isTv(Landroid/content/Context;)Z
    .registers 4
    .param p0, "context"    # Landroid/content/Context;

    .line 141
    const-string v0, "uimode"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/UiModeManager;

    .line 142
    .local v0, "uiModeManager":Landroid/app/UiModeManager;
    if-eqz v0, :cond_13

    .line 143
    invoke-virtual {v0}, Landroid/app/UiModeManager;->getCurrentModeType()I

    move-result v1

    const/4 v2, 0x4

    if-ne v1, v2, :cond_13

    const/4 v1, 0x1

    goto :goto_14

    :cond_13
    const/4 v1, 0x0

    .line 142
    :goto_14
    return v1
.end method

.method private static parseDisplaySize(Ljava/lang/String;)Landroid/graphics/Point;
    .registers 5
    .param p0, "displaySize"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 108
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v1, "x"

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    .line 109
    .local v0, "displaySizeParts":[Ljava/lang/String;
    array-length v1, v0

    const/4 v2, 0x2

    if-ne v1, v2, :cond_27

    .line 110
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 111
    .local v1, "width":I
    const/4 v2, 0x1

    aget-object v2, v0, v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    .line 112
    .local v2, "height":I
    if-lez v1, :cond_27

    if-lez v2, :cond_27

    .line 113
    new-instance v3, Landroid/graphics/Point;

    invoke-direct {v3, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    return-object v3

    .line 116
    .end local v1    # "width":I
    .end local v2    # "height":I
    :cond_27
    new-instance v1, Ljava/lang/NumberFormatException;

    invoke-direct {v1}, Ljava/lang/NumberFormatException;-><init>()V

    throw v1
.end method

.method private static parsePhysicalDisplaySizeFromSystemProperties(Ljava/lang/String;Landroid/view/Display;)Landroid/graphics/Point;
    .registers 5
    .param p0, "property"    # Ljava/lang/String;
    .param p1, "display"    # Landroid/view/Display;

    .line 158
    invoke-virtual {p1}, Landroid/view/Display;->getDisplayId()I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_8

    .line 159
    return-object v1

    .line 163
    :cond_8
    invoke-static {p0}, Landroidx/core/view/DisplayCompat;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 164
    .local v0, "displaySize":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1c

    if-nez v0, :cond_15

    goto :goto_1c

    .line 169
    :cond_15
    :try_start_15
    invoke-static {v0}, Landroidx/core/view/DisplayCompat;->parseDisplaySize(Ljava/lang/String;)Landroid/graphics/Point;

    move-result-object v1
    :try_end_19
    .catch Ljava/lang/NumberFormatException; {:try_start_15 .. :try_end_19} :catch_1a

    return-object v1

    .line 170
    :catch_1a
    move-exception v2

    .line 172
    .local v2, "e":Ljava/lang/NumberFormatException;
    return-object v1

    .line 165
    .end local v2    # "e":Ljava/lang/NumberFormatException;
    :cond_1c
    :goto_1c
    return-object v1
.end method
