.class public Landroidx/core/graphics/TypefaceCompatApi29Impl;
.super Landroidx/core/graphics/TypefaceCompatBaseImpl;
.source "TypefaceCompatApi29Impl.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "TypefaceCompatApi29Impl"


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 48
    invoke-direct {p0}, Landroidx/core/graphics/TypefaceCompatBaseImpl;-><init>()V

    return-void
.end method

.method private findBaseFont(Landroid/graphics/fonts/FontFamily;I)Landroid/graphics/fonts/Font;
    .registers 9
    .param p1, "family"    # Landroid/graphics/fonts/FontFamily;
    .param p2, "style"    # I

    .line 58
    new-instance v0, Landroid/graphics/fonts/FontStyle;

    .line 59
    and-int/lit8 v1, p2, 0x1

    if-eqz v1, :cond_9

    const/16 v1, 0x2bc

    goto :goto_b

    .line 60
    :cond_9
    const/16 v1, 0x190

    .line 61
    :goto_b
    and-int/lit8 v2, p2, 0x2

    const/4 v3, 0x0

    if-eqz v2, :cond_12

    const/4 v2, 0x1

    goto :goto_13

    .line 62
    :cond_12
    move v2, v3

    :goto_13
    invoke-direct {v0, v1, v2}, Landroid/graphics/fonts/FontStyle;-><init>(II)V

    .line 64
    .local v0, "desiredStyle":Landroid/graphics/fonts/FontStyle;
    invoke-virtual {p1, v3}, Landroid/graphics/fonts/FontFamily;->getFont(I)Landroid/graphics/fonts/Font;

    move-result-object v1

    .line 65
    .local v1, "bestFont":Landroid/graphics/fonts/Font;
    invoke-virtual {v1}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v2

    invoke-static {v0, v2}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getMatchScore(Landroid/graphics/fonts/FontStyle;Landroid/graphics/fonts/FontStyle;)I

    move-result v2

    .line 66
    .local v2, "bestScore":I
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_23
    invoke-virtual {p1}, Landroid/graphics/fonts/FontFamily;->getSize()I

    move-result v4

    if-ge v3, v4, :cond_3c

    .line 67
    invoke-virtual {p1, v3}, Landroid/graphics/fonts/FontFamily;->getFont(I)Landroid/graphics/fonts/Font;

    move-result-object v4

    .line 68
    .local v4, "candidate":Landroid/graphics/fonts/Font;
    invoke-virtual {v4}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v5

    invoke-static {v0, v5}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getMatchScore(Landroid/graphics/fonts/FontStyle;Landroid/graphics/fonts/FontStyle;)I

    move-result v5

    .line 69
    .local v5, "score":I
    if-ge v5, v2, :cond_39

    .line 70
    move-object v1, v4

    .line 71
    move v2, v5

    .line 66
    .end local v4    # "candidate":Landroid/graphics/fonts/Font;
    .end local v5    # "score":I
    :cond_39
    add-int/lit8 v3, v3, 0x1

    goto :goto_23

    .line 74
    .end local v3    # "i":I
    :cond_3c
    return-object v1
.end method

