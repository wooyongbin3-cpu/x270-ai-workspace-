.class public Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;
.super Ljava/lang/Object;
.source "MockCordovaWebViewImpl.java"

# interfaces
.implements Lorg/apache/cordova/CordovaWebView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$CapacitorEvalBridgeMode;
    }
.end annotation


# instance fields
.field private context:Landroid/content/Context;

.field private cookieManager:Lcom/getcapacitor/cordova/CapacitorCordovaCookieManager;

.field private cordova:Lorg/apache/cordova/CordovaInterface;

.field private hasPausedEver:Z

.field private nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

.field private pluginManager:Lorg/apache/cordova/PluginManager;

.field private preferences:Lorg/apache/cordova/CordovaPreferences;

.field private resourceApi:Lorg/apache/cordova/CordovaResourceApi;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method public static synthetic $r8$lambda$4KdV8CYlWQxu6zbahMKlKsvDFpM(Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->lambda$eval$0(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .registers 2
    .param p1, "context"    # Landroid/content/Context;

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->context:Landroid/content/Context;

    .line 37
    return-void
.end method

.method private synthetic lambda$eval$0(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    .registers 4
    .param p1, "js"    # Ljava/lang/String;
    .param p2, "callback"    # Landroid/webkit/ValueCallback;

    .line 189
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0, p1, p2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    return-void
.end method

.method static synthetic lambda$triggerDocumentEvent$1(Ljava/lang/String;)V
    .registers 1
    .param p0, "s"    # Ljava/lang/String;

    .line 193
    return-void
.end method


# virtual methods
.method public backHistory()Z
    .registers 2

    .line 120
    const/4 v0, 0x0

    return v0
.end method

.method public canGoBack()Z
    .registers 2

    .line 105
    const/4 v0, 0x0

    return v0
.end method

.method public clearCache()V
    .registers 1

    .line 109
    return-void
.end method

.method public clearCache(Z)V
    .registers 2
    .param p1, "b"    # Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 113
    return-void
.end method

.method public clearHistory()V
    .registers 1

    .line 116
    return-void
.end method

.method public eval(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    .registers 5
    .param p1, "js"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Landroid/webkit/ValueCallback<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 188
    .local p2, "callback":Landroid/webkit/ValueCallback;, "Landroid/webkit/ValueCallback<Ljava/lang/String;>;"
    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 189
    .local v0, "mainHandler":Landroid/os/Handler;
    new-instance v1, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1, p2}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$$ExternalSyntheticLambda1;-><init>(Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 190
    return-void
.end method

.method public getContext()Landroid/content/Context;
    .registers 2

    .line 258
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method

.method public getCookieManager()Lorg/apache/cordova/ICordovaCookieManager;
    .registers 2

    .line 248
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cookieManager:Lcom/getcapacitor/cordova/CapacitorCordovaCookieManager;

    return-object v0
.end method

.method public getEngine()Lorg/apache/cordova/CordovaWebViewEngine;
    .registers 2

    .line 238
    const/4 v0, 0x0

    return-object v0
.end method

.method public getPluginManager()Lorg/apache/cordova/PluginManager;
    .registers 2

    .line 233
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    return-object v0
.end method

.method public getPreferences()Lorg/apache/cordova/CordovaPreferences;
    .registers 2

    .line 243
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->preferences:Lorg/apache/cordova/CordovaPreferences;

    return-object v0
.end method

.method public getResourceApi()Lorg/apache/cordova/CordovaResourceApi;
    .registers 2

    .line 215
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->resourceApi:Lorg/apache/cordova/CordovaResourceApi;

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .registers 2

    .line 253
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getView()Landroid/view/View;
    .registers 2

    .line 89
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    return-object v0
.end method

.method public handleDestroy()V
    .registers 2

    .line 175
    invoke-virtual {p0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_7

    .line 176
    return-void

    .line 178
    :cond_7
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->onDestroy()V

    .line 179
    return-void
.end method

.method public handlePause(Z)V
    .registers 4
    .param p1, "keepRunning"    # Z

    .line 125
    invoke-virtual {p0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_7

    .line 126
    return-void

    .line 128
    :cond_7
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->hasPausedEver:Z

    .line 129
    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v1, p1}, Lorg/apache/cordova/PluginManager;->onPause(Z)V

    .line 130
    const-string v1, "pause"

    invoke-virtual {p0, v1}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->triggerDocumentEvent(Ljava/lang/String;)V

    .line 132
    if-nez p1, :cond_19

    .line 134
    invoke-virtual {p0, v0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->setPaused(Z)V

    .line 136
    :cond_19
    return-void
.end method

.method public handleResume(Z)V
    .registers 3
    .param p1, "keepRunning"    # Z

    .line 147
    invoke-virtual {p0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_7

    .line 148
    return-void

    .line 150
    :cond_7
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->setPaused(Z)V

    .line 151
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginManager;->onResume(Z)V

    .line 152
    iget-boolean v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->hasPausedEver:Z

    if-eqz v0, :cond_19

    .line 153
    const-string v0, "resume"

    invoke-virtual {p0, v0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->triggerDocumentEvent(Ljava/lang/String;)V

    .line 155
    :cond_19
    return-void
.end method

.method public handleStart()V
    .registers 2

    .line 159
    invoke-virtual {p0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_7

    .line 160
    return-void

    .line 162
    :cond_7
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->onStart()V

    .line 163
    return-void
.end method

.method public handleStop()V
    .registers 2

    .line 167
    invoke-virtual {p0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->isInitialized()Z

    move-result v0

    if-nez v0, :cond_7

    .line 168
    return-void

    .line 170
    :cond_7
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->onStop()V

    .line 171
    return-void
.end method

.method public hideCustomView()V
    .registers 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 211
    return-void
.end method

.method public init(Lorg/apache/cordova/CordovaInterface;Ljava/util/List;Lorg/apache/cordova/CordovaPreferences;)V
    .registers 7
    .param p1, "cordova"    # Lorg/apache/cordova/CordovaInterface;
    .param p3, "preferences"    # Lorg/apache/cordova/CordovaPreferences;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/apache/cordova/CordovaInterface;",
            "Ljava/util/List<",
            "Lorg/apache/cordova/PluginEntry;",
            ">;",
            "Lorg/apache/cordova/CordovaPreferences;",
            ")V"
        }
    .end annotation

    .line 41
    .local p2, "pluginEntries":Ljava/util/List;, "Ljava/util/List<Lorg/apache/cordova/PluginEntry;>;"
    iput-object p1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    .line 42
    iput-object p3, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->preferences:Lorg/apache/cordova/CordovaPreferences;

    .line 43
    new-instance v0, Lorg/apache/cordova/PluginManager;

    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-direct {v0, p0, v1, p2}, Lorg/apache/cordova/PluginManager;-><init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaInterface;Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    .line 44
    new-instance v0, Lorg/apache/cordova/CordovaResourceApi;

    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->context:Landroid/content/Context;

    iget-object v2, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/CordovaResourceApi;-><init>(Landroid/content/Context;Lorg/apache/cordova/PluginManager;)V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->resourceApi:Lorg/apache/cordova/CordovaResourceApi;

    .line 45
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->init()V

    .line 46
    return-void
.end method

.method public init(Lorg/apache/cordova/CordovaInterface;Ljava/util/List;Lorg/apache/cordova/CordovaPreferences;Landroid/webkit/WebView;)V
    .registers 8
    .param p1, "cordova"    # Lorg/apache/cordova/CordovaInterface;
    .param p3, "preferences"    # Lorg/apache/cordova/CordovaPreferences;
    .param p4, "webView"    # Landroid/webkit/WebView;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/apache/cordova/CordovaInterface;",
            "Ljava/util/List<",
            "Lorg/apache/cordova/PluginEntry;",
            ">;",
            "Lorg/apache/cordova/CordovaPreferences;",
            "Landroid/webkit/WebView;",
            ")V"
        }
    .end annotation

    .line 49
    .local p2, "pluginEntries":Ljava/util/List;, "Ljava/util/List<Lorg/apache/cordova/PluginEntry;>;"
    iput-object p1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    .line 50
    iput-object p4, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    .line 51
    iput-object p3, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->preferences:Lorg/apache/cordova/CordovaPreferences;

    .line 52
    new-instance v0, Lorg/apache/cordova/PluginManager;

    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-direct {v0, p0, v1, p2}, Lorg/apache/cordova/PluginManager;-><init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaInterface;Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    .line 53
    new-instance v0, Lorg/apache/cordova/CordovaResourceApi;

    iget-object v1, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->context:Landroid/content/Context;

    iget-object v2, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-direct {v0, v1, v2}, Lorg/apache/cordova/CordovaResourceApi;-><init>(Landroid/content/Context;Lorg/apache/cordova/PluginManager;)V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->resourceApi:Lorg/apache/cordova/CordovaResourceApi;

    .line 54
    new-instance v0, Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-direct {v0}, Lorg/apache/cordova/NativeToJsMessageQueue;-><init>()V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    .line 55
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    new-instance v1, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$CapacitorEvalBridgeMode;

    iget-object v2, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-direct {v1, p4, v2}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$CapacitorEvalBridgeMode;-><init>(Landroid/webkit/WebView;Lorg/apache/cordova/CordovaInterface;)V

    invoke-virtual {v0, v1}, Lorg/apache/cordova/NativeToJsMessageQueue;->addBridgeMode(Lorg/apache/cordova/NativeToJsMessageQueue$BridgeMode;)V

    .line 56
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/apache/cordova/NativeToJsMessageQueue;->setBridgeMode(I)V

    .line 57
    new-instance v0, Lcom/getcapacitor/cordova/CapacitorCordovaCookieManager;

    invoke-direct {v0, p4}, Lcom/getcapacitor/cordova/CapacitorCordovaCookieManager;-><init>(Landroid/webkit/WebView;)V

    iput-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cookieManager:Lcom/getcapacitor/cordova/CapacitorCordovaCookieManager;

    .line 58
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->init()V

    .line 59
    return-void
.end method

.method public isButtonPlumbedToJs(I)Z
    .registers 3
    .param p1, "keyCode"    # I

    .line 223
    const/4 v0, 0x0

    return v0
.end method

.method public isCustomViewShowing()Z
    .registers 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 202
    const/4 v0, 0x0

    return v0
.end method

.method public isInitialized()Z
    .registers 2

    .line 84
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->cordova:Lorg/apache/cordova/CordovaInterface;

    if-eqz v0, :cond_6

    const/4 v0, 0x1

    goto :goto_7

    :cond_6
    const/4 v0, 0x0

    :goto_7
    return v0
.end method

.method public loadUrl(Ljava/lang/String;)V
    .registers 3
    .param p1, "url"    # Ljava/lang/String;

    .line 263
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->loadUrlIntoView(Ljava/lang/String;Z)V

    .line 264
    return-void
.end method

.method public loadUrlIntoView(Ljava/lang/String;Z)V
    .registers 4
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "recreatePlugins"    # Z

    .line 94
    const-string v0, "about:blank"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_12

    const-string v0, "javascript:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_12

    .line 98
    :cond_11
    return-void

    .line 95
    :cond_12
    :goto_12
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 96
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .registers 3
    .param p1, "intent"    # Landroid/content/Intent;

    .line 140
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    if-eqz v0, :cond_9

    .line 141
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginManager;->onNewIntent(Landroid/content/Intent;)V

    .line 143
    :cond_9
    return-void
.end method

.method public postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 4
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/Object;

    .line 268
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->pluginManager:Lorg/apache/cordova/PluginManager;

    invoke-virtual {v0, p1, p2}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public sendJavascript(Ljava/lang/String;)V
    .registers 3
    .param p1, "statememt"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 184
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/NativeToJsMessageQueue;->addJavaScript(Ljava/lang/String;)V

    .line 185
    return-void
.end method

.method public sendPluginResult(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V
    .registers 4
    .param p1, "cr"    # Lorg/apache/cordova/PluginResult;
    .param p2, "callbackId"    # Ljava/lang/String;

    .line 228
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->nativeToJsMessageQueue:Lorg/apache/cordova/NativeToJsMessageQueue;

    invoke-virtual {v0, p1, p2}, Lorg/apache/cordova/NativeToJsMessageQueue;->addPluginResult(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V

    .line 229
    return-void
.end method

.method public setButtonPlumbedToJs(IZ)V
    .registers 3
    .param p1, "keyCode"    # I
    .param p2, "override"    # Z

    .line 219
    return-void
.end method

.method public setPaused(Z)V
    .registers 3
    .param p1, "value"    # Z

    .line 272
    if-eqz p1, :cond_d

    .line 273
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->onPause()V

    .line 274
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->pauseTimers()V

    goto :goto_17

    .line 276
    :cond_d
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->onResume()V

    .line 277
    iget-object v0, p0, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->resumeTimers()V

    .line 279
    :goto_17
    return-void
.end method

.method public showCustomView(Landroid/view/View;Landroid/webkit/WebChromeClient$CustomViewCallback;)V
    .registers 3
    .param p1, "view"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/webkit/WebChromeClient$CustomViewCallback;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 207
    return-void
.end method

.method public showWebPage(Ljava/lang/String;ZZLjava/util/Map;)V
    .registers 5
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "openExternal"    # Z
    .param p3, "clearHistory"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "ZZ",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 197
    .local p4, "params":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    return-void
.end method

.method public stopLoading()V
    .registers 1

    .line 101
    return-void
.end method

.method public triggerDocumentEvent(Ljava/lang/String;)V
    .registers 4
    .param p1, "eventName"    # Ljava/lang/String;

    .line 193
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "window.Capacitor.triggerEvent(\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', \'document\');"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl$$ExternalSyntheticLambda0;-><init>()V

    invoke-virtual {p0, v0, v1}, Lcom/getcapacitor/cordova/MockCordovaWebViewImpl;->eval(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    .line 194
    return-void
.end method
