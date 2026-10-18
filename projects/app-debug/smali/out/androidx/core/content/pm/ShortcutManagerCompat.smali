.class public Landroidx/core/content/pm/ShortcutManagerCompat;
.super Ljava/lang/Object;
.source "ShortcutManagerCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/content/pm/ShortcutManagerCompat$Api25Impl;,
        Landroidx/core/content/pm/ShortcutManagerCompat$ShortcutMatchFlags;
    }
.end annotation


# static fields
.field static final ACTION_INSTALL_SHORTCUT:Ljava/lang/String; = "com.android.launcher.action.INSTALL_SHORTCUT"

.field private static final DEFAULT_MAX_ICON_DIMENSION_DP:I = 0x60

.field private static final DEFAULT_MAX_ICON_DIMENSION_LOWRAM_DP:I = 0x30

.field public static final EXTRA_SHORTCUT_ID:Ljava/lang/String; = "android.intent.extra.shortcut.ID"

.field public static final FLAG_MATCH_CACHED:I = 0x8

.field public static final FLAG_MATCH_DYNAMIC:I = 0x2

.field public static final FLAG_MATCH_MANIFEST:I = 0x1

.field public static final FLAG_MATCH_PINNED:I = 0x4

.field static final INSTALL_SHORTCUT_PERMISSION:Ljava/lang/String; = "com.android.launcher.permission.INSTALL_SHORTCUT"

.field private static final SHORTCUT_LISTENER_INTENT_FILTER_ACTION:Ljava/lang/String; = "androidx.core.content.pm.SHORTCUT_LISTENER"

.field private static final SHORTCUT_LISTENER_META_DATA_KEY:Ljava/lang/String; = "androidx.core.content.pm.shortcut_listener_impl"

.field private static volatile sShortcutInfoChangeListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoChangeListener;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/core/content/pm/ShortcutInfoCompatSaver<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 128
    const/4 v0, 0x0

    sput-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    .line 138
    sput-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 145
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 147
    return-void
.end method

.method public static addDynamicShortcuts(Landroid/content/Context;Ljava/util/List;)Z
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)Z"
        }
    .end annotation

    .line 326
    .local p1, "shortcutInfoList":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    const/4 v0, 0x1

    invoke-static {p1, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->removeShortcutsExcludedFromSurface(Ljava/util/List;I)Ljava/util/List;

    move-result-object v1

    .line 328
    .local v1, "clone":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-gt v2, v3, :cond_e

    .line 329
    invoke-static {p0, v1}, Landroidx/core/content/pm/ShortcutManagerCompat;->convertUriIconsToBitmapIcons(Landroid/content/Context;Ljava/util/List;)V

    .line 331
    :cond_e
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x19

    if-lt v2, v3, :cond_41

    .line 332
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 333
    .local v2, "shortcuts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/content/pm/ShortcutInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1d
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_31

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 334
    .local v4, "item":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-virtual {v4}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 335
    .end local v4    # "item":Landroidx/core/content/pm/ShortcutInfoCompat;
    goto :goto_1d

    .line 336
    :cond_31
    const-class v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v3, v2}, Landroid/content/pm/ShortcutManager;->addDynamicShortcuts(Ljava/util/List;)Z

    move-result v3

    if-nez v3, :cond_41

    .line 337
    const/4 v0, 0x0

    return v0

    .line 341
    .end local v2    # "shortcuts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/content/pm/ShortcutInfo;>;"
    :cond_41
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->addShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 342
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_50
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_60

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 343
    .local v3, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v3, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 344
    .end local v3    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_50

    .line 345
    :cond_60
    return v0
.end method

