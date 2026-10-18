.class Landroidx/appcompat/widget/AppCompatTextHelper;
.super Ljava/lang/Object;
.source "AppCompatTextHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;,
        Landroidx/appcompat/widget/AppCompatTextHelper$Api24Impl;,
        Landroidx/appcompat/widget/AppCompatTextHelper$Api21Impl;,
        Landroidx/appcompat/widget/AppCompatTextHelper$Api28Impl;
    }
.end annotation


# static fields
.field private static final MONOSPACE:I = 0x3

.field private static final SANS:I = 0x1

.field private static final SERIF:I = 0x2

.field private static final TEXT_FONT_WEIGHT_UNSPECIFIED:I = -0x1


# instance fields
.field private mAsyncFontPending:Z

.field private final mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

.field private mDrawableBottomTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableEndTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableLeftTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableRightTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableStartTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableTint:Landroidx/appcompat/widget/TintInfo;

.field private mDrawableTopTint:Landroidx/appcompat/widget/TintInfo;

.field private mFontTypeface:Landroid/graphics/Typeface;

.field private mFontWeight:I

.field private mStyle:I

.field private final mView:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/widget/TextView;)V
    .registers 4
    .param p1, "view"    # Landroid/widget/TextView;

    .line 81
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 76
    const/4 v0, 0x0

    iput v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    .line 77
    const/4 v0, -0x1

    iput v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    .line 82
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    .line 83
    new-instance v0, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-direct {v0, v1}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;-><init>(Landroid/widget/TextView;)V

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    .line 84
    return-void
.end method

