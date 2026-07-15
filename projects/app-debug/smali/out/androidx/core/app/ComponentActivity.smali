.class public Landroidx/core/app/ComponentActivity;
.super Landroid/app/Activity;
.source "ComponentActivity.kt"

# interfaces
.implements Landroidx/lifecycle/LifecycleOwner;
.implements Landroidx/core/view/KeyEventDispatcher$Component;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/app/ComponentActivity$ExtraData;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000^\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0011\n\u0002\u0010\u000e\n\u0002\u0008\u0004\u0008\u0017\u0018\u00002\u00020\u00012\u00020\u00022\u00020\u0003:\u0001*B\u0007\u00a2\u0006\u0004\u0008\u0004\u0010\u0005J\u0010\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\tH\u0017J\u0012\u0010\u0011\u001a\u00020\u000f2\u0008\u0010\u0012\u001a\u0004\u0018\u00010\u0013H\u0014J\u0010\u0010\u0014\u001a\u00020\u000f2\u0006\u0010\u0015\u001a\u00020\u0013H\u0015J\'\u0010\u0016\u001a\u0004\u0018\u0001H\u0017\"\u0008\u0008\u0000\u0010\u0017*\u00020\t2\u000c\u0010\u0018\u001a\u0008\u0012\u0004\u0012\u0002H\u00170\u0008H\u0017\u00a2\u0006\u0002\u0010\u0019J\u0010\u0010\u001e\u001a\u00020\u001f2\u0006\u0010 \u001a\u00020!H\u0017J\u0010\u0010\"\u001a\u00020\u001f2\u0006\u0010 \u001a\u00020!H\u0016J\u0010\u0010#\u001a\u00020\u001f2\u0006\u0010 \u001a\u00020!H\u0016J\u001d\u0010$\u001a\u00020\u001f2\u000e\u0010%\u001a\n\u0012\u0004\u0012\u00020\'\u0018\u00010&H\u0004\u00a2\u0006\u0002\u0010(J\u001d\u0010)\u001a\u00020\u001f2\u000e\u0010%\u001a\n\u0012\u0004\u0012\u00020\'\u0018\u00010&H\u0002\u00a2\u0006\u0002\u0010(R(\u0010\u0006\u001a\u0016\u0012\u000c\u0012\n\u0012\u0006\u0008\u0001\u0012\u00020\t0\u0008\u0012\u0004\u0012\u00020\t0\u0007X\u0082\u0004\u00a2\u0006\u0008\n\u0000\u0012\u0004\u0008\n\u0010\u0005R\u0014\u0010\u000b\u001a\u00020\u000cX\u0082\u0004\u00a2\u0006\u0008\n\u0000\u0012\u0004\u0008\r\u0010\u0005R\u0014\u0010\u001a\u001a\u00020\u001b8VX\u0096\u0004\u00a2\u0006\u0006\u001a\u0004\u0008\u001c\u0010\u001d\u00a8\u0006+"
    }
    d2 = {
        "Landroidx/core/app/ComponentActivity;",
        "Landroid/app/Activity;",
        "Landroidx/lifecycle/LifecycleOwner;",
        "Landroidx/core/view/KeyEventDispatcher$Component;",
        "<init>",
        "()V",
        "extraDataMap",
        "Landroidx/collection/SimpleArrayMap;",
        "Ljava/lang/Class;",
        "Landroidx/core/app/ComponentActivity$ExtraData;",
        "getExtraDataMap$annotations",
        "lifecycleRegistry",
        "Landroidx/lifecycle/LifecycleRegistry;",
        "getLifecycleRegistry$annotations",
        "putExtraData",
        "",
        "extraData",
        "onCreate",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "onSaveInstanceState",
        "outState",
        "getExtraData",
        "T",
        "extraDataClass",
        "(Ljava/lang/Class;)Landroidx/core/app/ComponentActivity$ExtraData;",
        "lifecycle",
        "Landroidx/lifecycle/Lifecycle;",
        "getLifecycle",
        "()Landroidx/lifecycle/Lifecycle;",
        "superDispatchKeyEvent",
        "",
        "event",
        "Landroid/view/KeyEvent;",
        "dispatchKeyShortcutEvent",
        "dispatchKeyEvent",
        "shouldDumpInternalState",
        "args",
        "",
        "",
        "([Ljava/lang/String;)Z",
        "shouldSkipDump",
        "ExtraData",
        "core_release"
    }
    k = 0x1
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final extraDataMap:Landroidx/collection/SimpleArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/collection/SimpleArrayMap<",
            "Ljava/lang/Class<",
            "+",
            "Landroidx/core/app/ComponentActivity$ExtraData;",
            ">;",
            "Landroidx/core/app/ComponentActivity$ExtraData;",
            ">;"
        }
    .end annotation
