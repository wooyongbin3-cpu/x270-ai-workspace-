.class public Landroidx/appcompat/widget/ViewUtils;
.super Ljava/lang/Object;
.source "ViewUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/widget/ViewUtils$Api29Impl;
    }
.end annotation


# static fields
.field static final SDK_LEVEL_SUPPORTS_AUTOSIZE:Z

.field private static final TAG:Ljava/lang/String; = "ViewUtils"

.field private static sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

.field private static sInitComputeFitSystemWindowsMethod:Z


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 52
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1b

    if-lt v0, v1, :cond_8

    const/4 v0, 0x1

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    :goto_9
    sput-boolean v0, Landroidx/appcompat/widget/ViewUtils;->SDK_LEVEL_SUPPORTS_AUTOSIZE:Z

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static computeFitSystemWindows(Landroid/view/View;Landroid/graphics/Rect;Landroid/graphics/Rect;)V
    .registers 10
    .param p0, "view"    # Landroid/view/View;
    .param p1, "inoutInsets"    # Landroid/graphics/Rect;
    .param p2, "outLocalInsets"    # Landroid/graphics/Rect;

    .line 66
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_a

    .line 67
    invoke-static {p0, p1, p2}, Landroidx/appcompat/widget/ViewUtils$Api29Impl;->computeFitSystemWindows(Landroid/view/View;Landroid/graphics/Rect;Landroid/graphics/Rect;)V

    goto :goto_51

    .line 69
    :cond_a
    sget-boolean v0, Landroidx/appcompat/widget/ViewUtils;->sInitComputeFitSystemWindowsMethod:Z

    const-string v1, "ViewUtils"

    if-nez v0, :cond_3d

    .line 70
    const/4 v0, 0x1

    sput-boolean v0, Landroidx/appcompat/widget/ViewUtils;->sInitComputeFitSystemWindowsMethod:Z

    .line 72
    :try_start_13
    const-class v2, Landroid/view/View;

    const-string v3, "computeFitSystemWindows"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const-class v5, Landroid/graphics/Rect;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const-class v5, Landroid/graphics/Rect;

    aput-object v5, v4, v0

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Landroidx/appcompat/widget/ViewUtils;->sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

    .line 74
    sget-object v2, Landroidx/appcompat/widget/ViewUtils;->sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

    invoke-virtual {v2}, Ljava/lang/reflect/Method;->isAccessible()Z

    move-result v2

    if-nez v2, :cond_36

    .line 75
    sget-object v2, Landroidx/appcompat/widget/ViewUtils;->sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

    invoke-virtual {v2, v0}, Ljava/lang/reflect/Method;->setAccessible(Z)V
    :try_end_36
    .catch Ljava/lang/NoSuchMethodException; {:try_start_13 .. :try_end_36} :catch_37

    .line 79
    :cond_36
    goto :goto_3d

    .line 77
    :catch_37
    move-exception v0

    .line 78
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    const-string v2, "Could not find method computeFitSystemWindows. Oh well."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :cond_3d
    :goto_3d
    sget-object v0, Landroidx/appcompat/widget/ViewUtils;->sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_51

    .line 84
    :try_start_41
    sget-object v0, Landroidx/appcompat/widget/ViewUtils;->sComputeFitSystemWindowsMethod:Ljava/lang/reflect/Method;

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4a
    .catch Ljava/lang/Exception; {:try_start_41 .. :try_end_4a} :catch_4b

    .line 87
    goto :goto_51

    .line 85
    :catch_4b
    move-exception v0

    .line 86
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Could not invoke computeFitSystemWindows"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 90
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_51
    :goto_51
    return-void
.end method

.method public static isLayoutRtl(Landroid/view/View;)Z
    .registers 3
    .param p0, "view"    # Landroid/view/View;

    .line 57
    invoke-virtual {p0}, Landroid/view/View;->getLayoutDirection()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_8

    goto :goto_9

    :cond_8
    const/4 v1, 0x0

    :goto_9
    return v1
.end method

.method public static makeOptionalFitsSystemWindows(Landroid/view/View;)V
    .registers 7
    .param p0, "view"    # Landroid/view/View;

    .line 101
    const-string v0, "Could not invoke makeOptionalFitsSystemWindows"

    const-string v1, "ViewUtils"

    :try_start_4
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "makeOptionalFitsSystemWindows"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 102
    .local v2, "method":Ljava/lang/reflect/Method;
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->isAccessible()Z

    move-result v3

    if-nez v3, :cond_1b

    .line 103
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 105
    :cond_1b
    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v2, p0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_20
    .catch Ljava/lang/NoSuchMethodException; {:try_start_4 .. :try_end_20} :catch_2c
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_4 .. :try_end_20} :catch_27
    .catch Ljava/lang/IllegalAccessException; {:try_start_4 .. :try_end_20} :catch_22

    .line 112
    nop

    .end local v2    # "method":Ljava/lang/reflect/Method;
    goto :goto_33

    .line 110
    :catch_22
    move-exception v2

    .line 111
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-static {v1, v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_33

    .line 108
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_27
    move-exception v2

    .line 109
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-static {v1, v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    goto :goto_32

    .line 106
    :catch_2c
    move-exception v0

    .line 107
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    const-string v2, "Could not find method makeOptionalFitsSystemWindows. Oh well..."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 112
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :goto_32
    nop

    .line 113
    :goto_33
    return-void
.end method
