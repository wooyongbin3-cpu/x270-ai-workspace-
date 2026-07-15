.class public Lorg/apache/cordova/PluginManager;
.super Ljava/lang/Object;
.source "PluginManager.java"


# static fields
.field private static DEFAULT_HOSTNAME:Ljava/lang/String;

.field private static SCHEME_HTTPS:Ljava/lang/String;

.field private static final SLOW_EXEC_WARNING_THRESHOLD:I

.field private static TAG:Ljava/lang/String;


# instance fields
.field private final app:Lorg/apache/cordova/CordovaWebView;

.field private final ctx:Lorg/apache/cordova/CordovaInterface;

.field private final entryMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lorg/apache/cordova/PluginEntry;",
            ">;"
        }
    .end annotation
.end field

.field private isInitialized:Z

.field private permissionRequester:Lorg/apache/cordova/CordovaPlugin;

.field private final pluginMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lorg/apache/cordova/CordovaPlugin;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 45
    const-string v0, "PluginManager"

    sput-object v0, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    .line 48
    const-string v0, "https"

    sput-object v0, Lorg/apache/cordova/PluginManager;->SCHEME_HTTPS:Ljava/lang/String;

    .line 50
    const-string v0, "localhost"

    sput-object v0, Lorg/apache/cordova/PluginManager;->DEFAULT_HOSTNAME:Ljava/lang/String;

    .line 52
    invoke-static {}, Landroid/os/Debug;->isDebuggerConnected()Z

    move-result v0

    if-eqz v0, :cond_15

    const/16 v0, 0x3c

    goto :goto_17

    :cond_15
    const/16 v0, 0x10

    :goto_17
    sput v0, Lorg/apache/cordova/PluginManager;->SLOW_EXEC_WARNING_THRESHOLD:I

    return-void
.end method

.method public constructor <init>(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaInterface;Ljava/util/Collection;)V
    .registers 5
    .param p1, "cordovaWebView"    # Lorg/apache/cordova/CordovaWebView;
    .param p2, "cordova"    # Lorg/apache/cordova/CordovaInterface;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/apache/cordova/CordovaWebView;",
            "Lorg/apache/cordova/CordovaInterface;",
            "Ljava/util/Collection<",
            "Lorg/apache/cordova/PluginEntry;",
            ">;)V"
        }
    .end annotation

    .line 64
    .local p3, "pluginEntries":Ljava/util/Collection;, "Ljava/util/Collection<Lorg/apache/cordova/PluginEntry;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    .line 56
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    .line 65
    iput-object p2, p0, Lorg/apache/cordova/PluginManager;->ctx:Lorg/apache/cordova/CordovaInterface;

    .line 66
    iput-object p1, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    .line 67
    invoke-virtual {p0, p3}, Lorg/apache/cordova/PluginManager;->setPluginEntries(Ljava/util/Collection;)V

    .line 68
    return-void
.end method

.method private getLaunchUrlPrefix()Ljava/lang/String;
    .registers 5

    .line 384
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebView;->getPreferences()Lorg/apache/cordova/CordovaPreferences;

    move-result-object v0

    const-string v1, "AndroidInsecureFileModeEnabled"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/CordovaPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_51

    .line 385
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebView;->getPreferences()Lorg/apache/cordova/CordovaPreferences;

    move-result-object v0

    const-string v1, "scheme"

    sget-object v2, Lorg/apache/cordova/PluginManager;->SCHEME_HTTPS:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/CordovaPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 386
    .local v0, "scheme":Ljava/lang/String;
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaWebView;->getPreferences()Lorg/apache/cordova/CordovaPreferences;

    move-result-object v1

    const-string v2, "hostname"

    sget-object v3, Lorg/apache/cordova/PluginManager;->DEFAULT_HOSTNAME:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lorg/apache/cordova/CordovaPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    .line 387
    .local v1, "hostname":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x2f

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 390
    .end local v0    # "scheme":Ljava/lang/String;
    .end local v1    # "hostname":Ljava/lang/String;
    :cond_51
    const-string v0, "file://"

    return-object v0
.end method

