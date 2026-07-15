.class Landroidx/core/view/insets/ProtectionGroup;
.super Ljava/lang/Object;
.source "ProtectionGroup.java"

# interfaces
.implements Landroidx/core/view/insets/SystemBarStateMonitor$Callback;


# instance fields
.field private mAnimationCount:I

.field private mDisposed:Z

.field private mInsets:Landroidx/core/graphics/Insets;

.field private mInsetsIgnoringVisibility:Landroidx/core/graphics/Insets;

.field private final mMonitor:Landroidx/core/view/insets/SystemBarStateMonitor;

.field private final mProtections:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroidx/core/view/insets/Protection;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroidx/core/view/insets/SystemBarStateMonitor;Ljava/util/List;)V
    .registers 4
    .param p1, "monitor"    # Landroidx/core/view/insets/SystemBarStateMonitor;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/core/view/insets/SystemBarStateMonitor;",
            "Ljava/util/List<",
            "Landroidx/core/view/insets/Protection;",
            ">;)V"
        }
    .end annotation

    .line 52
    .local p2, "protections":Ljava/util/List;, "Ljava/util/List<Landroidx/core/view/insets/Protection;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    .line 47
    sget-object v0, Landroidx/core/graphics/Insets;->NONE:Landroidx/core/graphics/Insets;

    iput-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsets:Landroidx/core/graphics/Insets;

    .line 48
    sget-object v0, Landroidx/core/graphics/Insets;->NONE:Landroidx/core/graphics/Insets;

    iput-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsetsIgnoringVisibility:Landroidx/core/graphics/Insets;

    .line 53
    const/4 v0, 0x0

    invoke-direct {p0, p2, v0}, Landroidx/core/view/insets/ProtectionGroup;->addProtections(Ljava/util/List;Z)V

    .line 54
    const/4 v0, 0x1

    invoke-direct {p0, p2, v0}, Landroidx/core/view/insets/ProtectionGroup;->addProtections(Ljava/util/List;Z)V

    .line 55
    invoke-virtual {p1, p0}, Landroidx/core/view/insets/SystemBarStateMonitor;->addCallback(Landroidx/core/view/insets/SystemBarStateMonitor$Callback;)V

    .line 56
    iput-object p1, p0, Landroidx/core/view/insets/ProtectionGroup;->mMonitor:Landroidx/core/view/insets/SystemBarStateMonitor;

    .line 57
    return-void
.end method

.method private addProtections(Ljava/util/List;Z)V
    .registers 10
    .param p2, "occupiesCorners"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroidx/core/view/insets/Protection;",
            ">;Z)V"
        }
    .end annotation

    .line 60
    .local p1, "protections":Ljava/util/List;, "Ljava/util/List<Landroidx/core/view/insets/Protection;>;"
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    .line 61
    .local v0, "size":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_5
    if-ge v1, v0, :cond_42

    .line 62
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/view/insets/Protection;

    .line 63
    .local v2, "protection":Landroidx/core/view/insets/Protection;
    invoke-virtual {v2}, Landroidx/core/view/insets/Protection;->occupiesCorners()Z

    move-result v3

    if-eq v3, p2, :cond_14

    .line 64
    goto :goto_22

    .line 66
    :cond_14
    invoke-virtual {v2}, Landroidx/core/view/insets/Protection;->getController()Ljava/lang/Object;

    move-result-object v3

    .line 67
    .local v3, "controller":Ljava/lang/Object;
    if-nez v3, :cond_25

    .line 68
    invoke-virtual {v2, p0}, Landroidx/core/view/insets/Protection;->setController(Ljava/lang/Object;)V

    .line 69
    iget-object v4, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 61
    .end local v2    # "protection":Landroidx/core/view/insets/Protection;
    .end local v3    # "controller":Ljava/lang/Object;
    :goto_22
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 71
    .restart local v2    # "protection":Landroidx/core/view/insets/Protection;
    .restart local v3    # "controller":Ljava/lang/Object;
    :cond_25
    new-instance v4, Ljava/lang/IllegalStateException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is already controlled by "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 75
    .end local v1    # "i":I
    .end local v2    # "protection":Landroidx/core/view/insets/Protection;
    .end local v3    # "controller":Ljava/lang/Object;
    :cond_42
    return-void
.end method

