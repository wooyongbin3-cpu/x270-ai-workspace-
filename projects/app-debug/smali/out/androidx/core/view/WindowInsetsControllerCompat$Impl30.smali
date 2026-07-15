.class Landroidx/core/view/WindowInsetsControllerCompat$Impl30;
.super Landroidx/core/view/WindowInsetsControllerCompat$Impl;
.source "WindowInsetsControllerCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/view/WindowInsetsControllerCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Impl30"
.end annotation


# instance fields
.field final mCompatController:Landroidx/core/view/WindowInsetsControllerCompat;

.field final mInsetsController:Landroid/view/WindowInsetsController;

.field private final mListeners:Landroidx/collection/SimpleArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/collection/SimpleArrayMap<",
            "Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;",
            "Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;",
            ">;"
        }
    .end annotation
.end field

.field final mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

.field protected mWindow:Landroid/view/Window;


# direct methods
.method constructor <init>(Landroid/view/Window;Landroidx/core/view/WindowInsetsControllerCompat;Landroidx/core/view/SoftwareKeyboardControllerCompat;)V
    .registers 5
    .param p1, "window"    # Landroid/view/Window;
    .param p2, "compatController"    # Landroidx/core/view/WindowInsetsControllerCompat;
    .param p3, "softwareKeyboardControllerCompat"    # Landroidx/core/view/SoftwareKeyboardControllerCompat;

    .line 639
    invoke-virtual {p1}, Landroid/view/Window;->getInsetsController()Landroid/view/WindowInsetsController;

    move-result-object v0

    invoke-direct {p0, v0, p2, p3}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;-><init>(Landroid/view/WindowInsetsController;Landroidx/core/view/WindowInsetsControllerCompat;Landroidx/core/view/SoftwareKeyboardControllerCompat;)V

    .line 640
    iput-object p1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    .line 641
    return-void
.end method

.method constructor <init>(Landroid/view/WindowInsetsController;Landroidx/core/view/WindowInsetsControllerCompat;Landroidx/core/view/SoftwareKeyboardControllerCompat;)V
    .registers 5
    .param p1, "insetsController"    # Landroid/view/WindowInsetsController;
    .param p2, "compatController"    # Landroidx/core/view/WindowInsetsControllerCompat;
    .param p3, "softwareKeyboardControllerCompat"    # Landroidx/core/view/SoftwareKeyboardControllerCompat;

    .line 645
    invoke-direct {p0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl;-><init>()V

    .line 629
    new-instance v0, Landroidx/collection/SimpleArrayMap;

    invoke-direct {v0}, Landroidx/collection/SimpleArrayMap;-><init>()V

    iput-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mListeners:Landroidx/collection/SimpleArrayMap;

    .line 646
    iput-object p1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    .line 647
    iput-object p2, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mCompatController:Landroidx/core/view/WindowInsetsControllerCompat;

    .line 648
    iput-object p3, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    .line 649
    return-void
.end method


# virtual methods
.method addOnControllableInsetsChangedListener(Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;)V
    .registers 4
    .param p1, "listener"    # Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;

    .line 829
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mListeners:Landroidx/collection/SimpleArrayMap;

    invoke-virtual {v0, p1}, Landroidx/collection/SimpleArrayMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 831
    return-void

    .line 834
    :cond_9
    new-instance v0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30$$ExternalSyntheticLambda0;-><init>(Landroidx/core/view/WindowInsetsControllerCompat$Impl30;Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;)V

    .line 840
    .local v0, "fwListener":Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mListeners:Landroidx/collection/SimpleArrayMap;

    invoke-virtual {v1, p1, v0}, Landroidx/collection/SimpleArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 841
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v1, v0}, Landroid/view/WindowInsetsController;->addOnControllableInsetsChangedListener(Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;)V

    .line 842
    return-void
.end method