.method private applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V
    .registers 4
    .param p1, "drawable"    # Landroid/graphics/drawable/Drawable;
    .param p2, "info"    # Landroidx/appcompat/widget/TintInfo;

    .line 556
    if-eqz p1, :cond_d

    if-eqz p2, :cond_d

    .line 557
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getDrawableState()[I

    move-result-object v0

    invoke-static {p1, p2, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->tintDrawable(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;[I)V

    .line 559
    :cond_d
    return-void
.end method

.method private static createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;
    .registers 6
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "drawableManager"    # Landroidx/appcompat/widget/AppCompatDrawableManager;
    .param p2, "drawableId"    # I

    .line 563
    invoke-virtual {p1, p0, p2}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getTintList(Landroid/content/Context;I)Landroid/content/res/ColorStateList;

    move-result-object v0

    .line 564
    .local v0, "tintList":Landroid/content/res/ColorStateList;
    if-eqz v0, :cond_11

    .line 565
    new-instance v1, Landroidx/appcompat/widget/TintInfo;

    invoke-direct {v1}, Landroidx/appcompat/widget/TintInfo;-><init>()V

    .line 566
    .local v1, "tintInfo":Landroidx/appcompat/widget/TintInfo;
    const/4 v2, 0x1

    iput-boolean v2, v1, Landroidx/appcompat/widget/TintInfo;->mHasTintList:Z

    .line 567
    iput-object v0, v1, Landroidx/appcompat/widget/TintInfo;->mTintList:Landroid/content/res/ColorStateList;

    .line 568
    return-object v1

    .line 570
    .end local v1    # "tintInfo":Landroidx/appcompat/widget/TintInfo;
    :cond_11
    const/4 v1, 0x0

    return-object v1
.end method

.method private setCompoundDrawables(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V
    .registers 14
    .param p1, "drawableLeft"    # Landroid/graphics/drawable/Drawable;
    .param p2, "drawableTop"    # Landroid/graphics/drawable/Drawable;
    .param p3, "drawableRight"    # Landroid/graphics/drawable/Drawable;
    .param p4, "drawableBottom"    # Landroid/graphics/drawable/Drawable;
    .param p5, "drawableStart"    # Landroid/graphics/drawable/Drawable;
    .param p6, "drawableEnd"    # Landroid/graphics/drawable/Drawable;

    .line 683
    const/4 v0, 0x3

    const/4 v1, 0x1

    const/4 v2, 0x2

    const/4 v3, 0x0

    if-nez p5, :cond_5e

    if-eqz p6, :cond_a

    goto/16 :goto_5e

    .line 690
    :cond_a
    if-nez p1, :cond_15

    if-nez p2, :cond_15

    if-nez p3, :cond_15

    if-eqz p4, :cond_13

    goto :goto_15

    :cond_13
    :goto_13
    goto/16 :goto_82

    .line 693
    :cond_15
    :goto_15
    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getCompoundDrawablesRelative()[Landroid/graphics/drawable/Drawable;

    move-result-object v4

    .line 694
    .local v4, "existingRel":[Landroid/graphics/drawable/Drawable;
    aget-object v5, v4, v3

    if-nez v5, :cond_48

    aget-object v5, v4, v2

    if-eqz v5, :cond_24

    goto :goto_48

    .line 702
    :cond_24
    iget-object v5, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v5}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v5

    .line 703
    .local v5, "existingAbs":[Landroid/graphics/drawable/Drawable;
    iget-object v6, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    .line 704
    if-eqz p1, :cond_30

    move-object v3, p1

    goto :goto_32

    :cond_30
    aget-object v3, v5, v3

    .line 705
    :goto_32
    if-eqz p2, :cond_36

    move-object v1, p2

    goto :goto_38

    :cond_36
    aget-object v1, v5, v1

    .line 706
    :goto_38
    if-eqz p3, :cond_3c

    move-object v2, p3

    goto :goto_3e

    :cond_3c
    aget-object v2, v5, v2

    .line 707
    :goto_3e
    if-eqz p4, :cond_42

    move-object v0, p4

    goto :goto_44

    :cond_42
    aget-object v0, v5, v0

    .line 703
    :goto_44
    invoke-virtual {v6, v3, v1, v2, v0}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    goto :goto_82

    .line 695
    .end local v5    # "existingAbs":[Landroid/graphics/drawable/Drawable;
    :cond_48
    :goto_48
    if-eqz p2, :cond_4c

    move-object v1, p2

    goto :goto_4e

    :cond_4c
    aget-object v1, v4, v1

    .line 696
    .local v1, "top":Landroid/graphics/drawable/Drawable;
    :goto_4e
    if-eqz p4, :cond_52

    move-object v0, p4

    goto :goto_54

    :cond_52
    aget-object v0, v4, v0

    .line 697
    .local v0, "bottom":Landroid/graphics/drawable/Drawable;
    :goto_54
    iget-object v5, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    aget-object v3, v4, v3

    aget-object v2, v4, v2

    invoke-virtual {v5, v3, v1, v2, v0}, Landroid/widget/TextView;->setCompoundDrawablesRelativeWithIntrinsicBounds(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .line 699
    return-void

    .line 684
    .end local v0    # "bottom":Landroid/graphics/drawable/Drawable;
    .end local v1    # "top":Landroid/graphics/drawable/Drawable;
    .end local v4    # "existingRel":[Landroid/graphics/drawable/Drawable;
    :cond_5e
    :goto_5e
    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getCompoundDrawablesRelative()[Landroid/graphics/drawable/Drawable;

    move-result-object v4

    .line 685
    .restart local v4    # "existingRel":[Landroid/graphics/drawable/Drawable;
    if-eqz p5, :cond_68

    move-object v3, p5

    goto :goto_6a

    :cond_68
    aget-object v3, v4, v3

    .line 686
    .local v3, "start":Landroid/graphics/drawable/Drawable;
    :goto_6a
    if-eqz p2, :cond_6e

    move-object v1, p2

    goto :goto_70

    :cond_6e
    aget-object v1, v4, v1

    .line 687
    .restart local v1    # "top":Landroid/graphics/drawable/Drawable;
    :goto_70
    if-eqz p6, :cond_74

    move-object v2, p6

    goto :goto_76

    :cond_74
    aget-object v2, v4, v2

    .line 688
    .local v2, "end":Landroid/graphics/drawable/Drawable;
    :goto_76
    iget-object v5, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    .line 689
    if-eqz p4, :cond_7c

    move-object v0, p4

    goto :goto_7e

    :cond_7c
    aget-object v0, v4, v0

    .line 688
    :goto_7e
    invoke-virtual {v5, v3, v1, v2, v0}, Landroid/widget/TextView;->setCompoundDrawablesRelativeWithIntrinsicBounds(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .end local v1    # "top":Landroid/graphics/drawable/Drawable;
    .end local v2    # "end":Landroid/graphics/drawable/Drawable;
    .end local v3    # "start":Landroid/graphics/drawable/Drawable;
    .end local v4    # "existingRel":[Landroid/graphics/drawable/Drawable;
    goto :goto_13

    .line 710
    :goto_82
    return-void
.end method

.method private setCompoundTints()V
    .registers 2

    .line 671
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableLeftTint:Landroidx/appcompat/widget/TintInfo;

    .line 672
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTopTint:Landroidx/appcompat/widget/TintInfo;

    .line 673
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableRightTint:Landroidx/appcompat/widget/TintInfo;

    .line 674
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableBottomTint:Landroidx/appcompat/widget/TintInfo;

    .line 675
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableStartTint:Landroidx/appcompat/widget/TintInfo;

    .line 676
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableEndTint:Landroidx/appcompat/widget/TintInfo;

    .line 677
    return-void
.end method

.method private setTextSizeInternal(IF)V
    .registers 4
    .param p1, "unit"    # I
    .param p2, "size"    # F

    .line 600
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0, p1, p2}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->setTextSizeInternal(IF)V

    .line 601
    return-void
.end method

.method private updateTypefaceAndStyle(Landroid/content/Context;Landroidx/appcompat/widget/TintTypedArray;)V
    .registers 16
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "a"    # Landroidx/appcompat/widget/TintTypedArray;

    .line 359
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_textStyle:I

    iget v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-virtual {p2, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v0

    iput v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    .line 361
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/16 v3, 0x1c

    if-lt v0, v3, :cond_25

    .line 362
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_textFontWeight:I

    invoke-virtual {p2, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v0

    iput v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    .line 364
    iget v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    if-eq v0, v1, :cond_25

    .line 365
    iget v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    and-int/lit8 v0, v0, 0x2

    or-int/2addr v0, v2

    iput v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    .line 369
    :cond_25
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_fontFamily:I

    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v0

    const/4 v4, 0x1

    if-nez v0, :cond_5b

    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_fontFamily:I

    .line 370
    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v0

    if-eqz v0, :cond_37

    goto :goto_5b

    .line 432
    :cond_37
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_typeface:I

    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v0

    if-eqz v0, :cond_5a

    .line 434
    iput-boolean v2, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAsyncFontPending:Z

    .line 435
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_typeface:I

    invoke-virtual {p2, v0, v4}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v0

    .line 436
    .local v0, "typefaceIndex":I
    packed-switch v0, :pswitch_data_e8

    goto :goto_5a

    .line 446
    :pswitch_4b
    sget-object v1, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    iput-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    goto :goto_5a

    .line 442
    :pswitch_50
    sget-object v1, Landroid/graphics/Typeface;->SERIF:Landroid/graphics/Typeface;

    iput-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 443
    goto :goto_5a

    .line 438
    :pswitch_55
    sget-object v1, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    iput-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 439
    nop

    .line 450
    .end local v0    # "typefaceIndex":I
    :cond_5a
    :goto_5a
    return-void

    .line 371
    :cond_5b
    :goto_5b
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 372
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_fontFamily:I

    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v0

    if-eqz v0, :cond_69

    .line 373
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_fontFamily:I

    goto :goto_6b

    .line 374
    :cond_69
    sget v0, Landroidx/appcompat/R$styleable;->TextAppearance_android_fontFamily:I

    :goto_6b
    nop

    .line 375
    .local v0, "fontFamilyId":I
    iget v5, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    .line 376
    .local v5, "fontWeight":I
    iget v6, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    .line 377
    .local v6, "style":I
    invoke-virtual {p1}, Landroid/content/Context;->isRestricted()Z

    move-result v7

    if-nez v7, :cond_b8

    .line 378
    new-instance v7, Ljava/lang/ref/WeakReference;

    iget-object v8, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-direct {v7, v8}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    .line 379
    .local v7, "textViewWeak":Ljava/lang/ref/WeakReference;, "Ljava/lang/ref/WeakReference<Landroid/widget/TextView;>;"
    new-instance v8, Landroidx/appcompat/widget/AppCompatTextHelper$1;

    invoke-direct {v8, p0, v5, v6, v7}, Landroidx/appcompat/widget/AppCompatTextHelper$1;-><init>(Landroidx/appcompat/widget/AppCompatTextHelper;IILjava/lang/ref/WeakReference;)V

    .line 398
    .local v8, "replyCallback":Landroidx/core/content/res/ResourcesCompat$FontCallback;
    :try_start_82
    iget v9, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-virtual {p2, v0, v9, v8}, Landroidx/appcompat/widget/TintTypedArray;->getFont(IILandroidx/core/content/res/ResourcesCompat$FontCallback;)Landroid/graphics/Typeface;

    move-result-object v9

    .line 399
    .local v9, "typeface":Landroid/graphics/Typeface;
    if-eqz v9, :cond_ab

    .line 400
    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v10, v3, :cond_a9

    iget v10, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    if-eq v10, v1, :cond_a9

    .line 402
    nop

    .line 403
    invoke-static {v9, v2}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v10

    iget v11, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    iget v12, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    and-int/lit8 v12, v12, 0x2

    if-eqz v12, :cond_a1

    move v12, v4

    goto :goto_a2

    :cond_a1
    move v12, v2

    .line 402
    :goto_a2
    invoke-static {v10, v11, v12}, Landroidx/appcompat/widget/AppCompatTextHelper$Api28Impl;->create(Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;

    move-result-object v10

    iput-object v10, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    goto :goto_ab

    .line 406
    :cond_a9
    iput-object v9, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 410
    :cond_ab
    :goto_ab
    iget-object v10, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    if-nez v10, :cond_b1

    move v10, v4

    goto :goto_b2

    :cond_b1
    move v10, v2

    :goto_b2
    iput-boolean v10, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAsyncFontPending:Z
    :try_end_b4
    .catch Ljava/lang/UnsupportedOperationException; {:try_start_82 .. :try_end_b4} :catch_b7
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_82 .. :try_end_b4} :catch_b5

    .line 413
    .end local v9    # "typeface":Landroid/graphics/Typeface;
    goto :goto_b8

    .line 411
    :catch_b5
    move-exception v9

    goto :goto_b8

    :catch_b7
    move-exception v9

    .line 415
    .end local v7    # "textViewWeak":Ljava/lang/ref/WeakReference;, "Ljava/lang/ref/WeakReference<Landroid/widget/TextView;>;"
    .end local v8    # "replyCallback":Landroidx/core/content/res/ResourcesCompat$FontCallback;
    :cond_b8
    :goto_b8
    iget-object v7, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    if-nez v7, :cond_e7

    .line 417
    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 418
    .local v7, "fontFamilyName":Ljava/lang/String;
    if-eqz v7, :cond_e7

    .line 419
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v8, v3, :cond_df

    iget v3, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    if-eq v3, v1, :cond_df

    .line 421
    nop

    .line 422
    invoke-static {v7, v2}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v1

    iget v3, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    iget v8, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    and-int/lit8 v8, v8, 0x2

    if-eqz v8, :cond_d8

    move v2, v4

    .line 421
    :cond_d8
    invoke-static {v1, v3, v2}, Landroidx/appcompat/widget/AppCompatTextHelper$Api28Impl;->create(Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;

    move-result-object v1

    iput-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    goto :goto_e7

    .line 425
    :cond_df
    iget v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-static {v7, v1}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v1

    iput-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 429
    .end local v7    # "fontFamilyName":Ljava/lang/String;
    :cond_e7
    :goto_e7
    return-void

    :pswitch_data_e8
    .packed-switch 0x1
        :pswitch_55
        :pswitch_50
        :pswitch_4b
    .end packed-switch
.end method


# virtual methods
.method applyCompoundDrawablesTints()V
    .registers 6

    .line 540
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableLeftTint:Landroidx/appcompat/widget/TintInfo;

    const/4 v1, 0x2

    const/4 v2, 0x0

    if-nez v0, :cond_12

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTopTint:Landroidx/appcompat/widget/TintInfo;

    if-nez v0, :cond_12

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableRightTint:Landroidx/appcompat/widget/TintInfo;

    if-nez v0, :cond_12

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableBottomTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz v0, :cond_36

    .line 542
    :cond_12
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getCompoundDrawables()[Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 543
    .local v0, "compoundDrawables":[Landroid/graphics/drawable/Drawable;
    aget-object v3, v0, v2

    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableLeftTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v3, v4}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 544
    const/4 v3, 0x1

    aget-object v3, v0, v3

    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTopTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v3, v4}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 545
    aget-object v3, v0, v1

    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableRightTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v3, v4}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 546
    const/4 v3, 0x3

    aget-object v3, v0, v3

    iget-object v4, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableBottomTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v3, v4}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 548
    .end local v0    # "compoundDrawables":[Landroid/graphics/drawable/Drawable;
    :cond_36
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableStartTint:Landroidx/appcompat/widget/TintInfo;

    if-nez v0, :cond_3e

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableEndTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz v0, :cond_52

    .line 549
    :cond_3e
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getCompoundDrawablesRelative()[Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 550
    .restart local v0    # "compoundDrawables":[Landroid/graphics/drawable/Drawable;
    aget-object v2, v0, v2

    iget-object v3, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableStartTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v2, v3}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 551
    aget-object v1, v0, v1

    iget-object v2, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableEndTint:Landroidx/appcompat/widget/TintInfo;

    invoke-direct {p0, v1, v2}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawableTint(Landroid/graphics/drawable/Drawable;Landroidx/appcompat/widget/TintInfo;)V

    .line 553
    .end local v0    # "compoundDrawables":[Landroid/graphics/drawable/Drawable;
    :cond_52
    return-void
.end method

.method autoSizeText()V
    .registers 2

    .line 591
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->autoSizeText()V

    .line 592
    return-void
.end method

.method getAutoSizeMaxTextSize()I
    .registers 2

    .line 635
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeMaxTextSize()I

    move-result v0

    return v0
.end method

.method getAutoSizeMinTextSize()I
    .registers 2

    .line 631
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeMinTextSize()I

    move-result v0

    return v0
.end method

.method getAutoSizeStepGranularity()I
    .registers 2

    .line 627
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeStepGranularity()I

    move-result v0

    return v0
.end method

.method getAutoSizeTextAvailableSizes()[I
    .registers 2

    .line 639
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeTextAvailableSizes()[I

    move-result-object v0

    return-object v0
.end method

.method getAutoSizeTextType()I
    .registers 2

    .line 623
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeTextType()I

    move-result v0

    return v0
.end method

.method getCompoundDrawableTintList()Landroid/content/res/ColorStateList;
    .registers 2

    .line 644
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz v0, :cond_9

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iget-object v0, v0, Landroidx/appcompat/widget/TintInfo;->mTintList:Landroid/content/res/ColorStateList;

    goto :goto_a

    :cond_9
    const/4 v0, 0x0

    :goto_a
    return-object v0
.end method

.method getCompoundDrawableTintMode()Landroid/graphics/PorterDuff$Mode;
    .registers 2

    .line 658
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz v0, :cond_9

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iget-object v0, v0, Landroidx/appcompat/widget/TintInfo;->mTintMode:Landroid/graphics/PorterDuff$Mode;

    goto :goto_a

    :cond_9
    const/4 v0, 0x0

    :goto_a
    return-object v0
.end method

.method isAutoSizeEnabled()Z
    .registers 2

    .line 596
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->isAutoSizeEnabled()Z

    move-result v0

    return v0
.end method

.method loadFromAttributes(Landroid/util/AttributeSet;I)V
    .registers 39
    .param p1, "attrs"    # Landroid/util/AttributeSet;
    .param p2, "defStyleAttr"    # I

    .line 88
    move-object/from16 v0, p0

    move-object/from16 v4, p1

    move/from16 v6, p2

    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v8

    .line 89
    .local v8, "context":Landroid/content/Context;
    invoke-static {}, Landroidx/appcompat/widget/AppCompatDrawableManager;->get()Landroidx/appcompat/widget/AppCompatDrawableManager;

    move-result-object v9

    .line 92
    .local v9, "drawableManager":Landroidx/appcompat/widget/AppCompatDrawableManager;
    sget-object v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper:[I

    const/4 v10, 0x0

    invoke-static {v8, v4, v1, v6, v10}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;Landroid/util/AttributeSet;[III)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v11

    .line 94
    .local v11, "a":Landroidx/appcompat/widget/TintTypedArray;
    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroidx/appcompat/R$styleable;->AppCompatTextHelper:[I

    .line 95
    invoke-virtual {v11}, Landroidx/appcompat/widget/TintTypedArray;->getWrappedTypeArray()Landroid/content/res/TypedArray;

    move-result-object v5

    .line 94
    const/4 v7, 0x0

    invoke-static/range {v1 .. v7}, Landroidx/core/view/ViewCompat;->saveAttributeDataForStyleable(Landroid/view/View;Landroid/content/Context;[ILandroid/util/AttributeSet;Landroid/content/res/TypedArray;II)V

    .line 98
    move-object v7, v4

    move v12, v6

    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_textAppearance:I

    const/4 v13, -0x1

    invoke-virtual {v11, v1, v13}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v14

    .line 100
    .local v14, "ap":I
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableLeft:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_46

    .line 101
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableLeft:I

    .line 102
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 101
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableLeftTint:Landroidx/appcompat/widget/TintInfo;

    .line 104
    :cond_46
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableTop:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_5a

    .line 105
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableTop:I

    .line 106
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 105
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTopTint:Landroidx/appcompat/widget/TintInfo;

    .line 108
    :cond_5a
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableRight:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_6e

    .line 109
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableRight:I

    .line 110
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 109
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableRightTint:Landroidx/appcompat/widget/TintInfo;

    .line 112
    :cond_6e
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableBottom:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_82

    .line 113
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableBottom:I

    .line 114
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 113
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableBottomTint:Landroidx/appcompat/widget/TintInfo;

    .line 116
    :cond_82
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableStart:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_96

    .line 117
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableStart:I

    .line 118
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 117
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableStartTint:Landroidx/appcompat/widget/TintInfo;

    .line 120
    :cond_96
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableEnd:I

    invoke-virtual {v11, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_aa

    .line 121
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextHelper_android_drawableEnd:I

    .line 122
    invoke-virtual {v11, v1, v10}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v1

    .line 121
    invoke-static {v8, v9, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->createTintInfo(Landroid/content/Context;Landroidx/appcompat/widget/AppCompatDrawableManager;I)Landroidx/appcompat/widget/TintInfo;

    move-result-object v1

    iput-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableEndTint:Landroidx/appcompat/widget/TintInfo;

    .line 125
    :cond_aa
    invoke-virtual {v11}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 130
    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    .line 131
    invoke-virtual {v1}, Landroid/widget/TextView;->getTransformationMethod()Landroid/text/method/TransformationMethod;

    move-result-object v1

    instance-of v15, v1, Landroid/text/method/PasswordTransformationMethod;

    .line 132
    .local v15, "hasPwdTm":Z
    const/4 v1, 0x0

    .line 133
    .local v1, "allCaps":Z
    const/4 v2, 0x0

    .line 134
    .local v2, "allCapsSet":Z
    const/4 v3, 0x0

    .line 135
    .local v3, "textColor":Landroid/content/res/ColorStateList;
    const/4 v4, 0x0

    .line 136
    .local v4, "textColorHint":Landroid/content/res/ColorStateList;
    const/4 v5, 0x0

    .line 137
    .local v5, "textColorLink":Landroid/content/res/ColorStateList;
    const/4 v6, 0x0

    .line 138
    .local v6, "fontVariation":Ljava/lang/String;
    const/16 v16, 0x0

    .line 141
    .local v16, "localeListString":Ljava/lang/String;
    if-eq v14, v13, :cond_102

    .line 142
    sget-object v13, Landroidx/appcompat/R$styleable;->TextAppearance:[I

    invoke-static {v8, v14, v13}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;I[I)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v11

    .line 143
    if-nez v15, :cond_d7

    sget v13, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    invoke-virtual {v11, v13}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v13

    if-eqz v13, :cond_d7

    .line 144
    const/4 v2, 0x1

    .line 145
    sget v13, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    const/4 v10, 0x0

    invoke-virtual {v11, v13, v10}, Landroidx/appcompat/widget/TintTypedArray;->getBoolean(IZ)Z

    move-result v1

    .line 148
    :cond_d7
    invoke-direct {v0, v8, v11}, Landroidx/appcompat/widget/AppCompatTextHelper;->updateTypefaceAndStyle(Landroid/content/Context;Landroidx/appcompat/widget/TintTypedArray;)V

    .line 149
    nop

    .line 164
    sget v10, Landroidx/appcompat/R$styleable;->TextAppearance_textLocale:I

    invoke-virtual {v11, v10}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v10

    if-eqz v10, :cond_eb

    .line 165
    sget v10, Landroidx/appcompat/R$styleable;->TextAppearance_textLocale:I

    invoke-virtual {v11, v10}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v16, v10

    .line 167
    :cond_eb
    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v13, 0x1a

    if-lt v10, v13, :cond_ff

    sget v10, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    .line 168
    invoke-virtual {v11, v10}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v10

    if-eqz v10, :cond_ff

    .line 169
    sget v10, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    invoke-virtual {v11, v10}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 171
    :cond_ff
    invoke-virtual {v11}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 175
    :cond_102
    sget-object v10, Landroidx/appcompat/R$styleable;->TextAppearance:[I

    const/4 v13, 0x0

    invoke-static {v8, v7, v10, v12, v13}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;Landroid/util/AttributeSet;[III)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v10

    .line 177
    .end local v11    # "a":Landroidx/appcompat/widget/TintTypedArray;
    .local v10, "a":Landroidx/appcompat/widget/TintTypedArray;
    if-nez v15, :cond_11d

    sget v11, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    invoke-virtual {v10, v11}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v11

    if-eqz v11, :cond_11d

    .line 178
    const/4 v2, 0x1

    .line 179
    sget v11, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    invoke-virtual {v10, v11, v13}, Landroidx/appcompat/widget/TintTypedArray;->getBoolean(IZ)Z

    move-result v1

    move v11, v1

    move v13, v2

    goto :goto_11f

    .line 181
    :cond_11d
    move v11, v1

    move v13, v2

    .end local v1    # "allCaps":Z
    .end local v2    # "allCapsSet":Z
    .local v11, "allCaps":Z
    .local v13, "allCapsSet":Z
    :goto_11f
    nop

    .line 196
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_textLocale:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_12e

    .line 197
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_textLocale:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 200
    :cond_12e
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_144

    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    .line 201
    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_144

    .line 202
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    move-object v1, v6

    goto :goto_145

    .line 205
    :cond_144
    move-object v1, v6

    .end local v6    # "fontVariation":Ljava/lang/String;
    .local v1, "fontVariation":Ljava/lang/String;
    :goto_145
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1c

    if-lt v2, v6, :cond_16c

    sget v2, Landroidx/appcompat/R$styleable;->TextAppearance_android_textSize:I

    .line 206
    invoke-virtual {v10, v2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v2

    if-eqz v2, :cond_169

    .line 207
    sget v2, Landroidx/appcompat/R$styleable;->TextAppearance_android_textSize:I

    const/4 v6, -0x1

    invoke-virtual {v10, v2, v6}, Landroidx/appcompat/widget/TintTypedArray;->getDimensionPixelSize(II)I

    move-result v2

    if-nez v2, :cond_166

    .line 208
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    const/4 v6, 0x0

    move/from16 v19, v13

    const/4 v13, 0x0

    .end local v13    # "allCapsSet":Z
    .local v19, "allCapsSet":Z
    invoke-virtual {v2, v13, v6}, Landroid/widget/TextView;->setTextSize(IF)V

    goto :goto_16e

    .line 207
    .end local v19    # "allCapsSet":Z
    .restart local v13    # "allCapsSet":Z
    :cond_166
    move/from16 v19, v13

    .end local v13    # "allCapsSet":Z
    .restart local v19    # "allCapsSet":Z
    goto :goto_16e

    .line 206
    .end local v19    # "allCapsSet":Z
    .restart local v13    # "allCapsSet":Z
    :cond_169
    move/from16 v19, v13

    .end local v13    # "allCapsSet":Z
    .restart local v19    # "allCapsSet":Z
    goto :goto_16e

    .line 205
    .end local v19    # "allCapsSet":Z
    .restart local v13    # "allCapsSet":Z
    :cond_16c
    move/from16 v19, v13

    .line 212
    .end local v13    # "allCapsSet":Z
    .restart local v19    # "allCapsSet":Z
    :goto_16e
    invoke-direct {v0, v8, v10}, Landroidx/appcompat/widget/AppCompatTextHelper;->updateTypefaceAndStyle(Landroid/content/Context;Landroidx/appcompat/widget/TintTypedArray;)V

    .line 213
    invoke-virtual {v10}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 215
    if-eqz v3, :cond_17b

    .line 216
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(Landroid/content/res/ColorStateList;)V

    .line 218
    :cond_17b
    if-eqz v4, :cond_182

    .line 219
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setHintTextColor(Landroid/content/res/ColorStateList;)V

    .line 221
    :cond_182
    if-eqz v5, :cond_189

    .line 222
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setLinkTextColor(Landroid/content/res/ColorStateList;)V

    .line 224
    :cond_189
    if-nez v15, :cond_190

    if-eqz v19, :cond_190

    .line 225
    invoke-virtual {v0, v11}, Landroidx/appcompat/widget/AppCompatTextHelper;->setAllCaps(Z)V

    .line 227
    :cond_190
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    if-eqz v2, :cond_1aa

    .line 228
    iget v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontWeight:I

    const/4 v6, -0x1

    if-ne v2, v6, :cond_1a3

    .line 229
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    iget-object v6, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    iget v13, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-virtual {v2, v6, v13}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    goto :goto_1aa

    .line 231
    :cond_1a3
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    iget-object v6, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    invoke-virtual {v2, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 234
    :cond_1aa
    :goto_1aa
    if-eqz v1, :cond_1b1

    .line 235
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v2, v1}, Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;->setFontVariationSettings(Landroid/widget/TextView;Ljava/lang/String;)Z

    .line 237
    :cond_1b1
    if-eqz v16, :cond_1bd

    .line 238
    nop

    .line 239
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static/range {v16 .. v16}, Landroidx/appcompat/widget/AppCompatTextHelper$Api24Impl;->forLanguageTags(Ljava/lang/String;)Landroid/os/LocaleList;

    move-result-object v6

    invoke-static {v2, v6}, Landroidx/appcompat/widget/AppCompatTextHelper$Api24Impl;->setTextLocales(Landroid/widget/TextView;Landroid/os/LocaleList;)V

    .line 247
    :cond_1bd
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v2, v7, v12}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->loadFromAttributes(Landroid/util/AttributeSet;I)V

    .line 249
    sget-boolean v2, Landroidx/appcompat/widget/ViewUtils;->SDK_LEVEL_SUPPORTS_AUTOSIZE:Z

    const/high16 v13, -0x40800000    # -1.0f

    if-eqz v2, :cond_226

    .line 251
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v2}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeTextType()I

    move-result v2

    if-eqz v2, :cond_21d

    .line 253
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    .line 254
    invoke-virtual {v2}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeTextAvailableSizes()[I

    move-result-object v2

    .line 255
    .local v2, "autoSizeTextSizesInPx":[I
    array-length v6, v2

    if-lez v6, :cond_214

    .line 256
    iget-object v6, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v6}, Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;->getAutoSizeStepGranularity(Landroid/widget/TextView;)I

    move-result v6

    int-to-float v6, v6

    cmpl-float v6, v6, v13

    if-eqz v6, :cond_205

    .line 260
    iget-object v6, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    move/from16 v20, v13

    iget-object v13, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    .line 261
    invoke-virtual {v13}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeMinTextSize()I

    move-result v13

    move-object/from16 v21, v1

    .end local v1    # "fontVariation":Ljava/lang/String;
    .local v21, "fontVariation":Ljava/lang/String;
    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    .line 262
    invoke-virtual {v1}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeMaxTextSize()I

    move-result v1

    move-object/from16 v22, v3

    .end local v3    # "textColor":Landroid/content/res/ColorStateList;
    .local v22, "textColor":Landroid/content/res/ColorStateList;
    iget-object v3, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    .line 263
    invoke-virtual {v3}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->getAutoSizeStepGranularity()I

    move-result v3

    .line 260
    move-object/from16 v23, v4

    const/4 v4, 0x0

    .end local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    .local v23, "textColorHint":Landroid/content/res/ColorStateList;
    invoke-static {v6, v13, v1, v3, v4}, Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;->setAutoSizeTextTypeUniformWithConfiguration(Landroid/widget/TextView;IIII)V

    goto :goto_22e

    .line 266
    .end local v21    # "fontVariation":Ljava/lang/String;
    .end local v22    # "textColor":Landroid/content/res/ColorStateList;
    .end local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v1    # "fontVariation":Ljava/lang/String;
    .restart local v3    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    :cond_205
    move-object/from16 v21, v1

    move-object/from16 v22, v3

    move-object/from16 v23, v4

    move/from16 v20, v13

    const/4 v4, 0x0

    .end local v1    # "fontVariation":Ljava/lang/String;
    .end local v3    # "textColor":Landroid/content/res/ColorStateList;
    .end local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v21    # "fontVariation":Ljava/lang/String;
    .restart local v22    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v1, v2, v4}, Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;->setAutoSizeTextTypeUniformWithPresetSizes(Landroid/widget/TextView;[II)V

    goto :goto_22e

    .line 255
    .end local v21    # "fontVariation":Ljava/lang/String;
    .end local v22    # "textColor":Landroid/content/res/ColorStateList;
    .end local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v1    # "fontVariation":Ljava/lang/String;
    .restart local v3    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    :cond_214
    move-object/from16 v21, v1

    move-object/from16 v22, v3

    move-object/from16 v23, v4

    move/from16 v20, v13

    .end local v1    # "fontVariation":Ljava/lang/String;
    .end local v3    # "textColor":Landroid/content/res/ColorStateList;
    .end local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v21    # "fontVariation":Ljava/lang/String;
    .restart local v22    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    goto :goto_22e

    .line 251
    .end local v2    # "autoSizeTextSizesInPx":[I
    .end local v21    # "fontVariation":Ljava/lang/String;
    .end local v22    # "textColor":Landroid/content/res/ColorStateList;
    .end local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v1    # "fontVariation":Ljava/lang/String;
    .restart local v3    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    :cond_21d
    move-object/from16 v21, v1

    move-object/from16 v22, v3

    move-object/from16 v23, v4

    move/from16 v20, v13

    .end local v1    # "fontVariation":Ljava/lang/String;
    .end local v3    # "textColor":Landroid/content/res/ColorStateList;
    .end local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v21    # "fontVariation":Ljava/lang/String;
    .restart local v22    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    goto :goto_22e

    .line 249
    .end local v21    # "fontVariation":Ljava/lang/String;
    .end local v22    # "textColor":Landroid/content/res/ColorStateList;
    .end local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v1    # "fontVariation":Ljava/lang/String;
    .restart local v3    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    :cond_226
    move-object/from16 v21, v1

    move-object/from16 v22, v3

    move-object/from16 v23, v4

    move/from16 v20, v13

    .line 274
    .end local v1    # "fontVariation":Ljava/lang/String;
    .end local v3    # "textColor":Landroid/content/res/ColorStateList;
    .end local v4    # "textColorHint":Landroid/content/res/ColorStateList;
    .restart local v21    # "fontVariation":Ljava/lang/String;
    .restart local v22    # "textColor":Landroid/content/res/ColorStateList;
    .restart local v23    # "textColorHint":Landroid/content/res/ColorStateList;
    :goto_22e
    sget-object v1, Landroidx/appcompat/R$styleable;->AppCompatTextView:[I

    invoke-static {v8, v7, v1}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;Landroid/util/AttributeSet;[I)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v10

    .line 277
    const/4 v1, 0x0

    .local v1, "drawableLeft":Landroid/graphics/drawable/Drawable;
    const/4 v2, 0x0

    .local v2, "drawableTop":Landroid/graphics/drawable/Drawable;
    const/4 v3, 0x0

    .line 278
    .local v3, "drawableRight":Landroid/graphics/drawable/Drawable;
    const/4 v4, 0x0

    .local v4, "drawableBottom":Landroid/graphics/drawable/Drawable;
    const/4 v6, 0x0

    .local v6, "drawableStart":Landroid/graphics/drawable/Drawable;
    const/4 v13, 0x0

    .line 279
    .local v13, "drawableEnd":Landroid/graphics/drawable/Drawable;
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableLeftCompat:I

    move-object/from16 v17, v1

    const/4 v1, -0x1

    .end local v1    # "drawableLeft":Landroid/graphics/drawable/Drawable;
    .local v17, "drawableLeft":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 281
    .local v0, "drawableLeftId":I
    if-eq v0, v1, :cond_249

    .line 282
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v17

    .line 284
    :cond_249
    move/from16 v24, v0

    .end local v0    # "drawableLeftId":I
    .local v24, "drawableLeftId":I
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableTopCompat:I

    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 286
    .local v0, "drawableTopId":I
    if-eq v0, v1, :cond_257

    .line 287
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 289
    :cond_257
    move/from16 v25, v0

    .end local v0    # "drawableTopId":I
    .local v25, "drawableTopId":I
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableRightCompat:I

    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 291
    .local v0, "drawableRightId":I
    if-eq v0, v1, :cond_265

    .line 292
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 294
    :cond_265
    move/from16 v26, v0

    .end local v0    # "drawableRightId":I
    .local v26, "drawableRightId":I
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableBottomCompat:I

    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 296
    .local v0, "drawableBottomId":I
    if-eq v0, v1, :cond_273

    .line 297
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    .line 299
    :cond_273
    move/from16 v27, v0

    .end local v0    # "drawableBottomId":I
    .local v27, "drawableBottomId":I
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableStartCompat:I

    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 301
    .local v0, "drawableStartId":I
    if-eq v0, v1, :cond_281

    .line 302
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    .line 304
    :cond_281
    move/from16 v28, v0

    .end local v0    # "drawableStartId":I
    .local v28, "drawableStartId":I
    sget v0, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableEndCompat:I

    invoke-virtual {v10, v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result v0

    .line 306
    .local v0, "drawableEndId":I
    if-eq v0, v1, :cond_28f

    .line 307
    invoke-virtual {v9, v8, v0}, Landroidx/appcompat/widget/AppCompatDrawableManager;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    .line 309
    :cond_28f
    move-object v1, v13

    move-object v13, v5

    move-object v5, v6

    move-object v6, v1

    move-object/from16 v1, v17

    move/from16 v17, v0

    move-object/from16 v0, p0

    .end local v0    # "drawableEndId":I
    .restart local v1    # "drawableLeft":Landroid/graphics/drawable/Drawable;
    .local v5, "drawableStart":Landroid/graphics/drawable/Drawable;
    .local v6, "drawableEnd":Landroid/graphics/drawable/Drawable;
    .local v13, "textColorLink":Landroid/content/res/ColorStateList;
    .local v17, "drawableEndId":I
    invoke-direct/range {v0 .. v6}, Landroidx/appcompat/widget/AppCompatTextHelper;->setCompoundDrawables(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    .line 312
    move-object/from16 v29, v1

    .end local v1    # "drawableLeft":Landroid/graphics/drawable/Drawable;
    .local v29, "drawableLeft":Landroid/graphics/drawable/Drawable;
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableTint:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_2b4

    .line 313
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableTint:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    .line 315
    .local v1, "tintList":Landroid/content/res/ColorStateList;
    move-object/from16 v30, v2

    .end local v2    # "drawableTop":Landroid/graphics/drawable/Drawable;
    .local v30, "drawableTop":Landroid/graphics/drawable/Drawable;
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v2, v1}, Landroidx/core/widget/TextViewCompat;->setCompoundDrawableTintList(Landroid/widget/TextView;Landroid/content/res/ColorStateList;)V

    goto :goto_2b6

    .line 312
    .end local v1    # "tintList":Landroid/content/res/ColorStateList;
    .end local v30    # "drawableTop":Landroid/graphics/drawable/Drawable;
    .restart local v2    # "drawableTop":Landroid/graphics/drawable/Drawable;
    :cond_2b4
    move-object/from16 v30, v2

    .line 317
    .end local v2    # "drawableTop":Landroid/graphics/drawable/Drawable;
    .restart local v30    # "drawableTop":Landroid/graphics/drawable/Drawable;
    :goto_2b6
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableTintMode:I

    invoke-virtual {v10, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_2cf

    .line 318
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextView_drawableTintMode:I

    .line 319
    const/4 v2, -0x1

    invoke-virtual {v10, v1, v2}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v1

    .line 318
    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroidx/appcompat/widget/DrawableUtils;->parseTintMode(ILandroid/graphics/PorterDuff$Mode;)Landroid/graphics/PorterDuff$Mode;

    move-result-object v1

    .line 320
    .local v1, "tintMode":Landroid/graphics/PorterDuff$Mode;
    iget-object v2, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v2, v1}, Landroidx/core/widget/TextViewCompat;->setCompoundDrawableTintMode(Landroid/widget/TextView;Landroid/graphics/PorterDuff$Mode;)V

    .line 323
    .end local v1    # "tintMode":Landroid/graphics/PorterDuff$Mode;
    :cond_2cf
    sget v1, Landroidx/appcompat/R$styleable;->AppCompatTextView_firstBaselineToTopHeight:I

    const/4 v2, -0x1

    invoke-virtual {v10, v1, v2}, Landroidx/appcompat/widget/TintTypedArray;->getDimensionPixelSize(II)I

    move-result v1

    .line 325
    .local v1, "firstBaselineToTopHeight":I
    move-object/from16 v31, v3

    .end local v3    # "drawableRight":Landroid/graphics/drawable/Drawable;
    .local v31, "drawableRight":Landroid/graphics/drawable/Drawable;
    sget v3, Landroidx/appcompat/R$styleable;->AppCompatTextView_lastBaselineToBottomHeight:I

    invoke-virtual {v10, v3, v2}, Landroidx/appcompat/widget/TintTypedArray;->getDimensionPixelSize(II)I

    move-result v3

    .line 327
    .local v3, "lastBaselineToBottomHeight":I
    const/high16 v2, -0x40800000    # -1.0f

    .line 328
    .local v2, "lineHeight":F
    const/16 v32, -0x1

    .line 329
    .local v32, "lineHeightUnit":I
    move/from16 v33, v2

    .end local v2    # "lineHeight":F
    .local v33, "lineHeight":F
    sget v2, Landroidx/appcompat/R$styleable;->AppCompatTextView_lineHeight:I

    invoke-virtual {v10, v2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v2

    if-eqz v2, :cond_31e

    .line 330
    sget v2, Landroidx/appcompat/R$styleable;->AppCompatTextView_lineHeight:I

    invoke-virtual {v10, v2}, Landroidx/appcompat/widget/TintTypedArray;->peekValue(I)Landroid/util/TypedValue;

    move-result-object v2

    .line 331
    .local v2, "peekValue":Landroid/util/TypedValue;
    if-eqz v2, :cond_30e

    move-object/from16 v34, v4

    .end local v4    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .local v34, "drawableBottom":Landroid/graphics/drawable/Drawable;
    iget v4, v2, Landroid/util/TypedValue;->type:I

    move-object/from16 v35, v5

    .end local v5    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .local v35, "drawableStart":Landroid/graphics/drawable/Drawable;
    const/4 v5, 0x5

    if-ne v4, v5, :cond_312

    .line 332
    iget v4, v2, Landroid/util/TypedValue;->data:I

    invoke-static {v4}, Landroidx/core/util/TypedValueCompat;->getUnitFromComplexDimension(I)I

    move-result v32

    .line 333
    iget v4, v2, Landroid/util/TypedValue;->data:I

    invoke-static {v4}, Landroid/util/TypedValue;->complexToFloat(I)F

    move-result v4

    move v2, v4

    move/from16 v4, v32

    const/4 v5, -0x1

    .end local v33    # "lineHeight":F
    .local v4, "lineHeight":F
    goto :goto_327

    .line 331
    .end local v34    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .end local v35    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .local v4, "drawableBottom":Landroid/graphics/drawable/Drawable;
    .restart local v5    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .restart local v33    # "lineHeight":F
    :cond_30e
    move-object/from16 v34, v4

    move-object/from16 v35, v5

    .line 335
    .end local v4    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .end local v5    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .restart local v34    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .restart local v35    # "drawableStart":Landroid/graphics/drawable/Drawable;
    :cond_312
    sget v4, Landroidx/appcompat/R$styleable;->AppCompatTextView_lineHeight:I

    const/4 v5, -0x1

    invoke-virtual {v10, v4, v5}, Landroidx/appcompat/widget/TintTypedArray;->getDimensionPixelSize(II)I

    move-result v4

    int-to-float v4, v4

    move v2, v4

    move/from16 v4, v32

    .end local v33    # "lineHeight":F
    .local v4, "lineHeight":F
    goto :goto_327

    .line 329
    .end local v2    # "peekValue":Landroid/util/TypedValue;
    .end local v34    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .end local v35    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .local v4, "drawableBottom":Landroid/graphics/drawable/Drawable;
    .restart local v5    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .restart local v33    # "lineHeight":F
    :cond_31e
    move-object/from16 v34, v4

    move-object/from16 v35, v5

    const/4 v5, -0x1

    .end local v4    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .end local v5    # "drawableStart":Landroid/graphics/drawable/Drawable;
    .restart local v34    # "drawableBottom":Landroid/graphics/drawable/Drawable;
    .restart local v35    # "drawableStart":Landroid/graphics/drawable/Drawable;
    move/from16 v4, v32

    move/from16 v2, v33

    .line 342
    .end local v32    # "lineHeightUnit":I
    .end local v33    # "lineHeight":F
    .local v2, "lineHeight":F
    .local v4, "lineHeightUnit":I
    :goto_327
    invoke-virtual {v10}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 343
    if-eq v1, v5, :cond_331

    .line 344
    iget-object v5, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v5, v1}, Landroidx/core/widget/TextViewCompat;->setFirstBaselineToTopHeight(Landroid/widget/TextView;I)V

    .line 346
    :cond_331
    const/4 v5, -0x1

    if-eq v3, v5, :cond_339

    .line 347
    iget-object v5, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v5, v3}, Landroidx/core/widget/TextViewCompat;->setLastBaselineToBottomHeight(Landroid/widget/TextView;I)V

    .line 349
    :cond_339
    cmpl-float v5, v2, v20

    if-eqz v5, :cond_351

    .line 350
    const/4 v5, -0x1

    if-ne v4, v5, :cond_349

    .line 351
    iget-object v5, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    move/from16 v18, v1

    .end local v1    # "firstBaselineToTopHeight":I
    .local v18, "firstBaselineToTopHeight":I
    float-to-int v1, v2

    invoke-static {v5, v1}, Landroidx/core/widget/TextViewCompat;->setLineHeight(Landroid/widget/TextView;I)V

    goto :goto_353

    .line 353
    .end local v18    # "firstBaselineToTopHeight":I
    .restart local v1    # "firstBaselineToTopHeight":I
    :cond_349
    move/from16 v18, v1

    .end local v1    # "firstBaselineToTopHeight":I
    .restart local v18    # "firstBaselineToTopHeight":I
    iget-object v1, v0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v1, v4, v2}, Landroidx/core/widget/TextViewCompat;->setLineHeight(Landroid/widget/TextView;IF)V

    goto :goto_353

    .line 349
    .end local v18    # "firstBaselineToTopHeight":I
    .restart local v1    # "firstBaselineToTopHeight":I
    :cond_351
    move/from16 v18, v1

    .line 356
    .end local v1    # "firstBaselineToTopHeight":I
    .restart local v18    # "firstBaselineToTopHeight":I
    :goto_353
    return-void
.end method

.method onAsyncTypefaceReceived(Ljava/lang/ref/WeakReference;Landroid/graphics/Typeface;)V
    .registers 6
    .param p2, "typeface"    # Landroid/graphics/Typeface;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/ref/WeakReference<",
            "Landroid/widget/TextView;",
            ">;",
            "Landroid/graphics/Typeface;",
            ")V"
        }
    .end annotation

    .line 454
    .local p1, "textViewWeak":Ljava/lang/ref/WeakReference;, "Ljava/lang/ref/WeakReference<Landroid/widget/TextView;>;"
    iget-boolean v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAsyncFontPending:Z

    if-eqz v0, :cond_24

    .line 455
    iput-object p2, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    .line 456
    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 457
    .local v0, "textView":Landroid/widget/TextView;
    if-eqz v0, :cond_24

    .line 458
    invoke-virtual {v0}, Landroid/widget/TextView;->isAttachedToWindow()Z

    move-result v1

    if-eqz v1, :cond_1f

    .line 459
    iget v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    .line 460
    .local v1, "style":I
    new-instance v2, Landroidx/appcompat/widget/AppCompatTextHelper$2;

    invoke-direct {v2, p0, v0, p2, v1}, Landroidx/appcompat/widget/AppCompatTextHelper$2;-><init>(Landroidx/appcompat/widget/AppCompatTextHelper;Landroid/widget/TextView;Landroid/graphics/Typeface;I)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->post(Ljava/lang/Runnable;)Z

    .line 466
    .end local v1    # "style":I
    goto :goto_24

    .line 467
    :cond_1f
    iget v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-virtual {v0, p2, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 471
    .end local v0    # "textView":Landroid/widget/TextView;
    :cond_24
    :goto_24
    return-void
.end method

.method onLayout(ZIIII)V
    .registers 7
    .param p1, "changed"    # Z
    .param p2, "left"    # I
    .param p3, "top"    # I
    .param p4, "right"    # I
    .param p5, "bottom"    # I

    .line 575
    sget-boolean v0, Landroidx/appcompat/widget/ViewUtils;->SDK_LEVEL_SUPPORTS_AUTOSIZE:Z

    if-nez v0, :cond_7

    .line 576
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatTextHelper;->autoSizeText()V

    .line 578
    :cond_7
    return-void
.end method

.method onSetCompoundDrawables()V
    .registers 1

    .line 536
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatTextHelper;->applyCompoundDrawablesTints()V

    .line 537
    return-void
.end method

.method onSetTextAppearance(Landroid/content/Context;I)V
    .registers 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "resId"    # I

    .line 474
    sget-object v0, Landroidx/appcompat/R$styleable;->TextAppearance:[I

    invoke-static {p1, p2, v0}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;I[I)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v0

    .line 476
    .local v0, "a":Landroidx/appcompat/widget/TintTypedArray;
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_18

    .line 481
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_textAllCaps:I

    invoke-virtual {v0, v1, v2}, Landroidx/appcompat/widget/TintTypedArray;->getBoolean(IZ)Z

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/appcompat/widget/AppCompatTextHelper;->setAllCaps(Z)V

    .line 483
    :cond_18
    nop

    .line 509
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_android_textSize:I

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_30

    .line 510
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_android_textSize:I

    const/4 v3, -0x1

    invoke-virtual {v0, v1, v3}, Landroidx/appcompat/widget/TintTypedArray;->getDimensionPixelSize(II)I

    move-result v1

    if-nez v1, :cond_30

    .line 511
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 515
    :cond_30
    invoke-direct {p0, p1, v0}, Landroidx/appcompat/widget/AppCompatTextHelper;->updateTypefaceAndStyle(Landroid/content/Context;Landroidx/appcompat/widget/TintTypedArray;)V

    .line 517
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_4e

    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    .line 518
    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_4e

    .line 519
    sget v1, Landroidx/appcompat/R$styleable;->TextAppearance_fontVariationSettings:I

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/TintTypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 521
    .local v1, "fontVariation":Ljava/lang/String;
    if-eqz v1, :cond_4e

    .line 522
    iget-object v2, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-static {v2, v1}, Landroidx/appcompat/widget/AppCompatTextHelper$Api26Impl;->setFontVariationSettings(Landroid/widget/TextView;Ljava/lang/String;)Z

    .line 525
    .end local v1    # "fontVariation":Ljava/lang/String;
    :cond_4e
    invoke-virtual {v0}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 526
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    if-eqz v1, :cond_5e

    .line 527
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    iget-object v2, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mFontTypeface:Landroid/graphics/Typeface;

    iget v3, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mStyle:I

    invoke-virtual {v1, v2, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 529
    :cond_5e
    return-void
.end method

.method populateSurroundingTextIfNeeded(Landroid/widget/TextView;Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;)V
    .registers 6
    .param p1, "textView"    # Landroid/widget/TextView;
    .param p2, "inputConnection"    # Landroid/view/inputmethod/InputConnection;
    .param p3, "editorInfo"    # Landroid/view/inputmethod/EditorInfo;

    .line 728
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-ge v0, v1, :cond_f

    if-eqz p2, :cond_f

    .line 729
    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {p3, v0}, Landroidx/core/view/inputmethod/EditorInfoCompat;->setInitialSurroundingText(Landroid/view/inputmethod/EditorInfo;Ljava/lang/CharSequence;)V

    .line 731
    :cond_f
    return-void
.end method

.method setAllCaps(Z)V
    .registers 3
    .param p1, "allCaps"    # Z

    .line 532
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setAllCaps(Z)V

    .line 533
    return-void
.end method

.method setAutoSizeTextTypeUniformWithConfiguration(IIII)V
    .registers 6
    .param p1, "autoSizeMinTextSize"    # I
    .param p2, "autoSizeMaxTextSize"    # I
    .param p3, "autoSizeStepGranularity"    # I
    .param p4, "unit"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 612
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->setAutoSizeTextTypeUniformWithConfiguration(IIII)V

    .line 614
    return-void
.end method

.method setAutoSizeTextTypeUniformWithPresetSizes([II)V
    .registers 4
    .param p1, "presetSizes"    # [I
    .param p2, "unit"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 618
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0, p1, p2}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->setAutoSizeTextTypeUniformWithPresetSizes([II)V

    .line 619
    return-void
.end method

.method setAutoSizeTextTypeWithDefaults(I)V
    .registers 3
    .param p1, "autoSizeTextType"    # I

    .line 604
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mAutoSizeTextHelper:Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatTextViewAutoSizeHelper;->setAutoSizeTextTypeWithDefaults(I)V

    .line 605
    return-void
.end method

.method setCompoundDrawableTintList(Landroid/content/res/ColorStateList;)V
    .registers 4
    .param p1, "tintList"    # Landroid/content/res/ColorStateList;

    .line 648
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-nez v0, :cond_b

    .line 649
    new-instance v0, Landroidx/appcompat/widget/TintInfo;

    invoke-direct {v0}, Landroidx/appcompat/widget/TintInfo;-><init>()V

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    .line 651
    :cond_b
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object p1, v0, Landroidx/appcompat/widget/TintInfo;->mTintList:Landroid/content/res/ColorStateList;

    .line 652
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz p1, :cond_15

    const/4 v1, 0x1

    goto :goto_16

    :cond_15
    const/4 v1, 0x0

    :goto_16
    iput-boolean v1, v0, Landroidx/appcompat/widget/TintInfo;->mHasTintList:Z

    .line 653
    invoke-direct {p0}, Landroidx/appcompat/widget/AppCompatTextHelper;->setCompoundTints()V

    .line 654
    return-void
.end method

.method setCompoundDrawableTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .registers 4
    .param p1, "tintMode"    # Landroid/graphics/PorterDuff$Mode;

    .line 662
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-nez v0, :cond_b

    .line 663
    new-instance v0, Landroidx/appcompat/widget/TintInfo;

    invoke-direct {v0}, Landroidx/appcompat/widget/TintInfo;-><init>()V

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    .line 665
    :cond_b
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    iput-object p1, v0, Landroidx/appcompat/widget/TintInfo;->mTintMode:Landroid/graphics/PorterDuff$Mode;

    .line 666
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatTextHelper;->mDrawableTint:Landroidx/appcompat/widget/TintInfo;

    if-eqz p1, :cond_15

    const/4 v1, 0x1

    goto :goto_16

    :cond_15
    const/4 v1, 0x0

    :goto_16
    iput-boolean v1, v0, Landroidx/appcompat/widget/TintInfo;->mHasTintMode:Z

    .line 667
    invoke-direct {p0}, Landroidx/appcompat/widget/AppCompatTextHelper;->setCompoundTints()V

    .line 668
    return-void
.end method

.method setTextSize(IF)V
    .registers 4
    .param p1, "unit"    # I
    .param p2, "size"    # F

    .line 582
    sget-boolean v0, Landroidx/appcompat/widget/ViewUtils;->SDK_LEVEL_SUPPORTS_AUTOSIZE:Z

    if-nez v0, :cond_d

    .line 583
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatTextHelper;->isAutoSizeEnabled()Z

    move-result v0

    if-nez v0, :cond_d

    .line 584
    invoke-direct {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatTextHelper;->setTextSizeInternal(IF)V

    .line 587
    :cond_d
    return-void
.end method
