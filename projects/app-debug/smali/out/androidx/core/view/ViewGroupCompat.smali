.class public final Landroidx/core/view/ViewGroupCompat;
.super Ljava/lang/Object;
.source "ViewGroupCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/view/ViewGroupCompat$Api21Impl;
    }
.end annotation


# static fields
.field private static final CONSUMED:Landroid/view/WindowInsets;

.field public static final LAYOUT_MODE_CLIP_BOUNDS:I = 0x0

.field public static final LAYOUT_MODE_OPTICAL_BOUNDS:I = 0x1

.field static sCompatInsetsDispatchInstalled:Z


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 52
    sget-object v0, Landroidx/core/view/WindowInsetsCompat;->CONSUMED:Landroidx/core/view/WindowInsetsCompat;

    invoke-virtual {v0}, Landroidx/core/view/WindowInsetsCompat;->toWindowInsets()Landroid/view/WindowInsets;

    move-result-object v0

    sput-object v0, Landroidx/core/view/ViewGroupCompat;->CONSUMED:Landroid/view/WindowInsets;

    .line 54
    const/4 v0, 0x0

    sput-boolean v0, Landroidx/core/view/ViewGroupCompat;->sCompatInsetsDispatchInstalled:Z

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static dispatchApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 13
    .param p0, "view"    # Landroid/view/View;
    .param p1, "windowInsets"    # Landroid/view/WindowInsets;

    .line 232
    sget v0, Landroidx/core/R$id;->tag_on_apply_window_listener:I

    invoke-virtual {p0, v0}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    .line 233
    .local v0, "wrappedUserListener":Ljava/lang/Object;
    sget v1, Landroidx/core/R$id;->tag_window_insets_animation_callback:I

    invoke-virtual {p0, v1}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v1

    .line 235
    .local v1, "animCallback":Ljava/lang/Object;
    instance-of v2, v0, Landroid/view/View$OnApplyWindowInsetsListener;

    if-eqz v2, :cond_14

    .line 236
    move-object v2, v0

    check-cast v2, Landroid/view/View$OnApplyWindowInsetsListener;

    goto :goto_1d

    .line 237
    :cond_14
    instance-of v2, v1, Landroid/view/View$OnApplyWindowInsetsListener;

    if-eqz v2, :cond_1c

    .line 238
    move-object v2, v1

    check-cast v2, Landroid/view/View$OnApplyWindowInsetsListener;

    goto :goto_1d

    .line 239
    :cond_1c
    const/4 v2, 0x0

    :goto_1d
    nop

    .line 244
    .local v2, "listener":Landroid/view/View$OnApplyWindowInsetsListener;
    const/4 v3, 0x1

    new-array v3, v3, [Landroid/view/WindowInsets;

    sget-object v4, Landroidx/core/view/ViewGroupCompat;->CONSUMED:Landroid/view/WindowInsets;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 245
    .local v3, "outInsets":[Landroid/view/WindowInsets;
    new-instance v4, Landroidx/core/view/ViewGroupCompat$$ExternalSyntheticLambda0;

    invoke-direct {v4, v3, v2}, Landroidx/core/view/ViewGroupCompat$$ExternalSyntheticLambda0;-><init>([Landroid/view/WindowInsets;Landroid/view/View$OnApplyWindowInsetsListener;)V

    invoke-virtual {p0, v4}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 256
    invoke-virtual {p0, p1}, Landroid/view/View;->dispatchApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    .line 259
    sget v4, Landroidx/core/R$id;->tag_compat_insets_dispatch:I

    invoke-virtual {p0, v4}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v4

    .line 260
    .local v4, "compatInsetsDispatch":Ljava/lang/Object;
    nop

    .line 261
    instance-of v6, v4, Landroid/view/View$OnApplyWindowInsetsListener;

    if-eqz v6, :cond_40

    .line 262
    move-object v6, v4

    check-cast v6, Landroid/view/View$OnApplyWindowInsetsListener;

    goto :goto_41

    .line 263
    :cond_40
    move-object v6, v2

    .line 260
    :goto_41
    invoke-virtual {p0, v6}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 265
    aget-object v6, v3, v5

    if-eqz v6, :cond_6a

    aget-object v6, v3, v5

    invoke-virtual {v6}, Landroid/view/WindowInsets;->isConsumed()Z

    move-result v6

    if-nez v6, :cond_6a

    instance-of v6, p0, Landroid/view/ViewGroup;

    if-eqz v6, :cond_6a

    .line 266
    move-object v6, p0

    check-cast v6, Landroid/view/ViewGroup;

    .line 267
    .local v6, "parent":Landroid/view/ViewGroup;
    invoke-virtual {v6}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v7

    .line 268
    .local v7, "count":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_5c
    if-ge v8, v7, :cond_6a

    .line 269
    invoke-virtual {v6, v8}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v9

    aget-object v10, v3, v5

    invoke-static {v9, v10}, Landroidx/core/view/ViewGroupCompat;->dispatchApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    .line 268
    add-int/lit8 v8, v8, 0x1

    goto :goto_5c

    .line 272
    .end local v6    # "parent":Landroid/view/ViewGroup;
    .end local v7    # "count":I
    .end local v8    # "i":I
    :cond_6a
    aget-object v6, v3, v5

    if-eqz v6, :cond_71

    aget-object v5, v3, v5

    goto :goto_73

    :cond_71
    sget-object v5, Landroidx/core/view/ViewGroupCompat;->CONSUMED:Landroid/view/WindowInsets;

    :goto_73
    return-object v5
.end method

.method public static getLayoutMode(Landroid/view/ViewGroup;)I
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "group.getLayoutMode()"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 126
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getLayoutMode()I

    move-result v0

    return v0
.end method

.method public static getNestedScrollAxes(Landroid/view/ViewGroup;)I
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;

    .line 193
    nop

    .line 194
    invoke-static {p0}, Landroidx/core/view/ViewGroupCompat$Api21Impl;->getNestedScrollAxes(Landroid/view/ViewGroup;)I

    move-result v0

    return v0
.end method

.method public static installCompatInsetsDispatch(Landroid/view/View;)V
    .registers 3
    .param p0, "root"    # Landroid/view/View;

    .line 215
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_7

    .line 216
    return-void

    .line 218
    :cond_7
    new-instance v0, Landroidx/core/view/ViewGroupCompat$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Landroidx/core/view/ViewGroupCompat$$ExternalSyntheticLambda1;-><init>()V

    .line 225
    .local v0, "listener":Landroid/view/View$OnApplyWindowInsetsListener;
    sget v1, Landroidx/core/R$id;->tag_compat_insets_dispatch:I

    invoke-virtual {p0, v1, v0}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 226
    invoke-virtual {p0, v0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 227
    const/4 v1, 0x1

    sput-boolean v1, Landroidx/core/view/ViewGroupCompat;->sCompatInsetsDispatchInstalled:Z

    .line 228
    return-void
.end method

.method public static isTransitionGroup(Landroid/view/ViewGroup;)Z
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;

    .line 169
    nop

    .line 170
    invoke-static {p0}, Landroidx/core/view/ViewGroupCompat$Api21Impl;->isTransitionGroup(Landroid/view/ViewGroup;)Z

    move-result v0

    return v0
.end method

.method static synthetic lambda$dispatchApplyWindowInsets$1([Landroid/view/WindowInsets;Landroid/view/View$OnApplyWindowInsetsListener;Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 6
    .param p0, "outInsets"    # [Landroid/view/WindowInsets;
    .param p1, "listener"    # Landroid/view/View$OnApplyWindowInsetsListener;
    .param p2, "v"    # Landroid/view/View;
    .param p3, "w"    # Landroid/view/WindowInsets;

    .line 246
    if-eqz p1, :cond_7

    .line 247
    invoke-interface {p1, p2, p3}, Landroid/view/View$OnApplyWindowInsetsListener;->onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object v0

    goto :goto_b

    .line 248
    :cond_7
    invoke-virtual {p2, p3}, Landroid/view/View;->onApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object v0

    :goto_b
    const/4 v1, 0x0

    aput-object v0, p0, v1

    .line 251
    sget-object v0, Landroidx/core/view/ViewGroupCompat;->CONSUMED:Landroid/view/WindowInsets;

    return-object v0
.end method

.method static synthetic lambda$installCompatInsetsDispatch$0(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 3
    .param p0, "view"    # Landroid/view/View;
    .param p1, "windowInsets"    # Landroid/view/WindowInsets;

    .line 219
    invoke-static {p0, p1}, Landroidx/core/view/ViewGroupCompat;->dispatchApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    .line 223
    sget-object v0, Landroidx/core/view/ViewGroupCompat;->CONSUMED:Landroid/view/WindowInsets;

    return-object v0
.end method

.method public static onRequestSendAccessibilityEvent(Landroid/view/ViewGroup;Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z
    .registers 4
    .param p0, "group"    # Landroid/view/ViewGroup;
    .param p1, "child"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/accessibility/AccessibilityEvent;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "group.onRequestSendAccessibilityEvent(child, event)"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 83
    invoke-virtual {p0, p1, p2}, Landroid/view/ViewGroup;->onRequestSendAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z

    move-result v0

    return v0
.end method

.method public static setLayoutMode(Landroid/view/ViewGroup;I)V
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;
    .param p1, "mode"    # I
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "group.setLayoutMode(mode)"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 143
    invoke-virtual {p0, p1}, Landroid/view/ViewGroup;->setLayoutMode(I)V

    .line 144
    return-void
.end method

.method public static setMotionEventSplittingEnabled(Landroid/view/ViewGroup;Z)V
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;
    .param p1, "split"    # Z
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "group.setMotionEventSplittingEnabled(split)"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 107
    invoke-virtual {p0, p1}, Landroid/view/ViewGroup;->setMotionEventSplittingEnabled(Z)V

    .line 108
    return-void
.end method

.method public static setTransitionGroup(Landroid/view/ViewGroup;Z)V
    .registers 2
    .param p0, "group"    # Landroid/view/ViewGroup;
    .param p1, "isTransitionGroup"    # Z

    .line 156
    nop

    .line 157
    invoke-static {p0, p1}, Landroidx/core/view/ViewGroupCompat$Api21Impl;->setTransitionGroup(Landroid/view/ViewGroup;Z)V

    .line 161
    return-void
.end method