.method static convertUriIconToBitmapIcon(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;)Z
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "info"    # Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 555
    iget-object v0, p1, Landroidx/core/content/pm/ShortcutInfoCompat;->mIcon:Landroidx/core/graphics/drawable/IconCompat;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    .line 556
    return v1

    .line 558
    :cond_6
    iget-object v0, p1, Landroidx/core/content/pm/ShortcutInfoCompat;->mIcon:Landroidx/core/graphics/drawable/IconCompat;

    iget v0, v0, Landroidx/core/graphics/drawable/IconCompat;->mType:I

    .line 559
    .local v0, "type":I
    const/4 v2, 0x1

    const/4 v3, 0x6

    if-eq v0, v3, :cond_12

    const/4 v4, 0x4

    if-eq v0, v4, :cond_12

    .line 560
    return v2

    .line 562
    :cond_12
    iget-object v4, p1, Landroidx/core/content/pm/ShortcutInfoCompat;->mIcon:Landroidx/core/graphics/drawable/IconCompat;

    invoke-virtual {v4, p0}, Landroidx/core/graphics/drawable/IconCompat;->getUriInputStream(Landroid/content/Context;)Ljava/io/InputStream;

    move-result-object v4

    .line 563
    .local v4, "is":Ljava/io/InputStream;
    if-nez v4, :cond_1b

    .line 564
    return v1

    .line 566
    :cond_1b
    invoke-static {v4}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v5

    .line 567
    .local v5, "bitmap":Landroid/graphics/Bitmap;
    if-nez v5, :cond_22

    .line 568
    return v1

    .line 570
    :cond_22
    if-ne v0, v3, :cond_29

    .line 571
    invoke-static {v5}, Landroidx/core/graphics/drawable/IconCompat;->createWithAdaptiveBitmap(Landroid/graphics/Bitmap;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v1

    goto :goto_2d

    .line 572
    :cond_29
    invoke-static {v5}, Landroidx/core/graphics/drawable/IconCompat;->createWithBitmap(Landroid/graphics/Bitmap;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v1

    :goto_2d
    iput-object v1, p1, Landroidx/core/content/pm/ShortcutInfoCompat;->mIcon:Landroidx/core/graphics/drawable/IconCompat;

    .line 573
    return v2
.end method

.method static convertUriIconsToBitmapIcons(Landroid/content/Context;Ljava/util/List;)V
    .registers 6
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)V"
        }
    .end annotation

    .line 579
    .local p1, "shortcutInfoList":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 580
    .local v0, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_9
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 581
    .local v2, "info":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-static {p0, v2}, Landroidx/core/content/pm/ShortcutManagerCompat;->convertUriIconToBitmapIcon(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 582
    invoke-interface {p1, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 584
    .end local v2    # "info":Landroidx/core/content/pm/ShortcutInfoCompat;
    :cond_1e
    goto :goto_9

    .line 585
    :cond_1f
    return-void
.end method

.method public static createShortcutResultIntent(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;)Landroid/content/Intent;
    .registers 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "shortcut"    # Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 240
    const/4 v0, 0x0

    .line 241
    .local v0, "result":Landroid/content/Intent;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_17

    .line 242
    const-class v1, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/pm/ShortcutManager;

    .line 243
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/pm/ShortcutManager;->createShortcutResultIntent(Landroid/content/pm/ShortcutInfo;)Landroid/content/Intent;

    move-result-object v0

    .line 245
    :cond_17
    if-nez v0, :cond_1f

    .line 246
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    move-object v0, v1

    .line 248
    :cond_1f
    invoke-virtual {p1, v0}, Landroidx/core/content/pm/ShortcutInfoCompat;->addToIntent(Landroid/content/Intent;)Landroid/content/Intent;

    move-result-object v1

    return-object v1
.end method

.method public static disableShortcuts(Landroid/content/Context;Ljava/util/List;Ljava/lang/CharSequence;)V
    .registers 5
    .param p0, "context"    # Landroid/content/Context;
    .param p2, "disabledMessage"    # Ljava/lang/CharSequence;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/CharSequence;",
            ")V"
        }
    .end annotation

    .line 606
    .local p1, "shortcutIds":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_11

    .line 607
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    .line 608
    invoke-virtual {v0, p1, p2}, Landroid/content/pm/ShortcutManager;->disableShortcuts(Ljava/util/List;Ljava/lang/CharSequence;)V

    .line 611
    :cond_11
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 612
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_20
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_30

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 613
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v1, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutRemoved(Ljava/util/List;)V

    .line 614
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_20

    .line 615
    :cond_30
    return-void
.end method

.method public static enableShortcuts(Landroid/content/Context;Ljava/util/List;)V
    .registers 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)V"
        }
    .end annotation

    .line 635
    .local p1, "shortcutInfoList":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    const/4 v0, 0x1

    invoke-static {p1, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->removeShortcutsExcludedFromSurface(Ljava/util/List;I)Ljava/util/List;

    move-result-object v0

    .line 637
    .local v0, "clone":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x19

    if-lt v1, v2, :cond_35

    .line 638
    new-instance v1, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 639
    .local v1, "shortcutIds":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_18
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2a

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 640
    .local v3, "shortcut":Landroidx/core/content/pm/ShortcutInfoCompat;
    iget-object v4, v3, Landroidx/core/content/pm/ShortcutInfoCompat;->mId:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 641
    .end local v3    # "shortcut":Landroidx/core/content/pm/ShortcutInfoCompat;
    goto :goto_18

    .line 642
    :cond_2a
    const-class v2, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v2, v1}, Landroid/content/pm/ShortcutManager;->enableShortcuts(Ljava/util/List;)V

    .line 645
    .end local v1    # "shortcutIds":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_35
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->addShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 646
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_44
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_54

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 647
    .local v2, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v2, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 648
    .end local v2    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_44

    .line 649
    :cond_54
    return-void
.end method

