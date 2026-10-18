.class public final synthetic Landroidx/core/content/res/FontResourcesParserCompat$$ExternalSyntheticAutoCloseableDispatcher0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"


# direct methods
.method public static synthetic m(Ljava/lang/Object;)V
    .registers 2

    .line 0
    instance-of v0, p0, Ljava/lang/AutoCloseable;

    if-eqz v0, :cond_a

    check-cast p0, Ljava/lang/AutoCloseable;

    invoke-interface {p0}, Ljava/lang/AutoCloseable;->close()V

    return-void

    :cond_a
    instance-of v0, p0, Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_14

    check-cast p0, Ljava/util/concurrent/ExecutorService;

    invoke-static {p0}, Landroidx/core/content/res/FontResourcesParserCompat$$ExternalSyntheticAutoCloseableForwarder1;->m(Ljava/util/concurrent/ExecutorService;)V

    return-void

    :cond_14
    instance-of v0, p0, Landroid/content/res/TypedArray;

    if-eqz v0, :cond_1e

    check-cast p0, Landroid/content/res/TypedArray;

    invoke-virtual {p0}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :cond_1e
    instance-of v0, p0, Landroid/media/MediaMetadataRetriever;

    if-eqz v0, :cond_28

    check-cast p0, Landroid/media/MediaMetadataRetriever;

    invoke-virtual {p0}, Landroid/media/MediaMetadataRetriever;->release()V

    return-void

    :cond_28
    instance-of v0, p0, Landroid/media/MediaDrm;

    if-eqz v0, :cond_32

    check-cast p0, Landroid/media/MediaDrm;

    invoke-virtual {p0}, Landroid/media/MediaDrm;->release()V

    return-void

    :cond_32
    invoke-static {p0}, Landroidx/core/content/res/FontResourcesParserCompat$$ExternalSyntheticThrowIAE2;->m(Ljava/lang/Object;)V

    return-void
.end method
