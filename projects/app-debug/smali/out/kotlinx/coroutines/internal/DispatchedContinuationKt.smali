.class public final Lkotlinx/coroutines/internal/DispatchedContinuationKt;
.super Ljava/lang/Object;
.source "DispatchedContinuation.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDispatchedContinuation.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DispatchedContinuation.kt\nkotlinx/coroutines/internal/DispatchedContinuationKt\n+ 2 DispatchedContinuation.kt\nkotlinx/coroutines/internal/DispatchedContinuation\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 4 DispatchedTask.kt\nkotlinx/coroutines/DispatchedTaskKt\n+ 5 CoroutineContext.kt\nkotlinx/coroutines/CoroutineContextKt\n*L\n1#1,313:1\n293#1,5:321\n298#1,12:327\n310#1:383\n297#1:385\n298#1,12:387\n310#1:416\n213#2,7:314\n220#2:342\n239#2,8:343\n221#2:351\n251#2:352\n252#2,2:363\n254#2:367\n223#2:368\n225#2:384\n1#3:326\n1#3:386\n1#3:417\n196#4,3:339\n199#4,14:369\n196#4,17:399\n196#4,17:418\n103#5,10:353\n114#5,2:365\n*S KotlinDebug\n*F\n+ 1 DispatchedContinuation.kt\nkotlinx/coroutines/internal/DispatchedContinuationKt\n*L\n278#1:321,5\n278#1:327,12\n278#1:383\n283#1:385\n283#1:387,12\n283#1:416\n278#1:314,7\n278#1:342\n278#1:343,8\n278#1:351\n278#1:352\n278#1:363,2\n278#1:367\n278#1:368\n278#1:384\n278#1:326\n283#1:386\n278#1:339,3\n278#1:369,14\n283#1:399,17\n309#1:418,17\n278#1:353,10\n278#1:365,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000J\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u001a;\u0010\u0003\u001a\u00020\u0004*\u0006\u0012\u0002\u0008\u00030\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0006\u0010\u0008\u001a\u00020\t2\u0008\u0008\u0002\u0010\n\u001a\u00020\u00042\u000c\u0010\u000b\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cH\u0082\u0008\u001aR\u0010\u000e\u001a\u00020\r\"\u0004\u0008\u0000\u0010\u000f*\u0008\u0012\u0004\u0012\u0002H\u000f0\u00102\u000c\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u0002H\u000f0\u00122%\u0008\u0002\u0010\u0013\u001a\u001f\u0012\u0013\u0012\u00110\u0015\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\r\u0018\u00010\u0014H\u0007\u00a2\u0006\u0002\u0010\u0019\u001a\u0012\u0010\u001a\u001a\u00020\u0004*\u0008\u0012\u0004\u0012\u00020\r0\u0005H\u0000\"\u0010\u0010\u0000\u001a\u00020\u00018\u0000X\u0081\u0004\u00a2\u0006\u0002\n\u0000\"\u000e\u0010\u0002\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001b"
    }
    d2 = {
        "REUSABLE_CLAIMED",
        "Lkotlinx/coroutines/internal/Symbol;",
        "UNDEFINED",
        "executeUnconfined",
        "",
        "Lkotlinx/coroutines/internal/DispatchedContinuation;",
        "contState",
        "",
        "mode",
        "",
        "doYield",
        "block",
        "Lkotlin/Function0;",
        "",
        "resumeCancellableWith",
        "T",
        "Lkotlin/coroutines/Continuation;",
        "result",
        "Lkotlin/Result;",
        "onCancellation",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "cause",
        "(Lkotlin/coroutines/Continuation;Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V",
        "yieldUndispatched",
        "kotlinx-coroutines-core"
    }
    k = 0x2
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final REUSABLE_CLAIMED:Lkotlinx/coroutines/internal/Symbol;

.field private static final UNDEFINED:Lkotlinx/coroutines/internal/Symbol;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 8
    new-instance v0, Lkotlinx/coroutines/internal/Symbol;

    const-string v1, "UNDEFINED"

    invoke-direct {v0, v1}, Lkotlinx/coroutines/internal/Symbol;-><init>(Ljava/lang/String;)V

    sput-object v0, Lkotlinx/coroutines/internal/DispatchedContinuationKt;->UNDEFINED:Lkotlinx/coroutines/internal/Symbol;

    .line 10
    new-instance v0, Lkotlinx/coroutines/internal/Symbol;

    const-string v1, "REUSABLE_CLAIMED"

    invoke-direct {v0, v1}, Lkotlinx/coroutines/internal/Symbol;-><init>(Ljava/lang/String;)V

    sput-object v0, Lkotlinx/coroutines/internal/DispatchedContinuationKt;->REUSABLE_CLAIMED:Lkotlinx/coroutines/internal/Symbol;

    return-void
.end method

.method public static final synthetic access$getUNDEFINED$p()Lkotlinx/coroutines/internal/Symbol;
    .registers 1

    .line 1
    sget-object v0, Lkotlinx/coroutines/internal/DispatchedContinuationKt;->UNDEFINED:Lkotlinx/coroutines/internal/Symbol;

    return-object v0
.end method