.method private updateInsets()V
    .registers 6

    .line 78
    sget-object v0, Landroidx/core/graphics/Insets;->NONE:Landroidx/core/graphics/Insets;

    .line 79
    .local v0, "consumed":Landroidx/core/graphics/Insets;
    iget-object v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .local v1, "i":I
    :goto_a
    if-ltz v1, :cond_23

    .line 80
    iget-object v2, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/core/view/insets/Protection;

    .line 81
    .local v2, "protection":Landroidx/core/view/insets/Protection;
    iget-object v3, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsets:Landroidx/core/graphics/Insets;

    iget-object v4, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsetsIgnoringVisibility:Landroidx/core/graphics/Insets;

    invoke-virtual {v2, v3, v4, v0}, Landroidx/core/view/insets/Protection;->dispatchInsets(Landroidx/core/graphics/Insets;Landroidx/core/graphics/Insets;Landroidx/core/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v3

    invoke-static {v0, v3}, Landroidx/core/graphics/Insets;->max(Landroidx/core/graphics/Insets;Landroidx/core/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    .line 79
    .end local v2    # "protection":Landroidx/core/view/insets/Protection;
    add-int/lit8 v1, v1, -0x1

    goto :goto_a

    .line 84
    .end local v1    # "i":I
    :cond_23
    return-void
.end method


# virtual methods
.method dispose()V
    .registers 4

    .line 183
    iget-boolean v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mDisposed:Z

    if-eqz v0, :cond_5

    .line 184
    return-void

    .line 186
    :cond_5
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mDisposed:Z

    .line 187
    iget-object v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mMonitor:Landroidx/core/view/insets/SystemBarStateMonitor;

    invoke-virtual {v1, p0}, Landroidx/core/view/insets/SystemBarStateMonitor;->removeCallback(Landroidx/core/view/insets/SystemBarStateMonitor$Callback;)V

    .line 188
    iget-object v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    sub-int/2addr v1, v0

    .local v1, "i":I
    :goto_14
    if-ltz v1, :cond_25

    .line 189
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/core/view/insets/Protection;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroidx/core/view/insets/Protection;->setController(Ljava/lang/Object;)V

    .line 188
    add-int/lit8 v1, v1, -0x1

    goto :goto_14

    .line 191
    .end local v1    # "i":I
    :cond_25
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 192
    return-void
.end method

.method getProtection(I)Landroidx/core/view/insets/Protection;
    .registers 3
    .param p1, "index"    # I

    .line 176
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/core/view/insets/Protection;

    return-object v0
.end method

.method public onAnimationEnd()V
    .registers 4

    .line 150
    iget v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    const/4 v1, 0x1

    if-lez v0, :cond_7

    move v0, v1

    goto :goto_8

    :cond_7
    const/4 v0, 0x0

    .line 151
    .local v0, "wasAnimating":Z
    :goto_8
    iget v2, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    sub-int/2addr v2, v1

    iput v2, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    .line 152
    if-eqz v0, :cond_16

    iget v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    if-nez v1, :cond_16

    .line 155
    invoke-direct {p0}, Landroidx/core/view/insets/ProtectionGroup;->updateInsets()V

    .line 157
    :cond_16
    return-void
.end method

.method public onAnimationProgress(ILandroidx/core/graphics/Insets;Landroid/graphics/RectF;)V
    .registers 11
    .param p1, "sides"    # I
    .param p2, "insets"    # Landroidx/core/graphics/Insets;
    .param p3, "alpha"    # Landroid/graphics/RectF;

    .line 107
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsetsIgnoringVisibility:Landroidx/core/graphics/Insets;

    .line 108
    .local v0, "insetsStable":Landroidx/core/graphics/Insets;
    iget-object v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    .local v1, "i":I
    :goto_a
    if-ltz v1, :cond_77

    .line 109
    iget-object v3, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/core/view/insets/Protection;

    .line 110
    .local v3, "protection":Landroidx/core/view/insets/Protection;
    invoke-virtual {v3}, Landroidx/core/view/insets/Protection;->getSide()I

    move-result v4

    .line 111
    .local v4, "side":I
    and-int v5, v4, p1

    if-nez v5, :cond_1d

    .line 112
    goto :goto_74

    .line 114
    :cond_1d
    invoke-virtual {v3, v2}, Landroidx/core/view/insets/Protection;->setSystemVisible(Z)V

    .line 115
    sparse-switch v4, :sswitch_data_78

    goto :goto_74

    .line 138
    :sswitch_24
    iget v5, v0, Landroidx/core/graphics/Insets;->bottom:I

    if-lez v5, :cond_32

    .line 139
    iget v5, p2, Landroidx/core/graphics/Insets;->bottom:I

    int-to-float v5, v5

    iget v6, v0, Landroidx/core/graphics/Insets;->bottom:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemInsetAmount(F)V

    .line 142
    :cond_32
    iget v5, p3, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemAlpha(F)V

    goto :goto_74

    .line 131
    :sswitch_38
    iget v5, v0, Landroidx/core/graphics/Insets;->right:I

    if-lez v5, :cond_46

    .line 132
    iget v5, p2, Landroidx/core/graphics/Insets;->right:I

    int-to-float v5, v5

    iget v6, v0, Landroidx/core/graphics/Insets;->right:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemInsetAmount(F)V

    .line 135
    :cond_46
    iget v5, p3, Landroid/graphics/RectF;->right:F

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemAlpha(F)V

    .line 136
    goto :goto_74

    .line 124
    :sswitch_4c
    iget v5, v0, Landroidx/core/graphics/Insets;->top:I

    if-lez v5, :cond_5a

    .line 125
    iget v5, p2, Landroidx/core/graphics/Insets;->top:I

    int-to-float v5, v5

    iget v6, v0, Landroidx/core/graphics/Insets;->top:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemInsetAmount(F)V

    .line 128
    :cond_5a
    iget v5, p3, Landroid/graphics/RectF;->top:F

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemAlpha(F)V

    .line 129
    goto :goto_74

    .line 117
    :sswitch_60
    iget v5, v0, Landroidx/core/graphics/Insets;->left:I

    if-lez v5, :cond_6e

    .line 118
    iget v5, p2, Landroidx/core/graphics/Insets;->left:I

    int-to-float v5, v5

    iget v6, v0, Landroidx/core/graphics/Insets;->left:I

    int-to-float v6, v6

    div-float/2addr v5, v6

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemInsetAmount(F)V

    .line 121
    :cond_6e
    iget v5, p3, Landroid/graphics/RectF;->left:F

    invoke-virtual {v3, v5}, Landroidx/core/view/insets/Protection;->setSystemAlpha(F)V

    .line 122
    nop

    .line 108
    .end local v3    # "protection":Landroidx/core/view/insets/Protection;
    .end local v4    # "side":I
    :goto_74
    add-int/lit8 v1, v1, -0x1

    goto :goto_a

    .line 146
    .end local v1    # "i":I
    :cond_77
    return-void

    :sswitch_data_78
    .sparse-switch
        0x1 -> :sswitch_60
        0x2 -> :sswitch_4c
        0x4 -> :sswitch_38
        0x8 -> :sswitch_24
    .end sparse-switch
.end method

.method public onAnimationStart()V
    .registers 2

    .line 102
    iget v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mAnimationCount:I

    .line 103
    return-void
.end method

.method public onColorHintChanged(I)V
    .registers 4
    .param p1, "color"    # I

    .line 95
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    .local v0, "i":I
    :goto_8
    if-ltz v0, :cond_18

    .line 96
    iget-object v1, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/core/view/insets/Protection;

    invoke-virtual {v1, p1}, Landroidx/core/view/insets/Protection;->dispatchColorHint(I)V

    .line 95
    add-int/lit8 v0, v0, -0x1

    goto :goto_8

    .line 98
    .end local v0    # "i":I
    :cond_18
    return-void
.end method

.method public onInsetsChanged(Landroidx/core/graphics/Insets;Landroidx/core/graphics/Insets;)V
    .registers 3
    .param p1, "insets"    # Landroidx/core/graphics/Insets;
    .param p2, "insetsIgnoringVisibility"    # Landroidx/core/graphics/Insets;

    .line 88
    iput-object p1, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsets:Landroidx/core/graphics/Insets;

    .line 89
    iput-object p2, p0, Landroidx/core/view/insets/ProtectionGroup;->mInsetsIgnoringVisibility:Landroidx/core/graphics/Insets;

    .line 90
    invoke-direct {p0}, Landroidx/core/view/insets/ProtectionGroup;->updateInsets()V

    .line 91
    return-void
.end method

.method size()I
    .registers 2

    .line 165
    iget-object v0, p0, Landroidx/core/view/insets/ProtectionGroup;->mProtections:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method
