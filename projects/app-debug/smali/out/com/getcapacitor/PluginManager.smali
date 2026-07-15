.class public Lcom/getcapacitor/PluginManager;
.super Ljava/lang/Object;
.source "PluginManager.java"


# instance fields
.field private final assetManager:Landroid/content/res/AssetManager;


# direct methods
.method public constructor <init>(Landroid/content/res/AssetManager;)V
    .registers 2
    .param p1, "assetManager"    # Landroid/content/res/AssetManager;

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object p1, p0, Lcom/getcapacitor/PluginManager;->assetManager:Landroid/content/res/AssetManager;

    .line 19
    return-void
.end method

.method private parsePluginsJSON()Lorg/json/JSONArray;
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/getcapacitor/PluginLoadException;
        }
    .end annotation

    .line 42
    :try_start_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    iget-object v2, p0, Lcom/getcapacitor/PluginManager;->assetManager:Landroid/content/res/AssetManager;

    const-string v3, "capacitor.plugins.json"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_12} :catch_42
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_12} :catch_39

    .line 43
    .local v0, "reader":Ljava/io/BufferedReader;
    :try_start_12
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 45
    .local v1, "builder":Ljava/lang/StringBuilder;
    :goto_17
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .local v3, "line":Ljava/lang/String;
    if-eqz v2, :cond_22

    .line 46
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_17

    .line 48
    :cond_22
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 49
    .local v2, "jsonString":Ljava/lang/String;
    new-instance v4, Lorg/json/JSONArray;

    invoke-direct {v4, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V
    :try_end_2b
    .catchall {:try_start_12 .. :try_end_2b} :catchall_2f

    .line 50
    :try_start_2b
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_2e
    .catch Ljava/io/IOException; {:try_start_2b .. :try_end_2e} :catch_42
    .catch Lorg/json/JSONException; {:try_start_2b .. :try_end_2e} :catch_39

    .line 49
    return-object v4

    .line 42
    .end local v1    # "builder":Ljava/lang/StringBuilder;
    .end local v2    # "jsonString":Ljava/lang/String;
    .end local v3    # "line":Ljava/lang/String;
    :catchall_2f
    move-exception v1

    :try_start_30
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_33
    .catchall {:try_start_30 .. :try_end_33} :catchall_34

    goto :goto_38

    :catchall_34
    move-exception v2

    :try_start_35
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_38
    throw v1
    :try_end_39
    .catch Ljava/io/IOException; {:try_start_35 .. :try_end_39} :catch_42
    .catch Lorg/json/JSONException; {:try_start_35 .. :try_end_39} :catch_39

    .line 52
    .end local v0    # "reader":Ljava/io/BufferedReader;
    :catch_39
    move-exception v0

    .line 53
    .local v0, "e":Lorg/json/JSONException;
    new-instance v1, Lcom/getcapacitor/PluginLoadException;

    const-string v2, "Could not parse capacitor.plugins.json as JSON"

    invoke-direct {v1, v2}, Lcom/getcapacitor/PluginLoadException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 50
    .end local v0    # "e":Lorg/json/JSONException;
    :catch_42
    move-exception v0

    .line 51
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Lcom/getcapacitor/PluginLoadException;

    const-string v2, "Could not load capacitor.plugins.json"

    invoke-direct {v1, v2}, Lcom/getcapacitor/PluginLoadException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method public loadPluginClasses()Ljava/util/List;
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/getcapacitor/Plugin;",
            ">;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/getcapacitor/PluginLoadException;
        }
    .end annotation

    .line 22
    invoke-direct {p0}, Lcom/getcapacitor/PluginManager;->parsePluginsJSON()Lorg/json/JSONArray;

    move-result-object v0

    .line 23
    .local v0, "pluginsJSON":Lorg/json/JSONArray;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 26
    .local v1, "pluginList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Class<+Lcom/getcapacitor/Plugin;>;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :try_start_a
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    .local v3, "size":I
    :goto_e
    if-ge v2, v3, :cond_2b

    .line 27
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 28
    .local v4, "pluginJSON":Lorg/json/JSONObject;
    const-string v5, "classpath"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 29
    .local v5, "classPath":Ljava/lang/String;
    invoke-static {v5}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    .line 30
    .local v6, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-class v7, Lcom/getcapacitor/Plugin;

    invoke-virtual {v6, v7}, Ljava/lang/Class;->asSubclass(Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_27
    .catch Lorg/json/JSONException; {:try_start_a .. :try_end_27} :catch_4b
    .catch Ljava/lang/ClassNotFoundException; {:try_start_a .. :try_end_27} :catch_2d

    .line 26
    nop

    .end local v4    # "pluginJSON":Lorg/json/JSONObject;
    .end local v5    # "classPath":Ljava/lang/String;
    .end local v6    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    add-int/lit8 v2, v2, 0x1

    goto :goto_e

    .line 36
    .end local v2    # "i":I
    .end local v3    # "size":I
    :cond_2b
    nop

    .line 38
    return-object v1

    .line 34
    :catch_2d
    move-exception v2

    .line 35
    .local v2, "e":Ljava/lang/ClassNotFoundException;
    new-instance v3, Lcom/getcapacitor/PluginLoadException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Could not find class by class path: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Lcom/getcapacitor/PluginLoadException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 32
    .end local v2    # "e":Ljava/lang/ClassNotFoundException;
    :catch_4b
    move-exception v2

    .line 33
    .local v2, "e":Lorg/json/JSONException;
    new-instance v3, Lcom/getcapacitor/PluginLoadException;

    const-string v4, "Could not parse capacitor.plugins.json as JSON"

    invoke-direct {v3, v4}, Lcom/getcapacitor/PluginLoadException;-><init>(Ljava/lang/String;)V

    throw v3
.end method