.method private static final executeUnconfined(Lkotlinx/coroutines/internal/DispatchedContinuation;Ljava/lang/Object;IZLkotlin/jvm/functions/Function0;)Z
    .registers 13
    .param p0, "$this$executeUnconfined"    # Lkotlinx/coroutines/internal/DispatchedContinuation;
    .param p1, "contState"    # Ljava/lang/Object;
    .param p2, "mode"    # I
    .param p3, "doYield"    # Z
    .param p4, "block"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/internal/DispatchedContinuation<",
            "*>;",
            "Ljava/lang/Object;",
            "IZ",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    .line 297
    .local v0, "$i$f$executeUnconfined":I
    invoke-static {}, Lkotlinx/coroutines/DebugKt;->getASSERTIONS_ENABLED()Z

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_19

    .line 417
    const/4 v1, 0x0

    .line 297
    .local v1, "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1":I
    const/4 v4, -0x1

    if-eq p2, v4, :cond_f

    move v1, v3

    goto :goto_10

    :cond_f
    move v1, v2

    .end local v1    # "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1":I
    :goto_10
    if-eqz v1, :cond_13

    goto :goto_19

    :cond_13
    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1

    .line 298
    :cond_19
    :goto_19
    sget-object v1, Lkotlinx/coroutines/ThreadLocalEventLoop;->INSTANCE:Lkotlinx/coroutines/ThreadLocalEventLoop;

    invoke-virtual {v1}, Lkotlinx/coroutines/ThreadLocalEventLoop;->getEventLoop$kotlinx_coroutines_core()Lkotlinx/coroutines/EventLoop;

    move-result-object v1

    .line 300
    .local v1, "eventLoop":Lkotlinx/coroutines/EventLoop;
    if-eqz p3, :cond_28

    invoke-virtual {v1}, Lkotlinx/coroutines/EventLoop;->isUnconfinedQueueEmpty()Z

    move-result v4

    if-eqz v4, :cond_28

    return v2

    .line 301
    :cond_28
    invoke-virtual {v1}, Lkotlinx/coroutines/EventLoop;->isUnconfinedLoopActive()Z

    move-result v4

    if-eqz v4, :cond_3a

    .line 303
    iput-object p1, p0, Lkotlinx/coroutines/internal/DispatchedContinuation;->_state:Ljava/lang/Object;

    .line 304
    iput p2, p0, Lkotlinx/coroutines/internal/DispatchedContinuation;->resumeMode:I

    .line 305
    move-object v2, p0

    check-cast v2, Lkotlinx/coroutines/DispatchedTask;

    invoke-virtual {v1, v2}, Lkotlinx/coroutines/EventLoop;->dispatchUnconfined(Lkotlinx/coroutines/DispatchedTask;)V

    .line 306
    move v2, v3

    goto :goto_58

    .line 309
    :cond_3a
    move-object v4, p0

    check-cast v4, Lkotlinx/coroutines/DispatchedTask;

    .local v4, "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    const/4 v5, 0x0

    .line 418
    .local v5, "$i$f$runUnconfinedEventLoop":I
    invoke-virtual {v1, v3}, Lkotlinx/coroutines/EventLoop;->incrementUseCount(Z)V

    .line 419
    nop

    .line 420
    :try_start_42
    invoke-interface {p4}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    .line 421
    :cond_45
    nop

    .line 423
    invoke-virtual {v1}, Lkotlinx/coroutines/EventLoop;->processUnconfinedEvent()Z

    move-result v6
    :try_end_4a
    .catchall {:try_start_42 .. :try_end_4a} :catchall_4d

    if-nez v6, :cond_45

    goto :goto_52

    .line 425
    :catchall_4d
    move-exception v6

    .line 430
    .local v6, "e$iv":Ljava/lang/Throwable;
    const/4 v7, 0x0

    :try_start_4f
    invoke-virtual {v4, v6, v7}, Lkotlinx/coroutines/DispatchedTask;->handleFatalException$kotlinx_coroutines_core(Ljava/lang/Throwable;Ljava/lang/Throwable;)V
    :try_end_52
    .catchall {:try_start_4f .. :try_end_52} :catchall_59

    .line 432
    .end local v6    # "e$iv":Ljava/lang/Throwable;
    :goto_52
    invoke-virtual {v1, v3}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    .line 433
    nop

    .line 434
    nop

    .line 310
    .end local v4    # "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v5    # "$i$f$runUnconfinedEventLoop":I
    nop

    .line 301
    :goto_58
    return v2

    .line 432
    .restart local v4    # "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    .restart local v5    # "$i$f$runUnconfinedEventLoop":I
    :catchall_59
    move-exception v2

    invoke-virtual {v1, v3}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    throw v2
.end method

