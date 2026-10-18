.class public Landroidx/appcompat/widget/AppCompatImageView;
.super Landroid/widget/ImageView;
.source "AppCompatImageView.java"

# interfaces
.implements Landroidx/core/view/TintableBackgroundView;
.implements Landroidx/core/widget/TintableImageSourceView;


# instance fields
.field private final mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

.field private mHasLevel:Z

.field private final mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3
    .param p1, "context"    # Landroid/content/Context;

    .line 69
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/appcompat/widget/AppCompatImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 70
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 73
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Landroidx/appcompat/widget/AppCompatImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 74
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 78
    invoke-static {p1}, Landroidx/appcompat/widget/TintContextWrapper;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 66
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mHasLevel:Z

    .line 80
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatImageView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {p0, v0}, Landroidx/appcompat/widget/ThemeUtils;->checkAppCompatTheme(Landroid/view/View;Landroid/content/Context;)V

    .line 82
    new-instance v0, Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-direct {v0, p0}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;-><init>(Landroid/view/View;)V

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    .line 83
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0, p2, p3}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->loadFromAttributes(Landroid/util/AttributeSet;I)V

    .line 85
    new-instance v0, Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-direct {v0, p0}, Landroidx/appcompat/widget/AppCompatImageHelper;-><init>(Landroid/widget/ImageView;)V

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    .line 86
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0, p2, p3}, Landroidx/appcompat/widget/AppCompatImageHelper;->loadFromAttributes(Landroid/util/AttributeSet;I)V

    .line 87
    return-void
.end method


# virtual methods
.method protected drawableStateChanged()V
    .registers 2

    .line 260
    invoke-super {p0}, Landroid/widget/ImageView;->drawableStateChanged()V

    .line 261
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_c

    .line 262
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->applySupportBackgroundTint()V

    .line 264
    :cond_c
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_15

    .line 265
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->applySupportImageTint()V

    .line 267
    :cond_15
    return-void
.end method

.method public getSupportBackgroundTintList()Landroid/content/res/ColorStateList;
    .registers 2

    .line 176
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_b

    .line 177
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->getSupportBackgroundTintList()Landroid/content/res/ColorStateList;

    move-result-object v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    .line 176
    :goto_c
    return-object v0
.end method

.method public getSupportBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;
    .registers 2

    .line 202
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_b

    .line 203
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->getSupportBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    .line 202
    :goto_c
    return-object v0
.end method

.method public getSupportImageTintList()Landroid/content/res/ColorStateList;
    .registers 2

    .line 228
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_b

    .line 229
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->getSupportImageTintList()Landroid/content/res/ColorStateList;

    move-result-object v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    .line 228
    :goto_c
    return-object v0
.end method

.method public getSupportImageTintMode()Landroid/graphics/PorterDuff$Mode;
    .registers 2

    .line 254
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_b

    .line 255
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->getSupportImageTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v0

    goto :goto_c

    :cond_b
    const/4 v0, 0x0

    .line 254
    :goto_c
    return-object v0
.end method

.method public hasOverlappingRendering()Z
    .registers 2

    .line 271
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->hasOverlappingRendering()Z

    move-result v0

    if-eqz v0, :cond_10

    invoke-super {p0}, Landroid/widget/ImageView;->hasOverlappingRendering()Z

    move-result v0

    if-eqz v0, :cond_10

    const/4 v0, 0x1

    goto :goto_11

    :cond_10
    const/4 v0, 0x0

    :goto_11
    return v0
.end method

.method public setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    .registers 3
    .param p1, "background"    # Landroid/graphics/drawable/Drawable;

    .line 148
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 149
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_c

    .line 150
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->onSetBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 152
    :cond_c
    return-void
.end method

.method public setBackgroundResource(I)V
    .registers 3
    .param p1, "resId"    # I

    .line 140
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 141
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_c

    .line 142
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->onSetBackgroundResource(I)V

    .line 144
    :cond_c
    return-void
.end method

.method public setImageBitmap(Landroid/graphics/Bitmap;)V
    .registers 3
    .param p1, "bm"    # Landroid/graphics/Bitmap;

    .line 124
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    .line 125
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_c

    .line 126
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->applySupportImageTint()V

    .line 128
    :cond_c
    return-void
.end method

.method public setImageDrawable(Landroid/graphics/drawable/Drawable;)V
    .registers 3
    .param p1, "drawable"    # Landroid/graphics/drawable/Drawable;

    .line 108
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_f

    if-eqz p1, :cond_f

    iget-boolean v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mHasLevel:Z

    if-nez v0, :cond_f

    .line 110
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatImageHelper;->obtainLevelFromDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 112
    :cond_f
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 113
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_24

    .line 114
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->applySupportImageTint()V

    .line 115
    iget-boolean v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mHasLevel:Z

    if-nez v0, :cond_24

    .line 117
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->applyImageLevel()V

    .line 120
    :cond_24
    return-void
.end method

.method public setImageLevel(I)V
    .registers 3
    .param p1, "level"    # I

    .line 276
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageLevel(I)V

    .line 277
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mHasLevel:Z

    .line 278
    return-void
.end method

.method public setImageResource(I)V
    .registers 3
    .param p1, "resId"    # I

    .line 100
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_9

    .line 102
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatImageHelper;->setImageResource(I)V

    .line 104
    :cond_9
    return-void
.end method

.method public setImageURI(Landroid/net/Uri;)V
    .registers 3
    .param p1, "uri"    # Landroid/net/Uri;

    .line 132
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setImageURI(Landroid/net/Uri;)V

    .line 133
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_c

    .line 134
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatImageHelper;->applySupportImageTint()V

    .line 136
    :cond_c
    return-void
.end method

.method public setSupportBackgroundTintList(Landroid/content/res/ColorStateList;)V
    .registers 3
    .param p1, "tint"    # Landroid/content/res/ColorStateList;

    .line 162
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_9

    .line 163
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->setSupportBackgroundTintList(Landroid/content/res/ColorStateList;)V

    .line 165
    :cond_9
    return-void
.end method

.method public setSupportBackgroundTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .registers 3
    .param p1, "tintMode"    # Landroid/graphics/PorterDuff$Mode;

    .line 188
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    if-eqz v0, :cond_9

    .line 189
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mBackgroundTintHelper:Landroidx/appcompat/widget/AppCompatBackgroundHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatBackgroundHelper;->setSupportBackgroundTintMode(Landroid/graphics/PorterDuff$Mode;)V

    .line 191
    :cond_9
    return-void
.end method

.method public setSupportImageTintList(Landroid/content/res/ColorStateList;)V
    .registers 3
    .param p1, "tint"    # Landroid/content/res/ColorStateList;

    .line 214
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_9

    .line 215
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatImageHelper;->setSupportImageTintList(Landroid/content/res/ColorStateList;)V

    .line 217
    :cond_9
    return-void
.end method

.method public setSupportImageTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .registers 3
    .param p1, "tintMode"    # Landroid/graphics/PorterDuff$Mode;

    .line 240
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    if-eqz v0, :cond_9

    .line 241
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatImageView;->mImageHelper:Landroidx/appcompat/widget/AppCompatImageHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatImageHelper;->setSupportImageTintMode(Landroid/graphics/PorterDuff$Mode;)V

    .line 243
    :cond_9
    return-void
.end method
