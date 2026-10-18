.class public Landroidx/appcompat/widget/ActionBarContainer;
.super Landroid/widget/FrameLayout;
.source "ActionBarContainer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/widget/ActionBarContainer$Api21Impl;
    }
.end annotation


# instance fields
.field private mActionBarView:Landroid/view/View;

.field mBackground:Landroid/graphics/drawable/Drawable;

.field private mContextView:Landroid/view/View;

.field private mHeight:I

.field mIsSplit:Z

.field mIsStacked:Z

.field private mIsTransitioning:Z

.field mSplitBackground:Landroid/graphics/drawable/Drawable;

.field mStackedBackground:Landroid/graphics/drawable/Drawable;

.field private mTabContainer:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3
    .param p1, "context"    # Landroid/content/Context;

    .line 55
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/appcompat/widget/ActionBarContainer;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 56
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 59
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 62
    new-instance v0, Landroidx/appcompat/widget/ActionBarBackgroundDrawable;

    invoke-direct {v0, p0}, Landroidx/appcompat/widget/ActionBarBackgroundDrawable;-><init>(Landroidx/appcompat/widget/ActionBarContainer;)V

    .line 63
    .local v0, "bg":Landroid/graphics/drawable/Drawable;
    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 65
    sget-object v1, Landroidx/appcompat/R$styleable;->ActionBar:[I

    invoke-virtual {p1, p2, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v1

    .line 67
    .local v1, "a":Landroid/content/res/TypedArray;
    sget v2, Landroidx/appcompat/R$styleable;->ActionBar_background:I

    invoke-virtual {v1, v2}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    .line 68
    sget v2, Landroidx/appcompat/R$styleable;->ActionBar_backgroundStacked:I

    invoke-virtual {v1, v2}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    .line 70
    sget v2, Landroidx/appcompat/R$styleable;->ActionBar_height:I

    const/4 v3, -0x1

    invoke-virtual {v1, v2, v3}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result v2

    iput v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mHeight:I

    .line 72
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getId()I

    move-result v2

    sget v3, Landroidx/appcompat/R$id;->split_action_bar:I

    const/4 v4, 0x1

    if-ne v2, v3, :cond_3d

    .line 73
    iput-boolean v4, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    .line 74
    sget v2, Landroidx/appcompat/R$styleable;->ActionBar_backgroundSplit:I

    invoke-virtual {v1, v2}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    .line 76
    :cond_3d
    invoke-virtual {v1}, Landroid/content/res/TypedArray;->recycle()V

    .line 78
    iget-boolean v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    const/4 v3, 0x0

    if-eqz v2, :cond_4c

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-nez v2, :cond_4a

    goto :goto_56

    :cond_4a
    move v4, v3

    goto :goto_56

    .line 79
    :cond_4c
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-nez v2, :cond_55

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-nez v2, :cond_55

    goto :goto_56

    :cond_55
    move v4, v3

    .line 78
    :goto_56
    invoke-virtual {p0, v4}, Landroidx/appcompat/widget/ActionBarContainer;->setWillNotDraw(Z)V

    .line 80
    return-void
.end method

.method private getMeasuredHeightWithMargins(Landroid/view/View;)I
    .registers 5
    .param p1, "view"    # Landroid/view/View;

    .line 267
    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout$LayoutParams;

    .line 268
    .local v0, "lp":Landroid/widget/FrameLayout$LayoutParams;
    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v1

    iget v2, v0, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    add-int/2addr v1, v2

    iget v2, v0, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    add-int/2addr v1, v2

    return v1
.end method

.method private isCollapsed(Landroid/view/View;)Z
    .registers 4
    .param p1, "view"    # Landroid/view/View;

    .line 263
    if-eqz p1, :cond_13

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_13

    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v0

    if-nez v0, :cond_11

    goto :goto_13

    :cond_11
    const/4 v0, 0x0

    goto :goto_14

    :cond_13
    :goto_13
    const/4 v0, 0x1

    :goto_14
    return v0
.end method


# virtual methods
.method protected drawableStateChanged()V
    .registers 3

    .line 168
    invoke-super {p0}, Landroid/widget/FrameLayout;->drawableStateChanged()V

    .line 169
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_18

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v0

    if-eqz v0, :cond_18

    .line 170
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 172
    :cond_18
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_2d

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v0

    if-eqz v0, :cond_2d

    .line 173
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 175
    :cond_2d
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_42

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v0

    if-eqz v0, :cond_42

    .line 176
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 178
    :cond_42
    return-void
.end method

.method public getTabContainer()Landroid/view/View;
    .registers 2

    .line 243
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    return-object v0
.end method

.method public jumpDrawablesToCurrentState()V
    .registers 2

    .line 182
    invoke-super {p0}, Landroid/widget/FrameLayout;->jumpDrawablesToCurrentState()V

    .line 183
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_c

    .line 184
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->jumpToCurrentState()V

    .line 186
    :cond_c
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_15

    .line 187
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->jumpToCurrentState()V

    .line 189
    :cond_15
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_1e

    .line 190
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->jumpToCurrentState()V

    .line 192
    :cond_1e
    return-void
.end method

.method public onFinishInflate()V
    .registers 2

    .line 84
    invoke-super {p0}, Landroid/widget/FrameLayout;->onFinishInflate()V

    .line 85
    sget v0, Landroidx/appcompat/R$id;->action_bar:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    .line 86
    sget v0, Landroidx/appcompat/R$id;->action_context_bar:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    .line 87
    return-void
.end method

.method public onHoverEvent(Landroid/view/MotionEvent;)Z
    .registers 3
    .param p1, "ev"    # Landroid/view/MotionEvent;

    .line 222
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onHoverEvent(Landroid/view/MotionEvent;)Z

    .line 225
    const/4 v0, 0x1

    return v0
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 3
    .param p1, "ev"    # Landroid/view/MotionEvent;

    .line 209
    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsTransitioning:Z

    if-nez v0, :cond_d

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_b

    goto :goto_d

    :cond_b
    const/4 v0, 0x0

    goto :goto_e

    :cond_d
    :goto_d
    const/4 v0, 0x1

    :goto_e
    return v0
.end method

.method public onLayout(ZIIII)V
    .registers 15
    .param p1, "changed"    # Z
    .param p2, "l"    # I
    .param p3, "t"    # I
    .param p4, "r"    # I
    .param p5, "b"    # I

    .line 303
    invoke-super/range {p0 .. p5}, Landroid/widget/FrameLayout;->onLayout(ZIIII)V

    .line 305
    move v0, p5

    move p5, p4

    move p4, p3

    move p3, p2

    move p2, p1

    move-object p1, p0

    .end local p1    # "changed":Z
    .local v0, "b":I
    .local p2, "changed":Z
    .local p3, "l":I
    .local p4, "t":I
    .local p5, "r":I
    iget-object v1, p1, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    .line 306
    .local v1, "tabContainer":Landroid/view/View;
    const/16 v2, 0x8

    const/4 v3, 0x0

    if-eqz v1, :cond_18

    invoke-virtual {v1}, Landroid/view/View;->getVisibility()I

    move-result v4

    if-eq v4, v2, :cond_18

    const/4 v4, 0x1

    goto :goto_19

    :cond_18
    move v4, v3

    .line 308
    .local v4, "hasTabs":Z
    :goto_19
    if-eqz v1, :cond_3b

    invoke-virtual {v1}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-eq v5, v2, :cond_3b

    .line 309
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeight()I

    move-result v2

    .line 310
    .local v2, "containerHeight":I
    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/widget/FrameLayout$LayoutParams;

    .line 311
    .local v5, "lp":Landroid/widget/FrameLayout$LayoutParams;
    invoke-virtual {v1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v6

    .line 312
    .local v6, "tabHeight":I
    sub-int v7, v2, v6

    iget v8, v5, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    sub-int/2addr v7, v8

    iget v8, v5, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    sub-int v8, v2, v8

    invoke-virtual {v1, p3, v7, p5, v8}, Landroid/view/View;->layout(IIII)V

    .line 316
    .end local v2    # "containerHeight":I
    .end local v5    # "lp":Landroid/widget/FrameLayout$LayoutParams;
    .end local v6    # "tabHeight":I
    :cond_3b
    const/4 v2, 0x0

    .line 317
    .local v2, "needsInvalidate":Z
    iget-boolean v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    if-eqz v5, :cond_54

    .line 318
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v5, :cond_cc

    .line 319
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredWidth()I

    move-result v6

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeight()I

    move-result v7

    invoke-virtual {v5, v3, v3, v6, v7}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 320
    const/4 v2, 0x1

    goto/16 :goto_cc

    .line 323
    :cond_54
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v5, :cond_ae

    .line 324
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-nez v5, :cond_7e

    .line 325
    iget-object v3, p1, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v5

    iget-object v6, p1, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v6}, Landroid/view/View;->getTop()I

    move-result v6

    iget-object v7, p1, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    .line 326
    invoke-virtual {v7}, Landroid/view/View;->getRight()I

    move-result v7

    iget-object v8, p1, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v8}, Landroid/view/View;->getBottom()I

    move-result v8

    .line 325
    invoke-virtual {v3, v5, v6, v7, v8}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    goto :goto_ad

    .line 327
    :cond_7e
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    if-eqz v5, :cond_a8

    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    .line 328
    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-nez v5, :cond_a8

    .line 329
    iget-object v3, p1, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getLeft()I

    move-result v5

    iget-object v6, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    invoke-virtual {v6}, Landroid/view/View;->getTop()I

    move-result v6

    iget-object v7, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    .line 330
    invoke-virtual {v7}, Landroid/view/View;->getRight()I

    move-result v7

    iget-object v8, p1, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    invoke-virtual {v8}, Landroid/view/View;->getBottom()I

    move-result v8

    .line 329
    invoke-virtual {v3, v5, v6, v7, v8}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    goto :goto_ad

    .line 332
    :cond_a8
    iget-object v5, p1, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v5, v3, v3, v3, v3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 334
    :goto_ad
    const/4 v2, 0x1

    .line 336
    :cond_ae
    iput-boolean v4, p1, Landroidx/appcompat/widget/ActionBarContainer;->mIsStacked:Z

    .line 337
    if-eqz v4, :cond_cc

    iget-object v3, p1, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v3, :cond_cc

    .line 338
    iget-object v3, p1, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v5

    invoke-virtual {v1}, Landroid/view/View;->getTop()I

    move-result v6

    .line 339
    invoke-virtual {v1}, Landroid/view/View;->getRight()I

    move-result v7

    invoke-virtual {v1}, Landroid/view/View;->getBottom()I

    move-result v8

    .line 338
    invoke-virtual {v3, v5, v6, v7, v8}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 340
    const/4 v2, 0x1

    .line 344
    :cond_cc
    :goto_cc
    if-eqz v2, :cond_d1

    .line 345
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->invalidate()V

    .line 347
    :cond_d1
    return-void
.end method

.method public onMeasure(II)V
    .registers 8
    .param p1, "widthMeasureSpec"    # I
    .param p2, "heightMeasureSpec"    # I

    .line 273
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    const/high16 v1, -0x80000000

    if-nez v0, :cond_1e

    .line 274
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    if-ne v0, v1, :cond_1e

    iget v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mHeight:I

    if-ltz v0, :cond_1e

    .line 275
    iget v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mHeight:I

    .line 276
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v2

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 275
    invoke-static {v0, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    .line 278
    :cond_1e
    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->onMeasure(II)V

    .line 280
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    if-nez v0, :cond_26

    return-void

    .line 282
    :cond_26
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getMode(I)I

    move-result v0

    .line 283
    .local v0, "mode":I
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    if-eqz v2, :cond_77

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result v2

    const/16 v3, 0x8

    if-eq v2, v3, :cond_77

    const/high16 v2, 0x40000000    # 2.0f

    if-eq v0, v2, :cond_77

    .line 286
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-direct {p0, v2}, Landroidx/appcompat/widget/ActionBarContainer;->isCollapsed(Landroid/view/View;)Z

    move-result v2

    if-nez v2, :cond_4b

    .line 287
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-direct {p0, v2}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeightWithMargins(Landroid/view/View;)I

    move-result v2

    .local v2, "topMarginForTabs":I
    goto :goto_5b

    .line 288
    .end local v2    # "topMarginForTabs":I
    :cond_4b
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    invoke-direct {p0, v2}, Landroidx/appcompat/widget/ActionBarContainer;->isCollapsed(Landroid/view/View;)Z

    move-result v2

    if-nez v2, :cond_5a

    .line 289
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mContextView:Landroid/view/View;

    invoke-direct {p0, v2}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeightWithMargins(Landroid/view/View;)I

    move-result v2

    .restart local v2    # "topMarginForTabs":I
    goto :goto_5b

    .line 291
    .end local v2    # "topMarginForTabs":I
    :cond_5a
    const/4 v2, 0x0

    .line 293
    .restart local v2    # "topMarginForTabs":I
    :goto_5b
    if-ne v0, v1, :cond_62

    .line 294
    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    goto :goto_65

    :cond_62
    const v1, 0x7fffffff

    .line 295
    .local v1, "maxHeight":I
    :goto_65
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredWidth()I

    move-result v3

    iget-object v4, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    .line 296
    invoke-direct {p0, v4}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeightWithMargins(Landroid/view/View;)I

    move-result v4

    add-int/2addr v4, v2

    invoke-static {v4, v1}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 295
    invoke-virtual {p0, v3, v4}, Landroidx/appcompat/widget/ActionBarContainer;->setMeasuredDimension(II)V

    .line 299
    .end local v1    # "maxHeight":I
    .end local v2    # "topMarginForTabs":I
    :cond_77
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 3
    .param p1, "ev"    # Landroid/view/MotionEvent;

    .line 214
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 217
    const/4 v0, 0x1

    return v0
.end method

.method public setPrimaryBackground(Landroid/graphics/drawable/Drawable;)V
    .registers 7
    .param p1, "bg"    # Landroid/graphics/drawable/Drawable;

    .line 90
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_f

    .line 91
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 92
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->unscheduleDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 94
    :cond_f
    iput-object p1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    .line 95
    if-eqz p1, :cond_37

    .line 96
    invoke-virtual {p1, p0}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 97
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    if-eqz v0, :cond_37

    .line 98
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getTop()I

    move-result v2

    iget-object v3, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    .line 99
    invoke-virtual {v3}, Landroid/view/View;->getRight()I

    move-result v3

    iget-object v4, p0, Landroidx/appcompat/widget/ActionBarContainer;->mActionBarView:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getBottom()I

    move-result v4

    .line 98
    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 102
    :cond_37
    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_44

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_42

    goto :goto_4e

    :cond_42
    move v1, v2

    goto :goto_4e

    .line 103
    :cond_44
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_4d

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_4d

    goto :goto_4e

    :cond_4d
    move v1, v2

    .line 102
    :goto_4e
    invoke-virtual {p0, v1}, Landroidx/appcompat/widget/ActionBarContainer;->setWillNotDraw(Z)V

    .line 104
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->invalidate()V

    .line 105
    nop

    .line 106
    invoke-static {p0}, Landroidx/appcompat/widget/ActionBarContainer$Api21Impl;->invalidateOutline(Landroidx/appcompat/widget/ActionBarContainer;)V

    .line 108
    return-void
.end method

.method public setSplitBackground(Landroid/graphics/drawable/Drawable;)V
    .registers 6
    .param p1, "bg"    # Landroid/graphics/drawable/Drawable;

    .line 132
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_f

    .line 133
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 134
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->unscheduleDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 136
    :cond_f
    iput-object p1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    .line 137
    const/4 v0, 0x0

    if-eqz p1, :cond_2c

    .line 138
    invoke-virtual {p1, p0}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 139
    iget-boolean v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    if-eqz v1, :cond_2c

    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_2c

    .line 140
    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredWidth()I

    move-result v2

    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->getMeasuredHeight()I

    move-result v3

    invoke-virtual {v1, v0, v0, v2, v3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 143
    :cond_2c
    iget-boolean v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    const/4 v2, 0x1

    if-eqz v1, :cond_37

    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_40

    move v0, v2

    goto :goto_40

    .line 144
    :cond_37
    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_40

    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-nez v1, :cond_40

    move v0, v2

    .line 143
    :cond_40
    :goto_40
    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->setWillNotDraw(Z)V

    .line 145
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->invalidate()V

    .line 146
    nop

    .line 147
    invoke-static {p0}, Landroidx/appcompat/widget/ActionBarContainer$Api21Impl;->invalidateOutline(Landroidx/appcompat/widget/ActionBarContainer;)V

    .line 149
    return-void
.end method

.method public setStackedBackground(Landroid/graphics/drawable/Drawable;)V
    .registers 7
    .param p1, "bg"    # Landroid/graphics/drawable/Drawable;

    .line 111
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_f

    .line 112
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 113
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->unscheduleDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 115
    :cond_f
    iput-object p1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    .line 116
    if-eqz p1, :cond_3b

    .line 117
    invoke-virtual {p1, p0}, Landroid/graphics/drawable/Drawable;->setCallback(Landroid/graphics/drawable/Drawable$Callback;)V

    .line 118
    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsStacked:Z

    if-eqz v0, :cond_3b

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_3b

    .line 119
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    iget-object v1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getTop()I

    move-result v2

    iget-object v3, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    .line 120
    invoke-virtual {v3}, Landroid/view/View;->getRight()I

    move-result v3

    iget-object v4, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getBottom()I

    move-result v4

    .line 119
    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 123
    :cond_3b
    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_48

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_46

    goto :goto_52

    :cond_46
    move v1, v2

    goto :goto_52

    .line 124
    :cond_48
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_51

    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_51

    goto :goto_52

    :cond_51
    move v1, v2

    .line 123
    :goto_52
    invoke-virtual {p0, v1}, Landroidx/appcompat/widget/ActionBarContainer;->setWillNotDraw(Z)V

    .line 125
    invoke-virtual {p0}, Landroidx/appcompat/widget/ActionBarContainer;->invalidate()V

    .line 126
    nop

    .line 127
    invoke-static {p0}, Landroidx/appcompat/widget/ActionBarContainer$Api21Impl;->invalidateOutline(Landroidx/appcompat/widget/ActionBarContainer;)V

    .line 129
    return-void
.end method

.method public setTabContainer(Landroidx/appcompat/widget/ScrollingTabContainerView;)V
    .registers 4
    .param p1, "tabView"    # Landroidx/appcompat/widget/ScrollingTabContainerView;

    .line 229
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    if-eqz v0, :cond_9

    .line 230
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->removeView(Landroid/view/View;)V

    .line 232
    :cond_9
    iput-object p1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mTabContainer:Landroid/view/View;

    .line 233
    if-eqz p1, :cond_1e

    .line 234
    invoke-virtual {p0, p1}, Landroidx/appcompat/widget/ActionBarContainer;->addView(Landroid/view/View;)V

    .line 235
    invoke-virtual {p1}, Landroidx/appcompat/widget/ScrollingTabContainerView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 236
    .local v0, "lp":Landroid/view/ViewGroup$LayoutParams;
    const/4 v1, -0x1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 237
    const/4 v1, -0x2

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 238
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroidx/appcompat/widget/ScrollingTabContainerView;->setAllowCollapse(Z)V

    .line 240
    .end local v0    # "lp":Landroid/view/ViewGroup$LayoutParams;
    :cond_1e
    return-void
.end method

.method public setTransitioning(Z)V
    .registers 3
    .param p1, "isTransitioning"    # Z

    .line 202
    iput-boolean p1, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsTransitioning:Z

    .line 203
    if-eqz p1, :cond_7

    const/high16 v0, 0x60000

    goto :goto_9

    .line 204
    :cond_7
    const/high16 v0, 0x40000

    .line 203
    :goto_9
    invoke-virtual {p0, v0}, Landroidx/appcompat/widget/ActionBarContainer;->setDescendantFocusability(I)V

    .line 205
    return-void
.end method

.method public setVisibility(I)V
    .registers 5
    .param p1, "visibility"    # I

    .line 153
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 154
    const/4 v0, 0x0

    if-nez p1, :cond_8

    const/4 v1, 0x1

    goto :goto_9

    :cond_8
    move v1, v0

    .line 155
    .local v1, "isVisible":Z
    :goto_9
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_12

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2, v1, v0}, Landroid/graphics/drawable/Drawable;->setVisible(ZZ)Z

    .line 156
    :cond_12
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_1b

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2, v1, v0}, Landroid/graphics/drawable/Drawable;->setVisible(ZZ)Z

    .line 157
    :cond_1b
    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_24

    iget-object v2, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2, v1, v0}, Landroid/graphics/drawable/Drawable;->setVisible(ZZ)Z

    .line 158
    :cond_24
    return-void
