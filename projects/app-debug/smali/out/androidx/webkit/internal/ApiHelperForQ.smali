.class public Landroidx/webkit/internal/ApiHelperForQ;
.super Ljava/lang/Object;
.source "ApiHelperForQ.java"


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    return-void
.end method

.method public static getForceDark(Landroid/webkit/WebSettings;)I
    .registers 2
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 57
    invoke-virtual {p0}, Landroid/webkit/WebSettings;->getForceDark()I

    move-result v0

    return v0
.end method

.method public static getWebViewRenderProcess(Landroid/webkit/WebView;)Landroid/webkit/WebViewRenderProcess;
    .registers 2
    .param p0, "webView"    # Landroid/webkit/WebView;

    .line 64
    invoke-virtual {p0}, Landroid/webkit/WebView;->getWebViewRenderProcess()Landroid/webkit/WebViewRenderProcess;

    move-result-object v0

    return-object v0
.end method

.method public static getWebViewRenderProcessClient(Landroid/webkit/WebView;)Landroid/webkit/WebViewRenderProcessClient;
    .registers 2
    .param p0, "webView"    # Landroid/webkit/WebView;

    .line 101
    invoke-virtual {p0}, Landroid/webkit/WebView;->getWebViewRenderProcessClient()Landroid/webkit/WebViewRenderProcessClient;

    move-result-object v0

    return-object v0
.end method

.method public static setForceDark(Landroid/webkit/WebSettings;I)V
    .registers 2
    .param p0, "webSettings"    # Landroid/webkit/WebSettings;
    .param p1, "forceDark"    # I
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 48
    invoke-virtual {p0, p1}, Landroid/webkit/WebSettings;->setForceDark(I)V

    .line 49
    return-void
.end method

.method public static setWebViewRenderProcessClient(Landroid/webkit/WebView;Landroidx/webkit/WebViewRenderProcessClient;)V
    .registers 3
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "client"    # Landroidx/webkit/WebViewRenderProcessClient;

    .line 92
    if-eqz p1, :cond_8

    new-instance v0, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;

    invoke-direct {v0, p1}, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;-><init>(Landroidx/webkit/WebViewRenderProcessClient;)V

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    .line 93
    .local v0, "clientAdapter":Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;
    :goto_9
    invoke-virtual {p0, v0}, Landroid/webkit/WebView;->setWebViewRenderProcessClient(Landroid/webkit/WebViewRenderProcessClient;)V

    .line 94
    return-void
.end method

.method public static setWebViewRenderProcessClient(Landroid/webkit/WebView;Ljava/util/concurrent/Executor;Landroidx/webkit/WebViewRenderProcessClient;)V
    .registers 4
    .param p0, "webView"    # Landroid/webkit/WebView;
    .param p1, "executor"    # Ljava/util/concurrent/Executor;
    .param p2, "client"    # Landroidx/webkit/WebViewRenderProcessClient;

    .line 82
    if-eqz p2, :cond_8

    new-instance v0, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;

    invoke-direct {v0, p2}, Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;-><init>(Landroidx/webkit/WebViewRenderProcessClient;)V

    goto :goto_9

    :cond_8
    const/4 v0, 0x0

    .line 83
    .local v0, "clientAdapter":Landroidx/webkit/internal/WebViewRenderProcessClientFrameworkAdapter;
    :goto_9
    invoke-virtual {p0, p1, v0}, Landroid/webkit/WebView;->setWebViewRenderProcessClient(Ljava/util/concurrent/Executor;Landroid/webkit/WebViewRenderProcessClient;)V

    .line 84
    return-void
.end method

.method public static terminate(Landroid/webkit/WebViewRenderProcess;)Z
    .registers 2
    .param p0, "webViewRenderProcess"    # Landroid/webkit/WebViewRenderProcess;

    .line 71
    invoke-virtual {p0}, Landroid/webkit/WebViewRenderProcess;->terminate()Z

    move-result v0

    return v0
.end method