.method private instantiatePlugin(Ljava/lang/String;)Lorg/apache/cordova/CordovaPlugin;
    .registers 7
    .param p1, "className"    # Ljava/lang/String;

    .line 560
    const/4 v0, 0x0

    .line 562
    .local v0, "ret":Lorg/apache/cordova/CordovaPlugin;
    const/4 v1, 0x0

    .line 563
    .local v1, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    if-eqz p1, :cond_14

    :try_start_4
    const-string v2, ""

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_14

    .line 564
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    move-object v1, v2

    goto :goto_14

    .line 569
    .end local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_12
    move-exception v1

    goto :goto_2a

    .line 566
    .restart local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_14
    :goto_14
    if-eqz v1, :cond_18

    const/4 v2, 0x1

    goto :goto_19

    :cond_18
    const/4 v2, 0x0

    :goto_19
    const-class v3, Lorg/apache/cordova/CordovaPlugin;

    invoke-virtual {v3, v1}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    and-int/2addr v2, v3

    if-eqz v2, :cond_29

    .line 567
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_28} :catch_12

    move-object v0, v2

    .line 572
    .end local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_29
    goto :goto_4b

    .line 570
    .local v1, "e":Ljava/lang/Exception;
    :goto_2a
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 571
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error adding plugin "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 573
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_4b
    return-object v0
.end method

.method static synthetic lambda$postMessage$0(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;Lorg/apache/cordova/CordovaPlugin;)V
    .registers 4
    .param p0, "id"    # Ljava/lang/String;
    .param p1, "data"    # Ljava/lang/Object;
    .param p2, "s"    # Ljava/lang/String;
    .param p3, "plugin"    # Lorg/apache/cordova/CordovaPlugin;

    .line 352
    if-eqz p3, :cond_5

    .line 353
    invoke-virtual {p3, p0, p1}, Lorg/apache/cordova/CordovaPlugin;->onMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 355
    :cond_5
    return-void
.end method

.method private startupPlugins()V
    .registers 7

    .line 105
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 106
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_46

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 109
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-boolean v3, v2, Lorg/apache/cordova/PluginEntry;->onload:Z

    if-eqz v3, :cond_23

    .line 110
    iget-object v3, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-virtual {p0, v3}, Lorg/apache/cordova/PluginManager;->getPlugin(Ljava/lang/String;)Lorg/apache/cordova/CordovaPlugin;

    goto :goto_45

    .line 113
    :cond_23
    sget-object v3, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "startupPlugins: put - "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 114
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    :goto_45
    goto :goto_d

    .line 117
    :cond_46
    monitor-exit v0

    .line 118
    return-void

    .line 117
    :catchall_48
    move-exception v1

    monitor-exit v0
    :try_end_4a
    .catchall {:try_start_3 .. :try_end_4a} :catchall_48

    throw v1
.end method