.end method

.method public startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;
    .registers 4
    .param p1, "child"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/view/ActionMode$Callback;

    .line 250
    const/4 v0, 0x0

    return-object v0
.end method

.method public startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;I)Landroid/view/ActionMode;
    .registers 5
    .param p1, "child"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/view/ActionMode$Callback;
    .param p3, "type"    # I

    .line 256
    if-eqz p3, :cond_7

    .line 257
    invoke-super {p0, p1, p2, p3}, Landroid/widget/FrameLayout;->startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;I)Landroid/view/ActionMode;

    move-result-object v0

    return-object v0

    .line 259
    :cond_7
    const/4 v0, 0x0

    return-object v0
.end method

.method protected verifyDrawable(Landroid/graphics/drawable/Drawable;)Z
    .registers 3
    .param p1, "who"    # Landroid/graphics/drawable/Drawable;

    .line 162
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mBackground:Landroid/graphics/drawable/Drawable;

    if-ne p1, v0, :cond_8

    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    if-eqz v0, :cond_1e

    :cond_8
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mStackedBackground:Landroid/graphics/drawable/Drawable;

    if-ne p1, v0, :cond_10

    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsStacked:Z

    if-nez v0, :cond_1e

    :cond_10
    iget-object v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mSplitBackground:Landroid/graphics/drawable/Drawable;

    if-ne p1, v0, :cond_18

    iget-boolean v0, p0, Landroidx/appcompat/widget/ActionBarContainer;->mIsSplit:Z

    if-nez v0, :cond_1e

    .line 163
    :cond_18
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->verifyDrawable(Landroid/graphics/drawable/Drawable;)Z

    move-result v0

    if-eqz v0, :cond_20

    :cond_1e
    const/4 v0, 0x1

    goto :goto_21

    :cond_20
    const/4 v0, 0x0

    .line 162
    :goto_21
    return v0
.end method
