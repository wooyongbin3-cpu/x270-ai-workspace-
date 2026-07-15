.class public Lcom/getcapacitor/BridgeWebViewClient;
.super Landroid/webkit/WebViewClient;
.source "BridgeWebViewClient.java"


# instance fields
.field private bridge:Lcom/getcapacitor/Bridge;


# direct methods
.method public constructor <init>(Lcom/getcapacitor/Bridge;)V
    .registers 2
    .param p1, "bridge"    # Lcom/getcapacitor/Bridge;

    .line 17
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    .line 19
    return-void
.end method


# virtual methods
.method public onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 6
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .line 108
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 110
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v0

    .line 111
    .local v0, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v0, :cond_25

    .line 112
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_15
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_25

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/getcapacitor/WebViewListener;

    .line 113
    .local v2, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v2, p1, p2}, Lcom/getcapacitor/WebViewListener;->onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 114
    .end local v2    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_15

    .line 116
    :cond_25
    return-void
.end method

.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 6
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .line 34
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 35
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v0

    .line 37
    .local v0, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v0, :cond_2d

    invoke-virtual {p1}, Landroid/webkit/WebView;->getProgress()I

    move-result v1

    const/16 v2, 0x64

    if-ne v1, v2, :cond_2d

    .line 38
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2d

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/getcapacitor/WebViewListener;

    .line 39
    .local v2, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v2, p1}, Lcom/getcapacitor/WebViewListener;->onPageLoaded(Landroid/webkit/WebView;)V

    .line 40
    .end local v2    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_1d

    .line 42
    :cond_2d
    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .registers 7
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;
    .param p3, "favicon"    # Landroid/graphics/Bitmap;

    .line 63
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 64
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->reset()V

    .line 65
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v0

    .line 67
    .local v0, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v0, :cond_2a

    .line 68
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1a
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/getcapacitor/WebViewListener;

    .line 69
    .local v2, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v2, p1}, Lcom/getcapacitor/WebViewListener;->onPageStarted(Landroid/webkit/WebView;)V

    .line 70
    .end local v2    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_1a

    .line 72
    :cond_2a
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .registers 7
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "error"    # Landroid/webkit/WebResourceError;

    .line 46
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    .line 48
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v0

    .line 49
    .local v0, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v0, :cond_25

    .line 50
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_15
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_25

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/getcapacitor/WebViewListener;

    .line 51
    .local v2, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v2, p1}, Lcom/getcapacitor/WebViewListener;->onReceivedError(Landroid/webkit/WebView;)V

    .line 52
    .end local v2    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_15

    .line 55
    :cond_25
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getErrorUrl()Ljava/lang/String;

    move-result-object v1

    .line 56
    .local v1, "errorPath":Ljava/lang/String;
    if-eqz v1, :cond_36

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->isForMainFrame()Z

    move-result v2

    if-eqz v2, :cond_36

    .line 57
    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 59
    :cond_36
    return-void
.end method

.method public onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .registers 7
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;
    .param p3, "errorResponse"    # Landroid/webkit/WebResourceResponse;

    .line 76
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    .line 78
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v0

    .line 79
    .local v0, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v0, :cond_25

    .line 80
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_15
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_25

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/getcapacitor/WebViewListener;

    .line 81
    .local v2, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v2, p1}, Lcom/getcapacitor/WebViewListener;->onReceivedHttpError(Landroid/webkit/WebView;)V

    .line 82
    .end local v2    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_15

    .line 85
    :cond_25
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getErrorUrl()Ljava/lang/String;

    move-result-object v1

    .line 86
    .local v1, "errorPath":Ljava/lang/String;
    if-eqz v1, :cond_36

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->isForMainFrame()Z

    move-result v2

    if-eqz v2, :cond_36

    .line 87
    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 89
    :cond_36
    return-void
.end method

.method public onRenderProcessGone(Landroid/webkit/WebView;Landroid/webkit/RenderProcessGoneDetail;)Z
    .registers 8
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "detail"    # Landroid/webkit/RenderProcessGoneDetail;

    .line 93
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onRenderProcessGone(Landroid/webkit/WebView;Landroid/webkit/RenderProcessGoneDetail;)Z

    .line 94
    const/4 v0, 0x0

    .line 96
    .local v0, "result":Z
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v1

    .line 97
    .local v1, "webViewListeners":Ljava/util/List;, "Ljava/util/List<Lcom/getcapacitor/WebViewListener;>;"
    if-eqz v1, :cond_30

    .line 98
    iget-object v2, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v2}, Lcom/getcapacitor/Bridge;->getWebViewListeners()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_16
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_30

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/getcapacitor/WebViewListener;

    .line 99
    .local v3, "listener":Lcom/getcapacitor/WebViewListener;
    invoke-virtual {v3, p1, p2}, Lcom/getcapacitor/WebViewListener;->onRenderProcessGone(Landroid/webkit/WebView;Landroid/webkit/RenderProcessGoneDetail;)Z

    move-result v4

    if-nez v4, :cond_2d

    if-eqz v0, :cond_2b

    goto :goto_2d

    :cond_2b
    const/4 v4, 0x0

    goto :goto_2e

    :cond_2d
    :goto_2d
    const/4 v4, 0x1

    :goto_2e
    move v0, v4

    .line 100
    .end local v3    # "listener":Lcom/getcapacitor/WebViewListener;
    goto :goto_16

    .line 103
    :cond_30
    return v0
.end method

.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .registers 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;

    .line 23
    iget-object v0, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getLocalServer()Lcom/getcapacitor/WebViewLocalServer;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/getcapacitor/WebViewLocalServer;->shouldInterceptRequest(Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;

    move-result-object v0

    return-object v0
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Z
    .registers 5
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "request"    # Landroid/webkit/WebResourceRequest;

    .line 28
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    .line 29
    .local v0, "url":Landroid/net/Uri;
    iget-object v1, p0, Lcom/getcapacitor/BridgeWebViewClient;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1, v0}, Lcom/getcapacitor/Bridge;->launchIntent(Landroid/net/Uri;)Z

    move-result v1

    return v1
.end method
