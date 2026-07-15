.class Landroidx/core/view/ViewCompat$Api30Impl;
.super Ljava/lang/Object;
.source "ViewCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/view/ViewCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Api30Impl"
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 5551
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5553
    return-void
.end method

.method static dispatchApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .registers 3
    .param p0, "view"    # Landroid/view/View;
    .param p1, "insets"    # Landroid/view/WindowInsets;

    .line 5584
    invoke-virtual {p0, p1}, Landroid/view/View;->dispatchApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object v0

    return-object v0
.end method

.method static getImportantForContentCapture(Landroid/view/View;)I
    .registers 2
    .param p0, "view"    # Landroid/view/View;

    .line 5580
    invoke-virtual {p0}, Landroid/view/View;->getImportantForContentCapture()I

    move-result v0

    return v0
.end method

.method static getStateDescription(Landroid/view/View;)Ljava/lang/CharSequence;
    .registers 2
    .param p0, "view"    # Landroid/view/View;

    .line 5568
    invoke-virtual {p0}, Landroid/view/View;->getStateDescription()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method public static getWindowInsetsController(Landroid/view/View;)Landroidx/core/view/WindowInsetsControllerCompat;
    .registers 3
    .param p0, "view"    # Landroid/view/View;

    .line 5557
    invoke-virtual {p0}, Landroid/view/View;->getWindowInsetsController()Landroid/view/WindowInsetsController;

    move-result-object v0

    .line 5558
    .local v0, "windowInsetsController":Landroid/view/WindowInsetsController;
    if-eqz v0, :cond_b

    .line 5559
    invoke-static {v0}, Landroidx/core/view/WindowInsetsControllerCompat;->toWindowInsetsControllerCompat(Landroid/view/WindowInsetsController;)Landroidx/core/view/WindowInsetsControllerCompat;

    move-result-object v1

    goto :goto_c

    .line 5560
    :cond_b
    const/4 v1, 0x0

    .line 5558
    :goto_c
    return-object v1
.end method

.method static isImportantForContentCapture(Landroid/view/View;)Z
    .registers 2
    .param p0, "view"    # Landroid/view/View;

    .line 5576
    invoke-virtual {p0}, Landroid/view/View;->isImportantForContentCapture()Z

    move-result v0

    return v0
.end method

.method static setImportantForContentCapture(Landroid/view/View;I)V
    .registers 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "mode"    # I

    .line 5572
    invoke-virtual {p0, p1}, Landroid/view/View;->setImportantForContentCapture(I)V

    .line 5573
    return-void
.end method

.method static setStateDescription(Landroid/view/View;Ljava/lang/CharSequence;)V
    .registers 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "stateDescription"    # Ljava/lang/CharSequence;

    .line 5564
    invoke-virtual {p0, p1}, Landroid/view/View;->setStateDescription(Ljava/lang/CharSequence;)V

    .line 5565
    return-void
.end method