# virtual methods
.method public addService(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p1, "service"    # Ljava/lang/String;
    .param p2, "className"    # Ljava/lang/String;

    .line 202
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/cordova/PluginManager;->addService(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 203
    return-void
.end method

.method public addService(Ljava/lang/String;Ljava/lang/String;Z)V
    .registers 5
    .param p1, "service"    # Ljava/lang/String;
    .param p2, "className"    # Ljava/lang/String;
    .param p3, "onload"    # Z

    .line 213
    new-instance v0, Lorg/apache/cordova/PluginEntry;

    invoke-direct {v0, p1, p2, p3}, Lorg/apache/cordova/PluginEntry;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 214
    .local v0, "entry":Lorg/apache/cordova/PluginEntry;
    invoke-virtual {p0, v0}, Lorg/apache/cordova/PluginManager;->addService(Lorg/apache/cordova/PluginEntry;)V

    .line 215
    return-void
.end method

.method public addService(Lorg/apache/cordova/PluginEntry;)V
    .registers 7
    .param p1, "entry"    # Lorg/apache/cordova/PluginEntry;

    .line 224
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    iget-object v1, p1, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 225
    iget-object v0, p1, Lorg/apache/cordova/PluginEntry;->plugin:Lorg/apache/cordova/CordovaPlugin;

    if-eqz v0, :cond_3f

    .line 226
    iget-object v0, p1, Lorg/apache/cordova/PluginEntry;->plugin:Lorg/apache/cordova/CordovaPlugin;

    iget-object v1, p1, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->ctx:Lorg/apache/cordova/CordovaInterface;

    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    iget-object v4, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v4}, Lorg/apache/cordova/CordovaWebView;->getPreferences()Lorg/apache/cordova/CordovaPreferences;

    move-result-object v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lorg/apache/cordova/CordovaPlugin;->privateInitialize(Ljava/lang/String;Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaPreferences;)V

    .line 227
    sget-object v0, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "addService: put - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 228
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v1, p1, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    iget-object v2, p1, Lorg/apache/cordova/PluginEntry;->plugin:Lorg/apache/cordova/CordovaPlugin;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 230
    :cond_3f
    return-void
.end method

.method public exec(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 15
    .param p1, "service"    # Ljava/lang/String;
    .param p2, "action"    # Ljava/lang/String;
    .param p3, "callbackId"    # Ljava/lang/String;
    .param p4, "rawArgs"    # Ljava/lang/String;

    .line 138
    invoke-virtual {p0, p1}, Lorg/apache/cordova/PluginManager;->getPlugin(Ljava/lang/String;)Lorg/apache/cordova/CordovaPlugin;

    move-result-object v0

    .line 139
    .local v0, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-nez v0, :cond_2b

    .line 140
    sget-object v1, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "exec() call to unknown plugin: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 141
    new-instance v1, Lorg/apache/cordova/PluginResult;

    sget-object v2, Lorg/apache/cordova/PluginResult$Status;->CLASS_NOT_FOUND_EXCEPTION:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v1, v2}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 142
    .local v1, "cr":Lorg/apache/cordova/PluginResult;
    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v2, v1, p3}, Lorg/apache/cordova/CordovaWebView;->sendPluginResult(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V

    .line 143
    return-void

    .line 145
    .end local v1    # "cr":Lorg/apache/cordova/PluginResult;
    :cond_2b
    new-instance v1, Lorg/apache/cordova/CallbackContext;

    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-direct {v1, p3, v2}, Lorg/apache/cordova/CallbackContext;-><init>(Ljava/lang/String;Lorg/apache/cordova/CordovaWebView;)V

    .line 147
    .local v1, "callbackContext":Lorg/apache/cordova/CallbackContext;
    :try_start_32
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 148
    .local v2, "pluginStartTime":J
    invoke-virtual {v0, p2, p4, v1}, Lorg/apache/cordova/CordovaPlugin;->execute(Ljava/lang/String;Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)Z

    move-result v4

    .line 149
    .local v4, "wasValidAction":Z
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sub-long/2addr v5, v2

    .line 151
    .local v5, "duration":J
    sget v7, Lorg/apache/cordova/PluginManager;->SLOW_EXEC_WARNING_THRESHOLD:I

    int-to-long v7, v7

    cmp-long v7, v5, v7

    if-lez v7, :cond_78

    .line 152
    sget-object v7, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "THREAD WARNING: exec() call to "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "."

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " blocked the main thread for "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "ms. Plugin should use CordovaInterface.getThreadPool()."

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Lorg/apache/cordova/LOG;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 154
    :cond_78
    if-nez v4, :cond_a0

    .line 155
    new-instance v7, Lorg/apache/cordova/PluginResult;

    sget-object v8, Lorg/apache/cordova/PluginResult$Status;->INVALID_ACTION:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v7, v8}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 156
    .local v7, "cr":Lorg/apache/cordova/PluginResult;
    invoke-virtual {v1, v7}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V
    :try_end_84
    .catch Lorg/json/JSONException; {:try_start_32 .. :try_end_84} :catch_95
    .catch Ljava/lang/Exception; {:try_start_32 .. :try_end_84} :catch_85

    goto :goto_a0

    .line 161
    .end local v2    # "pluginStartTime":J
    .end local v4    # "wasValidAction":Z
    .end local v5    # "duration":J
    .end local v7    # "cr":Lorg/apache/cordova/PluginResult;
    :catch_85
    move-exception v2

    .line 162
    .local v2, "e":Ljava/lang/Exception;
    sget-object v3, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    const-string v4, "Uncaught exception from plugin"

    invoke-static {v3, v4, v2}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 163
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto :goto_a1

    .line 158
    .end local v2    # "e":Ljava/lang/Exception;
    :catch_95
    move-exception v2

    .line 159
    .local v2, "e":Lorg/json/JSONException;
    new-instance v3, Lorg/apache/cordova/PluginResult;

    sget-object v4, Lorg/apache/cordova/PluginResult$Status;->JSON_EXCEPTION:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v3, v4}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 160
    .local v3, "cr":Lorg/apache/cordova/PluginResult;
    invoke-virtual {v1, v3}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    .line 164
    .end local v2    # "e":Lorg/json/JSONException;
    .end local v3    # "cr":Lorg/apache/cordova/PluginResult;
    :cond_a0
    :goto_a0
    nop

    .line 165
    :goto_a1
    return-void
