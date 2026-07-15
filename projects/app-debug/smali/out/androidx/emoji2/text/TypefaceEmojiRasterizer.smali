.class public Landroidx/emoji2/text/TypefaceEmojiRasterizer;
.super Ljava/lang/Object;
.source "TypefaceEmojiRasterizer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/emoji2/text/TypefaceEmojiRasterizer$HasGlyph;
    }
.end annotation


# static fields
.field static final HAS_GLYPH_ABSENT:I = 0x1

.field static final HAS_GLYPH_EXISTS:I = 0x2

.field static final HAS_GLYPH_UNKNOWN:I

.field private static final sMetadataItem:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Landroidx/emoji2/text/flatbuffer/MetadataItem;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private volatile mCache:I

.field private final mIndex:I

.field private final mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 89
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->sMetadataItem:Ljava/lang/ThreadLocal;

    return-void
.end method

.method constructor <init>(Landroidx/emoji2/text/MetadataRepo;I)V
    .registers 4
    .param p1, "metadataRepo"    # Landroidx/emoji2/text/MetadataRepo;
    .param p2, "index"    # I

    .line 115
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 108
    const/4 v0, 0x0

    iput v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    .line 116
    iput-object p1, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;

    .line 117
    iput p2, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mIndex:I

    .line 118
    return-void
.end method