.method controlWindowInsetsAnimation(IJLandroid/view/animation/Interpolator;Landroid/os/CancellationSignal;Landroidx/core/view/WindowInsetsAnimationControlListenerCompat;)V
    .registers 15
    .param p1, "types"    # I
    .param p2, "durationMillis"    # J
    .param p4, "interpolator"    # Landroid/view/animation/Interpolator;
    .param p5, "cancellationSignal"    # Landroid/os/CancellationSignal;
    .param p6, "listener"    # Landroidx/core/view/WindowInsetsAnimationControlListenerCompat;

    .line 741
    new-instance v0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30$1;

    invoke-direct {v0, p0, p6}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30$1;-><init>(Landroidx/core/view/WindowInsetsControllerCompat$Impl30;Landroidx/core/view/WindowInsetsAnimationControlListenerCompat;)V

    move-object v7, v0

    .line 767
    .local v7, "fwListener":Landroid/view/WindowInsetsAnimationControlListener;
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    move v2, p1

    move-wide v3, p2

    move-object v5, p4

    move-object v6, p5

    .end local p1    # "types":I
    .end local p2    # "durationMillis":J
    .end local p4    # "interpolator":Landroid/view/animation/Interpolator;
    .end local p5    # "cancellationSignal":Landroid/os/CancellationSignal;
    .local v2, "types":I
    .local v3, "durationMillis":J
    .local v5, "interpolator":Landroid/view/animation/Interpolator;
    .local v6, "cancellationSignal":Landroid/os/CancellationSignal;
    invoke-interface/range {v1 .. v7}, Landroid/view/WindowInsetsController;->controlWindowInsetsAnimation(IJLandroid/view/animation/Interpolator;Landroid/os/CancellationSignal;Landroid/view/WindowInsetsAnimationControlListener;)V

    .line 772
    return-void
.end method

.method getSystemBarsBehavior()I
    .registers 3

    .line 816
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v0, :cond_1d

    .line 817
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const v1, 0x1538b9a6

    invoke-virtual {v0, v1}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v0

    .line 818
    .local v0, "behaviorTag":Ljava/lang/Object;
    if-eqz v0, :cond_1b

    move-object v1, v0

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    goto :goto_1c

    :cond_1b
    const/4 v1, 0x1

    :goto_1c
    return v1

    .line 820
    .end local v0    # "behaviorTag":Ljava/lang/Object;
    :cond_1d
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v0}, Landroid/view/WindowInsetsController;->getSystemBarsBehavior()I

    move-result v0

    return v0
.end method

.method hide(I)V
    .registers 4
    .param p1, "types"    # I

    .line 661
    and-int/lit8 v0, p1, 0x8

    if-eqz v0, :cond_9

    .line 662
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    invoke-virtual {v0}, Landroidx/core/view/SoftwareKeyboardControllerCompat;->hide()V

    .line 664
    :cond_9
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    and-int/lit8 v1, p1, -0x9

    invoke-interface {v0, v1}, Landroid/view/WindowInsetsController;->hide(I)V

    .line 665
    return-void
.end method

.method public isAppearanceLightNavigationBars()Z
    .registers 3

    .line 709
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    const/4 v1, 0x0

    invoke-interface {v0, v1, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    .line 710
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v0}, Landroid/view/WindowInsetsController;->getSystemBarsAppearance()I

    move-result v0

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_11

    const/4 v1, 0x1

    :cond_11
    return v1
.end method

.method public isAppearanceLightStatusBars()Z
    .registers 3

    .line 675
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    const/4 v1, 0x0

    invoke-interface {v0, v1, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    .line 676
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v0}, Landroid/view/WindowInsetsController;->getSystemBarsAppearance()I

    move-result v0

    and-int/lit8 v0, v0, 0x8

    if-eqz v0, :cond_11

    const/4 v1, 0x1

    :cond_11
    return v1
.end method

.method synthetic lambda$addOnControllableInsetsChangedListener$0$androidx-core-view-WindowInsetsControllerCompat$Impl30(Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;Landroid/view/WindowInsetsController;I)V
    .registers 5
    .param p1, "listener"    # Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;
    .param p2, "controller"    # Landroid/view/WindowInsetsController;
    .param p3, "typeMask"    # I

    .line 835
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    if-ne v0, p2, :cond_9

    .line 836
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mCompatController:Landroidx/core/view/WindowInsetsControllerCompat;

    invoke-interface {p1, v0, p3}, Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;->onControllableInsetsChanged(Landroidx/core/view/WindowInsetsControllerCompat;I)V

    .line 839
    :cond_9
    return-void
.end method

.method removeOnControllableInsetsChangedListener(Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;)V
    .registers 4
    .param p1, "listener"    # Landroidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener;

    .line 849
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mListeners:Landroidx/collection/SimpleArrayMap;

    invoke-virtual {v0, p1}, Landroidx/collection/SimpleArrayMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;

    .line 850
    .local v0, "fwListener":Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;
    if-eqz v0, :cond_f

    .line 851
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v1, v0}, Landroid/view/WindowInsetsController;->removeOnControllableInsetsChangedListener(Landroid/view/WindowInsetsController$OnControllableInsetsChangedListener;)V

    .line 853
    :cond_f
    return-void