.end method

.method public getPlugin(Ljava/lang/String;)Lorg/apache/cordova/CordovaPlugin;
    .registers 7
    .param p1, "service"    # Ljava/lang/String;

    .line 176
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/cordova/CordovaPlugin;

    .line 177
    .local v0, "ret":Lorg/apache/cordova/CordovaPlugin;
    if-nez v0, :cond_4d

    .line 178
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/cordova/PluginEntry;

    .line 179
    .local v1, "pe":Lorg/apache/cordova/PluginEntry;
    if-nez v1, :cond_16

    .line 180
    const/4 v2, 0x0

    return-object v2

    .line 182
    :cond_16
    iget-object v2, v1, Lorg/apache/cordova/PluginEntry;->plugin:Lorg/apache/cordova/CordovaPlugin;

    if-eqz v2, :cond_1d

    .line 183
    iget-object v0, v1, Lorg/apache/cordova/PluginEntry;->plugin:Lorg/apache/cordova/CordovaPlugin;

    goto :goto_23

    .line 185
    :cond_1d
    iget-object v2, v1, Lorg/apache/cordova/PluginEntry;->pluginClass:Ljava/lang/String;

    invoke-direct {p0, v2}, Lorg/apache/cordova/PluginManager;->instantiatePlugin(Ljava/lang/String;)Lorg/apache/cordova/CordovaPlugin;

    move-result-object v0

    .line 187
    :goto_23
    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->ctx:Lorg/apache/cordova/CordovaInterface;

    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    iget-object v4, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-interface {v4}, Lorg/apache/cordova/CordovaWebView;->getPreferences()Lorg/apache/cordova/CordovaPreferences;

    move-result-object v4

    invoke-virtual {v0, p1, v2, v3, v4}, Lorg/apache/cordova/CordovaPlugin;->privateInitialize(Ljava/lang/String;Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/CordovaPreferences;)V

    .line 188
    sget-object v2, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPlugin - put: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 189
    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 191
    .end local v1    # "pe":Lorg/apache/cordova/PluginEntry;
    :cond_4d
    return-object v0
.end method

.method public getPluginEntries()Ljava/util/Collection;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection<",
            "Lorg/apache/cordova/PluginEntry;",
            ">;"
        }
    .end annotation

    .line 71
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    return-object v0
.end method

.method public getPluginPathHandlers()Ljava/util/ArrayList;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lorg/apache/cordova/CordovaPluginPathHandler;",
            ">;"
        }
    .end annotation

    .line 612
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 613
    .local v0, "handlers":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lorg/apache/cordova/CordovaPluginPathHandler;>;"
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_f
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2b

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 614
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_2a

    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->getPathHandler()Lorg/apache/cordova/CordovaPluginPathHandler;

    move-result-object v3

    if-eqz v3, :cond_2a

    .line 615
    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->getPathHandler()Lorg/apache/cordova/CordovaPluginPathHandler;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 617
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_2a
    goto :goto_f

    .line 618
    :cond_2b
    return-object v0
.end method