.method public static getDynamicShortcuts(Landroid/content/Context;)Ljava/util/List;
    .registers 6
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;"
        }
    .end annotation

    .line 495
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_39

    .line 496
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    .line 497
    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getDynamicShortcuts()Ljava/util/List;

    move-result-object v0

    .line 498
    .local v0, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    new-instance v1, Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 499
    .local v1, "compats":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1f
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_38

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutInfo;

    .line 500
    .local v3, "item":Landroid/content/pm/ShortcutInfo;
    new-instance v4, Landroidx/core/content/pm/ShortcutInfoCompat$Builder;

    invoke-direct {v4, p0, v3}, Landroidx/core/content/pm/ShortcutInfoCompat$Builder;-><init>(Landroid/content/Context;Landroid/content/pm/ShortcutInfo;)V

    invoke-virtual {v4}, Landroidx/core/content/pm/ShortcutInfoCompat$Builder;->build()Landroidx/core/content/pm/ShortcutInfoCompat;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 501
    .end local v3    # "item":Landroid/content/pm/ShortcutInfo;
    goto :goto_1f

    .line 502
    :cond_38
    return-object v1

    .line 506
    .end local v0    # "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    .end local v1    # "compats":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    :cond_39
    :try_start_39
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->getShortcuts()Ljava/util/List;

    move-result-object v0
    :try_end_41
    .catch Ljava/lang/Exception; {:try_start_39 .. :try_end_41} :catch_42

    return-object v0

    .line 507
    :catch_42
    move-exception v0

    .line 511
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    return-object v0
.end method

.method private static getIconDimensionInternal(Landroid/content/Context;Z)I
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "isHorizontal"    # Z

    .line 830
    nop

    .line 831
    const-string v0, "activity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 832
    .local v0, "am":Landroid/app/ActivityManager;
    const/4 v1, 0x1

    if-eqz v0, :cond_15

    invoke-virtual {v0}, Landroid/app/ActivityManager;->isLowRamDevice()Z

    move-result v2

    if-eqz v2, :cond_13

    goto :goto_15

    :cond_13
    const/4 v2, 0x0

    goto :goto_16

    :cond_15
    :goto_15
    move v2, v1

    .line 833
    .local v2, "isLowRamDevice":Z
    :goto_16
    if-eqz v2, :cond_1b

    .line 834
    const/16 v3, 0x30

    goto :goto_1d

    :cond_1b
    const/16 v3, 0x60

    .line 833
    :goto_1d
    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 835
    .local v1, "iconDimensionDp":I
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    .line 836
    .local v3, "displayMetrics":Landroid/util/DisplayMetrics;
    if-eqz p1, :cond_2e

    iget v4, v3, Landroid/util/DisplayMetrics;->xdpi:F

    goto :goto_30

    :cond_2e
    iget v4, v3, Landroid/util/DisplayMetrics;->ydpi:F

    :goto_30
    const/high16 v5, 0x43200000    # 160.0f

    div-float/2addr v4, v5

    .line 838
    .local v4, "density":F
    int-to-float v5, v1

    mul-float/2addr v5, v4

    float-to-int v5, v5

    return v5
.end method

