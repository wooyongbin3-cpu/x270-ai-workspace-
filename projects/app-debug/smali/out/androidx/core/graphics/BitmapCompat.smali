.class public final Landroidx/core/graphics/BitmapCompat;
.super Ljava/lang/Object;
.source "BitmapCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/graphics/BitmapCompat$Api27Impl;,
        Landroidx/core/graphics/BitmapCompat$Api29Impl;,
        Landroidx/core/graphics/BitmapCompat$Api31Impl;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 333
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 335
    return-void
.end method

.method public static createScaledBitmap(Landroid/graphics/Bitmap;IILandroid/graphics/Rect;Z)Landroid/graphics/Bitmap;
    .registers 35
    .param p0, "srcBm"    # Landroid/graphics/Bitmap;
    .param p1, "dstW"    # I
    .param p2, "dstH"    # I
    .param p3, "srcRect"    # Landroid/graphics/Rect;
    .param p4, "scaleInLinearSpace"    # Z

    .line 134
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move-object/from16 v3, p3

    if-lez v1, :cond_24e

    if-lez v2, :cond_24e

    .line 138
    if-eqz v3, :cond_35

    .line 139
    invoke-virtual {v3}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2d

    iget v4, v3, Landroid/graphics/Rect;->left:I

    if-ltz v4, :cond_2d

    iget v4, v3, Landroid/graphics/Rect;->right:I

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    if-gt v4, v5, :cond_2d

    iget v4, v3, Landroid/graphics/Rect;->top:I

    if-ltz v4, :cond_2d

    iget v4, v3, Landroid/graphics/Rect;->bottom:I

    .line 140
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    if-gt v4, v5, :cond_2d

    goto :goto_35

    .line 141
    :cond_2d
    new-instance v4, Ljava/lang/IllegalArgumentException;

    const-string v5, "srcRect must be contained by srcBm!"

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 145
    :cond_35
    :goto_35
    move-object/from16 v4, p0

    .line 146
    .local v4, "src":Landroid/graphics/Bitmap;
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1b

    if-lt v5, v6, :cond_41

    .line 149
    invoke-static {v0}, Landroidx/core/graphics/BitmapCompat$Api27Impl;->copyBitmapIfHardware(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 152
    :cond_41
    if-eqz v3, :cond_48

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v5

    goto :goto_4c

    :cond_48
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    .line 153
    .local v5, "srcW":I
    :goto_4c
    if-eqz v3, :cond_53

    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I

    move-result v7

    goto :goto_57

    :cond_53
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    .line 155
    .local v7, "srcH":I
    :goto_57
    int-to-float v8, v1

    int-to-float v9, v5

    div-float/2addr v8, v9

    .line 156
    .local v8, "sx":F
    int-to-float v9, v2

    int-to-float v10, v7

    div-float/2addr v9, v10

    .line 158
    .local v9, "sy":F
    if-eqz v3, :cond_62

    iget v11, v3, Landroid/graphics/Rect;->left:I

    goto :goto_63

    :cond_62
    const/4 v11, 0x0

    .line 159
    .local v11, "srcX":I
    :goto_63
    if-eqz v3, :cond_68

    iget v12, v3, Landroid/graphics/Rect;->top:I

    goto :goto_69

    :cond_68
    const/4 v12, 0x0

    .line 162
    .local v12, "srcY":I
    :goto_69
    const/4 v13, 0x1

    if-nez v11, :cond_8c

    if-nez v12, :cond_8c

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v14

    if-ne v1, v14, :cond_8c

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v14

    if-ne v2, v14, :cond_8c

    .line 164
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v6

    if-eqz v6, :cond_8b

    if-ne v0, v4, :cond_8b

    .line 165
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v6

    invoke-virtual {v0, v6, v13}, Landroid/graphics/Bitmap;->copy(Landroid/graphics/Bitmap$Config;Z)Landroid/graphics/Bitmap;

    move-result-object v6

    return-object v6

    .line 168
    :cond_8b
    return-object v4

    .line 172
    :cond_8c
    new-instance v14, Landroid/graphics/Paint;

    invoke-direct {v14, v13}, Landroid/graphics/Paint;-><init>(I)V

    .line 173
    .local v14, "paint":Landroid/graphics/Paint;
    invoke-virtual {v14, v13}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 174
    sget v15, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v10, 0x1d

    if-lt v15, v10, :cond_9e

    .line 175
    invoke-static {v14}, Landroidx/core/graphics/BitmapCompat$Api29Impl;->setPaintBlendMode(Landroid/graphics/Paint;)V

    goto :goto_a8

    .line 177
    :cond_9e
    new-instance v10, Landroid/graphics/PorterDuffXfermode;

    sget-object v15, Landroid/graphics/PorterDuff$Mode;->SRC:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v10, v15}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {v14, v10}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    .line 181
    :goto_a8
    if-ne v5, v1, :cond_c1

    if-ne v7, v2, :cond_c1

    .line 182
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v6

    invoke-static {v1, v2, v6}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v6

    .line 183
    .local v6, "out":Landroid/graphics/Bitmap;
    new-instance v10, Landroid/graphics/Canvas;

    invoke-direct {v10, v6}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 184
    .local v10, "canvasForCopy":Landroid/graphics/Canvas;
    neg-int v13, v11

    int-to-float v13, v13

    neg-int v15, v12

    int-to-float v15, v15

    invoke-virtual {v10, v4, v13, v15, v14}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    .line 185
    return-object v6

    .line 189
    .end local v6    # "out":Landroid/graphics/Bitmap;
    .end local v10    # "canvasForCopy":Landroid/graphics/Canvas;
    :cond_c1
    const-wide/high16 v17, 0x4000000000000000L    # 2.0

    invoke-static/range {v17 .. v18}, Ljava/lang/Math;->log(D)D

    move-result-wide v17

    .line 190
    .local v17, "log2":D
    const/high16 v10, 0x3f800000    # 1.0f

    cmpl-float v15, v8, v10

    if-lez v15, :cond_dd

    move/from16 v19, v10

    move v15, v11

    .end local v11    # "srcX":I
    .local v15, "srcX":I
    float-to-double v10, v8

    invoke-static {v10, v11}, Ljava/lang/Math;->log(D)D

    move-result-wide v10

    div-double v10, v10, v17

    invoke-static {v10, v11}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v10

    double-to-int v10, v10

    goto :goto_ec

    .line 191
    .end local v15    # "srcX":I
    .restart local v11    # "srcX":I
    :cond_dd
    move/from16 v19, v10

    move v15, v11

    .end local v11    # "srcX":I
    .restart local v15    # "srcX":I
    float-to-double v10, v8

    invoke-static {v10, v11}, Ljava/lang/Math;->log(D)D

    move-result-wide v10

    div-double v10, v10, v17

    invoke-static {v10, v11}, Ljava/lang/Math;->floor(D)D

    move-result-wide v10

    double-to-int v10, v10

    :goto_ec
    nop

    .line 192
    .local v10, "stepsX":I
    cmpl-float v11, v9, v19

    if-lez v11, :cond_ff

    move-object v11, v14

    .end local v14    # "paint":Landroid/graphics/Paint;
    .local v11, "paint":Landroid/graphics/Paint;
    float-to-double v13, v9

    invoke-static {v13, v14}, Ljava/lang/Math;->log(D)D

    move-result-wide v13

    div-double v13, v13, v17

    invoke-static {v13, v14}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v13

    double-to-int v13, v13

    goto :goto_10c

    .line 193
    .end local v11    # "paint":Landroid/graphics/Paint;
    .restart local v14    # "paint":Landroid/graphics/Paint;
    :cond_ff
    move-object v11, v14

    .end local v14    # "paint":Landroid/graphics/Paint;
    .restart local v11    # "paint":Landroid/graphics/Paint;
    float-to-double v13, v9

    invoke-static {v13, v14}, Ljava/lang/Math;->log(D)D

    move-result-wide v13

    div-double v13, v13, v17

    invoke-static {v13, v14}, Ljava/lang/Math;->floor(D)D

    move-result-wide v13

    double-to-int v13, v13

    :goto_10c
    nop

    .line 194
    .local v13, "stepsY":I
    move v14, v10

    .line 195
    .local v14, "totalStepsX":I
    move/from16 v20, v13

    .line 201
    .local v20, "totalStepsY":I
    const/16 v21, 0x0

    .line 204
    .local v21, "dst":Landroid/graphics/Bitmap;
    const/16 v22, 0x0

    .line 205
    .local v22, "needFinalConversion":Z
    if-eqz p4, :cond_16d

    .line 206
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v6, :cond_164

    invoke-static {v0}, Landroidx/core/graphics/BitmapCompat$Api27Impl;->isAlreadyF16AndLinear(Landroid/graphics/Bitmap;)Z

    move-result v3

    if-nez v3, :cond_164

    .line 207
    if-lez v10, :cond_128

    const/4 v3, 0x1

    invoke-static {v5, v1, v3, v14}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v19

    goto :goto_12b

    :cond_128
    const/4 v3, 0x1

    move/from16 v19, v5

    :goto_12b
    move/from16 v23, v19

    .line 208
    .local v23, "allocW":I
    if-lez v13, :cond_136

    move/from16 v6, v20

    .end local v20    # "totalStepsY":I
    .local v6, "totalStepsY":I
    invoke-static {v7, v2, v3, v6}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v20

    goto :goto_13a

    .end local v6    # "totalStepsY":I
    .restart local v20    # "totalStepsY":I
    :cond_136
    move/from16 v6, v20

    .end local v20    # "totalStepsY":I
    .restart local v6    # "totalStepsY":I
    move/from16 v20, v7

    :goto_13a
    move/from16 v24, v20

    .line 209
    .local v24, "allocH":I
    move/from16 v20, v8

    move/from16 v8, v23

    move/from16 v23, v9

    move/from16 v9, v24

    move/from16 v24, v10

    .end local v10    # "stepsX":I
    .local v8, "allocW":I
    .local v9, "allocH":I
    .local v20, "sx":F
    .local v23, "sy":F
    .local v24, "stepsX":I
    invoke-static {v8, v9, v0, v3}, Landroidx/core/graphics/BitmapCompat$Api27Impl;->createBitmapWithSourceColorspace(IILandroid/graphics/Bitmap;Z)Landroid/graphics/Bitmap;

    move-result-object v10

    .line 211
    .end local v21    # "dst":Landroid/graphics/Bitmap;
    .local v10, "dst":Landroid/graphics/Bitmap;
    new-instance v3, Landroid/graphics/Canvas;

    invoke-direct {v3, v10}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 212
    .local v3, "canvasForCopy":Landroid/graphics/Canvas;
    move/from16 v25, v8

    .end local v8    # "allocW":I
    .local v25, "allocW":I
    neg-int v8, v15

    int-to-float v8, v8

    move/from16 v26, v9

    .end local v9    # "allocH":I
    .local v26, "allocH":I
    neg-int v9, v12

    int-to-float v9, v9

    invoke-virtual {v3, v4, v8, v9, v11}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    .line 213
    const/4 v8, 0x0

    .line 214
    .end local v15    # "srcX":I
    .local v8, "srcX":I
    const/4 v12, 0x0

    .line 215
    move-object v9, v10

    .line 216
    .local v9, "swap":Landroid/graphics/Bitmap;
    move-object/from16 v21, v4

    .line 217
    .end local v10    # "dst":Landroid/graphics/Bitmap;
    .restart local v21    # "dst":Landroid/graphics/Bitmap;
    move-object v4, v9

    .line 218
    const/16 v22, 0x1

    move v15, v8

    goto :goto_175

    .line 206
    .end local v3    # "canvasForCopy":Landroid/graphics/Canvas;
    .end local v6    # "totalStepsY":I
    .end local v23    # "sy":F
    .end local v24    # "stepsX":I
    .end local v25    # "allocW":I
    .end local v26    # "allocH":I
    .local v8, "sx":F
    .local v9, "sy":F
    .local v10, "stepsX":I
    .restart local v15    # "srcX":I
    .local v20, "totalStepsY":I
    :cond_164
    move/from16 v23, v9

    move/from16 v24, v10

    move/from16 v6, v20

    move/from16 v20, v8

    .end local v8    # "sx":F
    .end local v9    # "sy":F
    .end local v10    # "stepsX":I
    .restart local v6    # "totalStepsY":I
    .local v20, "sx":F
    .restart local v23    # "sy":F
    .restart local v24    # "stepsX":I
    goto :goto_175

    .line 205
    .end local v6    # "totalStepsY":I
    .end local v23    # "sy":F
    .end local v24    # "stepsX":I
    .restart local v8    # "sx":F
    .restart local v9    # "sy":F
    .restart local v10    # "stepsX":I
    .local v20, "totalStepsY":I
    :cond_16d
    move/from16 v23, v9

    move/from16 v24, v10

    move/from16 v6, v20

    move/from16 v20, v8

    .line 222
    .end local v8    # "sx":F
    .end local v9    # "sy":F
    .end local v10    # "stepsX":I
    .restart local v6    # "totalStepsY":I
    .local v20, "sx":F
    .restart local v23    # "sy":F
    .restart local v24    # "stepsX":I
    :goto_175
    new-instance v3, Landroid/graphics/Rect;

    invoke-direct {v3, v15, v12, v5, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 223
    .local v3, "currRect":Landroid/graphics/Rect;
    new-instance v8, Landroid/graphics/Rect;

    invoke-direct {v8}, Landroid/graphics/Rect;-><init>()V

    move-object/from16 v9, v21

    move/from16 v10, v24

    .line 225
    .end local v21    # "dst":Landroid/graphics/Bitmap;
    .end local v24    # "stepsX":I
    .local v8, "nextRect":Landroid/graphics/Rect;
    .local v9, "dst":Landroid/graphics/Bitmap;
    .restart local v10    # "stepsX":I
    :goto_183
    if-nez v10, :cond_190

    if-eqz v13, :cond_188

    goto :goto_190

    .line 311
    :cond_188
    if-eq v9, v0, :cond_18f

    if-eqz v9, :cond_18f

    .line 312
    invoke-virtual {v9}, Landroid/graphics/Bitmap;->recycle()V

    .line 314
    :cond_18f
    return-object v4

    .line 226
    :cond_190
    :goto_190
    if-gez v10, :cond_195

    .line 227
    add-int/lit8 v10, v10, 0x1

    goto :goto_199

    .line 228
    :cond_195
    if-lez v10, :cond_199

    .line 229
    add-int/lit8 v10, v10, -0x1

    .line 231
    :cond_199
    :goto_199
    if-gez v13, :cond_19e

    .line 232
    add-int/lit8 v13, v13, 0x1

    goto :goto_1a2

    .line 233
    :cond_19e
    if-lez v13, :cond_1a2

    .line 234
    add-int/lit8 v13, v13, -0x1

    .line 236
    :cond_1a2
    :goto_1a2
    move/from16 v21, v12

    .end local v12    # "srcY":I
    .local v21, "srcY":I
    invoke-static {v5, v1, v10, v14}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v12

    .line 237
    .local v12, "nextW":I
    move/from16 v24, v10

    .end local v10    # "stepsX":I
    .restart local v24    # "stepsX":I
    invoke-static {v7, v2, v13, v6}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v10

    .line 238
    .local v10, "nextH":I
    move/from16 v25, v13

    const/4 v13, 0x0

    .end local v13    # "stepsY":I
    .local v25, "stepsY":I
    invoke-virtual {v8, v13, v13, v12, v10}, Landroid/graphics/Rect;->set(IIII)V

    .line 256
    if-nez v24, :cond_1bb

    if-nez v25, :cond_1bb

    const/16 v16, 0x1

    goto :goto_1bd

    :cond_1bb
    move/from16 v16, v13

    .line 257
    .local v16, "lastStep":Z
    :goto_1bd
    if-eqz v9, :cond_1cd

    .line 258
    invoke-virtual {v9}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v13

    if-ne v13, v1, :cond_1cd

    invoke-virtual {v9}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v13

    if-ne v13, v2, :cond_1cd

    const/4 v13, 0x1

    goto :goto_1ce

    :cond_1cd
    const/4 v13, 0x0

    .line 259
    .local v13, "dstSizeIsFinal":Z
    :goto_1ce
    if-eqz v9, :cond_1f5

    if-eq v9, v0, :cond_1f5

    if-eqz p4, :cond_1e5

    move/from16 v27, v10

    .end local v10    # "nextH":I
    .local v27, "nextH":I
    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    move/from16 v28, v12

    const/16 v12, 0x1b

    .end local v12    # "nextW":I
    .local v28, "nextW":I
    if-lt v10, v12, :cond_1e9

    .line 268
    invoke-static {v9}, Landroidx/core/graphics/BitmapCompat$Api27Impl;->isAlreadyF16AndLinear(Landroid/graphics/Bitmap;)Z

    move-result v10

    if-eqz v10, :cond_1ef

    goto :goto_1e9

    .line 259
    .end local v27    # "nextH":I
    .end local v28    # "nextW":I
    .restart local v10    # "nextH":I
    .restart local v12    # "nextW":I
    :cond_1e5
    move/from16 v27, v10

    move/from16 v28, v12

    .line 268
    .end local v10    # "nextH":I
    .end local v12    # "nextW":I
    .restart local v27    # "nextH":I
    .restart local v28    # "nextW":I
    :cond_1e9
    :goto_1e9
    if-eqz v16, :cond_1f0

    if-eqz v13, :cond_1ef

    if-eqz v22, :cond_1f0

    :cond_1ef
    goto :goto_1f9

    .line 302
    :cond_1f0
    move/from16 v29, v5

    const/16 v5, 0x1b

    goto :goto_232

    .line 259
    .end local v27    # "nextH":I
    .end local v28    # "nextW":I
    .restart local v10    # "nextH":I
    .restart local v12    # "nextW":I
    :cond_1f5
    move/from16 v27, v10

    move/from16 v28, v12

    .line 275
    .end local v10    # "nextH":I
    .end local v12    # "nextW":I
    .restart local v27    # "nextH":I
    .restart local v28    # "nextW":I
    :goto_1f9
    if-eq v9, v0, :cond_200

    if-eqz v9, :cond_200

    .line 276
    invoke-virtual {v9}, Landroid/graphics/Bitmap;->recycle()V

    .line 284
    :cond_200
    move/from16 v10, v22

    .line 285
    .local v10, "lastScratchStep":I
    if-lez v24, :cond_206

    move v12, v10

    goto :goto_208

    :cond_206
    move/from16 v12, v24

    :goto_208
    invoke-static {v5, v1, v12, v14}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v12

    .line 287
    .local v12, "allocW":I
    if-lez v25, :cond_210

    move v1, v10

    goto :goto_212

    :cond_210
    move/from16 v1, v25

    :goto_212
    invoke-static {v7, v2, v1, v6}, Landroidx/core/graphics/BitmapCompat;->sizeAtStep(IIII)I

    move-result v1

    .line 291
    .local v1, "allocH":I
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    move/from16 v29, v5

    const/16 v5, 0x1b

    .end local v5    # "srcW":I
    .local v29, "srcW":I
    if-lt v2, v5, :cond_22a

    .line 292
    if-eqz p4, :cond_224

    if-nez v16, :cond_224

    const/4 v2, 0x1

    goto :goto_225

    :cond_224
    const/4 v2, 0x0

    .line 293
    .local v2, "linear":Z
    :goto_225
    invoke-static {v12, v1, v0, v2}, Landroidx/core/graphics/BitmapCompat$Api27Impl;->createBitmapWithSourceColorspace(IILandroid/graphics/Bitmap;Z)Landroid/graphics/Bitmap;

    move-result-object v9

    .line 295
    .end local v2    # "linear":Z
    goto :goto_232

    .line 296
    :cond_22a
    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v2

    invoke-static {v12, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v9

    .line 302
    .end local v1    # "allocH":I
    .end local v10    # "lastScratchStep":I
    .end local v12    # "allocW":I
    :goto_232
    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v9}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 303
    .local v1, "canvas":Landroid/graphics/Canvas;
    invoke-virtual {v1, v4, v3, v8, v11}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 306
    move-object v2, v4

    .line 307
    .local v2, "swap":Landroid/graphics/Bitmap;
    move-object v4, v9

    .line 308
    move-object v9, v2

    .line 309
    invoke-virtual {v3, v8}, Landroid/graphics/Rect;->set(Landroid/graphics/Rect;)V

    .line 310
    .end local v1    # "canvas":Landroid/graphics/Canvas;
    .end local v2    # "swap":Landroid/graphics/Bitmap;
    .end local v13    # "dstSizeIsFinal":Z
    .end local v16    # "lastStep":Z
    .end local v27    # "nextH":I
    .end local v28    # "nextW":I
    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v12, v21

    move/from16 v13, v25

    move/from16 v5, v29

    move/from16 v10, v24

    goto/16 :goto_183

    .line 135
    .end local v3    # "currRect":Landroid/graphics/Rect;
    .end local v4    # "src":Landroid/graphics/Bitmap;
    .end local v6    # "totalStepsY":I
    .end local v7    # "srcH":I
    .end local v8    # "nextRect":Landroid/graphics/Rect;
    .end local v9    # "dst":Landroid/graphics/Bitmap;
    .end local v11    # "paint":Landroid/graphics/Paint;
    .end local v14    # "totalStepsX":I
    .end local v15    # "srcX":I
    .end local v17    # "log2":D
    .end local v20    # "sx":F
    .end local v21    # "srcY":I
    .end local v22    # "needFinalConversion":Z
    .end local v23    # "sy":F
    .end local v24    # "stepsX":I
    .end local v25    # "stepsY":I
    .end local v29    # "srcW":I
    :cond_24e
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "dstW and dstH must be > 0!"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static getAllocationByteCount(Landroid/graphics/Bitmap;)I
    .registers 2
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "bitmap.getAllocationByteCount()"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 101
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getAllocationByteCount()I

    move-result v0

    return v0
.end method

.method public static hasMipMap(Landroid/graphics/Bitmap;)Z
    .registers 2
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "bitmap.hasMipMap()"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 60
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->hasMipMap()Z

    move-result v0

    return v0
.end method

.method public static setHasMipMap(Landroid/graphics/Bitmap;Z)V
    .registers 2
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .param p1, "hasMipMap"    # Z
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "bitmap.setHasMipMap(hasMipMap)"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 87
    invoke-virtual {p0, p1}, Landroid/graphics/Bitmap;->setHasMipMap(Z)V

    .line 88
    return-void
.end method

.method static sizeAtStep(IIII)I
    .registers 6
    .param p0, "srcSize"    # I
    .param p1, "dstSize"    # I
    .param p2, "step"    # I
    .param p3, "totalSteps"    # I

    .line 324
    if-nez p2, :cond_3

    .line 325
    return p1

    .line 326
    :cond_3
    const/4 v0, 0x1

    if-lez p2, :cond_b

    .line 327
    sub-int v1, p3, p2

    shl-int/2addr v0, v1

    mul-int/2addr v0, p0

    return v0

    .line 329
    :cond_b
    neg-int v1, p2

    sub-int/2addr v1, v0

    shl-int v0, p1, v1

    return v0
.end method
