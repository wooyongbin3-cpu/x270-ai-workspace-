.class public Lorg/apache/cordova/CoreAndroid;
.super Lorg/apache/cordova/CordovaPlugin;
.source "CoreAndroid.java"


# static fields
.field public static final PLUGIN_NAME:Ljava/lang/String; = "CoreAndroid"

.field protected static final TAG:Ljava/lang/String; = "CordovaApp"


# instance fields
.field private messageChannel:Lorg/apache/cordova/CallbackContext;

.field private final messageChannelLock:Ljava/lang/Object;

.field private pendingPause:Lorg/apache/cordova/PluginResult;

.field private pendingResume:Lorg/apache/cordova/PluginResult;

.field private telephonyReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 40
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 48
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lorg/apache/cordova/CoreAndroid;->messageChannelLock:Ljava/lang/Object;

    return-void
.end method

.method public static getBuildConfigValue(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;
    .registers 4
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "key"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 398
    const-string v0, "CordovaApp"

    const-string v1, "CoreAndroid.getBuildConfigValue is deprecated and will be removed in a future release. Use BuildHelper.getBuildConfigValue instead."

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 399
    invoke-static {p0, p1}, Lorg/apache/cordova/BuildHelper;->getBuildConfigValue(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private initTelephonyReceiver()V
    .registers 4

    .line 296
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 297
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.PHONE_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 299
    new-instance v1, Lorg/apache/cordova/CoreAndroid$5;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CoreAndroid$5;-><init>(Lorg/apache/cordova/CoreAndroid;)V

    iput-object v1, p0, Lorg/apache/cordova/CoreAndroid;->telephonyReceiver:Landroid/content/BroadcastReceiver;

    .line 326
    iget-object v1, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaWebView;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/cordova/CoreAndroid;->telephonyReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 327
    return-void
.end method

.method private sendEventMessage(Ljava/lang/String;)V
    .registers 7
    .param p1, "action"    # Ljava/lang/String;

    .line 330
    const-string v0, "CordovaApp"

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 332
    .local v1, "obj":Lorg/json/JSONObject;
    :try_start_7
    const-string v2, "action"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_c
    .catch Lorg/json/JSONException; {:try_start_7 .. :try_end_c} :catch_d

    .line 335
    goto :goto_13

    .line 333
    :catch_d
    move-exception v2

    .line 334
    .local v2, "e":Lorg/json/JSONException;
    const-string v3, "Failed to create event message"

    invoke-static {v0, v3, v2}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 336
    .end local v2    # "e":Lorg/json/JSONException;
    :goto_13
    new-instance v2, Lorg/apache/cordova/PluginResult;

    sget-object v3, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v2, v3, v1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    .line 338
    .local v2, "result":Lorg/apache/cordova/PluginResult;
    iget-object v3, p0, Lorg/apache/cordova/CoreAndroid;->messageChannel:Lorg/apache/cordova/CallbackContext;

    if-nez v3, :cond_4b

    .line 339
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Request to send event before messageChannel initialised: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lorg/apache/cordova/LOG;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 340
    const-string v0, "pause"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3f

    .line 341
    iput-object v2, p0, Lorg/apache/cordova/CoreAndroid;->pendingPause:Lorg/apache/cordova/PluginResult;

    goto :goto_4e

    .line 342
    :cond_3f
    const-string v0, "resume"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4e

    .line 344
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/CoreAndroid;->pendingPause:Lorg/apache/cordova/PluginResult;

    goto :goto_4e

    .line 347
    :cond_4b
    invoke-direct {p0, v2}, Lorg/apache/cordova/CoreAndroid;->sendEventMessage(Lorg/apache/cordova/PluginResult;)V

    .line 349
    :cond_4e
    :goto_4e
    return-void
.end method

.method private sendEventMessage(Lorg/apache/cordova/PluginResult;)V
    .registers 3
    .param p1, "payload"    # Lorg/apache/cordova/PluginResult;

    .line 352
    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    .line 353
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->messageChannel:Lorg/apache/cordova/CallbackContext;

    if-eqz v0, :cond_d

    .line 354
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->messageChannel:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 356
    :cond_d
    return-void
.end method


# virtual methods
.method public backHistory()V
    .registers 3

    .line 234
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lorg/apache/cordova/CoreAndroid$4;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CoreAndroid$4;-><init>(Lorg/apache/cordova/CoreAndroid;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 240
    return-void
.end method

.method public clearCache()V
    .registers 3

    .line 149
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lorg/apache/cordova/CoreAndroid$2;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CoreAndroid$2;-><init>(Lorg/apache/cordova/CoreAndroid;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 155
    return-void
.end method

.method public clearHistory()V
    .registers 3

    .line 221
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lorg/apache/cordova/CoreAndroid$3;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CoreAndroid$3;-><init>(Lorg/apache/cordova/CoreAndroid;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 227
    return-void
.end method

.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .registers 11
    .param p1, "action"    # Ljava/lang/String;
    .param p2, "args"    # Lorg/json/JSONArray;
    .param p3, "callbackContext"    # Lorg/apache/cordova/CallbackContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 79
    sget-object v0, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    .line 80
    .local v0, "status":Lorg/apache/cordova/PluginResult$Status;
    const-string v1, ""

    .line 83
    .local v1, "result":Ljava/lang/String;
    const/4 v2, 0x0

    :try_start_5
    const-string v3, "clearCache"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_13

    .line 84
    invoke-virtual {p0}, Lorg/apache/cordova/CoreAndroid;->clearCache()V

    goto/16 :goto_bb

    .line 86
    :cond_13
    const-string v3, "show"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2b

    .line 90
    iget-object v3, p0, Lorg/apache/cordova/CoreAndroid;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    new-instance v5, Lorg/apache/cordova/CoreAndroid$1;

    invoke-direct {v5, p0}, Lorg/apache/cordova/CoreAndroid$1;-><init>(Lorg/apache/cordova/CoreAndroid;)V

    invoke-virtual {v3, v5}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto/16 :goto_bb

    .line 97
    :cond_2b
    const-string v3, "loadUrl"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_40

    .line 98
    invoke-virtual {p2, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {p0, v3, v5}, Lorg/apache/cordova/CoreAndroid;->loadUrl(Ljava/lang/String;Lorg/json/JSONObject;)V

    goto/16 :goto_bb

    .line 100
    :cond_40
    const-string v3, "cancelLoadUrl"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4a

    goto/16 :goto_bb

    .line 103
    :cond_4a
    const-string v3, "clearHistory"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_56

    .line 104
    invoke-virtual {p0}, Lorg/apache/cordova/CoreAndroid;->clearHistory()V

    goto :goto_bb

    .line 106
    :cond_56
    const-string v3, "backHistory"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_62

    .line 107
    invoke-virtual {p0}, Lorg/apache/cordova/CoreAndroid;->backHistory()V

    goto :goto_bb

    .line 109
    :cond_62
    const-string v3, "overrideButton"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_76

    .line 110
    invoke-virtual {p2, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2, v4}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result v5

    invoke-virtual {p0, v3, v5}, Lorg/apache/cordova/CoreAndroid;->overrideButton(Ljava/lang/String;Z)V

    goto :goto_bb

    .line 112
    :cond_76
    const-string v3, "overrideBackbutton"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_86

    .line 113
    invoke-virtual {p2, v2}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result v3

    invoke-virtual {p0, v3}, Lorg/apache/cordova/CoreAndroid;->overrideBackbutton(Z)V

    goto :goto_bb

    .line 115
    :cond_86
    const-string v3, "exitApp"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_92

    .line 116
    invoke-virtual {p0}, Lorg/apache/cordova/CoreAndroid;->exitApp()V

    goto :goto_bb

    .line 118
    :cond_92
    const-string v3, "messageChannel"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_bb

    .line 119
    iget-object v3, p0, Lorg/apache/cordova/CoreAndroid;->messageChannelLock:Ljava/lang/Object;

    monitor-enter v3
    :try_end_9d
    .catch Lorg/json/JSONException; {:try_start_5 .. :try_end_9d} :catch_c4

    .line 120
    :try_start_9d
    iput-object p3, p0, Lorg/apache/cordova/CoreAndroid;->messageChannel:Lorg/apache/cordova/CallbackContext;

    .line 121
    iget-object v5, p0, Lorg/apache/cordova/CoreAndroid;->pendingPause:Lorg/apache/cordova/PluginResult;

    const/4 v6, 0x0

    if-eqz v5, :cond_ab

    .line 122
    iget-object v5, p0, Lorg/apache/cordova/CoreAndroid;->pendingPause:Lorg/apache/cordova/PluginResult;

    invoke-direct {p0, v5}, Lorg/apache/cordova/CoreAndroid;->sendEventMessage(Lorg/apache/cordova/PluginResult;)V

    .line 123
    iput-object v6, p0, Lorg/apache/cordova/CoreAndroid;->pendingPause:Lorg/apache/cordova/PluginResult;

    .line 125
    :cond_ab
    iget-object v5, p0, Lorg/apache/cordova/CoreAndroid;->pendingResume:Lorg/apache/cordova/PluginResult;

    if-eqz v5, :cond_b6

    .line 126
    iget-object v5, p0, Lorg/apache/cordova/CoreAndroid;->pendingResume:Lorg/apache/cordova/PluginResult;

    invoke-direct {p0, v5}, Lorg/apache/cordova/CoreAndroid;->sendEventMessage(Lorg/apache/cordova/PluginResult;)V

    .line 127
    iput-object v6, p0, Lorg/apache/cordova/CoreAndroid;->pendingResume:Lorg/apache/cordova/PluginResult;

    .line 129
    :cond_b6
    monitor-exit v3

    .line 130
    return v4

    .line 129
    :catchall_b8
    move-exception v4

    monitor-exit v3
    :try_end_ba
    .catchall {:try_start_9d .. :try_end_ba} :catchall_b8

    .end local v0    # "status":Lorg/apache/cordova/PluginResult$Status;
    .end local v1    # "result":Ljava/lang/String;
    .end local p1    # "action":Ljava/lang/String;
    .end local p2    # "args":Lorg/json/JSONArray;
    .end local p3    # "callbackContext":Lorg/apache/cordova/CallbackContext;
    :try_start_ba
    throw v4

    .line 133
    .restart local v0    # "status":Lorg/apache/cordova/PluginResult$Status;
    .restart local v1    # "result":Ljava/lang/String;
    .restart local p1    # "action":Ljava/lang/String;
    .restart local p2    # "args":Lorg/json/JSONArray;
    .restart local p3    # "callbackContext":Lorg/apache/cordova/CallbackContext;
    :cond_bb
    :goto_bb
    new-instance v3, Lorg/apache/cordova/PluginResult;

    invoke-direct {v3, v0, v1}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Ljava/lang/String;)V

    invoke-virtual {p3, v3}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V
    :try_end_c3
    .catch Lorg/json/JSONException; {:try_start_ba .. :try_end_c3} :catch_c4

    .line 134
    return v4

    .line 135
    :catch_c4
    move-exception v3

    .line 136
    .local v3, "e":Lorg/json/JSONException;
    new-instance v4, Lorg/apache/cordova/PluginResult;

    sget-object v5, Lorg/apache/cordova/PluginResult$Status;->JSON_EXCEPTION:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v4, v5}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    invoke-virtual {p3, v4}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 137
    return v2
.end method

.method public exitApp()V
    .registers 4

    .line 286
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebView;->getPluginManager()Lorg/apache/cordova/PluginManager;

    move-result-object v0

    const-string v1, "exit"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 287
    return-void
.end method

.method public fireJavascriptEvent(Ljava/lang/String;)V
    .registers 2
    .param p1, "action"    # Ljava/lang/String;

    .line 56
    invoke-direct {p0, p1}, Lorg/apache/cordova/CoreAndroid;->sendEventMessage(Ljava/lang/String;)V

    .line 57
    return-void
.end method

.method public isBackbuttonOverridden()Z
    .registers 3

    .line 279
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    const/4 v1, 0x4

    invoke-interface {v0, v1}, Lorg/apache/cordova/CordovaWebView;->isButtonPlumbedToJs(I)Z

    move-result v0

    return v0
.end method

.method public loadUrl(Ljava/lang/String;Lorg/json/JSONObject;)V
    .registers 13
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "props"    # Lorg/json/JSONObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 165
    const-string v0, "App"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "App.loadUrl("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 166
    const/4 v0, 0x0

    .line 167
    .local v0, "wait":I
    const/4 v1, 0x0

    .line 168
    .local v1, "openExternal":Z
    const/4 v2, 0x0

    .line 171
    .local v2, "clearHistory":Z
    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    .line 172
    .local v3, "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    if-eqz p2, :cond_aa

    .line 173
    invoke-virtual {p2}, Lorg/json/JSONObject;->names()Lorg/json/JSONArray;

    move-result-object v4

    .line 174
    .local v4, "keys":Lorg/json/JSONArray;
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_37
    invoke-virtual {v4}, Lorg/json/JSONArray;->length()I

    move-result v6

    if-ge v5, v6, :cond_aa

    .line 175
    invoke-virtual {v4, v5}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 176
    .local v6, "key":Ljava/lang/String;
    const-string v7, "wait"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4e

    .line 177
    invoke-virtual {p2, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    goto :goto_a7

    .line 179
    :cond_4e
    const-string v7, "openexternal"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_5b

    .line 180
    invoke-virtual {p2, v6}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    goto :goto_a7

    .line 182
    :cond_5b
    const-string v7, "clearhistory"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_68

    .line 183
    invoke-virtual {p2, v6}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    goto :goto_a7

    .line 186
    :cond_68
    invoke-virtual {p2, v6}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    .line 187
    .local v7, "value":Ljava/lang/Object;
    if-nez v7, :cond_6f

    goto :goto_a7

    .line 190
    :cond_6f
    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    const-class v9, Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_82

    .line 191
    move-object v8, v7

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v3, v6, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_a7

    .line 193
    :cond_82
    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    const-class v9, Ljava/lang/Boolean;

    invoke-virtual {v8, v9}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_95

    .line 194
    move-object v8, v7

    check-cast v8, Ljava/lang/Boolean;

    invoke-virtual {v3, v6, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_a7

    .line 196
    :cond_95
    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    const-class v9, Ljava/lang/Integer;

    invoke-virtual {v8, v9}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_a7

    .line 197
    move-object v8, v7

    check-cast v8, Ljava/lang/Integer;

    invoke-virtual {v3, v6, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 174
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "value":Ljava/lang/Object;
    :cond_a7
    :goto_a7
    add-int/lit8 v5, v5, 0x1

    goto :goto_37

    .line 205
    .end local v4    # "keys":Lorg/json/JSONArray;
    .end local v5    # "i":I
    :cond_aa
    if-lez v0, :cond_ba

    .line 207
    :try_start_ac
    monitor-enter p0
    :try_end_ad
    .catch Ljava/lang/InterruptedException; {:try_start_ac .. :try_end_ad} :catch_b6

    .line 208
    int-to-long v4, v0

    :try_start_ae
    invoke-virtual {p0, v4, v5}, Ljava/lang/Object;->wait(J)V

    .line 209
    monitor-exit p0

    .line 212
    goto :goto_ba

    .line 209
    :catchall_b3
    move-exception v4

    monitor-exit p0
    :try_end_b5
    .catchall {:try_start_ae .. :try_end_b5} :catchall_b3

    .end local v0    # "wait":I
    .end local v1    # "openExternal":Z
    .end local v2    # "clearHistory":Z
    .end local v3    # "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    .end local p1    # "url":Ljava/lang/String;
    .end local p2    # "props":Lorg/json/JSONObject;
    :try_start_b5
    throw v4
    :try_end_b6
    .catch Ljava/lang/InterruptedException; {:try_start_b5 .. :try_end_b6} :catch_b6

    .line 210
    .restart local v0    # "wait":I
    .restart local v1    # "openExternal":Z
    .restart local v2    # "clearHistory":Z
    .restart local v3    # "params":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    .restart local p1    # "url":Ljava/lang/String;
    .restart local p2    # "props":Lorg/json/JSONObject;
    :catch_b6
    move-exception v4

    .line 211
    .local v4, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v4}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 214
    .end local v4    # "e":Ljava/lang/InterruptedException;
    :cond_ba
    :goto_ba
    iget-object v4, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v4, p1, v1, v2, v3}, Lorg/apache/cordova/CordovaWebView;->showWebPage(Ljava/lang/String;ZZLjava/util/Map;)V

    .line 215
    return-void
.end method

.method public onDestroy()V
    .registers 3

    .line 364
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebView;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/cordova/CoreAndroid;->telephonyReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 365
    return-void
.end method

.method public overrideBackbutton(Z)V
    .registers 4
    .param p1, "override"    # Z

    .line 249
    const-string v0, "App"

    const-string v1, "WARNING: Back Button Default Behavior will be overridden.  The backbutton event will be fired!"

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 250
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    const/4 v1, 0x4

    invoke-interface {v0, v1, p1}, Lorg/apache/cordova/CordovaWebView;->setButtonPlumbedToJs(IZ)V

    .line 251
    return-void
.end method

.method public overrideButton(Ljava/lang/String;Z)V
    .registers 5
    .param p1, "button"    # Ljava/lang/String;
    .param p2, "override"    # Z

    .line 261
    const-string v0, "App"

    const-string v1, "WARNING: Volume Button Default Behavior will be overridden.  The volume event will be fired!"

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 262
    const-string v0, "volumeup"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_17

    .line 263
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    const/16 v1, 0x18

    invoke-interface {v0, v1, p2}, Lorg/apache/cordova/CordovaWebView;->setButtonPlumbedToJs(IZ)V

    goto :goto_36

    .line 265
    :cond_17
    const-string v0, "volumedown"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_27

    .line 266
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    const/16 v1, 0x19

    invoke-interface {v0, v1, p2}, Lorg/apache/cordova/CordovaWebView;->setButtonPlumbedToJs(IZ)V

    goto :goto_36

    .line 268
    :cond_27
    const-string v0, "menubutton"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_36

    .line 269
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->webView:Lorg/apache/cordova/CordovaWebView;

    const/16 v1, 0x52

    invoke-interface {v0, v1, p2}, Lorg/apache/cordova/CordovaWebView;->setButtonPlumbedToJs(IZ)V

    .line 271
    :cond_36
    :goto_36
    return-void
.end method

.method public pluginInitialize()V
    .registers 1

    .line 65
    invoke-direct {p0}, Lorg/apache/cordova/CoreAndroid;->initTelephonyReceiver()V

    .line 66
    return-void
.end method

.method public sendResumeEvent(Lorg/apache/cordova/PluginResult;)V
    .registers 4
    .param p1, "resumeEvent"    # Lorg/apache/cordova/PluginResult;

    .line 375
    iget-object v0, p0, Lorg/apache/cordova/CoreAndroid;->messageChannelLock:Ljava/lang/Object;

    monitor-enter v0

    .line 376
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/CoreAndroid;->messageChannel:Lorg/apache/cordova/CallbackContext;

    if-eqz v1, :cond_b

    .line 377
    invoke-direct {p0, p1}, Lorg/apache/cordova/CoreAndroid;->sendEventMessage(Lorg/apache/cordova/PluginResult;)V

    goto :goto_d

    .line 381
    :cond_b
    iput-object p1, p0, Lorg/apache/cordova/CoreAndroid;->pendingResume:Lorg/apache/cordova/PluginResult;

    .line 383
    :goto_d
    monitor-exit v0

    .line 384
    return-void

    .line 383
    :catchall_f
    move-exception v1

    monitor-exit v0
    :try_end_11
    .catchall {:try_start_3 .. :try_end_11} :catchall_f

    throw v1
.end method