.method static synthetic executeUnconfined$default(Lkotlinx/coroutines/internal/DispatchedContinuation;Ljava/lang/Object;IZLkotlin/jvm/functions/Function0;ILjava/lang/Object;)Z
    .registers 13
    .param p0, "$this$executeUnconfined_u24default"    # Lkotlinx/coroutines/internal/DispatchedContinuation;
    .param p1, "contState"    # Ljava/lang/Object;
    .param p2, "mode"    # I
    .param p3, "doYield"    # Z
    .param p4, "block"    # Lkotlin/jvm/functions/Function0;

    .line 293
    and-int/lit8 p5, p5, 0x4

    if-eqz p5, :cond_5

    .line 294
    const/4 p3, 0x0

    .line 293
    :cond_5
    const/4 p5, 0x0

    .line 297
    .local p5, "$i$f$executeUnconfined":I
    invoke-static {}, Lkotlinx/coroutines/DebugKt;->getASSERTIONS_ENABLED()Z

    move-result p6

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eqz p6, :cond_1e

    .line 417
    const/4 p6, 0x0

    .line 297
    .local p6, "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1":I
    const/4 v2, -0x1

    if-eq p2, v2, :cond_14

    move p6, v1

    goto :goto_15

    :cond_14
    move p6, v0

    .end local p6    # "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1":I
    :goto_15
    if-eqz p6, :cond_18

    goto :goto_1e

    :cond_18
    new-instance p6, Ljava/lang/AssertionError;

    invoke-direct {p6}, Ljava/lang/AssertionError;-><init>()V

    throw p6

    .line 298
    :cond_1e
    :goto_1e
    sget-object p6, Lkotlinx/coroutines/ThreadLocalEventLoop;->INSTANCE:Lkotlinx/coroutines/ThreadLocalEventLoop;

    invoke-virtual {p6}, Lkotlinx/coroutines/ThreadLocalEventLoop;->getEventLoop$kotlinx_coroutines_core()Lkotlinx/coroutines/EventLoop;

    move-result-object p6

    .line 300
    .local p6, "eventLoop":Lkotlinx/coroutines/EventLoop;
    if-eqz p3, :cond_2d

    invoke-virtual {p6}, Lkotlinx/coroutines/EventLoop;->isUnconfinedQueueEmpty()Z

    move-result v2

    if-eqz v2, :cond_2d

    return v0

    .line 301
    :cond_2d
    invoke-virtual {p6}, Lkotlinx/coroutines/EventLoop;->isUnconfinedLoopActive()Z

    move-result v2

    if-eqz v2, :cond_3f

    .line 303
    iput-object p1, p0, Lkotlinx/coroutines/internal/DispatchedContinuation;->_state:Ljava/lang/Object;

    .line 304
    iput p2, p0, Lkotlinx/coroutines/internal/DispatchedContinuation;->resumeMode:I

    .line 305
    move-object v0, p0

    check-cast v0, Lkotlinx/coroutines/DispatchedTask;

    invoke-virtual {p6, v0}, Lkotlinx/coroutines/EventLoop;->dispatchUnconfined(Lkotlinx/coroutines/DispatchedTask;)V

    .line 306
    move v0, v1

    goto :goto_5d

    .line 309
    :cond_3f
    move-object v2, p0

    check-cast v2, Lkotlinx/coroutines/DispatchedTask;

    .local v2, "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    const/4 v3, 0x0

    .line 418
    .local v3, "$i$f$runUnconfinedEventLoop":I
    invoke-virtual {p6, v1}, Lkotlinx/coroutines/EventLoop;->incrementUseCount(Z)V

    .line 419
    nop

    .line 420
    :try_start_47
    invoke-interface {p4}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    .line 421
    :cond_4a
    nop

    .line 423
    invoke-virtual {p6}, Lkotlinx/coroutines/EventLoop;->processUnconfinedEvent()Z

    move-result v4
    :try_end_4f
    .catchall {:try_start_47 .. :try_end_4f} :catchall_52

    if-nez v4, :cond_4a

    goto :goto_57

    .line 425
    :catchall_52
    move-exception v4

    .line 430
    .local v4, "e$iv":Ljava/lang/Throwable;
    const/4 v5, 0x0

    :try_start_54
    invoke-virtual {v2, v4, v5}, Lkotlinx/coroutines/DispatchedTask;->handleFatalException$kotlinx_coroutines_core(Ljava/lang/Throwable;Ljava/lang/Throwable;)V
    :try_end_57
    .catchall {:try_start_54 .. :try_end_57} :catchall_5e

    .line 432
    .end local v4    # "e$iv":Ljava/lang/Throwable;
    :goto_57
    invoke-virtual {p6, v1}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    .line 433
    nop

    .line 434
    nop

    .line 310
    .end local v2    # "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v3    # "$i$f$runUnconfinedEventLoop":I
    nop

    .line 301
    :goto_5d
    return v0

    .line 432
    .restart local v2    # "$this$runUnconfinedEventLoop$iv":Lkotlinx/coroutines/DispatchedTask;
    .restart local v3    # "$i$f$runUnconfinedEventLoop":I
    :catchall_5e
    move-exception v0

    invoke-virtual {p6, v1}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    throw v0
.end method