.end field

.field private final lifecycleRegistry:Landroidx/lifecycle/LifecycleRegistry;


# direct methods
.method public constructor <init>()V
    .registers 5

    .line 38
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 45
    new-instance v0, Landroidx/collection/SimpleArrayMap;

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-direct {v0, v3, v1, v2}, Landroidx/collection/SimpleArrayMap;-><init>(IILkotlin/jvm/internal/DefaultConstructorMarker;)V

    iput-object v0, p0, Landroidx/core/app/ComponentActivity;->extraDataMap:Landroidx/collection/SimpleArrayMap;

    .line 51
    new-instance v0, Landroidx/lifecycle/LifecycleRegistry;

    move-object v1, p0

    check-cast v1, Landroidx/lifecycle/LifecycleOwner;

    invoke-direct {v0, v1}, Landroidx/lifecycle/LifecycleRegistry;-><init>(Landroidx/lifecycle/LifecycleOwner;)V

    iput-object v0, p0, Landroidx/core/app/ComponentActivity;->lifecycleRegistry:Landroidx/lifecycle/LifecycleRegistry;

    .line 37
    return-void
.end method

.method private static synthetic getExtraDataMap$annotations()V
    .registers 0

    return-void
.end method

.method private static synthetic getLifecycleRegistry$annotations()V
    .registers 0

    return-void
.end method