.method public static getIconMaxHeight(Landroid/content/Context;)I
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 401
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 402
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_16

    .line 403
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getIconMaxHeight()I

    move-result v0

    return v0

    .line 405
    :cond_16
    const/4 v0, 0x0

    invoke-static {p0, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getIconDimensionInternal(Landroid/content/Context;Z)I

    move-result v0

    return v0
.end method

.method public static getIconMaxWidth(Landroid/content/Context;)I
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 390
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 391
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_16

    .line 392
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getIconMaxWidth()I

    move-result v0

    return v0

    .line 394
    :cond_16
    const/4 v0, 0x1

    invoke-static {p0, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getIconDimensionInternal(Landroid/content/Context;Z)I

    move-result v0

    return v0
.end method

.method public static getMaxShortcutCountPerActivity(Landroid/content/Context;)I
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 353
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 354
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_16

    .line 355
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getMaxShortcutCountPerActivity()I

    move-result v0

    return v0

    .line 358
    :cond_16
    const/4 v0, 0x5

    return v0
.end method

.method static getShortcutInfoChangeListeners()Ljava/util/List;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoChangeListener;",
            ">;"
        }
    .end annotation

    .line 825
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    return-object v0
.end method

.method private static getShortcutInfoCompatWithLowestRank(Ljava/util/List;)Ljava/lang/String;
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 802
    .local p0, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    const/4 v0, -0x1

    .line 803
    .local v0, "rank":I
    const/4 v1, 0x0

    .line 804
    .local v1, "target":Ljava/lang/String;
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_6
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_21

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 805
    .local v3, "s":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-virtual {v3}, Landroidx/core/content/pm/ShortcutInfoCompat;->getRank()I

    move-result v4

    if-le v4, v0, :cond_20

    .line 806
    invoke-virtual {v3}, Landroidx/core/content/pm/ShortcutInfoCompat;->getId()Ljava/lang/String;

    move-result-object v1

    .line 807
    invoke-virtual {v3}, Landroidx/core/content/pm/ShortcutInfoCompat;->getRank()I

    move-result v0

    .line 809
    .end local v3    # "s":Landroidx/core/content/pm/ShortcutInfoCompat;
    :cond_20
    goto :goto_6

    .line 810
    :cond_21
    return-object v1
.end method

.method private static getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;
    .registers 16
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoChangeListener;",
            ">;"
        }
    .end annotation

    .line 864
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    if-nez v0, :cond_76

    .line 865
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 866
    .local v0, "result":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoChangeListener;>;"
    nop

    .line 867
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 868
    .local v1, "packageManager":Landroid/content/pm/PackageManager;
    new-instance v2, Landroid/content/Intent;

    const-string v3, "androidx.core.content.pm.SHORTCUT_LISTENER"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 869
    .local v2, "activityIntent":Landroid/content/Intent;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 871
    const/16 v3, 0x80

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v3

    .line 874
    .local v3, "resolveInfos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_26
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_70

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/pm/ResolveInfo;

    .line 875
    .local v5, "resolveInfo":Landroid/content/pm/ResolveInfo;
    iget-object v6, v5, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    .line 876
    .local v6, "activityInfo":Landroid/content/pm/ActivityInfo;
    if-nez v6, :cond_37

    .line 877
    goto :goto_26

    .line 879
    :cond_37
    iget-object v7, v6, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 880
    .local v7, "metaData":Landroid/os/Bundle;
    if-nez v7, :cond_3c

    .line 881
    goto :goto_26

    .line 883
    :cond_3c
    nop

    .line 884
    const-string v8, "androidx.core.content.pm.shortcut_listener_impl"

    invoke-virtual {v7, v8}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 885
    .local v8, "shortcutListenerImplName":Ljava/lang/String;
    if-nez v8, :cond_46

    .line 886
    goto :goto_26

    .line 889
    :cond_46
    :try_start_46
    const-class v9, Landroidx/core/content/pm/ShortcutManagerCompat;

    invoke-virtual {v9}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v9

    .line 890
    .local v9, "loader":Ljava/lang/ClassLoader;
    const/4 v10, 0x0

    invoke-static {v8, v10, v9}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v11

    .line 891
    .local v11, "listener":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v12, "getInstance"

    const/4 v13, 0x1

    new-array v13, v13, [Ljava/lang/Class;

    const-class v14, Landroid/content/Context;

    aput-object v14, v13, v10

    invoke-virtual {v11, v12, v13}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v10

    .line 892
    .local v10, "getInstanceMethod":Ljava/lang/reflect/Method;
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v12

    .line 893
    const/4 v13, 0x0

    invoke-virtual {v10, v13, v12}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 892
    invoke-interface {v0, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_6c
    .catch Ljava/lang/Exception; {:try_start_46 .. :try_end_6c} :catch_6e

    .line 894
    nop

    .end local v9    # "loader":Ljava/lang/ClassLoader;
    .end local v10    # "getInstanceMethod":Ljava/lang/reflect/Method;
    .end local v11    # "listener":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    goto :goto_6f

    :catch_6e
    move-exception v9

    .line 895
    .end local v5    # "resolveInfo":Landroid/content/pm/ResolveInfo;
    .end local v6    # "activityInfo":Landroid/content/pm/ActivityInfo;
    .end local v7    # "metaData":Landroid/os/Bundle;
    .end local v8    # "shortcutListenerImplName":Ljava/lang/String;
    :goto_6f
    goto :goto_26

    .line 899
    .end local v1    # "packageManager":Landroid/content/pm/PackageManager;
    .end local v2    # "activityIntent":Landroid/content/Intent;
    .end local v3    # "resolveInfos":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    :cond_70
    sget-object v1, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    if-nez v1, :cond_76

    .line 900
    sput-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    .line 903
    .end local v0    # "result":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoChangeListener;>;"
    :cond_76
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    return-object v0
.end method

.method private static getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;
    .registers 7
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Landroidx/core/content/pm/ShortcutInfoCompatSaver<",
            "*>;"
        }
    .end annotation

    .line 842
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    if-nez v0, :cond_3a

    .line 843
    nop

    .line 845
    :try_start_5
    const-class v0, Landroidx/core/content/pm/ShortcutManagerCompat;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 846
    .local v0, "loader":Ljava/lang/ClassLoader;
    const-string v1, "androidx.sharetarget.ShortcutInfoCompatSaverImpl"

    const/4 v2, 0x0

    invoke-static {v1, v2, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 848
    .local v1, "saver":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v3, "getInstance"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const-class v5, Landroid/content/Context;

    aput-object v5, v4, v2

    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 849
    .local v2, "getInstanceMethod":Ljava/lang/reflect/Method;
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    sput-object v3, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;
    :try_end_2c
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_2c} :catch_2d

    .end local v0    # "loader":Ljava/lang/ClassLoader;
    .end local v1    # "saver":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v2    # "getInstanceMethod":Ljava/lang/reflect/Method;
    goto :goto_2e

    .line 851
    :catch_2d
    move-exception v0

    :goto_2e
    nop

    .line 854
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    if-nez v0, :cond_3a

    .line 856
    new-instance v0, Landroidx/core/content/pm/ShortcutInfoCompatSaver$NoopImpl;

    invoke-direct {v0}, Landroidx/core/content/pm/ShortcutInfoCompatSaver$NoopImpl;-><init>()V

    sput-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    .line 859
    :cond_3a
    sget-object v0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    return-object v0
.end method

.method public static getShortcuts(Landroid/content/Context;I)Ljava/util/List;
    .registers 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "matchFlags"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "I)",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;"
        }
    .end annotation

    .line 281
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_17

    .line 282
    const-class v0, Landroid/content/pm/ShortcutManager;

    .line 283
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0, p1}, Landroid/content/pm/ShortcutManager;->getShortcuts(I)Ljava/util/List;

    move-result-object v0

    .line 284
    .local v0, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    invoke-static {p0, v0}, Landroidx/core/content/pm/ShortcutInfoCompat;->fromShortcuts(Landroid/content/Context;Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 285
    .end local v0    # "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    :cond_17
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_50

    .line 286
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    .line 287
    .local v0, "manager":Landroid/content/pm/ShortcutManager;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 288
    .local v1, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    and-int/lit8 v2, p1, 0x1

    if-eqz v2, :cond_35

    .line 289
    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getManifestShortcuts()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 291
    :cond_35
    and-int/lit8 v2, p1, 0x2

    if-eqz v2, :cond_40

    .line 292
    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getDynamicShortcuts()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 294
    :cond_40
    and-int/lit8 v2, p1, 0x4

    if-eqz v2, :cond_4b

    .line 295
    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getPinnedShortcuts()Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 297
    :cond_4b
    invoke-static {p0, v1}, Landroidx/core/content/pm/ShortcutInfoCompat;->fromShortcuts(Landroid/content/Context;Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    return-object v2

    .line 299
    .end local v0    # "manager":Landroid/content/pm/ShortcutManager;
    .end local v1    # "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    :cond_50
    and-int/lit8 v0, p1, 0x2

    if-eqz v0, :cond_5e

    .line 301
    :try_start_54
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->getShortcuts()Ljava/util/List;

    move-result-object v0
    :try_end_5c
    .catch Ljava/lang/Exception; {:try_start_54 .. :try_end_5c} :catch_5d

    return-object v0

    .line 302
    :catch_5d
    move-exception v0

    .line 306
    :cond_5e
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static isRateLimitingActive(Landroid/content/Context;)Z
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 370
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 371
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_16

    .line 372
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->isRateLimitingActive()Z

    move-result v0

    return v0

    .line 375
    :cond_16
    const/4 v0, 0x3

    invoke-static {p0, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcuts(Landroid/content/Context;I)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 376
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getMaxShortcutCountPerActivity(Landroid/content/Context;)I

    move-result v1

    if-ne v0, v1, :cond_27

    const/4 v0, 0x1

    goto :goto_28

    :cond_27
    const/4 v0, 0x0

    .line 375
    :goto_28
    return v0
.end method

.method public static isRequestPinShortcutSupported(Landroid/content/Context;)Z
    .registers 7
    .param p0, "context"    # Landroid/content/Context;

    .line 154
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_13

    .line 155
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->isRequestPinShortcutSupported()Z

    move-result v0

    return v0

    .line 158
    :cond_13
    const-string v0, "com.android.launcher.permission.INSTALL_SHORTCUT"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1d

    .line 160
    return v2

    .line 162
    :cond_1d
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    new-instance v3, Landroid/content/Intent;

    const-string v4, "com.android.launcher.action.INSTALL_SHORTCUT"

    invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v3, v2}, Landroid/content/pm/PackageManager;->queryBroadcastReceivers(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_30
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_50

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ResolveInfo;

    .line 164
    .local v3, "info":Landroid/content/pm/ResolveInfo;
    iget-object v4, v3, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v4, v4, Landroid/content/pm/ActivityInfo;->permission:Ljava/lang/String;

    .line 165
    .local v4, "permission":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_4e

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4d

    goto :goto_4e

    .line 168
    .end local v3    # "info":Landroid/content/pm/ResolveInfo;
    .end local v4    # "permission":Ljava/lang/String;
    :cond_4d
    goto :goto_30

    .line 166
    .restart local v3    # "info":Landroid/content/pm/ResolveInfo;
    .restart local v4    # "permission":Ljava/lang/String;
    :cond_4e
    :goto_4e
    const/4 v0, 0x1

    return v0

    .line 169
    .end local v3    # "info":Landroid/content/pm/ResolveInfo;
    .end local v4    # "permission":Ljava/lang/String;
    :cond_50
    return v2
.end method

.method public static pushDynamicShortcut(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;)Z
    .registers 9
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "shortcut"    # Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 748
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 749
    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 751
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x20

    const/4 v2, 0x1

    if-gt v0, v1, :cond_30

    .line 752
    invoke-virtual {p1, v2}, Landroidx/core/content/pm/ShortcutInfoCompat;->isExcludedFromSurfaces(I)Z

    move-result v0

    if-eqz v0, :cond_30

    .line 753
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1b
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2f

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 754
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 755
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_1b

    .line 756
    :cond_2f
    return v2

    .line 758
    :cond_30
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getMaxShortcutCountPerActivity(Landroid/content/Context;)I

    move-result v0

    .line 759
    .local v0, "maxShortcutCount":I
    const/4 v1, 0x0

    if-nez v0, :cond_38

    .line 760
    return v1

    .line 762
    :cond_38
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    if-gt v3, v4, :cond_41

    .line 763
    invoke-static {p0, p1}, Landroidx/core/content/pm/ShortcutManagerCompat;->convertUriIconToBitmapIcon(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;)Z

    .line 765
    :cond_41
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1e

    if-lt v3, v4, :cond_57

    .line 766
    const-class v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutManager;

    .line 767
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v4

    .line 766
    invoke-virtual {v3, v4}, Landroid/content/pm/ShortcutManager;->pushDynamicShortcut(Landroid/content/pm/ShortcutInfo;)V

    goto :goto_94

    .line 768
    :cond_57
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x19

    if-lt v3, v4, :cond_94

    .line 769
    const-class v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutManager;

    .line 770
    .local v3, "sm":Landroid/content/pm/ShortcutManager;
    invoke-virtual {v3}, Landroid/content/pm/ShortcutManager;->isRateLimitingActive()Z

    move-result v4

    if-eqz v4, :cond_6c

    .line 771
    return v1

    .line 773
    :cond_6c
    invoke-virtual {v3}, Landroid/content/pm/ShortcutManager;->getDynamicShortcuts()Ljava/util/List;

    move-result-object v4

    .line 774
    .local v4, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    if-lt v5, v0, :cond_85

    .line 775
    new-array v5, v2, [Ljava/lang/String;

    .line 776
    invoke-static {v4}, Landroidx/core/content/pm/ShortcutManagerCompat$Api25Impl;->getShortcutInfoWithLowestRank(Ljava/util/List;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v1

    .line 775
    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/content/pm/ShortcutManager;->removeDynamicShortcuts(Ljava/util/List;)V

    .line 778
    :cond_85
    new-array v5, v2, [Landroid/content/pm/ShortcutInfo;

    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v6

    aput-object v6, v5, v1

    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/content/pm/ShortcutManager;->addDynamicShortcuts(Ljava/util/List;)Z

    .line 780
    .end local v3    # "sm":Landroid/content/pm/ShortcutManager;
    .end local v4    # "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    :cond_94
    :goto_94
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v3

    .line 782
    .local v3, "saver":Landroidx/core/content/pm/ShortcutInfoCompatSaver;, "Landroidx/core/content/pm/ShortcutInfoCompatSaver<*>;"
    :try_start_98
    invoke-virtual {v3}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->getShortcuts()Ljava/util/List;

    move-result-object v4

    .line 783
    .local v4, "oldShortcuts":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    if-lt v5, v0, :cond_b1

    .line 784
    new-array v5, v2, [Ljava/lang/String;

    .line 785
    invoke-static {v4}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoCompatWithLowestRank(Ljava/util/List;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v1

    .line 784
    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 787
    :cond_b1
    new-array v5, v2, [Landroidx/core/content/pm/ShortcutInfoCompat;

    aput-object p1, v5, v1

    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->addShortcuts(Ljava/util/List;)Ljava/lang/Object;
    :try_end_bc
    .catch Ljava/lang/Exception; {:try_start_98 .. :try_end_bc} :catch_106
    .catchall {:try_start_98 .. :try_end_bc} :catchall_e1

    .line 788
    nop

    .line 792
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_c5
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_d9

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 793
    .local v5, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 794
    .end local v5    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_c5

    .line 795
    :cond_d9
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->getId()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Landroidx/core/content/pm/ShortcutManagerCompat;->reportShortcutUsed(Landroid/content/Context;Ljava/lang/String;)V

    .line 788
    return v2

    .line 792
    .end local v4    # "oldShortcuts":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    :catchall_e1
    move-exception v1

    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_ea
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_fe

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 793
    .local v4, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 794
    .end local v4    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_ea

    .line 795
    :cond_fe
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v2}, Landroidx/core/content/pm/ShortcutManagerCompat;->reportShortcutUsed(Landroid/content/Context;Ljava/lang/String;)V

    .line 796
    throw v1

    .line 789
    :catch_106
    move-exception v2

    .line 792
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_10f
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_123

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 793
    .restart local v4    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 794
    .end local v4    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_10f

    .line 795
    :cond_123
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v2}, Landroidx/core/content/pm/ShortcutManagerCompat;->reportShortcutUsed(Landroid/content/Context;Ljava/lang/String;)V

    .line 796
    nop

    .line 797
    return v1
.end method

.method public static removeAllDynamicShortcuts(Landroid/content/Context;)V
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .line 678
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_11

    .line 679
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->removeAllDynamicShortcuts()V

    .line 682
    :cond_11
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeAllShortcuts()Ljava/lang/Object;

    .line 683
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_20
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_30

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 684
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onAllShortcutsRemoved()V

    .line 685
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_20

    .line 686
    :cond_30
    return-void
.end method

.method public static removeDynamicShortcuts(Landroid/content/Context;Ljava/util/List;)V
    .registers 4
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 660
    .local p1, "shortcutIds":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_11

    .line 661
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0, p1}, Landroid/content/pm/ShortcutManager;->removeDynamicShortcuts(Ljava/util/List;)V

    .line 664
    :cond_11
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 665
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_20
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_30

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 666
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v1, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutRemoved(Ljava/util/List;)V

    .line 667
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_20

    .line 668
    :cond_30
    return-void
.end method

.method public static removeLongLivedShortcuts(Landroid/content/Context;Ljava/util/List;)V
    .registers 4
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 701
    .local p1, "shortcutIds":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_a

    .line 702
    invoke-static {p0, p1}, Landroidx/core/content/pm/ShortcutManagerCompat;->removeDynamicShortcuts(Landroid/content/Context;Ljava/util/List;)V

    .line 703
    return-void

    .line 706
    :cond_a
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0, p1}, Landroid/content/pm/ShortcutManager;->removeLongLivedShortcuts(Ljava/util/List;)V

    .line 707
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 708
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_24
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_34

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 709
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v1, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutRemoved(Ljava/util/List;)V

    .line 710
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_24

    .line 711
    :cond_34
    return-void
.end method

.method private static removeShortcutsExcludedFromSurface(Ljava/util/List;I)Ljava/util/List;
    .registers 6
    .param p1, "surfaces"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;I)",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;"
        }
    .end annotation

    .line 908
    .local p0, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-static {p0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 909
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x20

    if-le v0, v1, :cond_a

    return-object p0

    .line 910
    :cond_a
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 911
    .local v0, "clone":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_13
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_29

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 912
    .local v2, "si":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-virtual {v2, p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->isExcludedFromSurfaces(I)Z

    move-result v3

    if-eqz v3, :cond_28

    .line 913
    invoke-interface {v0, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 915
    .end local v2    # "si":Landroidx/core/content/pm/ShortcutInfoCompat;
    :cond_28
    goto :goto_13

    .line 916
    :cond_29
    return-object v0
.end method

.method public static reportShortcutUsed(Landroid/content/Context;Ljava/lang/String;)V
    .registers 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "shortcutId"    # Ljava/lang/String;

    .line 427
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 428
    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 429
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x19

    if-lt v0, v1, :cond_17

    .line 430
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0, p1}, Landroid/content/pm/ShortcutManager;->reportShortcutUsed(Ljava/lang/String;)V

    .line 433
    :cond_17
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1f
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_33

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 434
    .local v1, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutUsageReported(Ljava/util/List;)V

    .line 435
    .end local v1    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_1f

    .line 436
    :cond_33
    return-void
.end method

.method public static requestPinShortcut(Landroid/content/Context;Landroidx/core/content/pm/ShortcutInfoCompat;Landroid/content/IntentSender;)Z
    .registers 15
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "shortcut"    # Landroidx/core/content/pm/ShortcutInfoCompat;
    .param p2, "callback"    # Landroid/content/IntentSender;

    .line 192
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x20

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-gt v0, v1, :cond_f

    .line 193
    invoke-virtual {p1, v3}, Landroidx/core/content/pm/ShortcutInfoCompat;->isExcludedFromSurfaces(I)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 195
    return v2

    .line 197
    :cond_f
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_26

    .line 198
    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    .line 199
    invoke-virtual {p1}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v1

    .line 198
    invoke-virtual {v0, v1, p2}, Landroid/content/pm/ShortcutManager;->requestPinShortcut(Landroid/content/pm/ShortcutInfo;Landroid/content/IntentSender;)Z

    move-result v0

    return v0

    .line 202
    :cond_26
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->isRequestPinShortcutSupported(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_2d

    .line 203
    return v2

    .line 205
    :cond_2d
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.launcher.action.INSTALL_SHORTCUT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Landroidx/core/content/pm/ShortcutInfoCompat;->addToIntent(Landroid/content/Intent;)Landroid/content/Intent;

    move-result-object v5

    .line 208
    .local v5, "intent":Landroid/content/Intent;
    if-nez p2, :cond_3e

    .line 209
    invoke-virtual {p0, v5}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 210
    return v3

    .line 214
    :cond_3e
    new-instance v7, Landroidx/core/content/pm/ShortcutManagerCompat$1;

    invoke-direct {v7, p2}, Landroidx/core/content/pm/ShortcutManagerCompat$1;-><init>(Landroid/content/IntentSender;)V

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, -0x1

    move-object v4, p0

    .end local p0    # "context":Landroid/content/Context;
    .local v4, "context":Landroid/content/Context;
    invoke-virtual/range {v4 .. v11}, Landroid/content/Context;->sendOrderedBroadcast(Landroid/content/Intent;Ljava/lang/String;Landroid/content/BroadcastReceiver;Landroid/os/Handler;ILjava/lang/String;Landroid/os/Bundle;)V

    .line 224
    return v3
.end method

.method public static setDynamicShortcuts(Landroid/content/Context;Ljava/util/List;)Z
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)Z"
        }
    .end annotation

    .line 464
    .local p1, "shortcutInfoList":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    invoke-static {p0}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 465
    invoke-static {p1}, Landroidx/core/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 466
    const/4 v0, 0x1

    invoke-static {p1, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->removeShortcutsExcludedFromSurface(Ljava/util/List;I)Ljava/util/List;

    move-result-object v1

    .line 468
    .local v1, "clone":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x19

    if-lt v2, v3, :cond_42

    .line 469
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 470
    .local v2, "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1e
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_32

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 471
    .local v4, "compat":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-virtual {v4}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 472
    .end local v4    # "compat":Landroidx/core/content/pm/ShortcutInfoCompat;
    goto :goto_1e

    .line 473
    :cond_32
    const-class v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v3, v2}, Landroid/content/pm/ShortcutManager;->setDynamicShortcuts(Ljava/util/List;)Z

    move-result v3

    if-nez v3, :cond_42

    .line 474
    const/4 v0, 0x0

    return v0

    .line 477
    .end local v2    # "shortcuts":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ShortcutInfo;>;"
    :cond_42
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->removeAllShortcuts()Ljava/lang/Object;

    .line 478
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->addShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 480
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_58
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6b

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 481
    .local v3, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v3}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onAllShortcutsRemoved()V

    .line 482
    invoke-virtual {v3, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutAdded(Ljava/util/List;)V

    .line 483
    .end local v3    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_58

    .line 484
    :cond_6b
    return v0
.end method

.method static setShortcutInfoChangeListeners(Ljava/util/List;)V
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoChangeListener;",
            ">;)V"
        }
    .end annotation

    .line 820
    .local p0, "listeners":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoChangeListener;>;"
    sput-object p0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoChangeListeners:Ljava/util/List;

    .line 821
    return-void
.end method

.method static setShortcutInfoCompatSaver(Landroidx/core/content/pm/ShortcutInfoCompatSaver;)V
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/core/content/pm/ShortcutInfoCompatSaver<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 815
    .local p0, "saver":Landroidx/core/content/pm/ShortcutInfoCompatSaver;, "Landroidx/core/content/pm/ShortcutInfoCompatSaver<Ljava/lang/Void;>;"
    sput-object p0, Landroidx/core/content/pm/ShortcutManagerCompat;->sShortcutInfoCompatSaver:Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    .line 816
    return-void
.end method

.method public static updateShortcuts(Landroid/content/Context;Ljava/util/List;)Z
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Landroidx/core/content/pm/ShortcutInfoCompat;",
            ">;)Z"
        }
    .end annotation

    .line 530
    .local p1, "shortcutInfoList":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    const/4 v0, 0x1

    invoke-static {p1, v0}, Landroidx/core/content/pm/ShortcutManagerCompat;->removeShortcutsExcludedFromSurface(Ljava/util/List;I)Ljava/util/List;

    move-result-object v1

    .line 532
    .local v1, "clone":Ljava/util/List;, "Ljava/util/List<Landroidx/core/content/pm/ShortcutInfoCompat;>;"
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-gt v2, v3, :cond_e

    .line 533
    invoke-static {p0, v1}, Landroidx/core/content/pm/ShortcutManagerCompat;->convertUriIconsToBitmapIcons(Landroid/content/Context;Ljava/util/List;)V

    .line 535
    :cond_e
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x19

    if-lt v2, v3, :cond_41

    .line 536
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 537
    .local v2, "shortcuts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/content/pm/ShortcutInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1d
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_31

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/core/content/pm/ShortcutInfoCompat;

    .line 538
    .local v4, "item":Landroidx/core/content/pm/ShortcutInfoCompat;
    invoke-virtual {v4}, Landroidx/core/content/pm/ShortcutInfoCompat;->toShortcutInfo()Landroid/content/pm/ShortcutInfo;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 539
    .end local v4    # "item":Landroidx/core/content/pm/ShortcutInfoCompat;
    goto :goto_1d

    .line 540
    :cond_31
    const-class v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v3, v2}, Landroid/content/pm/ShortcutManager;->updateShortcuts(Ljava/util/List;)Z

    move-result v3

    if-nez v3, :cond_41

    .line 541
    const/4 v0, 0x0

    return v0

    .line 545
    .end local v2    # "shortcuts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/content/pm/ShortcutInfo;>;"
    :cond_41
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoSaverInstance(Landroid/content/Context;)Landroidx/core/content/pm/ShortcutInfoCompatSaver;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroidx/core/content/pm/ShortcutInfoCompatSaver;->addShortcuts(Ljava/util/List;)Ljava/lang/Object;

    .line 546
    invoke-static {p0}, Landroidx/core/content/pm/ShortcutManagerCompat;->getShortcutInfoListeners(Landroid/content/Context;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_50
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_60

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/content/pm/ShortcutInfoChangeListener;

    .line 547
    .local v3, "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    invoke-virtual {v3, p1}, Landroidx/core/content/pm/ShortcutInfoChangeListener;->onShortcutUpdated(Ljava/util/List;)V

    .line 548
    .end local v3    # "listener":Landroidx/core/content/pm/ShortcutInfoChangeListener;
    goto :goto_50

    .line 549
    :cond_60
    return v0
.end method
