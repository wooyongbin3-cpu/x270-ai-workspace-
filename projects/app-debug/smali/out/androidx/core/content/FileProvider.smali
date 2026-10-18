.class public Landroidx/core/content/FileProvider;
.super Landroid/content/ContentProvider;
.source "FileProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/content/FileProvider$PathStrategy;,
        Landroidx/core/content/FileProvider$SimplePathStrategy;,
        Landroidx/core/content/FileProvider$Api21Impl;
    }
.end annotation


# static fields
.field private static final ATTR_NAME:Ljava/lang/String; = "name"

.field private static final ATTR_PATH:Ljava/lang/String; = "path"

.field private static final COLUMNS:[Ljava/lang/String;

.field private static final DEVICE_ROOT:Ljava/io/File;

.field private static final DISPLAYNAME_FIELD:Ljava/lang/String; = "displayName"

.field private static final META_DATA_FILE_PROVIDER_PATHS:Ljava/lang/String; = "android.support.FILE_PROVIDER_PATHS"

.field private static final TAG_CACHE_PATH:Ljava/lang/String; = "cache-path"

.field private static final TAG_EXTERNAL:Ljava/lang/String; = "external-path"

.field private static final TAG_EXTERNAL_CACHE:Ljava/lang/String; = "external-cache-path"

.field private static final TAG_EXTERNAL_FILES:Ljava/lang/String; = "external-files-path"

.field private static final TAG_EXTERNAL_MEDIA:Ljava/lang/String; = "external-media-path"

.field private static final TAG_FILES_PATH:Ljava/lang/String; = "files-path"

.field private static final TAG_ROOT_PATH:Ljava/lang/String; = "root-path"

.field private static final sCache:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Landroidx/core/content/FileProvider$PathStrategy;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mAuthority:Ljava/lang/String;

.field private mLocalPathStrategy:Landroidx/core/content/FileProvider$PathStrategy;

.field private final mLock:Ljava/lang/Object;

.field private final mResourceId:I


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 356
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "_display_name"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "_size"

    aput-object v2, v0, v1

    sput-object v0, Landroidx/core/content/FileProvider;->COLUMNS:[Ljava/lang/String;

    .line 374
    new-instance v0, Ljava/io/File;

    const-string v1, "/"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v0, Landroidx/core/content/FileProvider;->DEVICE_ROOT:Ljava/io/File;

    .line 377
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>()V
    .registers 2

    .line 388
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroidx/core/content/FileProvider;-><init>(I)V

    .line 389
    return-void
.end method

.method protected constructor <init>(I)V
    .registers 3
    .param p1, "resourceId"    # I

    .line 391
    invoke-direct {p0}, Landroid/content/ContentProvider;-><init>()V

    .line 379
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Landroidx/core/content/FileProvider;->mLock:Ljava/lang/Object;

    .line 392
    iput p1, p0, Landroidx/core/content/FileProvider;->mResourceId:I

    .line 393
    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)Ljava/lang/String;
    .registers 2
    .param p0, "x0"    # Ljava/lang/String;

    .line 355
    invoke-static {p0}, Landroidx/core/content/FileProvider;->removeTrailingSlash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static varargs buildPath(Ljava/io/File;[Ljava/lang/String;)Ljava/io/File;
    .registers 7
    .param p0, "base"    # Ljava/io/File;
    .param p1, "segments"    # [Ljava/lang/String;

    .line 581
    move-object v0, p0

    .line 582
    .local v0, "cur":Ljava/io/File;
    array-length v1, p1

    const/4 v2, 0x0

    :goto_3
    if-ge v2, v1, :cond_12

    aget-object v3, p1, v2

    .line 583
    .local v3, "segment":Ljava/lang/String;
    if-eqz v3, :cond_f

    .line 584
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v0, v4

    .line 582
    .end local v3    # "segment":Ljava/lang/String;
    :cond_f
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 587
    :cond_12
    return-object v0
.end method

.method private static copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;
    .registers 4
    .param p0, "original"    # [Ljava/lang/Object;
    .param p1, "newLength"    # I

    .line 597
    new-array v0, p1, [Ljava/lang/Object;

    .line 598
    .local v0, "result":[Ljava/lang/Object;
    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 599
    return-object v0
.end method

.method private static copyOf([Ljava/lang/String;I)[Ljava/lang/String;
    .registers 4
    .param p0, "original"    # [Ljava/lang/String;
    .param p1, "newLength"    # I

    .line 591
    new-array v0, p1, [Ljava/lang/String;

    .line 592
    .local v0, "result":[Ljava/lang/String;
    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1, p1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 593
    return-object v0
.end method

.method static getFileProviderPathsMetaData(Landroid/content/Context;Ljava/lang/String;Landroid/content/pm/ProviderInfo;I)Landroid/content/res/XmlResourceParser;
    .registers 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "authority"    # Ljava/lang/String;
    .param p2, "info"    # Landroid/content/pm/ProviderInfo;
    .param p3, "resourceId"    # I

    .line 477
    if-eqz p2, :cond_2a

    .line 482
    iget-object v0, p2, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    const-string v1, "android.support.FILE_PROVIDER_PATHS"

    if-nez v0, :cond_17

    if-eqz p3, :cond_17

    .line 483
    new-instance v0, Landroid/os/Bundle;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/os/Bundle;-><init>(I)V

    iput-object v0, p2, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    .line 484
    iget-object v0, p2, Landroid/content/pm/ProviderInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v0, v1, p3}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 487
    :cond_17
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p2, v0, v1}, Landroid/content/pm/ProviderInfo;->loadXmlMetaData(Landroid/content/pm/PackageManager;Ljava/lang/String;)Landroid/content/res/XmlResourceParser;

    move-result-object v0

    .line 489
    .local v0, "in":Landroid/content/res/XmlResourceParser;
    if-eqz v0, :cond_22

    .line 494
    return-object v0

    .line 490
    :cond_22
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Missing android.support.FILE_PROVIDER_PATHS meta-data"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 478
    .end local v0    # "in":Landroid/content/res/XmlResourceParser;
    :cond_2a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Couldn\'t find meta-data for provider with authority "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private getLocalPathStrategy()Landroidx/core/content/FileProvider$PathStrategy;
    .registers 5

    .line 821
    iget-object v0, p0, Landroidx/core/content/FileProvider;->mLock:Ljava/lang/Object;

    monitor-enter v0

    .line 822
    :try_start_3
    iget-object v1, p0, Landroidx/core/content/FileProvider;->mAuthority:Ljava/lang/String;

    const-string v2, "mAuthority is null. Did you override attachInfo and did not call super.attachInfo()?"

    invoke-static {v1, v2}, Landroidx/core/util/ObjectsCompat;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 825
    iget-object v1, p0, Landroidx/core/content/FileProvider;->mLocalPathStrategy:Landroidx/core/content/FileProvider$PathStrategy;

    if-nez v1, :cond_1c

    .line 826
    invoke-virtual {p0}, Landroidx/core/content/FileProvider;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Landroidx/core/content/FileProvider;->mAuthority:Ljava/lang/String;

    iget v3, p0, Landroidx/core/content/FileProvider;->mResourceId:I

    invoke-static {v1, v2, v3}, Landroidx/core/content/FileProvider;->getPathStrategy(Landroid/content/Context;Ljava/lang/String;I)Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v1

    iput-object v1, p0, Landroidx/core/content/FileProvider;->mLocalPathStrategy:Landroidx/core/content/FileProvider$PathStrategy;

    .line 828
    :cond_1c
    iget-object v1, p0, Landroidx/core/content/FileProvider;->mLocalPathStrategy:Landroidx/core/content/FileProvider$PathStrategy;

    monitor-exit v0

    return-object v1

    .line 829
    :catchall_20
    move-exception v1

    monitor-exit v0
    :try_end_22
    .catchall {:try_start_3 .. :try_end_22} :catchall_20

    throw v1
.end method

.method private static getPathStrategy(Landroid/content/Context;Ljava/lang/String;I)Landroidx/core/content/FileProvider$PathStrategy;
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "authority"    # Ljava/lang/String;
    .param p2, "resourceId"    # I

    .line 456
    sget-object v0, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    monitor-enter v0

    .line 457
    :try_start_3
    sget-object v1, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/content/FileProvider$PathStrategy;
    :try_end_b
    .catchall {:try_start_3 .. :try_end_b} :catchall_2d

    .line 458
    .local v1, "strat":Landroidx/core/content/FileProvider$PathStrategy;
    if-nez v1, :cond_2b

    .line 460
    :try_start_d
    invoke-static {p0, p1, p2}, Landroidx/core/content/FileProvider;->parsePathStrategy(Landroid/content/Context;Ljava/lang/String;I)Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v2
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_11} :catch_22
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_d .. :try_end_11} :catch_19
    .catchall {:try_start_d .. :try_end_11} :catchall_2d

    move-object v1, v2

    .line 467
    nop

    .line 468
    :try_start_13
    sget-object v2, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2b

    .line 464
    :catch_19
    move-exception v2

    .line 465
    .local v2, "e":Lorg/xmlpull/v1/XmlPullParserException;
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Failed to parse android.support.FILE_PROVIDER_PATHS meta-data"

    invoke-direct {v3, v4, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local p0    # "context":Landroid/content/Context;
    .end local p1    # "authority":Ljava/lang/String;
    .end local p2    # "resourceId":I
    throw v3

    .line 461
    .end local v2    # "e":Lorg/xmlpull/v1/XmlPullParserException;
    .restart local p0    # "context":Landroid/content/Context;
    .restart local p1    # "authority":Ljava/lang/String;
    .restart local p2    # "resourceId":I
    :catch_22
    move-exception v2

    .line 462
    .local v2, "e":Ljava/io/IOException;
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Failed to parse android.support.FILE_PROVIDER_PATHS meta-data"

    invoke-direct {v3, v4, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local p0    # "context":Landroid/content/Context;
    .end local p1    # "authority":Ljava/lang/String;
    .end local p2    # "resourceId":I
    throw v3

    .line 470
    .end local v2    # "e":Ljava/io/IOException;
    .restart local p0    # "context":Landroid/content/Context;
    .restart local p1    # "authority":Ljava/lang/String;
    .restart local p2    # "resourceId":I
    :cond_2b
    :goto_2b
    monitor-exit v0

    .line 471
    return-object v1

    .line 470
    .end local v1    # "strat":Landroidx/core/content/FileProvider$PathStrategy;
    :catchall_2d
    move-exception v1

    monitor-exit v0
    :try_end_2f
    .catchall {:try_start_13 .. :try_end_2f} :catchall_2d

    throw v1
.end method

.method public static getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;
    .registers 5
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "authority"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;

    .line 417
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroidx/core/content/FileProvider;->getPathStrategy(Landroid/content/Context;Ljava/lang/String;I)Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v0

    .line 418
    .local v0, "strategy":Landroidx/core/content/FileProvider$PathStrategy;
    invoke-interface {v0, p2}, Landroidx/core/content/FileProvider$PathStrategy;->getUriForFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    return-object v1
.end method

.method public static getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;Ljava/lang/String;)Landroid/net/Uri;
    .registers 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "authority"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "displayName"    # Ljava/lang/String;

    .line 446
    invoke-static {p0, p1, p2}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    .line 447
    .local v0, "uri":Landroid/net/Uri;
    invoke-virtual {v0}, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "displayName"

    invoke-virtual {v1, v2, p3}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    return-object v1
.end method

.method private static modeToMode(Ljava/lang/String;)I
    .registers 4
    .param p0, "mode"    # Ljava/lang/String;

    .line 561
    const-string v0, "r"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 562
    const/high16 v0, 0x10000000

    .local v0, "modeBits":I
    goto :goto_58

    .line 563
    .end local v0    # "modeBits":I
    :cond_b
    const-string v0, "w"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_56

    const-string v0, "wt"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    goto :goto_56

    .line 566
    :cond_1c
    const-string v0, "wa"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_27

    .line 567
    const/high16 v0, 0x2a000000

    .restart local v0    # "modeBits":I
    goto :goto_58

    .line 569
    .end local v0    # "modeBits":I
    :cond_27
    const-string v0, "rw"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_32

    .line 570
    const/high16 v0, 0x38000000

    .restart local v0    # "modeBits":I
    goto :goto_58

    .line 571
    .end local v0    # "modeBits":I
    :cond_32
    const-string v0, "rwt"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3d

    .line 572
    const/high16 v0, 0x3c000000    # 0.0078125f

    .restart local v0    # "modeBits":I
    goto :goto_58

    .line 575
    .end local v0    # "modeBits":I
    :cond_3d
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid mode: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 564
    :cond_56
    :goto_56
    const/high16 v0, 0x2c000000

    .line 577
    .restart local v0    # "modeBits":I
    :goto_58
    return v0
.end method

.method private static parsePathStrategy(Landroid/content/Context;Ljava/lang/String;I)Landroidx/core/content/FileProvider$PathStrategy;
    .registers 15
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "authority"    # Ljava/lang/String;
    .param p2, "resourceId"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/xmlpull/v1/XmlPullParserException;
        }
    .end annotation

    .line 505
    new-instance v0, Landroidx/core/content/FileProvider$SimplePathStrategy;

    invoke-direct {v0, p1}, Landroidx/core/content/FileProvider$SimplePathStrategy;-><init>(Ljava/lang/String;)V

    .line 507
    .local v0, "strat":Landroidx/core/content/FileProvider$SimplePathStrategy;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v1, p1, v2}, Landroid/content/pm/PackageManager;->resolveContentProvider(Ljava/lang/String;I)Landroid/content/pm/ProviderInfo;

    move-result-object v1

    .line 509
    .local v1, "info":Landroid/content/pm/ProviderInfo;
    invoke-static {p0, p1, v1, p2}, Landroidx/core/content/FileProvider;->getFileProviderPathsMetaData(Landroid/content/Context;Ljava/lang/String;Landroid/content/pm/ProviderInfo;I)Landroid/content/res/XmlResourceParser;

    move-result-object v2

    .line 513
    .local v2, "in":Landroid/content/res/XmlResourceParser;
    :cond_13
    :goto_13
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->next()I

    move-result v3

    move v4, v3

    .local v4, "type":I
    const/4 v5, 0x1

    if-eq v3, v5, :cond_a8

    .line 514
    const/4 v3, 0x2

    if-ne v4, v3, :cond_13

    .line 515
    invoke-interface {v2}, Landroid/content/res/XmlResourceParser;->getName()Ljava/lang/String;

    move-result-object v3

    .line 517
    .local v3, "tag":Ljava/lang/String;
    const-string v6, "name"

    const/4 v7, 0x0

    invoke-interface {v2, v7, v6}, Landroid/content/res/XmlResourceParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 518
    .local v6, "name":Ljava/lang/String;
    const-string v8, "path"

    invoke-interface {v2, v7, v8}, Landroid/content/res/XmlResourceParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 520
    .local v8, "path":Ljava/lang/String;
    const/4 v9, 0x0

    .line 521
    .local v9, "target":Ljava/io/File;
    const-string v10, "root-path"

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    const/4 v11, 0x0

    if-eqz v10, :cond_3c

    .line 522
    sget-object v9, Landroidx/core/content/FileProvider;->DEVICE_ROOT:Ljava/io/File;

    goto :goto_99

    .line 523
    :cond_3c
    const-string v10, "files-path"

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_49

    .line 524
    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v9

    goto :goto_99

    .line 525
    :cond_49
    const-string v10, "cache-path"

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_56

    .line 526
    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v9

    goto :goto_99

    .line 527
    :cond_56
    const-string v10, "external-path"

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_63

    .line 528
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v9

    goto :goto_99

    .line 529
    :cond_63
    const-string v10, "external-files-path"

    invoke-virtual {v10, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_75

    .line 530
    invoke-static {p0, v7}, Landroidx/core/content/ContextCompat;->getExternalFilesDirs(Landroid/content/Context;Ljava/lang/String;)[Ljava/io/File;

    move-result-object v7

    .line 531
    .local v7, "externalFilesDirs":[Ljava/io/File;
    array-length v10, v7

    if-lez v10, :cond_74

    .line 532
    aget-object v9, v7, v11

    .line 534
    .end local v7    # "externalFilesDirs":[Ljava/io/File;
    :cond_74
    goto :goto_99

    :cond_75
    const-string v7, "external-cache-path"

    invoke-virtual {v7, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_87

    .line 535
    invoke-static {p0}, Landroidx/core/content/ContextCompat;->getExternalCacheDirs(Landroid/content/Context;)[Ljava/io/File;

    move-result-object v7

    .line 536
    .local v7, "externalCacheDirs":[Ljava/io/File;
    array-length v10, v7

    if-lez v10, :cond_86

    .line 537
    aget-object v9, v7, v11

    .line 539
    .end local v7    # "externalCacheDirs":[Ljava/io/File;
    :cond_86
    goto :goto_99

    :cond_87
    nop

    .line 540
    const-string v7, "external-media-path"

    invoke-virtual {v7, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_99

    .line 541
    invoke-static {p0}, Landroidx/core/content/FileProvider$Api21Impl;->getExternalMediaDirs(Landroid/content/Context;)[Ljava/io/File;

    move-result-object v7

    .line 542
    .local v7, "externalMediaDirs":[Ljava/io/File;
    array-length v10, v7

    if-lez v10, :cond_99

    .line 543
    aget-object v9, v7, v11

    .line 547
    .end local v7    # "externalMediaDirs":[Ljava/io/File;
    :cond_99
    :goto_99
    if-eqz v9, :cond_a6

    .line 548
    new-array v5, v5, [Ljava/lang/String;

    aput-object v8, v5, v11

    invoke-static {v9, v5}, Landroidx/core/content/FileProvider;->buildPath(Ljava/io/File;[Ljava/lang/String;)Ljava/io/File;

    move-result-object v5

    invoke-virtual {v0, v6, v5}, Landroidx/core/content/FileProvider$SimplePathStrategy;->addRoot(Ljava/lang/String;Ljava/io/File;)V

    .line 550
    .end local v3    # "tag":Ljava/lang/String;
    .end local v6    # "name":Ljava/lang/String;
    .end local v8    # "path":Ljava/lang/String;
    .end local v9    # "target":Ljava/io/File;
    :cond_a6
    goto/16 :goto_13

    .line 553
    :cond_a8
    return-object v0
.end method

.method private static removeTrailingSlash(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .param p0, "path"    # Ljava/lang/String;

    .line 603
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_20

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2f

    if-ne v0, v1, :cond_20

    .line 604
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 606
    :cond_20
    return-object p0
.end method


# virtual methods
.method public attachInfo(Landroid/content/Context;Landroid/content/pm/ProviderInfo;)V
    .registers 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "info"    # Landroid/content/pm/ProviderInfo;

    .line 630
    invoke-super {p0, p1, p2}, Landroid/content/ContentProvider;->attachInfo(Landroid/content/Context;Landroid/content/pm/ProviderInfo;)V

    .line 633
    iget-boolean v0, p2, Landroid/content/pm/ProviderInfo;->exported:Z

    if-nez v0, :cond_4c

    .line 638
    iget-boolean v0, p2, Landroid/content/pm/ProviderInfo;->grantUriPermissions:Z

    if-eqz v0, :cond_44

    .line 641
    iget-object v0, p2, Landroid/content/pm/ProviderInfo;->authority:Ljava/lang/String;

    if-eqz v0, :cond_3c

    iget-object v0, p2, Landroid/content/pm/ProviderInfo;->authority:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3c

    .line 645
    iget-object v0, p2, Landroid/content/pm/ProviderInfo;->authority:Ljava/lang/String;

    const-string v1, ";"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 646
    .local v0, "authority":Ljava/lang/String;
    iget-object v1, p0, Landroidx/core/content/FileProvider;->mLock:Ljava/lang/Object;

    monitor-enter v1

    .line 647
    :try_start_29
    iput-object v0, p0, Landroidx/core/content/FileProvider;->mAuthority:Ljava/lang/String;

    .line 648
    monitor-exit v1
    :try_end_2c
    .catchall {:try_start_29 .. :try_end_2c} :catchall_39

    .line 649
    sget-object v2, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    monitor-enter v2

    .line 650
    :try_start_2f
    sget-object v1, Landroidx/core/content/FileProvider;->sCache:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 651
    monitor-exit v2

    .line 652
    return-void

    .line 651
    :catchall_36
    move-exception v1

    monitor-exit v2
    :try_end_38
    .catchall {:try_start_2f .. :try_end_38} :catchall_36

    throw v1

    .line 648
    :catchall_39
    move-exception v2

    :try_start_3a
    monitor-exit v1
    :try_end_3b
    .catchall {:try_start_3a .. :try_end_3b} :catchall_39

    throw v2

    .line 642
    .end local v0    # "authority":Ljava/lang/String;
    :cond_3c
    new-instance v0, Ljava/lang/SecurityException;

    const-string v1, "Provider must have a non-empty authority"

    invoke-direct {v0, v1}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 639
    :cond_44
    new-instance v0, Ljava/lang/SecurityException;

    const-string v1, "Provider must grant uri permissions"

    invoke-direct {v0, v1}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 636
    :cond_4c
    new-instance v0, Ljava/lang/SecurityException;

    const-string v1, "Provider must not be exported"

    invoke-direct {v0, v1}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .registers 6
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "selection"    # Ljava/lang/String;
    .param p3, "selectionArgs"    # [Ljava/lang/String;

    .line 789
    invoke-direct {p0}, Landroidx/core/content/FileProvider;->getLocalPathStrategy()Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v0

    invoke-interface {v0, p1}, Landroidx/core/content/FileProvider$PathStrategy;->getFileForUri(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 790
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    return v1
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .registers 6
    .param p1, "uri"    # Landroid/net/Uri;

    .line 731
    invoke-direct {p0}, Landroidx/core/content/FileProvider;->getLocalPathStrategy()Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v0

    invoke-interface {v0, p1}, Landroidx/core/content/FileProvider$PathStrategy;->getFileForUri(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 733
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x2e

    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 734
    .local v1, "lastDot":I
    if-ltz v1, :cond_29

    .line 735
    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    add-int/lit8 v3, v1, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 736
    .local v2, "extension":Ljava/lang/String;
    invoke-static {}, Landroid/webkit/MimeTypeMap;->getSingleton()Landroid/webkit/MimeTypeMap;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/webkit/MimeTypeMap;->getMimeTypeFromExtension(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 737
    .local v3, "mime":Ljava/lang/String;
    if-eqz v3, :cond_29

    .line 738
    return-object v3

    .line 742
    .end local v2    # "extension":Ljava/lang/String;
    .end local v3    # "mime":Ljava/lang/String;
    :cond_29
    const-string v2, "application/octet-stream"

    return-object v2
.end method

.method public getTypeAnonymous(Landroid/net/Uri;)Ljava/lang/String;
    .registers 3
    .param p1, "uri"    # Landroid/net/Uri;

    .line 752
    const-string v0, "application/octet-stream"

    return-object v0
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .registers 5
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;

    .line 761
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "No external inserts"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public onCreate()Z
    .registers 2

    .line 616
    const/4 v0, 0x1

    return v0
.end method

.method public openFile(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .registers 6
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "mode"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 814
    invoke-direct {p0}, Landroidx/core/content/FileProvider;->getLocalPathStrategy()Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v0

    invoke-interface {v0, p1}, Landroidx/core/content/FileProvider$PathStrategy;->getFileForUri(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 815
    .local v0, "file":Ljava/io/File;
    invoke-static {p2}, Landroidx/core/content/FileProvider;->modeToMode(Ljava/lang/String;)I

    move-result v1

    .line 816
    .local v1, "fileMode":I
    invoke-static {v0, v1}, Landroid/os/ParcelFileDescriptor;->open(Ljava/io/File;I)Landroid/os/ParcelFileDescriptor;

    move-result-object v2

    return-object v2
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .registers 17
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "projection"    # [Ljava/lang/String;
    .param p3, "selection"    # Ljava/lang/String;
    .param p4, "selectionArgs"    # [Ljava/lang/String;
    .param p5, "sortOrder"    # Ljava/lang/String;

    .line 691
    invoke-direct {p0}, Landroidx/core/content/FileProvider;->getLocalPathStrategy()Landroidx/core/content/FileProvider$PathStrategy;

    move-result-object v0

    invoke-interface {v0, p1}, Landroidx/core/content/FileProvider$PathStrategy;->getFileForUri(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 692
    .local v0, "file":Ljava/io/File;
    const-string v1, "displayName"

    invoke-virtual {p1, v1}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 694
    .local v1, "displayName":Ljava/lang/String;
    if-nez p2, :cond_12

    .line 695
    sget-object p2, Landroidx/core/content/FileProvider;->COLUMNS:[Ljava/lang/String;

    .line 698
    :cond_12
    array-length v2, p2

    new-array v2, v2, [Ljava/lang/String;

    .line 699
    .local v2, "cols":[Ljava/lang/String;
    array-length v3, p2

    new-array v3, v3, [Ljava/lang/Object;

    .line 700
    .local v3, "values":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 701
    .local v4, "i":I
    array-length v5, p2

    const/4 v6, 0x0

    :goto_1b
    if-ge v6, v5, :cond_51

    aget-object v7, p2, v6

    .line 702
    .local v7, "col":Ljava/lang/String;
    const-string v8, "_display_name"

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_37

    .line 703
    aput-object v8, v2, v4

    .line 704
    add-int/lit8 v8, v4, 0x1

    .end local v4    # "i":I
    .local v8, "i":I
    if-nez v1, :cond_32

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v9

    goto :goto_33

    :cond_32
    move-object v9, v1

    :goto_33
    aput-object v9, v3, v4

    move v4, v8

    goto :goto_4e

    .line 705
    .end local v8    # "i":I
    .restart local v4    # "i":I
    :cond_37
    const-string v8, "_size"

    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4e

    .line 706
    aput-object v8, v2, v4

    .line 707
    add-int/lit8 v8, v4, 0x1

    .end local v4    # "i":I
    .restart local v8    # "i":I
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    aput-object v9, v3, v4

    move v4, v8

    .line 701
    .end local v7    # "col":Ljava/lang/String;
    .end local v8    # "i":I
    .restart local v4    # "i":I
    :cond_4e
    :goto_4e
    add-int/lit8 v6, v6, 0x1

    goto :goto_1b

    .line 711
    :cond_51
    invoke-static {v2, v4}, Landroidx/core/content/FileProvider;->copyOf([Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v2

    .line 712
    invoke-static {v3, v4}, Landroidx/core/content/FileProvider;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v3

    .line 714
    new-instance v5, Landroid/database/MatrixCursor;

    const/4 v6, 0x1

    invoke-direct {v5, v2, v6}, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;I)V

    .line 715
    .local v5, "cursor":Landroid/database/MatrixCursor;
    invoke-virtual {v5, v3}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V

    .line 716
    return-object v5
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .registers 7
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "values"    # Landroid/content/ContentValues;
    .param p3, "selection"    # Ljava/lang/String;
    .param p4, "selectionArgs"    # [Ljava/lang/String;

    .line 771
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "No external updates"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
