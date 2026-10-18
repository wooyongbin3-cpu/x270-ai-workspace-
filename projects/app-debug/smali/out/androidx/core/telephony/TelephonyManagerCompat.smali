.class public Landroidx/core/telephony/TelephonyManagerCompat;
.super Ljava/lang/Object;
.source "TelephonyManagerCompat.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/telephony/TelephonyManagerCompat$Api26Impl;,
        Landroidx/core/telephony/TelephonyManagerCompat$Api23Impl;,
        Landroidx/core/telephony/TelephonyManagerCompat$Api30Impl;
    }
.end annotation


# static fields
.field private static sGetDeviceIdMethod:Ljava/lang/reflect/Method;

.field private static sGetSubIdMethod:Ljava/lang/reflect/Method;


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 133
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getImei(Landroid/telephony/TelephonyManager;)Ljava/lang/String;
    .registers 4
    .param p0, "telephonyManager"    # Landroid/telephony/TelephonyManager;

    .line 69
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_b

    .line 70
    invoke-static {p0}, Landroidx/core/telephony/TelephonyManagerCompat$Api26Impl;->getImei(Landroid/telephony/TelephonyManager;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 71
    :cond_b
    nop

    .line 76
    invoke-static {p0}, Landroidx/core/telephony/TelephonyManagerCompat;->getSubscriptionId(Landroid/telephony/TelephonyManager;)I

    move-result v0

    .line 77
    .local v0, "subId":I
    const v1, 0x7fffffff

    if-eq v0, v1, :cond_22

    const/4 v1, -0x1

    if-eq v0, v1, :cond_22

    .line 78
    invoke-static {v0}, Landroidx/core/telephony/SubscriptionManagerCompat;->getSlotIndex(I)I

    move-result v1

    .line 79
    .local v1, "slotIndex":I
    nop

    .line 80
    invoke-static {p0, v1}, Landroidx/core/telephony/TelephonyManagerCompat$Api23Impl;->getDeviceId(Landroid/telephony/TelephonyManager;I)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 101
    .end local v0    # "subId":I
    .end local v1    # "slotIndex":I
    :cond_22
    invoke-virtual {p0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSubscriptionId(Landroid/telephony/TelephonyManager;)I
    .registers 5
    .param p0, "telephonyManager"    # Landroid/telephony/TelephonyManager;

    .line 111
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_b

    .line 112
    invoke-static {p0}, Landroidx/core/telephony/TelephonyManagerCompat$Api30Impl;->getSubscriptionId(Landroid/telephony/TelephonyManager;)I

    move-result v0

    return v0

    .line 113
    :cond_b
    nop

    .line 115
    :try_start_c
    sget-object v0, Landroidx/core/telephony/TelephonyManagerCompat;->sGetSubIdMethod:Ljava/lang/reflect/Method;

    const/4 v1, 0x0

    if-nez v0, :cond_23

    .line 116
    const-class v0, Landroid/telephony/TelephonyManager;

    const-string v2, "getSubId"

    new-array v3, v1, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Landroidx/core/telephony/TelephonyManagerCompat;->sGetSubIdMethod:Ljava/lang/reflect/Method;

    .line 117
    sget-object v0, Landroidx/core/telephony/TelephonyManagerCompat;->sGetSubIdMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 120
    :cond_23
    sget-object v0, Landroidx/core/telephony/TelephonyManagerCompat;->sGetSubIdMethod:Ljava/lang/reflect/Method;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v0, p0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 121
    .local v0, "subId":Ljava/lang/Integer;
    if-eqz v0, :cond_40

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_40

    .line 122
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_3a
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_c .. :try_end_3a} :catch_3f
    .catch Ljava/lang/IllegalAccessException; {:try_start_c .. :try_end_3a} :catch_3d
    .catch Ljava/lang/NoSuchMethodException; {:try_start_c .. :try_end_3a} :catch_3b

    return v1

    .line 126
    .end local v0    # "subId":Ljava/lang/Integer;
    :catch_3b
    move-exception v0

    goto :goto_41

    .line 125
    :catch_3d
    move-exception v0

    goto :goto_40

    .line 124
    :catch_3f
    move-exception v0

    .line 127
    :cond_40
    :goto_40
    nop

    .line 130
    :goto_41
    const v0, 0x7fffffff

    return v0
.end method
