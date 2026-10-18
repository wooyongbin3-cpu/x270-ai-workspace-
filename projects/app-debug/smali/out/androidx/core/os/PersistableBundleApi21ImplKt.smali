.class final Landroidx/core/os/PersistableBundleApi21ImplKt;
.super Ljava/lang/Object;
.source "PersistableBundle.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\u0008\u00c3\u0002\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0010\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0007J$\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u00052\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u000c2\u0008\u0010\r\u001a\u0004\u0018\u00010\u0001H\u0007\u00a8\u0006\u000e"
    }
    d2 = {
        "Landroidx/core/os/PersistableBundleApi21ImplKt;",
        "",
        "<init>",
        "()V",
        "createPersistableBundle",
        "Landroid/os/PersistableBundle;",
        "capacity",
        "",
        "putValue",
        "",
        "persistableBundle",
        "key",
        "",
        "value",
        "core-ktx_release"
    }
    k = 0x1
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Landroidx/core/os/PersistableBundleApi21ImplKt;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    new-instance v0, Landroidx/core/os/PersistableBundleApi21ImplKt;

    invoke-direct {v0}, Landroidx/core/os/PersistableBundleApi21ImplKt;-><init>()V

    sput-object v0, Landroidx/core/os/PersistableBundleApi21ImplKt;->INSTANCE:Landroidx/core/os/PersistableBundleApi21ImplKt;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final createPersistableBundle(I)Landroid/os/PersistableBundle;
    .registers 2
    .param p0, "capacity"    # I
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 71
    new-instance v0, Landroid/os/PersistableBundle;

    invoke-direct {v0, p0}, Landroid/os/PersistableBundle;-><init>(I)V

    return-object v0
.end method

.method public static final putValue(Landroid/os/PersistableBundle;Ljava/lang/String;Ljava/lang/Object;)V
    .registers 12
    .param p0, "persistableBundle"    # Landroid/os/PersistableBundle;
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 75
    move-object v0, p0

    .local v0, "$this$putValue_u24lambda_u240":Landroid/os/PersistableBundle;
    const/4 v1, 0x0

    .line 76
    .local v1, "$i$a$-apply-PersistableBundleApi21ImplKt$putValue$1":I
    nop

    .line 77
    if-nez p2, :cond_b

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_b6

    .line 80
    :cond_b
    instance-of v2, p2, Ljava/lang/Boolean;

    if-eqz v2, :cond_1c

    .line 81
    nop

    .line 82
    move-object v2, p2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    invoke-static {v0, p1, v2}, Landroidx/core/os/PersistableBundleApi22ImplKt;->putBoolean(Landroid/os/PersistableBundle;Ljava/lang/String;Z)V

    goto/16 :goto_b6

    .line 90
    :cond_1c
    instance-of v2, p2, Ljava/lang/Double;

    if-eqz v2, :cond_2c

    move-object v2, p2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->doubleValue()D

    move-result-wide v2

    invoke-virtual {v0, p1, v2, v3}, Landroid/os/PersistableBundle;->putDouble(Ljava/lang/String;D)V

    goto/16 :goto_b6

    .line 91
    :cond_2c
    instance-of v2, p2, Ljava/lang/Integer;

    if-eqz v2, :cond_3c

    move-object v2, p2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putInt(Ljava/lang/String;I)V

    goto/16 :goto_b6

    .line 92
    :cond_3c
    instance-of v2, p2, Ljava/lang/Long;

    if-eqz v2, :cond_4c

    move-object v2, p2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->longValue()J

    move-result-wide v2

    invoke-virtual {v0, p1, v2, v3}, Landroid/os/PersistableBundle;->putLong(Ljava/lang/String;J)V

    goto/16 :goto_b6

    .line 95
    :cond_4c
    instance-of v2, p2, Ljava/lang/String;

    if-eqz v2, :cond_57

    move-object v2, p2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_b6

    .line 96
    :cond_57
    instance-of v2, p2, Landroid/os/PersistableBundle;

    if-eqz v2, :cond_62

    move-object v2, p2

    check-cast v2, Landroid/os/PersistableBundle;

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putPersistableBundle(Ljava/lang/String;Landroid/os/PersistableBundle;)V

    goto :goto_b6

    .line 99
    :cond_62
    instance-of v2, p2, [Z

    if-eqz v2, :cond_6e

    .line 100
    nop

    .line 101
    move-object v2, p2

    check-cast v2, [Z

    invoke-static {v0, p1, v2}, Landroidx/core/os/PersistableBundleApi22ImplKt;->putBooleanArray(Landroid/os/PersistableBundle;Ljava/lang/String;[Z)V

    goto :goto_b6

    .line 109
    :cond_6e
    instance-of v2, p2, [D

    if-eqz v2, :cond_79

    move-object v2, p2

    check-cast v2, [D

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putDoubleArray(Ljava/lang/String;[D)V

    goto :goto_b6

    .line 110
    :cond_79
    instance-of v2, p2, [I

    if-eqz v2, :cond_84

    move-object v2, p2

    check-cast v2, [I

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putIntArray(Ljava/lang/String;[I)V

    goto :goto_b6

    .line 111
    :cond_84
    instance-of v2, p2, [J

    if-eqz v2, :cond_8f

    move-object v2, p2

    check-cast v2, [J

    invoke-virtual {v0, p1, v2}, Landroid/os/PersistableBundle;->putLongArray(Ljava/lang/String;[J)V

    goto :goto_b6

    .line 114
    :cond_8f
    instance-of v2, p2, [Ljava/lang/Object;

    const/16 v3, 0x22

    const-string v4, " for key \""

    if-eqz v2, :cond_e2

    .line 115
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 117
    .local v2, "componentType":Ljava/lang/Class;
    nop

    .line 118
    const-class v5, Ljava/lang/String;

    invoke-virtual {v5, v2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v5

    if-eqz v5, :cond_b9

    .line 119
    const-string v3, "null cannot be cast to non-null type kotlin.Array<kotlin.String>"

    invoke-static {p2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v3, p2

    check-cast v3, [Ljava/lang/String;

    invoke-virtual {v0, p1, v3}, Landroid/os/PersistableBundle;->putStringArray(Ljava/lang/String;[Ljava/lang/String;)V

    .line 136
    .end local v2    # "componentType":Ljava/lang/Class;
    :goto_b6
    nop

    .line 75
    .end local v0    # "$this$putValue_u24lambda_u240":Landroid/os/PersistableBundle;
    .end local v1    # "$i$a$-apply-PersistableBundleApi21ImplKt$putValue$1":I
    nop

    .line 137
    return-void

    .line 122
    .restart local v0    # "$this$putValue_u24lambda_u240":Landroid/os/PersistableBundle;
    .restart local v1    # "$i$a$-apply-PersistableBundleApi21ImplKt$putValue$1":I
    .restart local v2    # "componentType":Ljava/lang/Class;
    :cond_b9
    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v5

    .line 123
    .local v5, "valueType":Ljava/lang/String;
    new-instance v6, Ljava/lang/IllegalArgumentException;

    .line 124
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unsupported value array type "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 123
    invoke-direct {v6, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 130
    .end local v2    # "componentType":Ljava/lang/Class;
    .end local v5    # "valueType":Ljava/lang/String;
    :cond_e2
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    .line 131
    .local v2, "valueType":Ljava/lang/String;
    new-instance v5, Ljava/lang/IllegalArgumentException;

    .line 132
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unsupported value type "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 131
    invoke-direct {v5, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5
.end method
