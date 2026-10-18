.class public final Landroidx/core/content/PackageManagerCompat;
.super Ljava/lang/Object;
.source "PackageManagerCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/content/PackageManagerCompat$Api30Impl;,
        Landroidx/core/content/PackageManagerCompat$UnusedAppRestrictionsStatus;
    }
.end annotation


# static fields
.field public static final ACTION_PERMISSION_REVOCATION_SETTINGS:Ljava/lang/String; = "android.intent.action.AUTO_REVOKE_PERMISSIONS"

.field public static final LOG_TAG:Ljava/lang/String; = "PackageManagerCompat"


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    return-void
.end method

.method public static areUnusedAppRestrictionsAvailable(Landroid/content/pm/PackageManager;)Z
    .registers 6
    .param p0, "packageManager"    # Landroid/content/pm/PackageManager;

    .line 199
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/16 v3, 0x1e

    if-lt v0, v3, :cond_a

    move v0, v1

    goto :goto_b

    :cond_a
    move v0, v2

    .line 200
    .local v0, "restrictionsBuiltIntoOs":Z
    :goto_b
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v4, v3, :cond_11

    move v3, v1

    goto :goto_12

    :cond_11
    move v3, v2

    .line 203
    .local v3, "isOsMThroughQ":Z
    :goto_12
    invoke-static {p0}, Landroidx/core/content/PackageManagerCompat;->getPermissionRevocationVerifierApp(Landroid/content/pm/PackageManager;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1a

    move v4, v1

    goto :goto_1b

    :cond_1a
    move v4, v2

    .line 205
    .local v4, "hasBackportFeature":Z
    :goto_1b
    if-nez v0, :cond_23

    if-eqz v3, :cond_22

    if-eqz v4, :cond_22

    goto :goto_23

    :cond_22
    move v1, v2

    :cond_23
    :goto_23
    return v1
.end method

.method public static getPermissionRevocationVerifierApp(Landroid/content/pm/PackageManager;)Ljava/lang/String;
    .registers 8
    .param p0, "packageManager"    # Landroid/content/pm/PackageManager;

    .line 218
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.AUTO_REVOKE_PERMISSIONS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 220
    const-string v1, "package"

    const-string v2, "com.example"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    move-result-object v0

    .line 222
    .local v0, "permissionRevocationSettingsIntent":Landroid/content/Intent;
    nop

    .line 223
    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    .line 226
    .local v1, "intentResolvers":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    const/4 v2, 0x0

    .line 228
    .local v2, "verifierPackageName":Ljava/lang/String;
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1f
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3d

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/pm/ResolveInfo;

    .line 229
    .local v4, "intentResolver":Landroid/content/pm/ResolveInfo;
    iget-object v5, v4, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v5, v5, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    .line 230
    .local v5, "packageName":Ljava/lang/String;
    const-string v6, "android.permission.PACKAGE_VERIFICATION_AGENT"

    invoke-virtual {p0, v6, v5}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    if-eqz v6, :cond_38

    .line 232
    goto :goto_1f

    .line 235
    :cond_38
    if-eqz v2, :cond_3b

    .line 239
    return-object v2

    .line 241
    :cond_3b
    move-object v2, v5

    .line 242
    .end local v4    # "intentResolver":Landroid/content/pm/ResolveInfo;
    .end local v5    # "packageName":Ljava/lang/String;
    goto :goto_1f

    .line 244
    :cond_3d
    return-object v2
.end method

.method public static getUnusedAppRestrictionsStatus(Landroid/content/Context;)Lcom/google/common/util/concurrent/ListenableFuture;
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 135
    invoke-static {}, Landroidx/concurrent/futures/ResolvableFuture;->create()Landroidx/concurrent/futures/ResolvableFuture;

    move-result-object v0

    .line 138
    .local v0, "resultFuture":Landroidx/concurrent/futures/ResolvableFuture;, "Landroidx/concurrent/futures/ResolvableFuture<Ljava/lang/Integer;>;"
    invoke-static {p0}, Landroidx/core/os/UserManagerCompat;->isUserUnlocked(Landroid/content/Context;)Z

    move-result v1

    const-string v2, "PackageManagerCompat"

    const/4 v3, 0x0

    .line 139
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 138
    if-nez v1, :cond_1a

    .line 139
    invoke-virtual {v0, v3}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    .line 140
    const-string v1, "User is in locked direct boot mode"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 141
    return-object v0

    .line 144
    :cond_1a
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-static {v1}, Landroidx/core/content/PackageManagerCompat;->areUnusedAppRestrictionsAvailable(Landroid/content/pm/PackageManager;)Z

    move-result v1

    if-nez v1, :cond_2d

    .line 145
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    .line 146
    return-object v0

    .line 149
    :cond_2d
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    .line 151
    .local v1, "targetSdkVersion":I
    const/16 v4, 0x1e

    if-ge v1, v4, :cond_40

    .line 152
    invoke-virtual {v0, v3}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    .line 153
    const-string v3, "Target SDK version below API 30"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    return-object v0

    .line 158
    :cond_40
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v3, 0x4

    const/4 v5, 0x2

    const/16 v6, 0x1f

    if-lt v2, v6, :cond_61

    .line 159
    invoke-static {p0}, Landroidx/core/content/PackageManagerCompat$Api30Impl;->areUnusedAppRestrictionsEnabled(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_59

    .line 162
    if-lt v1, v6, :cond_51

    const/4 v3, 0x5

    :cond_51
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    goto :goto_60

    .line 164
    :cond_59
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    .line 166
    :goto_60
    return-object v0

    .line 169
    :cond_61
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v2, v4, :cond_76

    .line 170
    nop

    .line 171
    invoke-static {p0}, Landroidx/core/content/PackageManagerCompat$Api30Impl;->areUnusedAppRestrictionsEnabled(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_6d

    .line 172
    goto :goto_6e

    .line 173
    :cond_6d
    move v3, v5

    .line 171
    :goto_6e
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 170
    invoke-virtual {v0, v2}, Landroidx/concurrent/futures/ResolvableFuture;->set(Ljava/lang/Object;)Z

    .line 174
    return-object v0

    .line 177
    :cond_76
    new-instance v2, Landroidx/core/content/UnusedAppRestrictionsBackportServiceConnection;

    invoke-direct {v2, p0}, Landroidx/core/content/UnusedAppRestrictionsBackportServiceConnection;-><init>(Landroid/content/Context;)V

    .line 182
    .local v2, "backportServiceConnection":Landroidx/core/content/UnusedAppRestrictionsBackportServiceConnection;
    nop

    .line 183
    invoke-static {v2}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Landroidx/core/content/PackageManagerCompat$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2}, Landroidx/core/content/PackageManagerCompat$$ExternalSyntheticLambda0;-><init>(Landroidx/core/content/UnusedAppRestrictionsBackportServiceConnection;)V

    .line 184
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v4

    .line 182
    invoke-virtual {v0, v3, v4}, Landroidx/concurrent/futures/ResolvableFuture;->addListener(Ljava/lang/Runnable;Ljava/util/concurrent/Executor;)V

    .line 187
    invoke-virtual {v2, v0}, Landroidx/core/content/UnusedAppRestrictionsBackportServiceConnection;->connectAndFetchResult(Landroidx/concurrent/futures/ResolvableFuture;)V

    .line 189
    return-object v0
.end method