.method private getFont(Landroid/os/CancellationSignal;Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/Font;
    .registers 5
    .param p1, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p2, "font"    # Landroidx/core/provider/FontsContractCompat$FontInfo;
    .param p3, "resolver"    # Landroid/content/ContentResolver;

    .line 136
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->isSystemFont()Z

    move-result v0

    if-eqz v0, :cond_b

    .line 137
    invoke-virtual {p0, p2}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFontFromSystemFont(Landroidx/core/provider/FontsContractCompat$FontInfo;)Landroid/graphics/fonts/Font;

    move-result-object v0

    return-object v0

    .line 139
    :cond_b
    invoke-direct {p0, p1, p2, p3}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFontFromProvider(Landroid/os/CancellationSignal;Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/Font;

    move-result-object v0

    return-object v0
.end method

.method private getFontFromProvider(Landroid/os/CancellationSignal;Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/Font;
    .registers 8
    .param p1, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p2, "font"    # Landroidx/core/provider/FontsContractCompat$FontInfo;
    .param p3, "resolver"    # Landroid/content/ContentResolver;

    .line 114
    const/4 v0, 0x0

    :try_start_1
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->getUri()Landroid/net/Uri;

    move-result-object v1

    const-string v2, "r"

    invoke-virtual {p3, v1, v2, p1}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;Landroid/os/CancellationSignal;)Landroid/os/ParcelFileDescriptor;

    move-result-object v1

    .line 116
    .local v1, "pfd":Landroid/os/ParcelFileDescriptor;
    if-nez v1, :cond_14

    .line 117
    nop

    .line 128
    if-eqz v1, :cond_13

    invoke-virtual {v1}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_13
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_13} :catch_5d

    .line 117
    :cond_13
    return-object v0

    .line 119
    :cond_14
    :try_start_14
    new-instance v2, Landroid/graphics/fonts/Font$Builder;

    invoke-direct {v2, v1}, Landroid/graphics/fonts/Font$Builder;-><init>(Landroid/os/ParcelFileDescriptor;)V

    .line 120
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->getWeight()I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/fonts/Font$Builder;->setWeight(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v2

    .line 121
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->isItalic()Z

    move-result v3

    if-eqz v3, :cond_29

    const/4 v3, 0x1

    goto :goto_2a

    .line 122
    :cond_29
    const/4 v3, 0x0

    .line 121
    :goto_2a
    invoke-virtual {v2, v3}, Landroid/graphics/fonts/Font$Builder;->setSlant(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v2

    .line 123
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->getTtcIndex()I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/fonts/Font$Builder;->setTtcIndex(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v2

    .line 124
    .local v2, "builder":Landroid/graphics/fonts/Font$Builder;
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->getVariationSettings()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_47

    .line 125
    invoke-virtual {p2}, Landroidx/core/provider/FontsContractCompat$FontInfo;->getVariationSettings()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/graphics/fonts/Font$Builder;->setFontVariationSettings(Ljava/lang/String;)Landroid/graphics/fonts/Font$Builder;

    .line 127
    :cond_47
    invoke-virtual {v2}, Landroid/graphics/fonts/Font$Builder;->build()Landroid/graphics/fonts/Font;

    move-result-object v3
    :try_end_4b
    .catchall {:try_start_14 .. :try_end_4b} :catchall_51

    .line 128
    if-eqz v1, :cond_50

    :try_start_4d
    invoke-virtual {v1}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_50
    .catch Ljava/io/IOException; {:try_start_4d .. :try_end_50} :catch_5d

    .line 127
    :cond_50
    return-object v3

    .line 114
    .end local v2    # "builder":Landroid/graphics/fonts/Font$Builder;
    :catchall_51
    move-exception v2

    if-eqz v1, :cond_5c

    :try_start_54
    invoke-virtual {v1}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_57
    .catchall {:try_start_54 .. :try_end_57} :catchall_58

    goto :goto_5c

    :catchall_58
    move-exception v3

    :try_start_59
    invoke-virtual {v2, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local p1    # "cancellationSignal":Landroid/os/CancellationSignal;
    .end local p2    # "font":Landroidx/core/provider/FontsContractCompat$FontInfo;
    .end local p3    # "resolver":Landroid/content/ContentResolver;
    :cond_5c
    :goto_5c
    throw v2
    :try_end_5d
    .catch Ljava/io/IOException; {:try_start_59 .. :try_end_5d} :catch_5d

    .line 128
    .end local v1    # "pfd":Landroid/os/ParcelFileDescriptor;
    .restart local p1    # "cancellationSignal":Landroid/os/CancellationSignal;
    .restart local p2    # "font":Landroidx/core/provider/FontsContractCompat$FontInfo;
    .restart local p3    # "resolver":Landroid/content/ContentResolver;
    :catch_5d
    move-exception v1

    .line 129
    .local v1, "e":Ljava/io/IOException;
    const-string v2, "TypefaceCompatApi29Impl"

    const-string v3, "Font load failed"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 130
    return-object v0
.end method

.method private static getMatchScore(Landroid/graphics/fonts/FontStyle;Landroid/graphics/fonts/FontStyle;)I
    .registers 5
    .param p0, "o1"    # Landroid/graphics/fonts/FontStyle;
    .param p1, "o2"    # Landroid/graphics/fonts/FontStyle;

    .line 53
    invoke-virtual {p0}, Landroid/graphics/fonts/FontStyle;->getWeight()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/fonts/FontStyle;->getWeight()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    div-int/lit8 v0, v0, 0x64

    .line 54
    invoke-virtual {p0}, Landroid/graphics/fonts/FontStyle;->getSlant()I

    move-result v1

    invoke-virtual {p1}, Landroid/graphics/fonts/FontStyle;->getSlant()I

    move-result v2

    if-ne v1, v2, :cond_1b

    const/4 v1, 0x0

    goto :goto_1c

    :cond_1b
    const/4 v1, 0x2

    :goto_1c
    add-int/2addr v0, v1

    .line 53
    return v0
.end method


# virtual methods
.method public createFromFontFamilyFilesResourceEntry(Landroid/content/Context;Landroidx/core/content/res/FontResourcesParserCompat$FontFamilyFilesResourceEntry;Landroid/content/res/Resources;I)Landroid/graphics/Typeface;
    .registers 14
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "familyEntry"    # Landroidx/core/content/res/FontResourcesParserCompat$FontFamilyFilesResourceEntry;
    .param p3, "resources"    # Landroid/content/res/Resources;
    .param p4, "style"    # I

    .line 198
    const/4 v0, 0x0

    .line 199
    .local v0, "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    const/4 v1, 0x0

    :try_start_2
    invoke-virtual {p2}, Landroidx/core/content/res/FontResourcesParserCompat$FontFamilyFilesResourceEntry;->getEntries()[Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    move v5, v4

    :goto_9
    if-ge v5, v3, :cond_50

    aget-object v6, v2, v5
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_d} :catch_6d

    .line 201
    .local v6, "entry":Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;
    :try_start_d
    new-instance v7, Landroid/graphics/fonts/Font$Builder;

    invoke-virtual {v6}, Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;->getResourceId()I

    move-result v8

    invoke-direct {v7, p3, v8}, Landroid/graphics/fonts/Font$Builder;-><init>(Landroid/content/res/Resources;I)V

    .line 202
    invoke-virtual {v6}, Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;->getWeight()I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/graphics/fonts/Font$Builder;->setWeight(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v7

    .line 203
    invoke-virtual {v6}, Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;->isItalic()Z

    move-result v8

    if-eqz v8, :cond_26

    const/4 v8, 0x1

    goto :goto_27

    .line 204
    :cond_26
    move v8, v4

    .line 203
    :goto_27
    invoke-virtual {v7, v8}, Landroid/graphics/fonts/Font$Builder;->setSlant(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v7

    .line 205
    invoke-virtual {v6}, Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;->getTtcIndex()I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/graphics/fonts/Font$Builder;->setTtcIndex(I)Landroid/graphics/fonts/Font$Builder;

    move-result-object v7

    .line 206
    invoke-virtual {v6}, Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;->getVariationSettings()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/graphics/fonts/Font$Builder;->setFontVariationSettings(Ljava/lang/String;)Landroid/graphics/fonts/Font$Builder;

    move-result-object v7

    .line 207
    invoke-virtual {v7}, Landroid/graphics/fonts/Font$Builder;->build()Landroid/graphics/fonts/Font;

    move-result-object v7

    .line 208
    .local v7, "platformFont":Landroid/graphics/fonts/Font;
    if-nez v0, :cond_48

    .line 209
    new-instance v8, Landroid/graphics/fonts/FontFamily$Builder;

    invoke-direct {v8, v7}, Landroid/graphics/fonts/FontFamily$Builder;-><init>(Landroid/graphics/fonts/Font;)V

    move-object v0, v8

    goto :goto_4b

    .line 211
    :cond_48
    invoke-virtual {v0, v7}, Landroid/graphics/fonts/FontFamily$Builder;->addFont(Landroid/graphics/fonts/Font;)Landroid/graphics/fonts/FontFamily$Builder;
    :try_end_4b
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_4b} :catch_4c
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_4b} :catch_6d

    .line 215
    .end local v7    # "platformFont":Landroid/graphics/fonts/Font;
    :goto_4b
    goto :goto_4d

    .line 213
    :catch_4c
    move-exception v7

    .line 199
    .end local v6    # "entry":Landroidx/core/content/res/FontResourcesParserCompat$FontFileResourceEntry;
    :goto_4d
    add-int/lit8 v5, v5, 0x1

    goto :goto_9

    .line 217
    :cond_50
    if-nez v0, :cond_53

    .line 218
    return-object v1

    .line 220
    :cond_53
    :try_start_53
    invoke-virtual {v0}, Landroid/graphics/fonts/FontFamily$Builder;->build()Landroid/graphics/fonts/FontFamily;

    move-result-object v2

    .line 221
    .local v2, "family":Landroid/graphics/fonts/FontFamily;
    new-instance v3, Landroid/graphics/Typeface$CustomFallbackBuilder;

    invoke-direct {v3, v2}, Landroid/graphics/Typeface$CustomFallbackBuilder;-><init>(Landroid/graphics/fonts/FontFamily;)V

    .line 222
    invoke-direct {p0, v2, p4}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->findBaseFont(Landroid/graphics/fonts/FontFamily;I)Landroid/graphics/fonts/Font;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/graphics/Typeface$CustomFallbackBuilder;->setStyle(Landroid/graphics/fonts/FontStyle;)Landroid/graphics/Typeface$CustomFallbackBuilder;

    move-result-object v3

    .line 223
    invoke-virtual {v3}, Landroid/graphics/Typeface$CustomFallbackBuilder;->build()Landroid/graphics/Typeface;

    move-result-object v1
    :try_end_6c
    .catch Ljava/lang/Exception; {:try_start_53 .. :try_end_6c} :catch_6d

    .line 221
    return-object v1

    .line 224
    .end local v0    # "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    .end local v2    # "family":Landroid/graphics/fonts/FontFamily;
    :catch_6d
    move-exception v0

    .line 225
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "TypefaceCompatApi29Impl"

    const-string v3, "Font load failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 226
    return-object v1
.end method

.method public createFromFontInfo(Landroid/content/Context;Landroid/os/CancellationSignal;[Landroidx/core/provider/FontsContractCompat$FontInfo;I)Landroid/graphics/Typeface;
    .registers 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p3, "fonts"    # [Landroidx/core/provider/FontsContractCompat$FontInfo;
    .param p4, "style"    # I

    .line 93
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 95
    .local v0, "resolver":Landroid/content/ContentResolver;
    const/4 v1, 0x0

    :try_start_5
    invoke-virtual {p0, p2, p3, v0}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFontFamily(Landroid/os/CancellationSignal;[Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/FontFamily;

    move-result-object v2

    .line 96
    .local v2, "family":Landroid/graphics/fonts/FontFamily;
    if-nez v2, :cond_c

    return-object v1

    .line 97
    :cond_c
    new-instance v3, Landroid/graphics/Typeface$CustomFallbackBuilder;

    invoke-direct {v3, v2}, Landroid/graphics/Typeface$CustomFallbackBuilder;-><init>(Landroid/graphics/fonts/FontFamily;)V

    .line 98
    invoke-direct {p0, v2, p4}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->findBaseFont(Landroid/graphics/fonts/FontFamily;I)Landroid/graphics/fonts/Font;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/graphics/Typeface$CustomFallbackBuilder;->setStyle(Landroid/graphics/fonts/FontStyle;)Landroid/graphics/Typeface$CustomFallbackBuilder;

    move-result-object v3

    .line 99
    invoke-virtual {v3}, Landroid/graphics/Typeface$CustomFallbackBuilder;->build()Landroid/graphics/Typeface;

    move-result-object v1
    :try_end_21
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_21} :catch_22

    .line 97
    return-object v1

    .line 100
    .end local v2    # "family":Landroid/graphics/fonts/FontFamily;
    :catch_22
    move-exception v2

    .line 101
    .local v2, "e":Ljava/lang/Exception;
    const-string v3, "TypefaceCompatApi29Impl"

    const-string v4, "Font load failed"

    invoke-static {v3, v4, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 102
    return-object v1
.end method

.method public createFromFontInfoWithFallback(Landroid/content/Context;Landroid/os/CancellationSignal;Ljava/util/List;I)Landroid/graphics/Typeface;
    .registers 11
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p4, "style"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/os/CancellationSignal;",
            "Ljava/util/List<",
            "[",
            "Landroidx/core/provider/FontsContractCompat$FontInfo;",
            ">;I)",
            "Landroid/graphics/Typeface;"
        }
    .end annotation

    .line 169
    .local p3, "fonts":Ljava/util/List;, "Ljava/util/List<[Landroidx/core/provider/FontsContractCompat$FontInfo;>;"
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 171
    .local v0, "resolver":Landroid/content/ContentResolver;
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_6
    invoke-interface {p3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/core/provider/FontsContractCompat$FontInfo;

    invoke-virtual {p0, p2, v1, v0}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFontFamily(Landroid/os/CancellationSignal;[Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/FontFamily;

    move-result-object v1

    .line 172
    .local v1, "family":Landroid/graphics/fonts/FontFamily;
    if-nez v1, :cond_13

    return-object v2

    .line 173
    :cond_13
    new-instance v3, Landroid/graphics/Typeface$CustomFallbackBuilder;

    invoke-direct {v3, v1}, Landroid/graphics/Typeface$CustomFallbackBuilder;-><init>(Landroid/graphics/fonts/FontFamily;)V

    .line 174
    .local v3, "builder":Landroid/graphics/Typeface$CustomFallbackBuilder;
    const/4 v4, 0x1

    .local v4, "i":I
    :goto_19
    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v5

    if-ge v4, v5, :cond_31

    .line 175
    invoke-interface {p3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Landroidx/core/provider/FontsContractCompat$FontInfo;

    invoke-virtual {p0, p2, v5, v0}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFontFamily(Landroid/os/CancellationSignal;[Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/FontFamily;

    move-result-object v5

    .line 177
    .local v5, "fallbackFamily":Landroid/graphics/fonts/FontFamily;
    if-eqz v5, :cond_2e

    .line 178
    invoke-virtual {v3, v5}, Landroid/graphics/Typeface$CustomFallbackBuilder;->addCustomFallback(Landroid/graphics/fonts/FontFamily;)Landroid/graphics/Typeface$CustomFallbackBuilder;

    .line 174
    .end local v5    # "fallbackFamily":Landroid/graphics/fonts/FontFamily;
    :cond_2e
    add-int/lit8 v4, v4, 0x1

    goto :goto_19

    .line 186
    .end local v4    # "i":I
    :cond_31
    invoke-direct {p0, v1, p4}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->findBaseFont(Landroid/graphics/fonts/FontFamily;I)Landroid/graphics/fonts/Font;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/graphics/Typeface$CustomFallbackBuilder;->setStyle(Landroid/graphics/fonts/FontStyle;)Landroid/graphics/Typeface$CustomFallbackBuilder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/Typeface$CustomFallbackBuilder;->build()Landroid/graphics/Typeface;

    move-result-object v2
    :try_end_41
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_41} :catch_42

    return-object v2

    .line 187
    .end local v1    # "family":Landroid/graphics/fonts/FontFamily;
    .end local v3    # "builder":Landroid/graphics/Typeface$CustomFallbackBuilder;
    :catch_42
    move-exception v1

    .line 188
    .local v1, "e":Ljava/lang/Exception;
    const-string v3, "TypefaceCompatApi29Impl"

    const-string v4, "Font load failed"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 189
    return-object v2
.end method

.method protected createFromInputStream(Landroid/content/Context;Ljava/io/InputStream;)Landroid/graphics/Typeface;
    .registers 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "is"    # Ljava/io/InputStream;

    .line 86
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Do not use this function in API 29 or later."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public createFromResourcesFontFile(Landroid/content/Context;Landroid/content/res/Resources;ILjava/lang/String;I)Landroid/graphics/Typeface;
    .registers 11
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "resources"    # Landroid/content/res/Resources;
    .param p3, "id"    # I
    .param p4, "path"    # Ljava/lang/String;
    .param p5, "style"    # I

    .line 236
    const/4 v0, 0x0

    .line 237
    .local v0, "family":Landroid/graphics/fonts/FontFamily;
    const/4 v1, 0x0

    .line 239
    .local v1, "font":Landroid/graphics/fonts/Font;
    :try_start_2
    new-instance v2, Landroid/graphics/fonts/Font$Builder;

    invoke-direct {v2, p2, p3}, Landroid/graphics/fonts/Font$Builder;-><init>(Landroid/content/res/Resources;I)V

    invoke-virtual {v2}, Landroid/graphics/fonts/Font$Builder;->build()Landroid/graphics/fonts/Font;

    move-result-object v2

    move-object v1, v2

    .line 240
    new-instance v2, Landroid/graphics/fonts/FontFamily$Builder;

    invoke-direct {v2, v1}, Landroid/graphics/fonts/FontFamily$Builder;-><init>(Landroid/graphics/fonts/Font;)V

    invoke-virtual {v2}, Landroid/graphics/fonts/FontFamily$Builder;->build()Landroid/graphics/fonts/FontFamily;

    move-result-object v2

    move-object v0, v2

    .line 241
    new-instance v2, Landroid/graphics/Typeface$CustomFallbackBuilder;

    invoke-direct {v2, v0}, Landroid/graphics/Typeface$CustomFallbackBuilder;-><init>(Landroid/graphics/fonts/FontFamily;)V

    .line 243
    invoke-virtual {v1}, Landroid/graphics/fonts/Font;->getStyle()Landroid/graphics/fonts/FontStyle;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/graphics/Typeface$CustomFallbackBuilder;->setStyle(Landroid/graphics/fonts/FontStyle;)Landroid/graphics/Typeface$CustomFallbackBuilder;

    move-result-object v2

    .line 244
    invoke-virtual {v2}, Landroid/graphics/Typeface$CustomFallbackBuilder;->build()Landroid/graphics/Typeface;

    move-result-object v2
    :try_end_27
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_27} :catch_28

    .line 241
    return-object v2

    .line 245
    :catch_28
    move-exception v2

    .line 246
    .local v2, "e":Ljava/lang/Exception;
    const-string v3, "TypefaceCompatApi29Impl"

    const-string v4, "Font load failed"

    invoke-static {v3, v4, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 247
    const/4 v3, 0x0

    return-object v3
.end method

.method createWeightStyle(Landroid/content/Context;Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;
    .registers 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "base"    # Landroid/graphics/Typeface;
    .param p3, "weight"    # I
    .param p4, "italic"    # Z

    .line 254
    invoke-static {p2, p3, p4}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method protected findBestInfo([Landroidx/core/provider/FontsContractCompat$FontInfo;I)Landroidx/core/provider/FontsContractCompat$FontInfo;
    .registers 5
    .param p1, "fonts"    # [Landroidx/core/provider/FontsContractCompat$FontInfo;
    .param p2, "style"    # I

    .line 80
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Do not use this function in API 29 or later."

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected getFontFamily(Landroid/os/CancellationSignal;[Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/FontFamily;
    .registers 10
    .param p1, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p2, "fonts"    # [Landroidx/core/provider/FontsContractCompat$FontInfo;
    .param p3, "resolver"    # Landroid/content/ContentResolver;

    .line 147
    const/4 v0, 0x0

    .line 148
    .local v0, "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    array-length v1, p2

    const/4 v2, 0x0

    :goto_3
    if-ge v2, v1, :cond_1d

    aget-object v3, p2, v2

    .line 149
    .local v3, "font":Landroidx/core/provider/FontsContractCompat$FontInfo;
    invoke-direct {p0, p1, v3, p3}, Landroidx/core/graphics/TypefaceCompatApi29Impl;->getFont(Landroid/os/CancellationSignal;Landroidx/core/provider/FontsContractCompat$FontInfo;Landroid/content/ContentResolver;)Landroid/graphics/fonts/Font;

    move-result-object v4

    .line 150
    .local v4, "platformFont":Landroid/graphics/fonts/Font;
    if-nez v4, :cond_e

    .line 151
    goto :goto_1a

    .line 153
    :cond_e
    if-nez v0, :cond_17

    .line 154
    new-instance v5, Landroid/graphics/fonts/FontFamily$Builder;

    invoke-direct {v5, v4}, Landroid/graphics/fonts/FontFamily$Builder;-><init>(Landroid/graphics/fonts/Font;)V

    move-object v0, v5

    .end local v0    # "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    .local v5, "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    goto :goto_1a

    .line 156
    .end local v5    # "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    .restart local v0    # "familyBuilder":Landroid/graphics/fonts/FontFamily$Builder;
    :cond_17
    invoke-virtual {v0, v4}, Landroid/graphics/fonts/FontFamily$Builder;->addFont(Landroid/graphics/fonts/Font;)Landroid/graphics/fonts/FontFamily$Builder;

    .line 148
    .end local v3    # "font":Landroidx/core/provider/FontsContractCompat$FontInfo;
    .end local v4    # "platformFont":Landroid/graphics/fonts/Font;
    :goto_1a
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 159
    :cond_1d
    if-nez v0, :cond_21

    .line 160
    const/4 v1, 0x0

    return-object v1

    .line 162
    :cond_21
    invoke-virtual {v0}, Landroid/graphics/fonts/FontFamily$Builder;->build()Landroid/graphics/fonts/FontFamily;

    move-result-object v1

    return-object v1
.end method

.method protected getFontFromSystemFont(Landroidx/core/provider/FontsContractCompat$FontInfo;)Landroid/graphics/fonts/Font;
    .registers 4
    .param p1, "font"    # Landroidx/core/provider/FontsContractCompat$FontInfo;

    .line 108
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Getting font from Typeface is not supported before API31"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