.method private getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;
    .registers 4

    .line 154
    sget-object v0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->sMetadataItem:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/emoji2/text/flatbuffer/MetadataItem;

    .line 155
    .local v0, "result":Landroidx/emoji2/text/flatbuffer/MetadataItem;
    if-nez v0, :cond_15

    .line 156
    new-instance v1, Landroidx/emoji2/text/flatbuffer/MetadataItem;

    invoke-direct {v1}, Landroidx/emoji2/text/flatbuffer/MetadataItem;-><init>()V

    move-object v0, v1

    .line 157
    sget-object v1, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->sMetadataItem:Ljava/lang/ThreadLocal;

    invoke-virtual {v1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 167
    :cond_15
    iget-object v1, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;

    invoke-virtual {v1}, Landroidx/emoji2/text/MetadataRepo;->getMetadataList()Landroidx/emoji2/text/flatbuffer/MetadataList;

    move-result-object v1

    iget v2, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mIndex:I

    invoke-virtual {v1, v0, v2}, Landroidx/emoji2/text/flatbuffer/MetadataList;->list(Landroidx/emoji2/text/flatbuffer/MetadataItem;I)Landroidx/emoji2/text/flatbuffer/MetadataItem;

    .line 168
    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;FFLandroid/graphics/Paint;)V
    .registers 15
    .param p1, "canvas"    # Landroid/graphics/Canvas;
    .param p2, "x"    # F
    .param p3, "y"    # F
    .param p4, "paint"    # Landroid/graphics/Paint;

    .line 130
    iget-object v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;

    invoke-virtual {v0}, Landroidx/emoji2/text/MetadataRepo;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v0

    .line 131
    .local v0, "typeface":Landroid/graphics/Typeface;
    invoke-virtual {p4}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v1

    .line 132
    .local v1, "oldTypeface":Landroid/graphics/Typeface;
    invoke-virtual {p4, v0}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 137
    iget v2, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mIndex:I

    mul-int/lit8 v5, v2, 0x2

    .line 138
    .local v5, "charArrayStartIndex":I
    iget-object v2, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;

    invoke-virtual {v2}, Landroidx/emoji2/text/MetadataRepo;->getEmojiCharArray()[C

    move-result-object v4

    const/4 v6, 0x2

    move-object v3, p1

    move v7, p2

    move v8, p3

    move-object v9, p4

    .end local p1    # "canvas":Landroid/graphics/Canvas;
    .end local p2    # "x":F
    .end local p3    # "y":F
    .end local p4    # "paint":Landroid/graphics/Paint;
    .local v3, "canvas":Landroid/graphics/Canvas;
    .local v7, "x":F
    .local v8, "y":F
    .local v9, "paint":Landroid/graphics/Paint;
    invoke-virtual/range {v3 .. v9}, Landroid/graphics/Canvas;->drawText([CIIFFLandroid/graphics/Paint;)V

    .line 139
    invoke-virtual {v9, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 140
    return-void
.end method

.method public getCodepointAt(I)I
    .registers 3
    .param p1, "index"    # I

    .line 306
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->codepoints(I)I

    move-result v0

    return v0
.end method

.method public getCodepointsLength()I
    .registers 2

    .line 313
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->codepointsLength()I

    move-result v0

    return v0
.end method

.method public getCompatAdded()S
    .registers 2

    .line 202
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->compatAdded()S

    move-result v0

    return v0
.end method

.method public getHasGlyph()I
    .registers 2

    .line 228
    iget v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    and-int/lit8 v0, v0, 0x3

    return v0
.end method

.method public getHeight()I
    .registers 2

    .line 193
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->height()S

    move-result v0

    return v0
.end method

.method public getId()I
    .registers 2

    .line 179
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->id()I

    move-result v0

    return v0
.end method

.method public getSdkAdded()S
    .registers 2

    .line 211
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->sdkAdded()S

    move-result v0

    return v0
.end method

.method public getTypeface()Landroid/graphics/Typeface;
    .registers 2

    .line 147
    iget-object v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mMetadataRepo:Landroidx/emoji2/text/MetadataRepo;

    invoke-virtual {v0}, Landroidx/emoji2/text/MetadataRepo;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method public getWidth()I
    .registers 2

    .line 186
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->width()S

    move-result v0

    return v0
.end method

.method public isDefaultEmoji()Z
    .registers 2

    .line 297
    invoke-direct {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getMetadataItem()Landroidx/emoji2/text/flatbuffer/MetadataItem;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/emoji2/text/flatbuffer/MetadataItem;->emojiStyle()Z

    move-result v0

    return v0
.end method

.method public isPreferredSystemRender()Z
    .registers 2

    .line 289
    iget v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    and-int/lit8 v0, v0, 0x4

    if-lez v0, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    return v0
.end method

.method public resetHasGlyphCache()V
    .registers 3

    .line 240
    invoke-virtual {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->isPreferredSystemRender()Z

    move-result v0

    .line 241
    .local v0, "willExclude":Z
    if-eqz v0, :cond_a

    .line 242
    const/4 v1, 0x4

    iput v1, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    goto :goto_d

    .line 244
    :cond_a
    const/4 v1, 0x0

    iput v1, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    .line 246
    :goto_d
    return-void
.end method

.method public setExclusion(Z)V
    .registers 4
    .param p1, "exclude"    # Z

    .line 275
    invoke-virtual {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getHasGlyph()I

    move-result v0

    .line 276
    .local v0, "hasGlyphBits":I
    if-eqz p1, :cond_b

    .line 277
    or-int/lit8 v1, v0, 0x4

    iput v1, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    goto :goto_d

    .line 279
    :cond_b
    iput v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    .line 281
    :goto_d
    return-void
.end method

.method public setHasGlyph(Z)V
    .registers 3
    .param p1, "hasGlyph"    # Z

    .line 258
    iget v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    and-int/lit8 v0, v0, 0x4

    .line 259
    .local v0, "newValue":I
    if-eqz p1, :cond_9

    .line 260
    or-int/lit8 v0, v0, 0x2

    goto :goto_b

    .line 262
    :cond_9
    or-int/lit8 v0, v0, 0x1

    .line 264
    :goto_b
    iput v0, p0, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->mCache:I

    .line 265
    return-void
.end method

.method public toString()Ljava/lang/String;
    .registers 5

    .line 319
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 320
    .local v0, "builder":Ljava/lang/StringBuilder;
    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    const-string v1, ", id:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 322
    invoke-virtual {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getId()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 323
    const-string v1, ", codepoints:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 324
    invoke-virtual {p0}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getCodepointsLength()I

    move-result v1

    .line 325
    .local v1, "codepointsLength":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_26
    if-ge v2, v1, :cond_3b

    .line 326
    invoke-virtual {p0, v2}, Landroidx/emoji2/text/TypefaceEmojiRasterizer;->getCodepointAt(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 327
    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 325
    add-int/lit8 v2, v2, 0x1

    goto :goto_26

    .line 329
    .end local v2    # "i":I
    :cond_3b
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method
