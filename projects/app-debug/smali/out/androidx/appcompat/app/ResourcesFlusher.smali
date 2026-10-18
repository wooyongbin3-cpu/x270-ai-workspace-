.class Landroidx/appcompat/app/ResourcesFlusher;
.super Ljava/lang/Object;
.source "ResourcesFlusher.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "ResourcesFlusher"

.field private static sDrawableCacheField:Ljava/lang/reflect/Field;

.field private static sDrawableCacheFieldFetched:Z

.field private static sResourcesImplField:Ljava/lang/reflect/Field;

.field private static sResourcesImplFieldFetched:Z

.field private static sThemedResourceCacheClazz:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static sThemedResourceCacheClazzFetched:Z

.field private static sThemedResourceCache_mUnthemedEntriesField:Ljava/lang/reflect/Field;

.field private static sThemedResourceCache_mUnthemedEntriesFieldFetched:Z


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 208
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 209
    return-void
.end method

.method static flush(Landroid/content/res/Resources;)V
    .registers 3
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 46
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_7

    .line 48
    return-void

    .line 49
    :cond_7
    nop

    .line 50
    invoke-static {p0}, Landroidx/appcompat/app/ResourcesFlusher;->flushNougats(Landroid/content/res/Resources;)V

    .line 56
    return-void
.end method

.method private static flushLollipops(Landroid/content/res/Resources;)V
    .registers 5
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 60
    sget-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    const-string v1, "ResourcesFlusher"

    if-nez v0, :cond_1f

    .line 62
    const/4 v0, 0x1

    :try_start_7
    const-class v2, Landroid/content/res/Resources;

    const-string v3, "mDrawableCache"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    sput-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    .line 63
    sget-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v2, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_16
    .catch Ljava/lang/NoSuchFieldException; {:try_start_7 .. :try_end_16} :catch_17

    .line 66
    goto :goto_1d

    .line 64
    :catch_17
    move-exception v2

    .line 65
    .local v2, "e":Ljava/lang/NoSuchFieldException;
    const-string v3, "Could not retrieve Resources#mDrawableCache field"

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 67
    .end local v2    # "e":Ljava/lang/NoSuchFieldException;
    :goto_1d
    sput-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    .line 69
    :cond_1f
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    if-eqz v0, :cond_39

    .line 70
    const/4 v0, 0x0

    .line 72
    .local v0, "drawableCache":Ljava/util/Map;
    :try_start_24
    sget-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map;
    :try_end_2c
    .catch Ljava/lang/IllegalAccessException; {:try_start_24 .. :try_end_2c} :catch_2e

    move-object v0, v2

    .line 75
    goto :goto_34

    .line 73
    :catch_2e
    move-exception v2

    .line 74
    .local v2, "e":Ljava/lang/IllegalAccessException;
    const-string v3, "Could not retrieve value from Resources#mDrawableCache"

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 76
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :goto_34
    if-eqz v0, :cond_39

    .line 77
    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 80
    .end local v0    # "drawableCache":Ljava/util/Map;
    :cond_39
    return-void
.end method

