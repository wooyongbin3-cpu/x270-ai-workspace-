.class public Lorg/apache/cordova/CallbackContext;
.super Ljava/lang/Object;
.source "CallbackContext.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "CordovaPlugin"


# instance fields
.field private callbackId:Ljava/lang/String;

.field private changingThreads:I

.field protected finished:Z

.field private webView:Lorg/apache/cordova/CordovaWebView;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lorg/apache/cordova/CordovaWebView;)V
    .registers 3
    .param p1, "callbackId"    # Ljava/lang/String;
    .param p2, "webView"    # Lorg/apache/cordova/CordovaWebView;

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lorg/apache/cordova/CallbackContext;->callbackId:Ljava/lang/String;

    .line 37
    iput-object p2, p0, Lorg/apache/cordova/CallbackContext;->webView:Lorg/apache/cordova/CordovaWebView;

    .line 38
    return-void
.end method


# virtual methods
.method public error(I)V
    .registers 4
    .param p1, "message"    # I

    .line 140
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->ERROR:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;I)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 141
    return-void
.end method

.method public error(Ljava/lang/String;)V
    .registers 4
    .param p1, "message"    # Ljava/lang/String;

    .line 131
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->ERROR:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 132
    return-void
.end method

.method public error(Lorg/json/JSONObject;)V
    .registers 4
    .param p1, "message"    # Lorg/json/JSONObject;

    .line 122
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->ERROR:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 123
    return-void
.end method

.method public getCallbackId()Ljava/lang/String;
    .registers 2

    .line 49
    iget-object v0, p0, Lorg/apache/cordova/CallbackContext;->callbackId:Ljava/lang/String;

    return-object v0
.end method

.method public isChangingThreads()Z
    .registers 2

    .line 45
    iget v0, p0, Lorg/apache/cordova/CallbackContext;->changingThreads:I

    if-lez v0, :cond_6

    const/4 v0, 0x1

    goto :goto_7

    :cond_6
    const/4 v0, 0x0

    :goto_7
    return v0
.end method

.method public isFinished()Z
    .registers 2

    .line 41
    iget-boolean v0, p0, Lorg/apache/cordova/CallbackContext;->finished:Z

    return v0
.end method

.method public sendPluginResult(Lorg/apache/cordova/PluginResult;)V
    .registers 5
    .param p1, "pluginResult"    # Lorg/apache/cordova/PluginResult;

    .line 53
    monitor-enter p0

    .line 54
    :try_start_1
    iget-boolean v0, p0, Lorg/apache/cordova/CallbackContext;->finished:Z

    if-eqz v0, :cond_2f

    .line 55
    const-string v0, "CordovaPlugin"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Attempted to send a second callback for ID: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/cordova/CallbackContext;->callbackId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\nResult was: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    monitor-exit p0

    return-void

    .line 58
    :cond_2f
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getKeepCallback()Z

    move-result v0

    if-nez v0, :cond_37

    const/4 v0, 0x1

    goto :goto_38

    :cond_37
    const/4 v0, 0x0

    :goto_38
    iput-boolean v0, p0, Lorg/apache/cordova/CallbackContext;->finished:Z

    .line 60
    monitor-exit p0
    :try_end_3b
    .catchall {:try_start_1 .. :try_end_3b} :catchall_43

    .line 61
    iget-object v0, p0, Lorg/apache/cordova/CallbackContext;->webView:Lorg/apache/cordova/CordovaWebView;

    iget-object v1, p0, Lorg/apache/cordova/CallbackContext;->callbackId:Ljava/lang/String;

    invoke-interface {v0, p1, v1}, Lorg/apache/cordova/CordovaWebView;->sendPluginResult(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V

    .line 62
    return-void

    .line 60
    :catchall_43
    move-exception v0

    :try_start_44
    monitor-exit p0
    :try_end_45
    .catchall {:try_start_44 .. :try_end_45} :catchall_43

    throw v0
.end method

.method public success()V
    .registers 3

    .line 113
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 114
    return-void
.end method

.method public success(I)V
    .registers 4
    .param p1, "message"    # I

    .line 106
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;I)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 107
    return-void
.end method

.method public success(Ljava/lang/String;)V
    .registers 4
    .param p1, "message"    # Ljava/lang/String;

    .line 79
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 80
    return-void
.end method

.method public success(Lorg/json/JSONArray;)V
    .registers 4
    .param p1, "message"    # Lorg/json/JSONArray;

    .line 88
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONArray;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 89
    return-void
.end method

.method public success(Lorg/json/JSONObject;)V
    .registers 4
    .param p1, "message"    # Lorg/json/JSONObject;

    .line 70
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 71
    return-void
.end method

.method public success([B)V
    .registers 4
    .param p1, "message"    # [B

    .line 97
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v1, p1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;[B)V

    invoke-virtual {p0, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 98
    return-void
.end method
