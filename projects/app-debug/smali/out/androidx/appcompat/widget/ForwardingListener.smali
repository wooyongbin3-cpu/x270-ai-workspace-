.class public abstract Landroidx/appcompat/widget/ForwardingListener;
.super Ljava/lang/Object;
.source "ForwardingListener.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;
.implements Landroid/view/View$OnAttachStateChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/widget/ForwardingListener$DisallowIntercept;,
        Landroidx/appcompat/widget/ForwardingListener$TriggerLongPress;
    }
.end annotation


# instance fields
.field private mActivePointerId:I

.field private mDisallowIntercept:Ljava/lang/Runnable;

.field private mForwarding:Z

.field private final mLongPressTimeout:I

.field private final mScaledTouchSlop:F

.field final mSrc:Landroid/view/View;

.field private final mTapTimeout:I

.field private final mTmpLocation:[I

.field private mTriggerLongPress:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .registers 5
    .param p1, "src"    # Landroid/view/View;

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const/4 v0, 0x2

    new-array v1, v0, [I

    iput-object v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mTmpLocation:[I

    .line 68
    iput-object p1, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    .line 69
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/view/View;->setLongClickable(Z)V

    .line 70
    invoke-virtual {p1, p0}, Landroid/view/View;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 72
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v1

    int-to-float v1, v1

    iput v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mScaledTouchSlop:F

    .line 73
    invoke-static {}, Landroid/view/ViewConfiguration;->getTapTimeout()I

    move-result v1

    iput v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mTapTimeout:I

    .line 76
    iget v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mTapTimeout:I

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v2

    add-int/2addr v1, v2

    div-int/2addr v1, v0

    iput v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mLongPressTimeout:I

    .line 77
    return-void
.end method

.method private clearCallbacks()V
    .registers 3

    .line 215
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mTriggerLongPress:Ljava/lang/Runnable;

    if-eqz v0, :cond_b

    .line 216
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    iget-object v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mTriggerLongPress:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 219
    :cond_b
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    if-eqz v0, :cond_16

    .line 220
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    iget-object v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 222
    :cond_16
    return-void
.end method

.method private onTouchForwarded(Landroid/view/MotionEvent;)Z
    .registers 11
    .param p1, "srcEvent"    # Landroid/view/MotionEvent;

    .line 258
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    .line 259
    .local v0, "src":Landroid/view/View;
    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->getPopup()Landroidx/appcompat/view/menu/ShowableListMenu;

    move-result-object v1

    .line 260
    .local v1, "popup":Landroidx/appcompat/view/menu/ShowableListMenu;
    const/4 v2, 0x0

    if-eqz v1, :cond_46

    invoke-interface {v1}, Landroidx/appcompat/view/menu/ShowableListMenu;->isShowing()Z

    move-result v3

    if-nez v3, :cond_10

    goto :goto_46

    .line 264
    :cond_10
    invoke-interface {v1}, Landroidx/appcompat/view/menu/ShowableListMenu;->getListView()Landroid/widget/ListView;

    move-result-object v3

    check-cast v3, Landroidx/appcompat/widget/DropDownListView;

    .line 265
    .local v3, "dst":Landroidx/appcompat/widget/DropDownListView;
    if-eqz v3, :cond_45

    invoke-virtual {v3}, Landroidx/appcompat/widget/DropDownListView;->isShown()Z

    move-result v4

    if-nez v4, :cond_1f

    goto :goto_45

    .line 270
    :cond_1f
    invoke-static {p1}, Landroid/view/MotionEvent;->obtainNoHistory(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v4

    .line 271
    .local v4, "dstEvent":Landroid/view/MotionEvent;
    invoke-direct {p0, v0, v4}, Landroidx/appcompat/widget/ForwardingListener;->toGlobalMotionEvent(Landroid/view/View;Landroid/view/MotionEvent;)Z

    .line 272
    invoke-direct {p0, v3, v4}, Landroidx/appcompat/widget/ForwardingListener;->toLocalMotionEvent(Landroid/view/View;Landroid/view/MotionEvent;)Z

    .line 275
    iget v5, p0, Landroidx/appcompat/widget/ForwardingListener;->mActivePointerId:I

    invoke-virtual {v3, v4, v5}, Landroidx/appcompat/widget/DropDownListView;->onForwardedEvent(Landroid/view/MotionEvent;I)Z

    move-result v5

    .line 276
    .local v5, "handled":Z
    invoke-virtual {v4}, Landroid/view/MotionEvent;->recycle()V

    .line 279
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v6

    .line 280
    .local v6, "action":I
    const/4 v7, 0x1

    if-eq v6, v7, :cond_3e

    const/4 v8, 0x3

    if-eq v6, v8, :cond_3e

    move v8, v7

    goto :goto_3f

    :cond_3e
    move v8, v2

    .line 283
    .local v8, "keepForwarding":Z
    :goto_3f
    if-eqz v5, :cond_44

    if-eqz v8, :cond_44

    move v2, v7

    :cond_44
    return v2

    .line 266
    .end local v4    # "dstEvent":Landroid/view/MotionEvent;
    .end local v5    # "handled":Z
    .end local v6    # "action":I
    .end local v8    # "keepForwarding":Z
    :cond_45
    :goto_45
    return v2

    .line 261
    .end local v3    # "dst":Landroidx/appcompat/widget/DropDownListView;
    :cond_46
    :goto_46
    return v2
.end method

.method private onTouchObserved(Landroid/view/MotionEvent;)Z
    .registers 9
    .param p1, "srcEvent"    # Landroid/view/MotionEvent;

    .line 169
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    .line 170
    .local v0, "src":Landroid/view/View;
    invoke-virtual {v0}, Landroid/view/View;->isEnabled()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_a

    .line 171
    return v2

    .line 174
    :cond_a
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    .line 175
    .local v1, "actionMasked":I
    packed-switch v1, :pswitch_data_6a

    goto :goto_68

    .line 190
    :pswitch_12
    iget v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mActivePointerId:I

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v3

    .line 191
    .local v3, "activePointerIndex":I
    if-ltz v3, :cond_68

    .line 192
    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    .line 193
    .local v4, "x":F
    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v5

    .line 196
    .local v5, "y":F
    iget v6, p0, Landroidx/appcompat/widget/ForwardingListener;->mScaledTouchSlop:F

    invoke-static {v0, v4, v5, v6}, Landroidx/appcompat/widget/ForwardingListener;->pointInView(Landroid/view/View;FFF)Z

    move-result v6

    if-nez v6, :cond_36

    .line 197
    invoke-direct {p0}, Landroidx/appcompat/widget/ForwardingListener;->clearCallbacks()V

    .line 200
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    const/4 v6, 0x1

    invoke-interface {v2, v6}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 201
    return v6

    .line 203
    .end local v4    # "x":F
    .end local v5    # "y":F
    :cond_36
    goto :goto_68

    .line 207
    .end local v3    # "activePointerIndex":I
    :pswitch_37
    invoke-direct {p0}, Landroidx/appcompat/widget/ForwardingListener;->clearCallbacks()V

    goto :goto_68

    .line 177
    :pswitch_3b
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v3

    iput v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mActivePointerId:I

    .line 179
    iget-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    if-nez v3, :cond_4c

    .line 180
    new-instance v3, Landroidx/appcompat/widget/ForwardingListener$DisallowIntercept;

    invoke-direct {v3, p0}, Landroidx/appcompat/widget/ForwardingListener$DisallowIntercept;-><init>(Landroidx/appcompat/widget/ForwardingListener;)V

    iput-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    .line 182
    :cond_4c
    iget-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    iget v4, p0, Landroidx/appcompat/widget/ForwardingListener;->mTapTimeout:I

    int-to-long v4, v4

    invoke-virtual {v0, v3, v4, v5}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 184
    iget-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mTriggerLongPress:Ljava/lang/Runnable;

    if-nez v3, :cond_5f

    .line 185
    new-instance v3, Landroidx/appcompat/widget/ForwardingListener$TriggerLongPress;

    invoke-direct {v3, p0}, Landroidx/appcompat/widget/ForwardingListener$TriggerLongPress;-><init>(Landroidx/appcompat/widget/ForwardingListener;)V

    iput-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mTriggerLongPress:Ljava/lang/Runnable;

    .line 187
    :cond_5f
    iget-object v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mTriggerLongPress:Ljava/lang/Runnable;

    iget v4, p0, Landroidx/appcompat/widget/ForwardingListener;->mLongPressTimeout:I

    int-to-long v4, v4

    invoke-virtual {v0, v3, v4, v5}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 188
    nop

    .line 211
    :cond_68
    :goto_68
    return v2

    nop

    :pswitch_data_6a
    .packed-switch 0x0
        :pswitch_3b
        :pswitch_37
        :pswitch_12
        :pswitch_37
    .end packed-switch
.end method

.method private static pointInView(Landroid/view/View;FFF)Z
    .registers 6
    .param p0, "view"    # Landroid/view/View;
    .param p1, "localX"    # F
    .param p2, "localY"    # F
    .param p3, "slop"    # F

    .line 287
    neg-float v0, p3

    cmpl-float v0, p1, v0

    if-ltz v0, :cond_2a

    neg-float v0, p3

    cmpl-float v0, p2, v0

    if-ltz v0, :cond_2a

    .line 288
    invoke-virtual {p0}, Landroid/view/View;->getRight()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getLeft()I

    move-result v1

    sub-int/2addr v0, v1

    int-to-float v0, v0

    add-float/2addr v0, p3

    cmpg-float v0, p1, v0

    if-gez v0, :cond_2a

    .line 289
    invoke-virtual {p0}, Landroid/view/View;->getBottom()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getTop()I

    move-result v1

    sub-int/2addr v0, v1

    int-to-float v0, v0

    add-float/2addr v0, p3

    cmpg-float v0, p2, v0

    if-gez v0, :cond_2a

    const/4 v0, 0x1

    goto :goto_2b

    :cond_2a
    const/4 v0, 0x0

    .line 287
    :goto_2b
    return v0
.end method

.method private toGlobalMotionEvent(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .registers 7
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 308
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mTmpLocation:[I

    .line 309
    .local v0, "loc":[I
    invoke-virtual {p1, v0}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 310
    const/4 v1, 0x0

    aget v1, v0, v1

    int-to-float v1, v1

    const/4 v2, 0x1

    aget v3, v0, v2

    int-to-float v3, v3

    invoke-virtual {p2, v1, v3}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    .line 311
    return v2
.end method

.method private toLocalMotionEvent(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .registers 7
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 297
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mTmpLocation:[I

    .line 298
    .local v0, "loc":[I
    invoke-virtual {p1, v0}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 299
    const/4 v1, 0x0

    aget v1, v0, v1

    neg-int v1, v1

    int-to-float v1, v1

    const/4 v2, 0x1

    aget v3, v0, v2

    neg-int v3, v3

    int-to-float v3, v3

    invoke-virtual {p2, v1, v3}, Landroid/view/MotionEvent;->offsetLocation(FF)V

    .line 300
    return v2
.end method


# virtual methods
.method public abstract getPopup()Landroidx/appcompat/view/menu/ShowableListMenu;
.end method

.method protected onForwardingStarted()Z
    .registers 3

    .line 138
    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->getPopup()Landroidx/appcompat/view/menu/ShowableListMenu;

    move-result-object v0

    .line 139
    .local v0, "popup":Landroidx/appcompat/view/menu/ShowableListMenu;
    if-eqz v0, :cond_f

    invoke-interface {v0}, Landroidx/appcompat/view/menu/ShowableListMenu;->isShowing()Z

    move-result v1

    if-nez v1, :cond_f

    .line 140
    invoke-interface {v0}, Landroidx/appcompat/view/menu/ShowableListMenu;->show()V

    .line 142
    :cond_f
    const/4 v1, 0x1

    return v1
.end method

.method protected onForwardingStopped()Z
    .registers 3

    .line 155
    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->getPopup()Landroidx/appcompat/view/menu/ShowableListMenu;

    move-result-object v0

    .line 156
    .local v0, "popup":Landroidx/appcompat/view/menu/ShowableListMenu;
    if-eqz v0, :cond_f

    invoke-interface {v0}, Landroidx/appcompat/view/menu/ShowableListMenu;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_f

    .line 157
    invoke-interface {v0}, Landroidx/appcompat/view/menu/ShowableListMenu;->dismiss()V

    .line 159
    :cond_f
    const/4 v1, 0x1

    return v1
.end method

.method onLongPress()V
    .registers 12

    .line 225
    invoke-direct {p0}, Landroidx/appcompat/widget/ForwardingListener;->clearCallbacks()V

    .line 227
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    .line 228
    .local v0, "src":Landroid/view/View;
    invoke-virtual {v0}, Landroid/view/View;->isEnabled()Z

    move-result v1

    if-eqz v1, :cond_37

    invoke-virtual {v0}, Landroid/view/View;->isLongClickable()Z

    move-result v1

    if-eqz v1, :cond_12

    goto :goto_37

    .line 234
    :cond_12
    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->onForwardingStarted()Z

    move-result v1

    if-nez v1, :cond_19

    .line 235
    return-void

    .line 239
    :cond_19
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    const/4 v2, 0x1

    invoke-interface {v1, v2}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 242
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    .line 243
    .local v3, "now":J
    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v7, 0x3

    const/4 v8, 0x0

    move-wide v5, v3

    invoke-static/range {v3 .. v10}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v1

    .line 244
    .local v1, "e":Landroid/view/MotionEvent;
    invoke-virtual {v0, v1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 245
    invoke-virtual {v1}, Landroid/view/MotionEvent;->recycle()V

    .line 247
    iput-boolean v2, p0, Landroidx/appcompat/widget/ForwardingListener;->mForwarding:Z

    .line 248
    return-void

    .line 231
    .end local v1    # "e":Landroid/view/MotionEvent;
    .end local v3    # "now":J
    :cond_37
    :goto_37
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .registers 15
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 93
    iget-boolean v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mForwarding:Z

    .line 95
    .local v0, "wasForwarding":Z
    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_17

    .line 96
    invoke-direct {p0, p2}, Landroidx/appcompat/widget/ForwardingListener;->onTouchForwarded(Landroid/view/MotionEvent;)Z

    move-result v3

    if-nez v3, :cond_15

    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->onForwardingStopped()Z

    move-result v3

    if-nez v3, :cond_13

    goto :goto_15

    :cond_13
    move v3, v2

    goto :goto_16

    :cond_15
    :goto_15
    move v3, v1

    .local v3, "forwarding":Z
    :goto_16
    goto :goto_3d

    .line 98
    .end local v3    # "forwarding":Z
    :cond_17
    invoke-direct {p0, p2}, Landroidx/appcompat/widget/ForwardingListener;->onTouchObserved(Landroid/view/MotionEvent;)Z

    move-result v3

    if-eqz v3, :cond_25

    invoke-virtual {p0}, Landroidx/appcompat/widget/ForwardingListener;->onForwardingStarted()Z

    move-result v3

    if-eqz v3, :cond_25

    move v3, v1

    goto :goto_26

    :cond_25
    move v3, v2

    .line 100
    .restart local v3    # "forwarding":Z
    :goto_26
    if-eqz v3, :cond_3d

    .line 102
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    .line 103
    .local v4, "now":J
    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v8, 0x3

    const/4 v9, 0x0

    move-wide v6, v4

    invoke-static/range {v4 .. v11}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v6

    .line 105
    .local v6, "e":Landroid/view/MotionEvent;
    iget-object v7, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    invoke-virtual {v7, v6}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 106
    invoke-virtual {v6}, Landroid/view/MotionEvent;->recycle()V

    .line 110
    .end local v4    # "now":J
    .end local v6    # "e":Landroid/view/MotionEvent;
    :cond_3d
    :goto_3d
    iput-boolean v3, p0, Landroidx/appcompat/widget/ForwardingListener;->mForwarding:Z

    .line 111
    if-nez v3, :cond_45

    if-eqz v0, :cond_44

    goto :goto_45

    :cond_44
    move v1, v2

    :cond_45
    :goto_45
    return v1
.end method

.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2
    .param p1, "v"    # Landroid/view/View;

    .line 116
    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 4
    .param p1, "v"    # Landroid/view/View;

    .line 120
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mForwarding:Z

    .line 121
    const/4 v0, -0x1

    iput v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mActivePointerId:I

    .line 123
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    if-eqz v0, :cond_11

    .line 124
    iget-object v0, p0, Landroidx/appcompat/widget/ForwardingListener;->mSrc:Landroid/view/View;

    iget-object v1, p0, Landroidx/appcompat/widget/ForwardingListener;->mDisallowIntercept:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 126
    :cond_11
    return-void
.end method
