.class public abstract Landroidx/core/graphics/drawable/RoundedBitmapDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "RoundedBitmapDrawable.java"


# static fields
.field private static final DEFAULT_PAINT_FLAGS:I = 0x3


# instance fields
.field private mApplyGravity:Z

.field final mBitmap:Landroid/graphics/Bitmap;

.field private mBitmapHeight:I

.field private final mBitmapShader:Landroid/graphics/BitmapShader;

.field private mBitmapWidth:I

.field private mCornerRadius:F

.field final mDstRect:Landroid/graphics/Rect;

.field private final mDstRectF:Landroid/graphics/RectF;

.field private mGravity:I

.field private mIsCircular:Z

.field private final mPaint:Landroid/graphics/Paint;

.field private final mShaderMatrix:Landroid/graphics/Matrix;

.field private mTargetDensity:I


# direct methods
.method constructor <init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V
    .registers 7
    .param p1, "res"    # Landroid/content/res/Resources;
    .param p2, "bitmap"    # Landroid/graphics/Bitmap;

    .line 380
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 50
    const/16 v0, 0xa0

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    .line 51
    const/16 v0, 0x77

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    .line 52
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    .line 54
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mShaderMatrix:Landroid/graphics/Matrix;

    .line 57
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    .line 58
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    .line 60
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    .line 381
    if-eqz p1, :cond_35

    .line 382
    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    .line 385
    :cond_35
    iput-object p2, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    .line 386
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_4c

    .line 387
    invoke-direct {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->computeBitmapSize()V

    .line 388
    new-instance v0, Landroid/graphics/BitmapShader;

    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    sget-object v2, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    sget-object v3, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct {v0, v1, v2, v3}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    goto :goto_54

    .line 390
    :cond_4c
    const/4 v0, -0x1

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    .line 391
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    .line 393
    :goto_54
    return-void
.end method

.method private computeBitmapSize()V
    .registers 3

    .line 82
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    iget v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    invoke-virtual {v0, v1}, Landroid/graphics/Bitmap;->getScaledWidth(I)I

    move-result v0

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    .line 83
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    iget v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    invoke-virtual {v0, v1}, Landroid/graphics/Bitmap;->getScaledHeight(I)I

    move-result v0

    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    .line 84
    return-void
.end method

.method private static isGreaterThanZero(F)Z
    .registers 2
    .param p0, "toCompare"    # F

    .line 396
    const v0, 0x3d4ccccd    # 0.05f

    cmpl-float v0, p0, v0

    if-lez v0, :cond_9

    const/4 v0, 0x1

    goto :goto_a

    :cond_9
    const/4 v0, 0x0

    :goto_a
    return v0
.end method

.method private updateCircularCornerRadius()V
    .registers 3

    .line 313
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    iget v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 314
    .local v0, "minCircularSize":I
    div-int/lit8 v1, v0, 0x2

    int-to-float v1, v1

    iput v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    .line 315
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 7
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 258
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    .line 259
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-nez v0, :cond_5

    .line 260
    return-void

    .line 263
    :cond_5
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->updateDstRect()V

    .line 264
    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1}, Landroid/graphics/Paint;->getShader()Landroid/graphics/Shader;

    move-result-object v1

    if-nez v1, :cond_19

    .line 265
    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    iget-object v2, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    invoke-virtual {p1, v0, v3, v1, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_24

    .line 267
    :cond_19
    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    iget v2, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    iget v3, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    iget-object v4, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 269
    :goto_24
    return-void
.end method

.method public getAlpha()I
    .registers 2

    .line 282
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getAlpha()I

    move-result v0

    return v0
.end method

.method public final getBitmap()Landroid/graphics/Bitmap;
    .registers 2

    .line 78
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public getColorFilter()Landroid/graphics/ColorFilter;
    .registers 2

    .line 293
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColorFilter()Landroid/graphics/ColorFilter;

    move-result-object v0

    return-object v0
.end method

.method public getCornerRadius()F
    .registers 2

    .line 354
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    return v0
.end method

.method public getGravity()I
    .registers 2

    .line 138
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    return v0
.end method

.method public getIntrinsicHeight()I
    .registers 2

    .line 364
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    return v0
.end method

.method public getIntrinsicWidth()I
    .registers 2

    .line 359
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    return v0
.end method

.method public getOpacity()I
    .registers 5

    .line 369
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    const/16 v1, 0x77

    const/4 v2, -0x3

    if-ne v0, v1, :cond_2d

    iget-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    if-eqz v0, :cond_c

    goto :goto_2d

    .line 372
    :cond_c
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    .line 373
    .local v0, "bm":Landroid/graphics/Bitmap;
    if-eqz v0, :cond_2b

    .line 374
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v1

    if-nez v1, :cond_2b

    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    .line 375
    invoke-virtual {v1}, Landroid/graphics/Paint;->getAlpha()I

    move-result v1

    const/16 v3, 0xff

    if-lt v1, v3, :cond_2b

    iget v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    .line 376
    invoke-static {v1}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->isGreaterThanZero(F)Z

    move-result v1

    if-eqz v1, :cond_29

    goto :goto_2b

    .line 377
    :cond_29
    const/4 v2, -0x1

    goto :goto_2c

    :cond_2b
    :goto_2b
    nop

    .line 373
    :goto_2c
    return v2

    .line 370
    .end local v0    # "bm":Landroid/graphics/Bitmap;
    :cond_2d
    :goto_2d
    return v2
.end method

.method public final getPaint()Landroid/graphics/Paint;
    .registers 2

    .line 71
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    return-object v0
.end method

.method gravityCompatApply(IIILandroid/graphics/Rect;Landroid/graphics/Rect;)V
    .registers 7
    .param p1, "gravity"    # I
    .param p2, "bitmapWidth"    # I
    .param p3, "bitmapHeight"    # I
    .param p4, "bounds"    # Landroid/graphics/Rect;
    .param p5, "outRect"    # Landroid/graphics/Rect;

    .line 221
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public hasAntiAlias()Z
    .registers 2

    .line 204
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->isAntiAlias()Z

    move-result v0

    return v0
.end method

.method public hasMipMap()Z
    .registers 2

    .line 180
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public isCircular()Z
    .registers 2

    .line 321
    iget-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    return v0
.end method

.method protected onBoundsChange(Landroid/graphics/Rect;)V
    .registers 3
    .param p1, "bounds"    # Landroid/graphics/Rect;

    .line 343
    invoke-super {p0, p1}, Landroid/graphics/drawable/Drawable;->onBoundsChange(Landroid/graphics/Rect;)V

    .line 344
    iget-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    if-eqz v0, :cond_a

    .line 345
    invoke-direct {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->updateCircularCornerRadius()V

    .line 347
    :cond_a
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    .line 348
    return-void
.end method

.method public setAlpha(I)V
    .registers 4
    .param p1, "alpha"    # I

    .line 273
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getAlpha()I

    move-result v0

    .line 274
    .local v0, "oldAlpha":I
    if-eq p1, v0, :cond_10

    .line 275
    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 276
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 278
    :cond_10
    return-void
.end method

.method public setAntiAlias(Z)V
    .registers 3
    .param p1, "aa"    # Z

    .line 192
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 193
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 194
    return-void
.end method

.method public setCircular(Z)V
    .registers 4
    .param p1, "circular"    # Z

    .line 301
    iput-boolean p1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    .line 302
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    .line 303
    if-eqz p1, :cond_15

    .line 304
    invoke-direct {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->updateCircularCornerRadius()V

    .line 305
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 306
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    goto :goto_19

    .line 308
    :cond_15
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->setCornerRadius(F)V

    .line 310
    :goto_19
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 3
    .param p1, "cf"    # Landroid/graphics/ColorFilter;

    .line 287
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 288
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 289
    return-void
.end method

.method public setCornerRadius(F)V
    .registers 4
    .param p1, "cornerRadius"    # F

    .line 328
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    cmpl-float v0, v0, p1

    if-nez v0, :cond_7

    return-void

    .line 330
    :cond_7
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    .line 331
    invoke-static {p1}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->isGreaterThanZero(F)Z

    move-result v0

    if-eqz v0, :cond_18

    .line 332
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    iget-object v1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    goto :goto_1e

    .line 334
    :cond_18
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 337
    :goto_1e
    iput p1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    .line 338
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 339
    return-void
.end method

.method public setDither(Z)V
    .registers 3
    .param p1, "dither"    # Z

    .line 215
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setDither(Z)V

    .line 216
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 217
    return-void
.end method

.method public setFilterBitmap(Z)V
    .registers 3
    .param p1, "filter"    # Z

    .line 209
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 210
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 211
    return-void
.end method

.method public setGravity(I)V
    .registers 3
    .param p1, "gravity"    # I

    .line 149
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    if-eq v0, p1, :cond_c

    .line 150
    iput p1, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    .line 151
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    .line 152
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 154
    :cond_c
    return-void
.end method

.method public setMipMap(Z)V
    .registers 3
    .param p1, "mipMap"    # Z

    .line 168
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public setTargetDensity(I)V
    .registers 3
    .param p1, "density"    # I

    .line 121
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    if-eq v0, p1, :cond_16

    .line 122
    if-nez p1, :cond_9

    const/16 v0, 0xa0

    goto :goto_a

    :cond_9
    move v0, p1

    :goto_a
    iput v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mTargetDensity:I

    .line 123
    iget-object v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_13

    .line 124
    invoke-direct {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->computeBitmapSize()V

    .line 126
    :cond_13
    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->invalidateSelf()V

    .line 128
    :cond_16
    return-void
.end method

.method public setTargetDensity(Landroid/graphics/Canvas;)V
    .registers 3
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 97
    invoke-virtual {p1}, Landroid/graphics/Canvas;->getDensity()I

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->setTargetDensity(I)V

    .line 98
    return-void
.end method

.method public setTargetDensity(Landroid/util/DisplayMetrics;)V
    .registers 3
    .param p1, "metrics"    # Landroid/util/DisplayMetrics;

    .line 109
    iget v0, p1, Landroid/util/DisplayMetrics;->densityDpi:I

    invoke-virtual {p0, v0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->setTargetDensity(I)V

    .line 110
    return-void
.end method

.method updateDstRect()V
    .registers 16

    .line 225
    iget-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    if-eqz v0, :cond_af

    .line 226
    iget-boolean v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mIsCircular:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_54

    .line 227
    iget v0, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    iget v2, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 228
    .local v5, "minDimen":I
    iget v4, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v7

    iget-object v8, p0, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    move v6, v5

    move-object v3, p0

    invoke-virtual/range {v3 .. v8}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->gravityCompatApply(IIILandroid/graphics/Rect;Landroid/graphics/Rect;)V

    .line 232
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v2}, Landroid/graphics/Rect;->height()I

    move-result v2

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 233
    .local v0, "minDrawDimen":I
    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    move-result v2

    sub-int/2addr v2, v0

    div-int/lit8 v2, v2, 0x2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 234
    .local v2, "insetX":I
    iget-object v4, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v4}, Landroid/graphics/Rect;->height()I

    move-result v4

    sub-int/2addr v4, v0

    div-int/lit8 v4, v4, 0x2

    invoke-static {v1, v4}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 235
    .local v4, "insetY":I
    iget-object v6, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v6, v2, v4}, Landroid/graphics/Rect;->inset(II)V

    .line 236
    const/high16 v6, 0x3f000000    # 0.5f

    int-to-float v7, v0

    mul-float/2addr v7, v6

    iput v7, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mCornerRadius:F

    .line 237
    .end local v0    # "minDrawDimen":I
    .end local v2    # "insetX":I
    .end local v4    # "insetY":I
    .end local v5    # "minDimen":I
    goto :goto_65

    .line 238
    :cond_54
    move-object v3, p0

    iget v10, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mGravity:I

    iget v11, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapWidth:I

    iget v12, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapHeight:I

    invoke-virtual {p0}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v13

    iget-object v14, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    move-object v9, v3

    invoke-virtual/range {v9 .. v14}, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->gravityCompatApply(IIILandroid/graphics/Rect;Landroid/graphics/Rect;)V

    .line 240
    :goto_65
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRect:Landroid/graphics/Rect;

    invoke-virtual {v0, v2}, Landroid/graphics/RectF;->set(Landroid/graphics/Rect;)V

    .line 242
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    if-eqz v0, :cond_ac

    .line 244
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mShaderMatrix:Landroid/graphics/Matrix;

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->left:F

    iget-object v4, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->top:F

    invoke-virtual {v0, v2, v4}, Landroid/graphics/Matrix;->setTranslate(FF)V

    .line 245
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mShaderMatrix:Landroid/graphics/Matrix;

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    .line 246
    invoke-virtual {v2}, Landroid/graphics/RectF;->width()F

    move-result v2

    iget-object v4, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v2, v4

    iget-object v4, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mDstRectF:Landroid/graphics/RectF;

    .line 247
    invoke-virtual {v4}, Landroid/graphics/RectF;->height()F

    move-result v4

    iget-object v5, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    int-to-float v5, v5

    div-float/2addr v4, v5

    .line 245
    invoke-virtual {v0, v2, v4}, Landroid/graphics/Matrix;->preScale(FF)Z

    .line 248
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mShaderMatrix:Landroid/graphics/Matrix;

    invoke-virtual {v0, v2}, Landroid/graphics/BitmapShader;->setLocalMatrix(Landroid/graphics/Matrix;)V

    .line 249
    iget-object v0, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mPaint:Landroid/graphics/Paint;

    iget-object v2, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mBitmapShader:Landroid/graphics/BitmapShader;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 252
    :cond_ac
    iput-boolean v1, v3, Landroidx/core/graphics/drawable/RoundedBitmapDrawable;->mApplyGravity:Z

    goto :goto_b0

    .line 225
    :cond_af
    move-object v3, p0

    .line 254
    :goto_b0
    return-void
.end method