.method private final shouldSkipDump([Ljava/lang/String;)Z
    .registers 6
    .param p1, "args"    # [Ljava/lang/String;

    .line 139
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_f

    array-length v2, p1

    if-nez v2, :cond_9

    move v2, v0

    goto :goto_a

    :cond_9
    move v2, v1

    :goto_a
    if-eqz v2, :cond_d

    goto :goto_f

    :cond_d
    move v2, v1

    goto :goto_10

    :cond_f
    :goto_f
    move v2, v0

    :goto_10
    if-nez v2, :cond_6d

    .line 141
    aget-object v2, p1, v1

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    sparse-switch v3, :sswitch_data_6e

    :goto_1b
    goto :goto_6d

    :sswitch_1c
    const-string v3, "--autofill"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_25

    goto :goto_1b

    .line 142
    :cond_25
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v2, v3, :cond_2c

    goto :goto_2d

    :cond_2c
    move v0, v1

    :goto_2d
    return v0

    .line 141
    :sswitch_2e
    const-string v3, "--contentcapture"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_37

    goto :goto_1b

    .line 143
    :cond_37
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-lt v2, v3, :cond_3e

    goto :goto_3f

    :cond_3e
    move v0, v1

    :goto_3f
    return v0

    .line 141
    :sswitch_40
    const-string v3, "--list-dumpables"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_52

    goto :goto_1b

    :sswitch_49
    const-string v3, "--dump-dumpable"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_52

    goto :goto_1b

    .line 146
    :cond_52
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x21

    if-lt v2, v3, :cond_59

    goto :goto_5a

    :cond_59
    move v0, v1

    :goto_5a
    return v0

    .line 141
    :sswitch_5b
    const-string v3, "--translation"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_64

    goto :goto_1b

    .line 144
    :cond_64
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1f

    if-lt v2, v3, :cond_6b

    goto :goto_6c

    :cond_6b
    move v0, v1

    :goto_6c
    return v0

    .line 149
    :cond_6d
    :goto_6d
    return v1

    :sswitch_data_6e
    .sparse-switch
        -0x2673d6ef -> :sswitch_5b
        0x5fd0f67 -> :sswitch_49
        0x1c2b8816 -> :sswitch_40
        0x4519f64d -> :sswitch_2e
        0x56b9c952 -> :sswitch_1c
    .end sparse-switch
.end method


# virtual methods
.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .registers 5
    .param p1, "event"    # Landroid/view/KeyEvent;

    const-string v0, "event"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    invoke-virtual {p0}, Landroidx/core/app/ComponentActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const-string v1, "getDecorView(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 108
    .local v0, "decor":Landroid/view/View;
    invoke-static {v0, p1}, Landroidx/core/view/KeyEventDispatcher;->dispatchBeforeHierarchy(Landroid/view/View;Landroid/view/KeyEvent;)Z

    move-result v1

    if-eqz v1, :cond_1a

    .line 109
    const/4 v1, 0x1

    goto :goto_24

    .line 110
    :cond_1a
    move-object v1, p0

    check-cast v1, Landroidx/core/view/KeyEventDispatcher$Component;

    move-object v2, p0

    check-cast v2, Landroid/view/Window$Callback;

    invoke-static {v1, v0, v2, p1}, Landroidx/core/view/KeyEventDispatcher;->dispatchKeyEvent(Landroidx/core/view/KeyEventDispatcher$Component;Landroid/view/View;Landroid/view/Window$Callback;Landroid/view/KeyEvent;)Z

    move-result v1

    .line 108
    :goto_24
    return v1
.end method

.method public dispatchKeyShortcutEvent(Landroid/view/KeyEvent;)Z
    .registers 4
    .param p1, "event"    # Landroid/view/KeyEvent;

    const-string v0, "event"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 100
    invoke-virtual {p0}, Landroidx/core/app/ComponentActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const-string v1, "getDecorView(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    .local v0, "decor":Landroid/view/View;
    invoke-static {v0, p1}, Landroidx/core/view/KeyEventDispatcher;->dispatchBeforeHierarchy(Landroid/view/View;Landroid/view/KeyEvent;)Z

    move-result v1

    if-eqz v1, :cond_1a

    .line 102
    const/4 v1, 0x1

    goto :goto_1e

    .line 103
    :cond_1a
    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchKeyShortcutEvent(Landroid/view/KeyEvent;)Z

    move-result v1

    .line 101
    :goto_1e
    return v1
.end method

.method public getExtraData(Ljava/lang/Class;)Landroidx/core/app/ComponentActivity$ExtraData;
    .registers 3
    .param p1, "extraDataClass"    # Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Landroidx/core/app/ComponentActivity$ExtraData;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    .annotation runtime Lkotlin/Deprecated;
        message = "Use {@link View#getTag(int)} with the window\'s decor view."
    .end annotation

    const-string v0, "extraDataClass"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 87
    iget-object v0, p0, Landroidx/core/app/ComponentActivity;->extraDataMap:Landroidx/collection/SimpleArrayMap;

    invoke-virtual {v0, p1}, Landroidx/collection/SimpleArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/core/app/ComponentActivity$ExtraData;

    return-object v0
.end method

.method public getLifecycle()Landroidx/lifecycle/Lifecycle;
    .registers 2

    .line 91
    iget-object v0, p0, Landroidx/core/app/ComponentActivity;->lifecycleRegistry:Landroidx/lifecycle/LifecycleRegistry;

    check-cast v0, Landroidx/lifecycle/Lifecycle;

    return-object v0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 68
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 69
    sget-object v0, Landroidx/lifecycle/ReportFragment;->Companion:Landroidx/lifecycle/ReportFragment$Companion;

    move-object v1, p0

    check-cast v1, Landroid/app/Activity;

    invoke-virtual {v0, v1}, Landroidx/lifecycle/ReportFragment$Companion;->injectIfNeededIn(Landroid/app/Activity;)V

    .line 70
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .registers 4
    .param p1, "outState"    # Landroid/os/Bundle;

    const-string v0, "outState"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 74
    iget-object v0, p0, Landroidx/core/app/ComponentActivity;->lifecycleRegistry:Landroidx/lifecycle/LifecycleRegistry;

    sget-object v1, Landroidx/lifecycle/Lifecycle$State;->CREATED:Landroidx/lifecycle/Lifecycle$State;

    invoke-virtual {v0, v1}, Landroidx/lifecycle/LifecycleRegistry;->setCurrentState(Landroidx/lifecycle/Lifecycle$State;)V

    .line 75
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 76
    return-void
.end method

.method public putExtraData(Landroidx/core/app/ComponentActivity$ExtraData;)V
    .registers 4
    .param p1, "extraData"    # Landroidx/core/app/ComponentActivity$ExtraData;
    .annotation runtime Lkotlin/Deprecated;
        message = "Use {@link View#setTag(int, Object)} with the window\'s decor view."
    .end annotation

    const-string v0, "extraData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    iget-object v0, p0, Landroidx/core/app/ComponentActivity;->extraDataMap:Landroidx/collection/SimpleArrayMap;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Landroidx/collection/SimpleArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    return-void
.end method

.method protected final shouldDumpInternalState([Ljava/lang/String;)Z
    .registers 3
    .param p1, "args"    # [Ljava/lang/String;

    .line 135
    invoke-direct {p0, p1}, Landroidx/core/app/ComponentActivity;->shouldSkipDump([Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public superDispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .registers 3
    .param p1, "event"    # Landroid/view/KeyEvent;

    const-string v0, "event"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method
