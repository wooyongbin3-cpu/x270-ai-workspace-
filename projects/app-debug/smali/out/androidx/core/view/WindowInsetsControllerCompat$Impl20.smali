.class Landroidx/core/view/WindowInsetsControllerCompat$Impl20;
.super Landroidx/core/view/WindowInsetsControllerCompat$Impl;
.source "WindowInsetsControllerCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/view/WindowInsetsControllerCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Impl20"
.end annotation


# instance fields
.field private final mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

.field protected final mWindow:Landroid/view/Window;


# direct methods
.method constructor <init>(Landroid/view/Window;Landroidx/core/view/SoftwareKeyboardControllerCompat;)V
    .registers 3
    .param p1, "window"    # Landroid/view/Window;
    .param p2, "softwareKeyboardControllerCompat"    # Landroidx/core/view/SoftwareKeyboardControllerCompat;

    .line 452
    invoke-direct {p0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl;-><init>()V

    .line 453
    iput-object p1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    .line 454
    iput-object p2, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    .line 455
    return-void
.end method

.method private hideForType(I)V
    .registers 3
    .param p1, "type"    # I

    .line 494
    sparse-switch p1, :sswitch_data_16

    goto :goto_14

    .line 502
    :sswitch_4
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    invoke-virtual {v0}, Landroidx/core/view/SoftwareKeyboardControllerCompat;->hide()V

    goto :goto_14

    .line 499
    :sswitch_a
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->setSystemUiFlag(I)V

    .line 500
    return-void

    .line 496
    :sswitch_f
    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->setSystemUiFlag(I)V

    .line 497
    return-void

    .line 504
    :goto_14
    return-void

    nop

    :sswitch_data_16
    .sparse-switch
        0x1 -> :sswitch_f
        0x2 -> :sswitch_a
        0x8 -> :sswitch_4
    .end sparse-switch
.end method

.method private showForType(I)V
    .registers 3
    .param p1, "type"    # I

    .line 469
    sparse-switch p1, :sswitch_data_1a

    goto :goto_19

    .line 478
    :sswitch_4
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    invoke-virtual {v0}, Landroidx/core/view/SoftwareKeyboardControllerCompat;->show()V

    goto :goto_19

    .line 475
    :sswitch_a
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetSystemUiFlag(I)V

    .line 476
    return-void

    .line 471
    :sswitch_f
    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetSystemUiFlag(I)V

    .line 472
    const/16 v0, 0x400

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetWindowFlag(I)V

    .line 473
    return-void

    .line 480
    :goto_19
    return-void

    :sswitch_data_1a
    .sparse-switch
        0x1 -> :sswitch_f
        0x2 -> :sswitch_a
        0x8 -> :sswitch_4
    .end sparse-switch
.end method


# virtual methods
.method addOnControllableInsetsChangedListener(Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;)V
    .registers 2
    .param p1, "listener"    # Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;

    .line 562
    return-void
.end method

.method controlWindowInsetsAnimation(IJLandroid/view/animation/Interpolator;Landroid/os/CancellationSignal;Landroidx/core/view/WindowInsetsAnimationControlListenerCompat;)V
    .registers 7
    .param p1, "types"    # I
    .param p2, "durationMillis"    # J
    .param p4, "interpolator"    # Landroid/view/animation/Interpolator;
    .param p5, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p6, "listener"    # Landroidx/core/view/WindowInsetsAnimationControlListenerCompat;

    .line 532
    return-void
.end method

.method getSystemBarsBehavior()I
    .registers 3

    .line 555
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const v1, 0x1538b9a6

    invoke-virtual {v0, v1}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    .line 556
    .local v0, "behaviorTag":Ljava/lang/Object;
    if-eqz v0, :cond_17

    move-object v1, v0

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    goto :goto_18

    :cond_17
    const/4 v1, 0x1

    :goto_18
    return v1
.end method

.method hide(I)V
    .registers 4
    .param p1, "typeMask"    # I

    .line 484
    const/4 v0, 0x1

    .local v0, "i":I
    :goto_1
    const/16 v1, 0x200

    if-gt v0, v1, :cond_10

    .line 486
    and-int v1, p1, v0

    if-nez v1, :cond_a

    .line 487
    goto :goto_d

    .line 489
    :cond_a
    invoke-direct {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->hideForType(I)V

    .line 485
    :goto_d
    shl-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 491
    .end local v0    # "i":I
    :cond_10
    return-void
.end method

.method removeOnControllableInsetsChangedListener(Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;)V
    .registers 2
    .param p1, "listener"    # Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;

    .line 568
    return-void
.end method

.method setSystemBarsBehavior(I)V
    .registers 5
    .param p1, "behavior"    # I

    .line 536
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const v1, 0x1538b9a6

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 537
    const/16 v0, 0x800

    const/16 v1, 0x1000

    packed-switch p1, :pswitch_data_2c

    goto :goto_2b

    .line 543
    :pswitch_18
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetSystemUiFlag(I)V

    .line 544
    invoke-virtual {p0, v1}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->setSystemUiFlag(I)V

    .line 545
    goto :goto_2b

    .line 539
    :pswitch_1f
    invoke-virtual {p0, v1}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetSystemUiFlag(I)V

    .line 540
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->setSystemUiFlag(I)V

    .line 541
    goto :goto_2b

    .line 547
    :pswitch_26
    const/16 v0, 0x1800

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->unsetSystemUiFlag(I)V

    .line 551
    :goto_2b
    return-void

    :pswitch_data_2c
    .packed-switch 0x0
        :pswitch_26
        :pswitch_1f
        :pswitch_18
    .end packed-switch
.end method

.method protected setSystemUiFlag(I)V
    .registers 4
    .param p1, "systemUiFlag"    # I

    .line 507
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 508
    .local v0, "decorView":Landroid/view/View;
    nop

    .line 509
    invoke-virtual {v0}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    or-int/2addr v1, p1

    .line 508
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 511
    return-void
.end method

.method protected setWindowFlag(I)V
    .registers 3
    .param p1, "windowFlag"    # I

    .line 521
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0, p1}, Landroid/view/Window;->addFlags(I)V

    .line 522
    return-void
.end method

.method show(I)V
    .registers 4
    .param p1, "typeMask"    # I

    .line 459
    const/4 v0, 0x1

    .local v0, "i":I
    :goto_1
    const/16 v1, 0x200

    if-gt v0, v1, :cond_10

    .line 461
    and-int v1, p1, v0

    if-nez v1, :cond_a

    .line 462
    goto :goto_d

    .line 464
    :cond_a
    invoke-direct {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->showForType(I)V

    .line 460
    :goto_d
    shl-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 466
    .end local v0    # "i":I
    :cond_10
    return-void
.end method

.method protected unsetSystemUiFlag(I)V
    .registers 5
    .param p1, "systemUiFlag"    # I

    .line 514
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 515
    .local v0, "decorView":Landroid/view/View;
    nop

    .line 516
    invoke-virtual {v0}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    not-int v2, p1

    and-int/2addr v1, v2

    .line 515
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 518
    return-void
.end method

.method protected unsetWindowFlag(I)V
    .registers 3
    .param p1, "windowFlag"    # I

    .line 525
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl20;->mWindow:Landroid/view/Window;

    invoke-virtual {v0, p1}, Landroid/view/Window;->clearFlags(I)V

    .line 526
    return-void
.end method