.end method

.method public setAppearanceLightNavigationBars(Z)V
    .registers 5
    .param p1, "isLight"    # Z

    .line 716
    const/16 v0, 0x10

    if-eqz p1, :cond_11

    .line 717
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v1, :cond_b

    .line 718
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->setSystemUiFlag(I)V

    .line 721
    :cond_b
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v1, v0, v0}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    goto :goto_1e

    .line 725
    :cond_11
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v1, :cond_18

    .line 726
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->unsetSystemUiFlag(I)V

    .line 729
    :cond_18
    iget-object v1, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    const/4 v2, 0x0

    invoke-interface {v1, v2, v0}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    .line 733
    :goto_1e
    return-void
.end method

.method public setAppearanceLightStatusBars(Z)V
    .registers 5
    .param p1, "isLight"    # Z

    .line 682
    const/16 v0, 0x2000

    const/16 v1, 0x8

    if-eqz p1, :cond_13

    .line 683
    iget-object v2, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v2, :cond_d

    .line 684
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->setSystemUiFlag(I)V

    .line 687
    :cond_d
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v0, v1, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    goto :goto_20

    .line 691
    :cond_13
    iget-object v2, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v2, :cond_1a

    .line 692
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->unsetSystemUiFlag(I)V

    .line 695
    :cond_1a
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    const/4 v2, 0x0

    invoke-interface {v0, v2, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    .line 699
    :goto_20
    return-void
.end method

.method setSystemBarsBehavior(I)V
    .registers 5
    .param p1, "behavior"    # I

    .line 782
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    if-eqz v0, :cond_30

    .line 786
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const v1, 0x1538b9a6

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 787
    const/16 v0, 0x800

    const/16 v1, 0x1000

    packed-switch p1, :pswitch_data_36

    goto :goto_2f

    .line 793
    :pswitch_1c
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->unsetSystemUiFlag(I)V

    .line 794
    invoke-virtual {p0, v1}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->setSystemUiFlag(I)V

    .line 795
    goto :goto_2f

    .line 789
    :pswitch_23
    invoke-virtual {p0, v1}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->unsetSystemUiFlag(I)V

    .line 790
    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->setSystemUiFlag(I)V

    .line 791
    goto :goto_2f

    .line 797
    :pswitch_2a
    const/16 v0, 0x1800

    invoke-virtual {p0, v0}, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->unsetSystemUiFlag(I)V

    .line 799
    :goto_2f
    goto :goto_35

    .line 802
    :cond_30
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    invoke-interface {v0, p1}, Landroid/view/WindowInsetsController;->setSystemBarsBehavior(I)V

    .line 804
    :goto_35
    return-void

    :pswitch_data_36
    .packed-switch 0x0
        :pswitch_2a
        :pswitch_23
        :pswitch_1c
    .end packed-switch
.end method

.method protected setSystemUiFlag(I)V
    .registers 4
    .param p1, "systemUiFlag"    # I

    .line 863
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 864
    .local v0, "decorView":Landroid/view/View;
    nop

    .line 865
    invoke-virtual {v0}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    or-int/2addr v1, p1

    .line 864
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 867
    return-void
.end method

.method show(I)V
    .registers 4
    .param p1, "types"    # I

    .line 653
    and-int/lit8 v0, p1, 0x8

    if-eqz v0, :cond_9

    .line 654
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mSoftwareKeyboardControllerCompat:Landroidx/core/view/SoftwareKeyboardControllerCompat;

    invoke-virtual {v0}, Landroidx/core/view/SoftwareKeyboardControllerCompat;->show()V

    .line 656
    :cond_9
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mInsetsController:Landroid/view/WindowInsetsController;

    and-int/lit8 v1, p1, -0x9

    invoke-interface {v0, v1}, Landroid/view/WindowInsetsController;->show(I)V

    .line 657
    return-void
.end method

.method protected unsetSystemUiFlag(I)V
    .registers 5
    .param p1, "systemUiFlag"    # I

    .line 856
    iget-object v0, p0, Landroidx/core/view/WindowInsetsControllerCompat$Impl30;->mWindow:Landroid/view/Window;

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 857
    .local v0, "decorView":Landroid/view/View;
    nop

    .line 858
    invoke-virtual {v0}, Landroid/view/View;->getSystemUiVisibility()I

    move-result v1

    not-int v2, p1

    and-int/2addr v1, v2

    .line 857
    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 860
    return-void
.end method