.method public init()V
    .registers 3

    .line 93
    sget-object v0, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    const-string v1, "init()"

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/PluginManager;->isInitialized:Z

    .line 95
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lorg/apache/cordova/PluginManager;->onPause(Z)V

    .line 96
    invoke-virtual {p0}, Lorg/apache/cordova/PluginManager;->onDestroy()V

    .line 97
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 98
    invoke-direct {p0}, Lorg/apache/cordova/PluginManager;->startupPlugins()V

    .line 99
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 5
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .line 582
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 583
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 584
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 585
    invoke-virtual {v2, p1}, Lorg/apache/cordova/CordovaPlugin;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 587
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 588
    :cond_1f
    monitor-exit v0

    .line 589
    return-void

    .line 588
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onDestroy()V
    .registers 4

    .line 332
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 333
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 334
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 335
    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->onDestroy()V

    .line 337
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 338
    :cond_1f
    monitor-exit v0

    .line 339
    return-void

    .line 338
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .registers 5
    .param p1, "intent"    # Landroid/content/Intent;

    .line 364
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 365
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 366
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 367
    invoke-virtual {v2, p1}, Lorg/apache/cordova/CordovaPlugin;->onNewIntent(Landroid/content/Intent;)V

    .line 369
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 370
    :cond_1f
    monitor-exit v0

    .line 371
    return-void

    .line 370
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onOverrideUrlLoading(Ljava/lang/String;)Z
    .registers 7
    .param p1, "url"    # Ljava/lang/String;

    .line 518
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 519
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 520
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 521
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_2e

    invoke-virtual {v3, p1}, Lorg/apache/cordova/CordovaPlugin;->onOverrideUrlLoading(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2e

    .line 522
    monitor-exit v0

    const/4 v0, 0x1

    return v0

    .line 524
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_2e
    goto :goto_d

    .line 525
    :cond_2f
    monitor-exit v0

    const/4 v0, 0x0

    return v0

    .line 526
    :catchall_32
    move-exception v1

    monitor-exit v0
    :try_end_34
    .catchall {:try_start_3 .. :try_end_34} :catchall_32

    throw v1
.end method

.method public onPause(Z)V
    .registers 5
    .param p1, "multitasking"    # Z

    .line 238
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 239
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 240
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 241
    invoke-virtual {v2, p1}, Lorg/apache/cordova/CordovaPlugin;->onPause(Z)V

    .line 243
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 244
    :cond_1f
    monitor-exit v0

    .line 245
    return-void

    .line 244
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onReceivedClientCertRequest(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/ICordovaClientCertRequest;)Z
    .registers 7
    .param p1, "view"    # Lorg/apache/cordova/CordovaWebView;
    .param p2, "request"    # Lorg/apache/cordova/ICordovaClientCertRequest;

    .line 277
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 278
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_27

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 279
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_26

    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-virtual {v2, v3, p2}, Lorg/apache/cordova/CordovaPlugin;->onReceivedClientCertRequest(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/ICordovaClientCertRequest;)Z

    move-result v3

    if-eqz v3, :cond_26

    .line 280
    monitor-exit v0

    const/4 v0, 0x1

    return v0

    .line 282
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_26
    goto :goto_d

    .line 283
    :cond_27
    monitor-exit v0

    .line 284
    const/4 v0, 0x0

    return v0

    .line 283
    :catchall_2a
    move-exception v1

    monitor-exit v0
    :try_end_2c
    .catchall {:try_start_3 .. :try_end_2c} :catchall_2a

    throw v1
.end method

.method public onReceivedHttpAuthRequest(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/ICordovaHttpAuthHandler;Ljava/lang/String;Ljava/lang/String;)Z
    .registers 9
    .param p1, "view"    # Lorg/apache/cordova/CordovaWebView;
    .param p2, "handler"    # Lorg/apache/cordova/ICordovaHttpAuthHandler;
    .param p3, "host"    # Ljava/lang/String;
    .param p4, "realm"    # Ljava/lang/String;

    .line 258
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 259
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_27

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 260
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_26

    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->app:Lorg/apache/cordova/CordovaWebView;

    invoke-virtual {v2, v3, p2, p3, p4}, Lorg/apache/cordova/CordovaPlugin;->onReceivedHttpAuthRequest(Lorg/apache/cordova/CordovaWebView;Lorg/apache/cordova/ICordovaHttpAuthHandler;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_26

    .line 261
    monitor-exit v0

    const/4 v0, 0x1

    return v0

    .line 263
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_26
    goto :goto_d

    .line 264
    :cond_27
    monitor-exit v0

    .line 265
    const/4 v0, 0x0

    return v0

    .line 264
    :catchall_2a
    move-exception v1

    monitor-exit v0
    :try_end_2c
    .catchall {:try_start_3 .. :try_end_2c} :catchall_2a

    throw v1
.end method

.method public onRenderProcessGone(Landroid/webkit/WebView;Landroid/webkit/RenderProcessGoneDetail;)Z
    .registers 9
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "detail"    # Landroid/webkit/RenderProcessGoneDetail;

    .line 631
    const/4 v0, 0x0

    .line 632
    .local v0, "result":Z
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v1

    .line 633
    :try_start_4
    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_e
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2e

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/PluginEntry;

    .line 634
    .local v3, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v4, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v5, v3, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v4, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/apache/cordova/CordovaPlugin;

    .line 635
    .local v4, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v4, :cond_2d

    .line 636
    invoke-virtual {v4, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->onRenderProcessGone(Landroid/webkit/WebView;Landroid/webkit/RenderProcessGoneDetail;)Z

    move-result v5

    if-eqz v5, :cond_2d

    .line 637
    const/4 v0, 0x1

    .line 640
    .end local v3    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v4    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_2d
    goto :goto_e

    .line 641
    :cond_2e
    monitor-exit v1

    .line 643
    return v0

    .line 641
    :catchall_30
    move-exception v2

    monitor-exit v1
    :try_end_32
    .catchall {:try_start_4 .. :try_end_32} :catchall_30

    throw v2
.end method

.method public onReset()V
    .registers 4

    .line 533
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 534
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 535
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 536
    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->onReset()V

    .line 538
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 539
    :cond_1f
    monitor-exit v0

    .line 540
    return-void

    .line 539
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onResume(Z)V
    .registers 5
    .param p1, "multitasking"    # Z

    .line 293
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 294
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 295
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 296
    invoke-virtual {v2, p1}, Lorg/apache/cordova/CordovaPlugin;->onResume(Z)V

    .line 298
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 299
    :cond_1f
    monitor-exit v0

    .line 300
    return-void

    .line 299
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onSaveInstanceState()Landroid/os/Bundle;
    .registers 7

    .line 592
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 593
    .local v0, "state":Landroid/os/Bundle;
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v1

    .line 594
    :try_start_8
    iget-object v2, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_12
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2e

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 595
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_2d

    .line 596
    invoke-virtual {v3}, Lorg/apache/cordova/CordovaPlugin;->onSaveInstanceState()Landroid/os/Bundle;

    move-result-object v4

    .line 597
    .local v4, "pluginState":Landroid/os/Bundle;
    if-eqz v4, :cond_2d

    .line 598
    invoke-virtual {v3}, Lorg/apache/cordova/CordovaPlugin;->getServiceName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5, v4}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 601
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v4    # "pluginState":Landroid/os/Bundle;
    :cond_2d
    goto :goto_12

    .line 602
    :cond_2e
    monitor-exit v1

    .line 603
    return-object v0

    .line 602
    :catchall_30
    move-exception v2

    monitor-exit v1
    :try_end_32
    .catchall {:try_start_8 .. :try_end_32} :catchall_30

    throw v2
.end method

.method public onStart()V
    .registers 4

    .line 306
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 307
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 308
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 309
    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->onStart()V

    .line 311
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 312
    :cond_1f
    monitor-exit v0

    .line 313
    return-void

    .line 312
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public onStop()V
    .registers 4

    .line 319
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 320
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 321
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_1e

    .line 322
    invoke-virtual {v2}, Lorg/apache/cordova/CordovaPlugin;->onStop()V

    .line 324
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    :cond_1e
    goto :goto_d

    .line 325
    :cond_1f
    monitor-exit v0

    .line 326
    return-void

    .line 325
    :catchall_21
    move-exception v1

    monitor-exit v0
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_21

    throw v1
.end method

.method public postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 6
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/Object;

    .line 349
    sget-object v0, Lorg/apache/cordova/PluginManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "postMessage: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 351
    :try_start_1b
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    new-instance v2, Lorg/apache/cordova/PluginManager$$ExternalSyntheticLambda0;

    invoke-direct {v2, p1, p2}, Lorg/apache/cordova/PluginManager$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    invoke-interface {v1, v2}, Ljava/util/Map;->forEach(Ljava/util/function/BiConsumer;)V

    .line 356
    monitor-exit v0
    :try_end_26
    .catchall {:try_start_1b .. :try_end_26} :catchall_2d

    .line 357
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->ctx:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0, p1, p2}, Lorg/apache/cordova/CordovaInterface;->onMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    .line 356
    :catchall_2d
    move-exception v1

    :try_start_2e
    monitor-exit v0
    :try_end_2f
    .catchall {:try_start_2e .. :try_end_2f} :catchall_2d

    throw v1
.end method

.method remapUri(Landroid/net/Uri;)Landroid/net/Uri;
    .registers 6
    .param p1, "uri"    # Landroid/net/Uri;

    .line 543
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    monitor-enter v0

    .line 544
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_24

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/CordovaPlugin;

    .line 545
    .local v2, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v2, :cond_23

    .line 546
    invoke-virtual {v2, p1}, Lorg/apache/cordova/CordovaPlugin;->remapUri(Landroid/net/Uri;)Landroid/net/Uri;

    move-result-object v3

    .line 547
    .local v3, "ret":Landroid/net/Uri;
    if-eqz v3, :cond_23

    .line 548
    monitor-exit v0

    return-object v3

    .line 551
    .end local v2    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v3    # "ret":Landroid/net/Uri;
    :cond_23
    goto :goto_d

    .line 552
    :cond_24
    monitor-exit v0

    .line 553
    const/4 v0, 0x0

    return-object v0

    .line 552
    :catchall_27
    move-exception v1

    monitor-exit v0
    :try_end_29
    .catchall {:try_start_3 .. :try_end_29} :catchall_27

    throw v1
.end method

.method public setPluginEntries(Ljava/util/Collection;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lorg/apache/cordova/PluginEntry;",
            ">;)V"
        }
    .end annotation

    .line 75
    .local p1, "pluginEntries":Ljava/util/Collection;, "Ljava/util/Collection<Lorg/apache/cordova/PluginEntry;>;"
    iget-boolean v0, p0, Lorg/apache/cordova/PluginManager;->isInitialized:Z

    if-eqz v0, :cond_15

    .line 76
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lorg/apache/cordova/PluginManager;->onPause(Z)V

    .line 77
    invoke-virtual {p0}, Lorg/apache/cordova/PluginManager;->onDestroy()V

    .line 78
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 79
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 81
    :cond_15
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_19
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_29

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/cordova/PluginEntry;

    .line 82
    .local v1, "entry":Lorg/apache/cordova/PluginEntry;
    invoke-virtual {p0, v1}, Lorg/apache/cordova/PluginManager;->addService(Lorg/apache/cordova/PluginEntry;)V

    .line 83
    .end local v1    # "entry":Lorg/apache/cordova/PluginEntry;
    goto :goto_19

    .line 84
    :cond_29
    iget-boolean v0, p0, Lorg/apache/cordova/PluginManager;->isInitialized:Z

    if-eqz v0, :cond_30

    .line 85
    invoke-direct {p0}, Lorg/apache/cordova/PluginManager;->startupPlugins()V

    .line 87
    :cond_30
    return-void
.end method

.method public shouldAllowBridgeAccess(Ljava/lang/String;)Z
    .registers 7
    .param p1, "url"    # Ljava/lang/String;

    .line 466
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 467
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_32

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 468
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 469
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_31

    .line 470
    invoke-virtual {v3, p1}, Lorg/apache/cordova/CordovaPlugin;->shouldAllowBridgeAccess(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v4

    .line 471
    .local v4, "result":Ljava/lang/Boolean;
    if-eqz v4, :cond_31

    .line 472
    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    monitor-exit v0

    return v1

    .line 475
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v4    # "result":Ljava/lang/Boolean;
    :cond_31
    goto :goto_d

    .line 476
    :cond_32
    monitor-exit v0
    :try_end_33
    .catchall {:try_start_3 .. :try_end_33} :catchall_3c

    .line 479
    invoke-direct {p0}, Lorg/apache/cordova/PluginManager;->getLaunchUrlPrefix()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0

    .line 476
    :catchall_3c
    move-exception v1

    :try_start_3d
    monitor-exit v0
    :try_end_3e
    .catchall {:try_start_3d .. :try_end_3e} :catchall_3c

    throw v1
.end method

.method public shouldAllowNavigation(Ljava/lang/String;)Z
    .registers 7
    .param p1, "url"    # Ljava/lang/String;

    .line 445
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 446
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_32

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 447
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 448
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_31

    .line 449
    invoke-virtual {v3, p1}, Lorg/apache/cordova/CordovaPlugin;->shouldAllowNavigation(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v4

    .line 450
    .local v4, "result":Ljava/lang/Boolean;
    if-eqz v4, :cond_31

    .line 451
    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    monitor-exit v0

    return v1

    .line 454
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v4    # "result":Ljava/lang/Boolean;
    :cond_31
    goto :goto_d

    .line 455
    :cond_32
    monitor-exit v0
    :try_end_33
    .catchall {:try_start_3 .. :try_end_33} :catchall_4a

    .line 458
    invoke-direct {p0}, Lorg/apache/cordova/PluginManager;->getLaunchUrlPrefix()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_48

    const-string v0, "about:blank"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_46

    goto :goto_48

    :cond_46
    const/4 v0, 0x0

    goto :goto_49

    :cond_48
    :goto_48
    const/4 v0, 0x1

    :goto_49
    return v0

    .line 455
    :catchall_4a
    move-exception v1

    :try_start_4b
    monitor-exit v0
    :try_end_4c
    .catchall {:try_start_4b .. :try_end_4c} :catchall_4a

    throw v1
.end method

.method public shouldAllowRequest(Ljava/lang/String;)Z
    .registers 7
    .param p1, "url"    # Ljava/lang/String;

    .line 405
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 406
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_32

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 407
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 408
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_31

    .line 409
    invoke-virtual {v3, p1}, Lorg/apache/cordova/CordovaPlugin;->shouldAllowRequest(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v4

    .line 410
    .local v4, "result":Ljava/lang/Boolean;
    if-eqz v4, :cond_31

    .line 411
    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    monitor-exit v0

    return v1

    .line 414
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v4    # "result":Ljava/lang/Boolean;
    :cond_31
    goto :goto_d

    .line 415
    :cond_32
    monitor-exit v0
    :try_end_33
    .catchall {:try_start_3 .. :try_end_33} :catchall_69

    .line 418
    const-string v0, "blob:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_68

    const-string v0, "data:"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_68

    const-string v0, "about:blank"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4d

    goto :goto_68

    .line 422
    :cond_4d
    const-string v0, "https://ssl.gstatic.com/accessibility/javascript/android/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_56

    .line 423
    return v1

    .line 425
    :cond_56
    const-string v0, "file://"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_66

    .line 428
    const-string v0, "/app_webview/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v1

    return v0

    .line 430
    :cond_66
    const/4 v0, 0x0

    return v0

    .line 419
    :cond_68
    :goto_68
    return v1

    .line 415
    :catchall_69
    move-exception v1

    :try_start_6a
    monitor-exit v0
    :try_end_6b
    .catchall {:try_start_6a .. :try_end_6b} :catchall_69

    throw v1
.end method

.method public shouldOpenExternalUrl(Ljava/lang/String;)Ljava/lang/Boolean;
    .registers 7
    .param p1, "url"    # Ljava/lang/String;

    .line 495
    iget-object v0, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    monitor-enter v0

    .line 496
    :try_start_3
    iget-object v1, p0, Lorg/apache/cordova/PluginManager;->entryMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_d
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2e

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/cordova/PluginEntry;

    .line 497
    .local v2, "entry":Lorg/apache/cordova/PluginEntry;
    iget-object v3, p0, Lorg/apache/cordova/PluginManager;->pluginMap:Ljava/util/Map;

    iget-object v4, v2, Lorg/apache/cordova/PluginEntry;->service:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/apache/cordova/CordovaPlugin;

    .line 498
    .local v3, "plugin":Lorg/apache/cordova/CordovaPlugin;
    if-eqz v3, :cond_2d

    .line 499
    invoke-virtual {v3, p1}, Lorg/apache/cordova/CordovaPlugin;->shouldOpenExternalUrl(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v4

    .line 500
    .local v4, "result":Ljava/lang/Boolean;
    if-eqz v4, :cond_2d

    .line 501
    monitor-exit v0

    return-object v4

    .line 504
    .end local v2    # "entry":Lorg/apache/cordova/PluginEntry;
    .end local v3    # "plugin":Lorg/apache/cordova/CordovaPlugin;
    .end local v4    # "result":Ljava/lang/Boolean;
    :cond_2d
    goto :goto_d

    .line 505
    :cond_2e
    monitor-exit v0
    :try_end_2f
    .catchall {:try_start_3 .. :try_end_2f} :catchall_35

    .line 508
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 505
    :catchall_35
    move-exception v1

    :try_start_36
    monitor-exit v0
    :try_end_37
    .catchall {:try_start_36 .. :try_end_37} :catchall_35

    throw v1
.end method
