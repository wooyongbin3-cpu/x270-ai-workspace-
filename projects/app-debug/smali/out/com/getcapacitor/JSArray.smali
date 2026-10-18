.class public Lcom/getcapacitor/JSArray;
.super Lorg/json/JSONArray;
.source "JSArray.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 12
    invoke-direct {p0}, Lorg/json/JSONArray;-><init>()V

    .line 13
    return-void
.end method

.method public constructor <init>(Ljava/lang/Object;)V
    .registers 2
    .param p1, "array"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 24
    invoke-direct {p0, p1}, Lorg/json/JSONArray;-><init>(Ljava/lang/Object;)V

    .line 25
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .registers 2
    .param p1, "json"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 16
    invoke-direct {p0, p1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    .line 17
    return-void
.end method

.method public constructor <init>(Ljava/util/Collection;)V
    .registers 2
    .param p1, "copyFrom"    # Ljava/util/Collection;

    .line 20
    invoke-direct {p0, p1}, Lorg/json/JSONArray;-><init>(Ljava/util/Collection;)V

    .line 21
    return-void
.end method

.method public static from(Ljava/lang/Object;)Lcom/getcapacitor/JSArray;
    .registers 2
    .param p0, "array"    # Ljava/lang/Object;

    .line 47
    :try_start_0
    new-instance v0, Lcom/getcapacitor/JSArray;

    invoke-direct {v0, p0}, Lcom/getcapacitor/JSArray;-><init>(Ljava/lang/Object;)V
    :try_end_5
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_5} :catch_6

    return-object v0

    .line 48
    :catch_6
    move-exception v0

    .line 49
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public toList()Ljava/util/List;
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<E:",
            "Ljava/lang/Object;",
            ">()",
            "Ljava/util/List<",
            "TE;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 29
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 30
    .local v0, "items":Ljava/util/List;, "Ljava/util/List<TE;>;"
    const/4 v1, 0x0

    .line 31
    .local v1, "o":Ljava/lang/Object;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_7
    invoke-virtual {p0}, Lcom/getcapacitor/JSArray;->length()I

    move-result v3

    if-ge v2, v3, :cond_25

    .line 32
    invoke-virtual {p0, v2}, Lcom/getcapacitor/JSArray;->get(I)Ljava/lang/Object;

    move-result-object v1

    .line 34
    :try_start_11
    invoke-virtual {p0, v2}, Lcom/getcapacitor/JSArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_18} :catch_1c

    .line 37
    nop

    .line 31
    add-int/lit8 v2, v2, 0x1

    goto :goto_7

    .line 35
    :catch_1c
    move-exception v3

    .line 36
    .local v3, "ex":Ljava/lang/Exception;
    new-instance v4, Lorg/json/JSONException;

    const-string v5, "Not all items are instances of the given type"

    invoke-direct {v4, v5}, Lorg/json/JSONException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 39
    .end local v2    # "i":I
    .end local v3    # "ex":Ljava/lang/Exception;
    :cond_25
    return-object v0
.end method
