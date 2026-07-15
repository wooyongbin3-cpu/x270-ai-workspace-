.class Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;
.super Ljava/lang/Object;
.source "DropDownListView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/appcompat/widget/DropDownListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "PreApi33Impl"
.end annotation


# static fields
.field private static final sIsChildViewEnabled:Ljava/lang/reflect/Field;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 814
    const/4 v0, 0x0

    .line 817
    .local v0, "isChildViewEnabled":Ljava/lang/reflect/Field;
    :try_start_1
    const-class v1, Landroid/widget/AbsListView;

    const-string v2, "mIsChildViewEnabled"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    move-object v0, v1

    .line 818
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_e
    .catch Ljava/lang/NoSuchFieldException; {:try_start_1 .. :try_end_e} :catch_f

    .line 821
    goto :goto_13

    .line 819
    :catch_f
    move-exception v1

    .line 820
    .local v1, "e":Ljava/lang/NoSuchFieldException;
    invoke-virtual {v1}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    .line 823
    .end local v1    # "e":Ljava/lang/NoSuchFieldException;
    :goto_13
    sput-object v0, Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;->sIsChildViewEnabled:Ljava/lang/reflect/Field;

    .line 824
    .end local v0    # "isChildViewEnabled":Ljava/lang/reflect/Field;
    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 826
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 828
    return-void
.end method

.method static isSelectedChildViewEnabled(Landroid/widget/AbsListView;)Z
    .registers 2
    .param p0, "view"    # Landroid/widget/AbsListView;

    .line 831
    sget-object v0, Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;->sIsChildViewEnabled:Ljava/lang/reflect/Field;

    if-eqz v0, :cond_f

    .line 833
    :try_start_4
    sget-object v0, Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;->sIsChildViewEnabled:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v0
    :try_end_a
    .catch Ljava/lang/IllegalAccessException; {:try_start_4 .. :try_end_a} :catch_b

    return v0

    .line 834
    :catch_b
    move-exception v0

    .line 835
    .local v0, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 839
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :cond_f
    const/4 v0, 0x0

    return v0
.end method

.method static setSelectedChildViewEnabled(Landroid/widget/AbsListView;Z)V
    .registers 4
    .param p0, "view"    # Landroid/widget/AbsListView;
    .param p1, "enabled"    # Z

    .line 843
    sget-object v0, Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;->sIsChildViewEnabled:Ljava/lang/reflect/Field;

    if-eqz v0, :cond_12

    .line 845
    :try_start_4
    sget-object v0, Landroidx/appcompat/widget/DropDownListView$PreApi33Impl;->sIsChildViewEnabled:Ljava/lang/reflect/Field;

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_d
    .catch Ljava/lang/IllegalAccessException; {:try_start_4 .. :try_end_d} :catch_e

    .line 848
    goto :goto_12

    .line 846
    :catch_e
    move-exception v0

    .line 847
    .local v0, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 850
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :cond_12
    :goto_12
    return-void
.end method