.method private static flushMarshmallows(Landroid/content/res/Resources;)V
    .registers 5
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 84
    sget-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    const-string v1, "ResourcesFlusher"

    if-nez v0, :cond_1f

    .line 86
    const/4 v0, 0x1

    :try_start_7
    const-class v2, Landroid/content/res/Resources;

    const-string v3, "mDrawableCache"

    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    sput-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    .line 87
    sget-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v2, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_16
    .catch Ljava/lang/NoSuchFieldException; {:try_start_7 .. :try_end_16} :catch_17

    .line 90
    goto :goto_1d

    .line 88
    :catch_17
    move-exception v2

    .line 89
    .local v2, "e":Ljava/lang/NoSuchFieldException;
    const-string v3, "Could not retrieve Resources#mDrawableCache field"

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 91
    .end local v2    # "e":Ljava/lang/NoSuchFieldException;
    :goto_1d
    sput-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    .line 94
    :cond_1f
    const/4 v0, 0x0

    .line 95
    .local v0, "drawableCache":Ljava/lang/Object;
    sget-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    if-eqz v2, :cond_32

    .line 97
    :try_start_24
    sget-object v2, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_2a
    .catch Ljava/lang/IllegalAccessException; {:try_start_24 .. :try_end_2a} :catch_2c

    move-object v0, v1

    .line 100
    goto :goto_32

    .line 98
    :catch_2c
    move-exception v2

    .line 99
    .local v2, "e":Ljava/lang/IllegalAccessException;
    const-string v3, "Could not retrieve value from Resources#mDrawableCache"

    invoke-static {v1, v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 103
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :cond_32
    :goto_32
    if-nez v0, :cond_35

    .line 105
    return-void

    .line 108
    :cond_35
    invoke-static {v0}, Landroidx/appcompat/app/ResourcesFlusher;->flushThemedResourcesCache(Ljava/lang/Object;)V

    .line 109
    return-void
.end method

.method private static flushNougats(Landroid/content/res/Resources;)V
    .registers 6
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 113
    sget-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplFieldFetched:Z

    const/4 v1, 0x1

    const-string v2, "ResourcesFlusher"

    if-nez v0, :cond_1f

    .line 115
    :try_start_7
    const-class v0, Landroid/content/res/Resources;

    const-string v3, "mResourcesImpl"

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplField:Ljava/lang/reflect/Field;

    .line 116
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_16
    .catch Ljava/lang/NoSuchFieldException; {:try_start_7 .. :try_end_16} :catch_17

    .line 119
    goto :goto_1d

    .line 117
    :catch_17
    move-exception v0

    .line 118
    .local v0, "e":Ljava/lang/NoSuchFieldException;
    const-string v3, "Could not retrieve Resources#mResourcesImpl field"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 120
    .end local v0    # "e":Ljava/lang/NoSuchFieldException;
    :goto_1d
    sput-boolean v1, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplFieldFetched:Z

    .line 123
    :cond_1f
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplField:Ljava/lang/reflect/Field;

    if-nez v0, :cond_24

    .line 125
    return-void

    .line 128
    :cond_24
    const/4 v0, 0x0

    .line 130
    .local v0, "resourcesImpl":Ljava/lang/Object;
    :try_start_25
    sget-object v3, Landroidx/appcompat/app/ResourcesFlusher;->sResourcesImplField:Ljava/lang/reflect/Field;

    invoke-virtual {v3, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_2b
    .catch Ljava/lang/IllegalAccessException; {:try_start_25 .. :try_end_2b} :catch_2d

    move-object v0, v3

    .line 133
    goto :goto_33

    .line 131
    :catch_2d
    move-exception v3

    .line 132
    .local v3, "e":Ljava/lang/IllegalAccessException;
    const-string v4, "Could not retrieve value from Resources#mResourcesImpl"

    invoke-static {v2, v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 135
    .end local v3    # "e":Ljava/lang/IllegalAccessException;
    :goto_33
    if-nez v0, :cond_36

    .line 137
    return-void

    .line 140
    :cond_36
    sget-boolean v3, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    if-nez v3, :cond_54

    .line 142
    :try_start_3a
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "mDrawableCache"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sput-object v3, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    .line 143
    sget-object v3, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_4b
    .catch Ljava/lang/NoSuchFieldException; {:try_start_3a .. :try_end_4b} :catch_4c

    .line 146
    goto :goto_52

    .line 144
    :catch_4c
    move-exception v3

    .line 145
    .local v3, "e":Ljava/lang/NoSuchFieldException;
    const-string v4, "Could not retrieve ResourcesImpl#mDrawableCache field"

    invoke-static {v2, v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 147
    .end local v3    # "e":Ljava/lang/NoSuchFieldException;
    :goto_52
    sput-boolean v1, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheFieldFetched:Z

    .line 150
    :cond_54
    const/4 v1, 0x0

    .line 151
    .local v1, "drawableCache":Ljava/lang/Object;
    sget-object v3, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    if-eqz v3, :cond_67

    .line 153
    :try_start_59
    sget-object v3, Landroidx/appcompat/app/ResourcesFlusher;->sDrawableCacheField:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2
    :try_end_5f
    .catch Ljava/lang/IllegalAccessException; {:try_start_59 .. :try_end_5f} :catch_61

    move-object v1, v2

    .line 156
    goto :goto_67

    .line 154
    :catch_61
    move-exception v3

    .line 155
    .local v3, "e":Ljava/lang/IllegalAccessException;
    const-string v4, "Could not retrieve value from ResourcesImpl#mDrawableCache"

    invoke-static {v2, v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 159
    .end local v3    # "e":Ljava/lang/IllegalAccessException;
    :cond_67
    :goto_67
    if-eqz v1, :cond_6c

    .line 160
    invoke-static {v1}, Landroidx/appcompat/app/ResourcesFlusher;->flushThemedResourcesCache(Ljava/lang/Object;)V

    .line 162
    :cond_6c
    return-void
.end method

.method private static flushThemedResourcesCache(Ljava/lang/Object;)V
    .registers 5
    .param p0, "cache"    # Ljava/lang/Object;

    .line 165
    sget-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCacheClazzFetched:Z

    const/4 v1, 0x1

    const-string v2, "ResourcesFlusher"

    if-nez v0, :cond_18

    .line 167
    :try_start_7
    const-string v0, "android.content.res.ThemedResourceCache"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    sput-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCacheClazz:Ljava/lang/Class;
    :try_end_f
    .catch Ljava/lang/ClassNotFoundException; {:try_start_7 .. :try_end_f} :catch_10

    .line 170
    goto :goto_16

    .line 168
    :catch_10
    move-exception v0

    .line 169
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    const-string v3, "Could not find ThemedResourceCache class"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 171
    .end local v0    # "e":Ljava/lang/ClassNotFoundException;
    :goto_16
    sput-boolean v1, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCacheClazzFetched:Z

    .line 174
    :cond_18
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCacheClazz:Ljava/lang/Class;

    if-nez v0, :cond_1d

    .line 176
    return-void

    .line 179
    :cond_1d
    sget-boolean v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesFieldFetched:Z

    if-nez v0, :cond_39

    .line 181
    :try_start_21
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCacheClazz:Ljava/lang/Class;

    const-string v3, "mUnthemedEntries"

    .line 182
    invoke-virtual {v0, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    sput-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesField:Ljava/lang/reflect/Field;

    .line 183
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_30
    .catch Ljava/lang/NoSuchFieldException; {:try_start_21 .. :try_end_30} :catch_31

    .line 186
    goto :goto_37

    .line 184
    :catch_31
    move-exception v0

    .line 185
    .local v0, "ee":Ljava/lang/NoSuchFieldException;
    const-string v3, "Could not retrieve ThemedResourceCache#mUnthemedEntries field"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 187
    .end local v0    # "ee":Ljava/lang/NoSuchFieldException;
    :goto_37
    sput-boolean v1, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesFieldFetched:Z

    .line 190
    :cond_39
    sget-object v0, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesField:Ljava/lang/reflect/Field;

    if-nez v0, :cond_3e

    .line 192
    return-void

    .line 195
    :cond_3e
    const/4 v0, 0x0

    .line 197
    .local v0, "unthemedEntries":Landroid/util/LongSparseArray;
    :try_start_3f
    sget-object v1, Landroidx/appcompat/app/ResourcesFlusher;->sThemedResourceCache_mUnthemedEntriesField:Ljava/lang/reflect/Field;

    .line 198
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/util/LongSparseArray;
    :try_end_47
    .catch Ljava/lang/IllegalAccessException; {:try_start_3f .. :try_end_47} :catch_49

    move-object v0, v1

    .line 201
    goto :goto_4f

    .line 199
    :catch_49
    move-exception v1

    .line 200
    .local v1, "e":Ljava/lang/IllegalAccessException;
    const-string v3, "Could not retrieve value from ThemedResourceCache#mUnthemedEntries"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 203
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :goto_4f
    if-eqz v0, :cond_54

    .line 204
    invoke-virtual {v0}, Landroid/util/LongSparseArray;->clear()V

    .line 206
    :cond_54
    return-void
.end method