.method public static final resumeCancellableWith(Lkotlin/coroutines/Continuation;Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V
    .registers 25
    .param p0, "$this$resumeCancellableWith"    # Lkotlin/coroutines/Continuation;
    .param p1, "result"    # Ljava/lang/Object;
    .param p2, "onCancellation"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;",
            "Ljava/lang/Object;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Throwable;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 277
    move-object/from16 v1, p0

    .line 278
    instance-of v0, v1, Lkotlinx/coroutines/internal/DispatchedContinuation;

    if-eqz v0, :cond_145

    move-object v2, v1

    check-cast v2, Lkotlinx/coroutines/internal/DispatchedContinuation;

    .local v2, "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    const/4 v3, 0x0

    .line 314
    .local v3, "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    invoke-static/range {p1 .. p2}, Lkotlinx/coroutines/CompletionStateKt;->toState(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Ljava/lang/Object;

    move-result-object v4

    .line 315
    .local v4, "state$iv":Ljava/lang/Object;
    iget-object v0, v2, Lkotlinx/coroutines/internal/DispatchedContinuation;->dispatcher:Lkotlinx/coroutines/CoroutineDispatcher;

    invoke-virtual {v2}, Lkotlinx/coroutines/internal/DispatchedContinuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v5

    invoke-virtual {v0, v5}, Lkotlinx/coroutines/CoroutineDispatcher;->isDispatchNeeded(Lkotlin/coroutines/CoroutineContext;)Z

    move-result v0

    const/4 v5, 0x1

    if-eqz v0, :cond_33

    .line 316
    iput-object v4, v2, Lkotlinx/coroutines/internal/DispatchedContinuation;->_state:Ljava/lang/Object;

    .line 317
    iput v5, v2, Lkotlinx/coroutines/internal/DispatchedContinuation;->resumeMode:I

    .line 318
    iget-object v0, v2, Lkotlinx/coroutines/internal/DispatchedContinuation;->dispatcher:Lkotlinx/coroutines/CoroutineDispatcher;

    invoke-virtual {v2}, Lkotlinx/coroutines/internal/DispatchedContinuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v5

    move-object v6, v2

    check-cast v6, Ljava/lang/Runnable;

    invoke-virtual {v0, v5, v6}, Lkotlinx/coroutines/CoroutineDispatcher;->dispatch(Lkotlin/coroutines/CoroutineContext;Ljava/lang/Runnable;)V

    move-object/from16 v1, p1

    move-object/from16 v18, v2

    move/from16 v19, v3

    goto/16 :goto_13d

    .line 320
    :cond_33
    const/4 v0, 0x1

    .local v0, "mode$iv$iv":I
    move-object v6, v2

    .local v6, "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    move v7, v0

    .line 321
    .end local v0    # "mode$iv$iv":I
    .local v7, "mode$iv$iv":I
    nop

    .line 322
    const/4 v8, 0x0

    .line 321
    .local v8, "doYield$iv$iv":Z
    const/4 v9, 0x0

    .line 325
    .local v9, "$i$f$executeUnconfined":I
    invoke-static {}, Lkotlinx/coroutines/DebugKt;->getASSERTIONS_ENABLED()Z

    move-result v0

    if-eqz v0, :cond_41

    .line 326
    const/4 v0, 0x0

    .line 325
    .local v0, "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1$iv$iv":I
    nop

    .line 327
    .end local v0    # "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1$iv$iv":I
    :cond_41
    sget-object v0, Lkotlinx/coroutines/ThreadLocalEventLoop;->INSTANCE:Lkotlinx/coroutines/ThreadLocalEventLoop;

    invoke-virtual {v0}, Lkotlinx/coroutines/ThreadLocalEventLoop;->getEventLoop$kotlinx_coroutines_core()Lkotlinx/coroutines/EventLoop;

    move-result-object v10

    .line 329
    .local v10, "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    nop

    .line 330
    invoke-virtual {v10}, Lkotlinx/coroutines/EventLoop;->isUnconfinedLoopActive()Z

    move-result v0

    if-eqz v0, :cond_60

    .line 332
    iput-object v4, v6, Lkotlinx/coroutines/internal/DispatchedContinuation;->_state:Ljava/lang/Object;

    .line 333
    iput v7, v6, Lkotlinx/coroutines/internal/DispatchedContinuation;->resumeMode:I

    .line 334
    move-object v0, v6

    check-cast v0, Lkotlinx/coroutines/DispatchedTask;

    invoke-virtual {v10, v0}, Lkotlinx/coroutines/EventLoop;->dispatchUnconfined(Lkotlinx/coroutines/DispatchedTask;)V

    .line 335
    move-object/from16 v1, p1

    move-object/from16 v18, v2

    move/from16 v19, v3

    goto/16 :goto_13c

    .line 338
    :cond_60
    move-object v11, v6

    check-cast v11, Lkotlinx/coroutines/DispatchedTask;

    .local v11, "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    const/4 v12, 0x0

    .line 339
    .local v12, "$i$f$runUnconfinedEventLoop":I
    invoke-virtual {v10, v5}, Lkotlinx/coroutines/EventLoop;->incrementUseCount(Z)V

    .line 340
    nop

    .line 341
    const/4 v13, 0x0

    .line 342
    .local v13, "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    move-object v0, v2

    .local v0, "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    const/4 v14, 0x0

    .line 343
    .local v14, "$i$f$resumeCancelled$kotlinx_coroutines_core":I
    :try_start_6b
    invoke-virtual {v0}, Lkotlinx/coroutines/internal/DispatchedContinuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v15

    sget-object v16, Lkotlinx/coroutines/Job;->Key:Lkotlinx/coroutines/Job$Key;

    move-object/from16 v5, v16

    check-cast v5, Lkotlin/coroutines/CoroutineContext$Key;

    invoke-interface {v15, v5}, Lkotlin/coroutines/CoroutineContext;->get(Lkotlin/coroutines/CoroutineContext$Key;)Lkotlin/coroutines/CoroutineContext$Element;

    move-result-object v5

    check-cast v5, Lkotlinx/coroutines/Job;
    :try_end_7b
    .catchall {:try_start_6b .. :try_end_7b} :catchall_12a

    .line 344
    .local v5, "job$iv$iv":Lkotlinx/coroutines/Job;
    if-eqz v5, :cond_ae

    :try_start_7d
    invoke-interface {v5}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v15

    if-nez v15, :cond_ae

    .line 345
    invoke-interface {v5}, Lkotlinx/coroutines/Job;->getCancellationException()Ljava/util/concurrent/CancellationException;

    move-result-object v15

    .line 346
    .local v15, "cause$iv$iv":Ljava/util/concurrent/CancellationException;
    move-object v1, v15

    check-cast v1, Ljava/lang/Throwable;

    invoke-virtual {v0, v4, v1}, Lkotlinx/coroutines/internal/DispatchedContinuation;->cancelCompletedResult$kotlinx_coroutines_core(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 347
    move-object v1, v0

    check-cast v1, Lkotlin/coroutines/Continuation;

    sget-object v16, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object/from16 v16, v15

    check-cast v16, Ljava/lang/Throwable;

    invoke-static/range {v16 .. v16}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v17, v0

    .end local v0    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .local v17, "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    invoke-static/range {v16 .. v16}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v1, v0}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V
    :try_end_a3
    .catchall {:try_start_7d .. :try_end_a3} :catchall_a5

    .line 348
    const/4 v0, 0x1

    goto :goto_b1

    .line 373
    .end local v5    # "job$iv$iv":Lkotlinx/coroutines/Job;
    .end local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    .end local v14    # "$i$f$resumeCancelled$kotlinx_coroutines_core":I
    .end local v15    # "cause$iv$iv":Ljava/util/concurrent/CancellationException;
    .end local v17    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :catchall_a5
    move-exception v0

    move-object/from16 v1, p1

    move-object/from16 v18, v2

    move/from16 v19, v3

    goto/16 :goto_131

    .line 344
    .restart local v0    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v5    # "job$iv$iv":Lkotlinx/coroutines/Job;
    .restart local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    .restart local v14    # "$i$f$resumeCancelled$kotlinx_coroutines_core":I
    :cond_ae
    move-object/from16 v17, v0

    .line 350
    .end local v0    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v17    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    const/4 v0, 0x0

    .line 342
    .end local v5    # "job$iv$iv":Lkotlinx/coroutines/Job;
    .end local v14    # "$i$f$resumeCancelled$kotlinx_coroutines_core":I
    .end local v17    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :goto_b1
    if-nez v0, :cond_118

    .line 351
    move-object v1, v2

    .local v1, "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    const/4 v5, 0x0

    .line 352
    .local v5, "$i$f$resumeUndispatchedWith$kotlinx_coroutines_core":I
    :try_start_b5
    iget-object v0, v1, Lkotlinx/coroutines/internal/DispatchedContinuation;->continuation:Lkotlin/coroutines/Continuation;

    iget-object v14, v1, Lkotlinx/coroutines/internal/DispatchedContinuation;->countOrElement:Ljava/lang/Object;

    .local v14, "countOrElement$iv$iv$iv":Ljava/lang/Object;
    move-object v15, v0

    .local v15, "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    const/16 v16, 0x0

    .line 353
    .local v16, "$i$f$withContinuationContext":I
    invoke-interface {v15}, Lkotlin/coroutines/Continuation;->getContext()Lkotlin/coroutines/CoroutineContext;

    move-result-object v0
    :try_end_c0
    .catchall {:try_start_b5 .. :try_end_c0} :catchall_12a

    move-object/from16 v17, v0

    .line 354
    .local v17, "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    move-object/from16 v18, v2

    move-object/from16 v2, v17

    .end local v17    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .local v2, "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .local v18, "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :try_start_c6
    invoke-static {v2, v14}, Lkotlinx/coroutines/internal/ThreadContextKt;->updateThreadContext(Lkotlin/coroutines/CoroutineContext;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v17, v0

    .line 355
    .local v17, "oldValue$iv$iv$iv":Ljava/lang/Object;
    sget-object v0, Lkotlinx/coroutines/internal/ThreadContextKt;->NO_THREAD_ELEMENTS:Lkotlinx/coroutines/internal/Symbol;
    :try_end_ce
    .catchall {:try_start_c6 .. :try_end_ce} :catchall_112

    move/from16 v19, v3

    move-object/from16 v3, v17

    .end local v17    # "oldValue$iv$iv$iv":Ljava/lang/Object;
    .local v3, "oldValue$iv$iv$iv":Ljava/lang/Object;
    .local v19, "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    if-eq v3, v0, :cond_dd

    .line 357
    :try_start_d4
    invoke-static {v15, v2, v3}, Lkotlinx/coroutines/CoroutineContextKt;->updateUndispatchedCompletion(Lkotlin/coroutines/Continuation;Lkotlin/coroutines/CoroutineContext;Ljava/lang/Object;)Lkotlinx/coroutines/UndispatchedCoroutine;

    move-result-object v0
    :try_end_d8
    .catchall {:try_start_d4 .. :try_end_d8} :catchall_d9

    goto :goto_de

    .line 373
    .end local v1    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v2    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .end local v3    # "oldValue$iv$iv$iv":Ljava/lang/Object;
    .end local v5    # "$i$f$resumeUndispatchedWith$kotlinx_coroutines_core":I
    .end local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    .end local v14    # "countOrElement$iv$iv$iv":Ljava/lang/Object;
    .end local v15    # "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    .end local v16    # "$i$f$withContinuationContext":I
    :catchall_d9
    move-exception v0

    move-object/from16 v1, p1

    goto :goto_131

    .line 359
    .restart local v1    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v2    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .restart local v3    # "oldValue$iv$iv$iv":Ljava/lang/Object;
    .restart local v5    # "$i$f$resumeUndispatchedWith$kotlinx_coroutines_core":I
    .restart local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    .restart local v14    # "countOrElement$iv$iv$iv":Ljava/lang/Object;
    .restart local v15    # "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    .restart local v16    # "$i$f$withContinuationContext":I
    :cond_dd
    const/4 v0, 0x0

    .line 355
    :goto_de
    move-object/from16 v17, v0

    .line 361
    .local v17, "undispatchedCompletion$iv$iv$iv":Lkotlinx/coroutines/UndispatchedCoroutine;
    nop

    .line 362
    const/4 v0, 0x0

    .line 363
    .local v0, "$i$a$-withContinuationContext-DispatchedContinuation$resumeUndispatchedWith$1$iv$iv":I
    move/from16 v20, v0

    .end local v0    # "$i$a$-withContinuationContext-DispatchedContinuation$resumeUndispatchedWith$1$iv$iv":I
    .local v20, "$i$a$-withContinuationContext-DispatchedContinuation$resumeUndispatchedWith$1$iv$iv":I
    :try_start_e4
    iget-object v0, v1, Lkotlinx/coroutines/internal/DispatchedContinuation;->continuation:Lkotlin/coroutines/Continuation;
    :try_end_e6
    .catchall {:try_start_e4 .. :try_end_e6} :catchall_100

    move-object/from16 v21, v1

    move-object/from16 v1, p1

    .end local v1    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .local v21, "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :try_start_ea
    invoke-interface {v0, v1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 364
    nop

    .end local v20    # "$i$a$-withContinuationContext-DispatchedContinuation$resumeUndispatchedWith$1$iv$iv":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_f0
    .catchall {:try_start_ea .. :try_end_f0} :catchall_fe

    .line 362
    nop

    .line 365
    if-eqz v17, :cond_f9

    :try_start_f3
    invoke-virtual/range {v17 .. v17}, Lkotlinx/coroutines/UndispatchedCoroutine;->clearThreadContext()Z

    move-result v0

    if-eqz v0, :cond_fc

    .line 366
    :cond_f9
    invoke-static {v2, v3}, Lkotlinx/coroutines/internal/ThreadContextKt;->restoreThreadContext(Lkotlin/coroutines/CoroutineContext;Ljava/lang/Object;)V

    .line 362
    :cond_fc
    nop

    .line 367
    .end local v2    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .end local v3    # "oldValue$iv$iv$iv":Ljava/lang/Object;
    .end local v14    # "countOrElement$iv$iv$iv":Ljava/lang/Object;
    .end local v15    # "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    .end local v16    # "$i$f$withContinuationContext":I
    .end local v17    # "undispatchedCompletion$iv$iv$iv":Lkotlinx/coroutines/UndispatchedCoroutine;
    goto :goto_11e

    .line 365
    .restart local v2    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .restart local v3    # "oldValue$iv$iv$iv":Ljava/lang/Object;
    .restart local v14    # "countOrElement$iv$iv$iv":Ljava/lang/Object;
    .restart local v15    # "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    .restart local v16    # "$i$f$withContinuationContext":I
    .restart local v17    # "undispatchedCompletion$iv$iv$iv":Lkotlinx/coroutines/UndispatchedCoroutine;
    :catchall_fe
    move-exception v0

    goto :goto_105

    .end local v21    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v1    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :catchall_100
    move-exception v0

    move-object/from16 v21, v1

    move-object/from16 v1, p1

    .end local v1    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v21    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    :goto_105
    if-eqz v17, :cond_10d

    invoke-virtual/range {v17 .. v17}, Lkotlinx/coroutines/UndispatchedCoroutine;->clearThreadContext()Z

    move-result v20

    if-eqz v20, :cond_110

    .line 366
    :cond_10d
    invoke-static {v2, v3}, Lkotlinx/coroutines/internal/ThreadContextKt;->restoreThreadContext(Lkotlin/coroutines/CoroutineContext;Ljava/lang/Object;)V

    :cond_110
    nop

    .end local v4    # "state$iv":Ljava/lang/Object;
    .end local v6    # "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v7    # "mode$iv$iv":I
    .end local v8    # "doYield$iv$iv":Z
    .end local v9    # "$i$f$executeUnconfined":I
    .end local v10    # "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    .end local v11    # "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v12    # "$i$f$runUnconfinedEventLoop":I
    .end local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .end local p0    # "$this$resumeCancellableWith":Lkotlin/coroutines/Continuation;
    .end local p1    # "result":Ljava/lang/Object;
    .end local p2    # "onCancellation":Lkotlin/jvm/functions/Function1;
    throw v0

    .line 373
    .end local v2    # "context$iv$iv$iv":Lkotlin/coroutines/CoroutineContext;
    .end local v5    # "$i$f$resumeUndispatchedWith$kotlinx_coroutines_core":I
    .end local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    .end local v14    # "countOrElement$iv$iv$iv":Ljava/lang/Object;
    .end local v15    # "continuation$iv$iv$iv":Lkotlin/coroutines/Continuation;
    .end local v16    # "$i$f$withContinuationContext":I
    .end local v17    # "undispatchedCompletion$iv$iv$iv":Lkotlinx/coroutines/UndispatchedCoroutine;
    .end local v21    # "this_$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .local v3, "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .restart local v4    # "state$iv":Ljava/lang/Object;
    .restart local v6    # "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v7    # "mode$iv$iv":I
    .restart local v8    # "doYield$iv$iv":Z
    .restart local v9    # "$i$f$executeUnconfined":I
    .restart local v10    # "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    .restart local v11    # "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .restart local v12    # "$i$f$runUnconfinedEventLoop":I
    .restart local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local p0    # "$this$resumeCancellableWith":Lkotlin/coroutines/Continuation;
    .restart local p1    # "result":Ljava/lang/Object;
    .restart local p2    # "onCancellation":Lkotlin/jvm/functions/Function1;
    :catchall_112
    move-exception v0

    move-object/from16 v1, p1

    move/from16 v19, v3

    .end local v3    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .restart local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    goto :goto_131

    .line 342
    .end local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .local v2, "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v3    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .restart local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    :cond_118
    move-object/from16 v1, p1

    move-object/from16 v18, v2

    move/from16 v19, v3

    .line 368
    .end local v2    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v3    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .restart local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    :goto_11e
    nop

    .line 341
    .end local v13    # "$i$a$-executeUnconfined$default-DispatchedContinuation$resumeCancellableWith$1$iv":I
    nop

    .line 369
    :cond_120
    nop

    .line 371
    invoke-virtual {v10}, Lkotlinx/coroutines/EventLoop;->processUnconfinedEvent()Z

    move-result v0
    :try_end_125
    .catchall {:try_start_f3 .. :try_end_125} :catchall_128

    if-nez v0, :cond_120

    goto :goto_135

    .line 373
    :catchall_128
    move-exception v0

    goto :goto_131

    .end local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .restart local v2    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v3    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    :catchall_12a
    move-exception v0

    move-object/from16 v1, p1

    move-object/from16 v18, v2

    move/from16 v19, v3

    .line 378
    .end local v2    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v3    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    .local v0, "e$iv$iv$iv":Ljava/lang/Throwable;
    .restart local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    :goto_131
    const/4 v2, 0x0

    :try_start_132
    invoke-virtual {v11, v0, v2}, Lkotlinx/coroutines/DispatchedTask;->handleFatalException$kotlinx_coroutines_core(Ljava/lang/Throwable;Ljava/lang/Throwable;)V
    :try_end_135
    .catchall {:try_start_132 .. :try_end_135} :catchall_13f

    .line 380
    .end local v0    # "e$iv$iv$iv":Ljava/lang/Throwable;
    :goto_135
    const/4 v2, 0x1

    invoke-virtual {v10, v2}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    .line 381
    nop

    .line 382
    nop

    .line 383
    .end local v11    # "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v12    # "$i$f$runUnconfinedEventLoop":I
    nop

    .line 330
    :goto_13c
    nop

    .line 384
    .end local v6    # "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v7    # "mode$iv$iv":I
    .end local v8    # "doYield$iv$iv":Z
    .end local v9    # "$i$f$executeUnconfined":I
    .end local v10    # "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    :goto_13d
    nop

    .end local v4    # "state$iv":Ljava/lang/Object;
    .end local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    goto :goto_14a

    .line 380
    .restart local v4    # "state$iv":Ljava/lang/Object;
    .restart local v6    # "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v7    # "mode$iv$iv":I
    .restart local v8    # "doYield$iv$iv":Z
    .restart local v9    # "$i$f$executeUnconfined":I
    .restart local v10    # "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    .restart local v11    # "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .restart local v12    # "$i$f$runUnconfinedEventLoop":I
    .restart local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    :catchall_13f
    move-exception v0

    const/4 v2, 0x1

    invoke-virtual {v10, v2}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    throw v0

    .line 279
    .end local v4    # "state$iv":Ljava/lang/Object;
    .end local v6    # "$this$executeUnconfined_u24default$iv$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v7    # "mode$iv$iv":I
    .end local v8    # "doYield$iv$iv":Z
    .end local v9    # "$i$f$executeUnconfined":I
    .end local v10    # "eventLoop$iv$iv":Lkotlinx/coroutines/EventLoop;
    .end local v11    # "$this$runUnconfinedEventLoop$iv$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v12    # "$i$f$runUnconfinedEventLoop":I
    .end local v18    # "this_$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v19    # "$i$f$resumeCancellableWith$kotlinx_coroutines_core":I
    :cond_145
    move-object/from16 v1, p1

    invoke-interface/range {p0 .. p1}, Lkotlin/coroutines/Continuation;->resumeWith(Ljava/lang/Object;)V

    .line 280
    :goto_14a
    return-void
.end method

.method public static synthetic resumeCancellableWith$default(Lkotlin/coroutines/Continuation;Ljava/lang/Object;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .registers 5

    .line 274
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_5

    .line 276
    const/4 p2, 0x0

    .line 274
    :cond_5
    invoke-static {p0, p1, p2}, Lkotlinx/coroutines/internal/DispatchedContinuationKt;->resumeCancellableWith(Lkotlin/coroutines/Continuation;Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public static final yieldUndispatched(Lkotlinx/coroutines/internal/DispatchedContinuation;)Z
    .registers 13
    .param p0, "$this$yieldUndispatched"    # Lkotlinx/coroutines/internal/DispatchedContinuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/internal/DispatchedContinuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    .line 283
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .local v0, "contState$iv":Ljava/lang/Object;
    const/4 v1, 0x1

    .local v1, "mode$iv":I
    const/4 v2, 0x1

    .local v2, "doYield$iv":Z
    move-object v3, p0

    .local v3, "$this$executeUnconfined$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    const/4 v4, 0x0

    .line 385
    .local v4, "$i$f$executeUnconfined":I
    invoke-static {}, Lkotlinx/coroutines/DebugKt;->getASSERTIONS_ENABLED()Z

    move-result v5

    if-eqz v5, :cond_e

    .line 386
    const/4 v5, 0x0

    .line 385
    .local v5, "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1$iv":I
    nop

    .line 387
    .end local v5    # "$i$a$-assert-DispatchedContinuationKt$executeUnconfined$1$iv":I
    :cond_e
    sget-object v5, Lkotlinx/coroutines/ThreadLocalEventLoop;->INSTANCE:Lkotlinx/coroutines/ThreadLocalEventLoop;

    invoke-virtual {v5}, Lkotlinx/coroutines/ThreadLocalEventLoop;->getEventLoop$kotlinx_coroutines_core()Lkotlinx/coroutines/EventLoop;

    move-result-object v5

    .line 389
    .local v5, "eventLoop$iv":Lkotlinx/coroutines/EventLoop;
    invoke-virtual {v5}, Lkotlinx/coroutines/EventLoop;->isUnconfinedQueueEmpty()Z

    move-result v6

    const/4 v7, 0x0

    if-eqz v6, :cond_1c

    goto :goto_51

    .line 390
    :cond_1c
    invoke-virtual {v5}, Lkotlinx/coroutines/EventLoop;->isUnconfinedLoopActive()Z

    move-result v6

    const/4 v8, 0x1

    if-eqz v6, :cond_2f

    .line 392
    iput-object v0, v3, Lkotlinx/coroutines/internal/DispatchedContinuation;->_state:Ljava/lang/Object;

    .line 393
    iput v1, v3, Lkotlinx/coroutines/internal/DispatchedContinuation;->resumeMode:I

    .line 394
    move-object v6, v3

    check-cast v6, Lkotlinx/coroutines/DispatchedTask;

    invoke-virtual {v5, v6}, Lkotlinx/coroutines/EventLoop;->dispatchUnconfined(Lkotlinx/coroutines/DispatchedTask;)V

    .line 395
    move v7, v8

    goto :goto_50

    .line 398
    :cond_2f
    move-object v6, v3

    check-cast v6, Lkotlinx/coroutines/DispatchedTask;

    .local v6, "$this$runUnconfinedEventLoop$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    const/4 v9, 0x0

    .line 399
    .local v9, "$i$f$runUnconfinedEventLoop":I
    invoke-virtual {v5, v8}, Lkotlinx/coroutines/EventLoop;->incrementUseCount(Z)V

    .line 400
    nop

    .line 401
    const/4 v10, 0x0

    .line 284
    .local v10, "$i$a$-executeUnconfined-DispatchedContinuationKt$yieldUndispatched$1":I
    :try_start_38
    invoke-virtual {p0}, Lkotlinx/coroutines/internal/DispatchedContinuation;->run()V

    .line 285
    nop

    .line 401
    .end local v10    # "$i$a$-executeUnconfined-DispatchedContinuationKt$yieldUndispatched$1":I
    nop

    .line 402
    :cond_3d
    nop

    .line 404
    invoke-virtual {v5}, Lkotlinx/coroutines/EventLoop;->processUnconfinedEvent()Z

    move-result v10
    :try_end_42
    .catchall {:try_start_38 .. :try_end_42} :catchall_45

    if-nez v10, :cond_3d

    goto :goto_4a

    .line 406
    :catchall_45
    move-exception v10

    .line 411
    .local v10, "e$iv$iv":Ljava/lang/Throwable;
    const/4 v11, 0x0

    :try_start_47
    invoke-virtual {v6, v10, v11}, Lkotlinx/coroutines/DispatchedTask;->handleFatalException$kotlinx_coroutines_core(Ljava/lang/Throwable;Ljava/lang/Throwable;)V
    :try_end_4a
    .catchall {:try_start_47 .. :try_end_4a} :catchall_52

    .line 413
    .end local v10    # "e$iv$iv":Ljava/lang/Throwable;
    :goto_4a
    invoke-virtual {v5, v8}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    .line 414
    nop

    .line 415
    nop

    .line 416
    .end local v6    # "$this$runUnconfinedEventLoop$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .end local v9    # "$i$f$runUnconfinedEventLoop":I
    nop

    .line 390
    :goto_50
    nop

    .line 285
    .end local v0    # "contState$iv":Ljava/lang/Object;
    .end local v1    # "mode$iv":I
    .end local v2    # "doYield$iv":Z
    .end local v3    # "$this$executeUnconfined$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .end local v4    # "$i$f$executeUnconfined":I
    .end local v5    # "eventLoop$iv":Lkotlinx/coroutines/EventLoop;
    :goto_51
    return v7

    .line 413
    .restart local v0    # "contState$iv":Ljava/lang/Object;
    .restart local v1    # "mode$iv":I
    .restart local v2    # "doYield$iv":Z
    .restart local v3    # "$this$executeUnconfined$iv":Lkotlinx/coroutines/internal/DispatchedContinuation;
    .restart local v4    # "$i$f$executeUnconfined":I
    .restart local v5    # "eventLoop$iv":Lkotlinx/coroutines/EventLoop;
    .restart local v6    # "$this$runUnconfinedEventLoop$iv$iv":Lkotlinx/coroutines/DispatchedTask;
    .restart local v9    # "$i$f$runUnconfinedEventLoop":I
    :catchall_52
    move-exception v7

    invoke-virtual {v5, v8}, Lkotlinx/coroutines/EventLoop;->decrementUseCount(Z)V

    throw v7
.end method
