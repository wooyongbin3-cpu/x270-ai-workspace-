.class public Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;
.super Ljava/lang/Object;
.source "CapacitorHttpUrlConnection.java"

# interfaces
.implements Lcom/getcapacitor/plugin/util/ICapacitorHttpUrlConnection;


# instance fields
.field private final connection:Ljava/net/HttpURLConnection;


# direct methods
.method public constructor <init>(Ljava/net/HttpURLConnection;)V
    .registers 2
    .param p1, "conn"    # Ljava/net/HttpURLConnection;

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    iput-object p1, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    .line 45
    invoke-direct {p0}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->setDefaultRequestProperties()V

    .line 46
    return-void
.end method

.method private buildDefaultAcceptLanguageProperty()Ljava/lang/String;
    .registers 7

    .line 487
    invoke-static {}, Landroid/os/LocaleList;->getDefault()Landroid/os/LocaleList;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    .line 488
    .local v0, "locale":Ljava/util/Locale;
    const-string v1, ""

    .line 489
    .local v1, "result":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    .line 490
    .local v2, "lang":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    .line 491
    .local v3, "country":Ljava/lang/String;
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_34

    .line 492
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2a

    .line 493
    const-string v4, "%s-%s,%s;q=0.5"

    filled-new-array {v2, v3, v2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_34

    .line 495
    :cond_2a
    const-string v4, "%s;q=0.5"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 498
    :cond_34
    :goto_34
    return-object v1
.end method

.method public static extractBoundaryFromContentType(Ljava/lang/String;)Ljava/lang/String;
    .registers 7
    .param p0, "contentType"    # Ljava/lang/String;

    .line 324
    const-string v0, "boundary="

    .line 325
    .local v0, "boundaryPrefix":Ljava/lang/String;
    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    .line 326
    .local v1, "boundaryIndex":I
    const/4 v2, -0x1

    if-ne v1, v2, :cond_b

    .line 327
    const/4 v2, 0x0

    return-object v2

    .line 331
    :cond_b
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v3, v1

    invoke-virtual {p0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 334
    .local v3, "boundary":Ljava/lang/String;
    const-string v4, ";"

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 335
    .local v4, "endIndex":I
    if-eq v4, v2, :cond_21

    .line 336
    const/4 v2, 0x0

    invoke-virtual {v3, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 340
    :cond_21
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    .line 341
    .end local v3    # "boundary":Ljava/lang/String;
    .local v2, "boundary":Ljava/lang/String;
    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3d

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3d

    .line 342
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v5, 0x1

    sub-int/2addr v3, v5

    invoke-virtual {v2, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 345
    :cond_3d
    return-object v2
.end method

.method private setDefaultRequestProperties()V
    .registers 4

    .line 477
    invoke-direct {p0}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->buildDefaultAcceptLanguageProperty()Ljava/lang/String;

    move-result-object v0

    .line 478
    .local v0, "acceptLanguage":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_11

    .line 479
    iget-object v1, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    const-string v2, "Accept-Language"

    invoke-virtual {v1, v2, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 481
    :cond_11
    return-void
.end method

.method private writeFormDataRequestBody(Ljava/lang/String;Lcom/getcapacitor/JSArray;)V
    .registers 19
    .param p1, "boundary"    # Ljava/lang/String;
    .param p2, "entries"    # Lcom/getcapacitor/JSArray;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/json/JSONException;
        }
    .end annotation

    .line 274
    move-object/from16 v1, p1

    new-instance v0, Ljava/io/DataOutputStream;

    move-object/from16 v2, p0

    iget-object v3, v2, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v3, v0

    .line 275
    .local v3, "os":Ljava/io/DataOutputStream;
    :try_start_10
    const-string v0, "\r\n"

    .line 276
    .local v0, "lineEnd":Ljava/lang/String;
    const-string v4, "--"

    .line 278
    .local v4, "twoHyphens":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Lcom/getcapacitor/JSArray;->toList()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1c
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_135

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .line 279
    .local v6, "e":Ljava/lang/Object;
    instance-of v7, v6, Lorg/json/JSONObject;

    if-eqz v7, :cond_133

    .line 280
    move-object v7, v6

    check-cast v7, Lorg/json/JSONObject;

    .line 281
    .local v7, "entry":Lorg/json/JSONObject;
    const-string v8, "type"

    invoke-virtual {v7, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 282
    .local v8, "type":Ljava/lang/String;
    const-string v9, "key"

    invoke-virtual {v7, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 283
    .local v9, "key":Ljava/lang/String;
    const-string v10, "value"

    invoke-virtual {v7, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 284
    .local v10, "value":Ljava/lang/String;
    const-string v11, "string"

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11
    :try_end_45
    .catchall {:try_start_10 .. :try_end_45} :catchall_158

    const-string v12, "\""

    const-string v13, "Content-Disposition: form-data; name=\""

    if-eqz v11, :cond_91

    .line 285
    :try_start_4b
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v11}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 286
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v11}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 287
    sget-object v11, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v10, v11}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v11

    invoke-virtual {v3, v11}, Ljava/io/DataOutputStream;->write([B)V

    .line 288
    invoke-virtual {v3, v0}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    goto/16 :goto_133

    .line 289
    :cond_91
    const-string v11, "base64File"

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_133

    .line 290
    const-string v11, "fileName"

    invoke-virtual {v7, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 291
    .local v11, "fileName":Ljava/lang/String;
    const-string v14, "contentType"

    invoke-virtual {v7, v14}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 293
    .local v14, "fileContentType":Ljava/lang/String;
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v3, v15}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 294
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v15, "\"; filename=\""

    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 295
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Content-Type: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 296
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "Content-Transfer-Encoding: binary"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 297
    invoke-virtual {v3, v0}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 299
    sget v12, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v13, 0x1a

    if-lt v12, v13, :cond_128

    .line 300
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    move-result-object v12

    invoke-virtual {v12, v10}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/io/DataOutputStream;->write([B)V

    goto :goto_130

    .line 302
    :cond_128
    const/4 v12, 0x0

    invoke-static {v10, v12}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/io/DataOutputStream;->write([B)V

    .line 305
    :goto_130
    invoke-virtual {v3, v0}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 308
    .end local v6    # "e":Ljava/lang/Object;
    .end local v7    # "entry":Lorg/json/JSONObject;
    .end local v8    # "type":Ljava/lang/String;
    .end local v9    # "key":Ljava/lang/String;
    .end local v10    # "value":Ljava/lang/String;
    .end local v11    # "fileName":Ljava/lang/String;
    .end local v14    # "fileContentType":Ljava/lang/String;
    :cond_133
    :goto_133
    goto/16 :goto_1c

    .line 310
    :cond_135
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 311
    invoke-virtual {v3}, Ljava/io/DataOutputStream;->flush()V
    :try_end_154
    .catchall {:try_start_4b .. :try_end_154} :catchall_158

    .line 312
    .end local v0    # "lineEnd":Ljava/lang/String;
    .end local v4    # "twoHyphens":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/io/DataOutputStream;->close()V

    .line 313
    .end local v3    # "os":Ljava/io/DataOutputStream;
    return-void

    .line 274
    .restart local v3    # "os":Ljava/io/DataOutputStream;
    :catchall_158
    move-exception v0

    move-object v4, v0

    :try_start_15a
    invoke-virtual {v3}, Ljava/io/DataOutputStream;->close()V
    :try_end_15d
    .catchall {:try_start_15a .. :try_end_15d} :catchall_15e

    goto :goto_162

    :catchall_15e
    move-exception v0

    invoke-virtual {v4, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_162
    throw v4
.end method

.method private writeObjectRequestBody(Lcom/getcapacitor/JSObject;)V
    .registers 8
    .param p1, "object"    # Lcom/getcapacitor/JSObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/json/JSONException;
        }
    .end annotation

    .line 256
    const-string v0, "UTF-8"

    new-instance v1, Ljava/io/DataOutputStream;

    iget-object v2, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 257
    .local v1, "os":Ljava/io/DataOutputStream;
    :try_start_d
    invoke-virtual {p1}, Lcom/getcapacitor/JSObject;->keys()Ljava/util/Iterator;

    move-result-object v2

    .line 258
    .local v2, "keys":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_11
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_44

    .line 259
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 260
    .local v3, "key":Ljava/lang/String;
    invoke-virtual {p1, v3}, Lcom/getcapacitor/JSObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    .line 261
    .local v4, "d":Ljava/lang/Object;
    invoke-static {v3, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 262
    const-string v5, "="

    invoke-virtual {v1, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 263
    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 265
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_43

    .line 266
    const-string v5, "&"

    invoke-virtual {v1, v5}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 268
    .end local v3    # "key":Ljava/lang/String;
    .end local v4    # "d":Ljava/lang/Object;
    :cond_43
    goto :goto_11

    .line 269
    :cond_44
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->flush()V
    :try_end_47
    .catchall {:try_start_d .. :try_end_47} :catchall_4b

    .line 270
    .end local v2    # "keys":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V

    .line 271
    .end local v1    # "os":Ljava/io/DataOutputStream;
    return-void

    .line 256
    .restart local v1    # "os":Ljava/io/DataOutputStream;
    :catchall_4b
    move-exception v0

    :try_start_4c
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_4f
    .catchall {:try_start_4c .. :try_end_4f} :catchall_50

    goto :goto_54

    :catchall_50
    move-exception v2

    invoke-virtual {v0, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_54
    throw v0
.end method

.method private writeRequestBody(Ljava/lang/String;)V
    .registers 5
    .param p1, "body"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 249
    new-instance v0, Ljava/io/DataOutputStream;

    iget-object v1, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 250
    .local v0, "os":Ljava/io/DataOutputStream;
    :try_start_b
    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->write([B)V

    .line 251
    invoke-virtual {v0}, Ljava/io/DataOutputStream;->flush()V
    :try_end_17
    .catchall {:try_start_b .. :try_end_17} :catchall_1b

    .line 252
    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V

    .line 253
    .end local v0    # "os":Ljava/io/DataOutputStream;
    return-void

    .line 249
    .restart local v0    # "os":Ljava/io/DataOutputStream;
    :catchall_1b
    move-exception v1

    :try_start_1c
    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V
    :try_end_1f
    .catchall {:try_start_1c .. :try_end_1f} :catchall_20

    goto :goto_24

    :catchall_20
    move-exception v2

    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_24
    throw v1
.end method


# virtual methods
.method public connect()V
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 370
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->connect()V

    .line 371
    return-void
.end method

.method public disconnect()V
    .registers 2

    .line 57
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 58
    return-void
.end method

.method public getErrorStream()Ljava/io/InputStream;
    .registers 2

    .line 421
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v0

    return-object v0
.end method

.method public getHeaderField(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .param p1, "name"    # Ljava/lang/String;

    .line 437
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getHeaderFields()Ljava/util/Map;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .line 469
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getHttpConnection()Ljava/net/HttpURLConnection;
    .registers 2

    .line 53
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    return-object v0
.end method

.method public getInputStream()Ljava/io/InputStream;
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 456
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    return-object v0
.end method

.method public getResponseCode()I
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 387
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v0

    return v0
.end method

.method public getURL()Ljava/net/URL;
    .registers 2

    .line 398
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getURL()Ljava/net/URL;

    move-result-object v0

    return-object v0
.end method

.method public setAllowUserInteraction(Z)V
    .registers 3
    .param p1, "isAllowedInteraction"    # Z

    .line 68
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setAllowUserInteraction(Z)V

    .line 69
    return-void
.end method

.method public setConnectTimeout(I)V
    .registers 4
    .param p1, "timeout"    # I

    .line 116
    if-ltz p1, :cond_8

    .line 119
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 120
    return-void

    .line 117
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "timeout can not be negative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDisableRedirects(Z)V
    .registers 4
    .param p1, "disableRedirects"    # Z

    .line 146
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    xor-int/lit8 v1, p1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    .line 147
    return-void
.end method

.method public setDoOutput(Z)V
    .registers 3
    .param p1, "shouldDoOutput"    # Z

    .line 174
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 175
    return-void
.end method

.method public setReadTimeout(I)V
    .registers 4
    .param p1, "timeout"    # I

    .line 135
    if-ltz p1, :cond_8

    .line 138
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 139
    return-void

    .line 136
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "timeout can not be negative"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setRequestBody(Lcom/getcapacitor/PluginCall;Lcom/getcapacitor/JSValue;)V
    .registers 4
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .param p2, "body"    # Lcom/getcapacitor/JSValue;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 184
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->setRequestBody(Lcom/getcapacitor/PluginCall;Lcom/getcapacitor/JSValue;Ljava/lang/String;)V

    .line 185
    return-void
.end method

.method public setRequestBody(Lcom/getcapacitor/PluginCall;Lcom/getcapacitor/JSValue;Ljava/lang/String;)V
    .registers 11
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .param p2, "body"    # Lcom/getcapacitor/JSValue;
    .param p3, "bodyType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 194
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    const-string v1, "Content-Type"

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->getRequestProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 195
    .local v0, "contentType":Ljava/lang/String;
    const-string v2, ""

    .line 197
    .local v2, "dataString":Ljava/lang/String;
    if-eqz v0, :cond_d7

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_14

    goto/16 :goto_d7

    .line 199
    :cond_14
    const-string v3, "application/json"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_43

    .line 200
    const/4 v1, 0x0

    .line 201
    .local v1, "jsArray":Lcom/getcapacitor/JSArray;
    const-string v3, "data"

    if-eqz p2, :cond_26

    .line 202
    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_2b

    .line 204
    :cond_26
    const/4 v4, 0x0

    invoke-virtual {p1, v3, v4}, Lcom/getcapacitor/PluginCall;->getArray(Ljava/lang/String;Lcom/getcapacitor/JSArray;)Lcom/getcapacitor/JSArray;

    move-result-object v1

    .line 206
    :goto_2b
    if-eqz v1, :cond_32

    .line 207
    invoke-virtual {v1}, Lcom/getcapacitor/JSArray;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_38

    .line 208
    :cond_32
    if-nez p2, :cond_38

    .line 209
    invoke-virtual {p1, v3}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 211
    :cond_38
    :goto_38
    if-eqz v2, :cond_3c

    move-object v3, v2

    goto :goto_3e

    :cond_3c
    const-string v3, ""

    :goto_3e
    invoke-direct {p0, v3}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->writeRequestBody(Ljava/lang/String;)V

    .line 212
    .end local v1    # "jsArray":Lcom/getcapacitor/JSArray;
    goto/16 :goto_d6

    :cond_43
    if-eqz p3, :cond_7e

    const-string v3, "file"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_7e

    .line 213
    new-instance v1, Ljava/io/DataOutputStream;

    iget-object v3, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 214
    .local v1, "os":Ljava/io/DataOutputStream;
    :try_start_58
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1a

    if-lt v3, v4, :cond_6d

    .line 215
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    move-result-object v3

    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/io/DataOutputStream;->write([B)V

    .line 217
    :cond_6d
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->flush()V
    :try_end_70
    .catchall {:try_start_58 .. :try_end_70} :catchall_74

    .line 218
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V

    .line 213
    .end local v1    # "os":Ljava/io/DataOutputStream;
    goto :goto_d6

    .restart local v1    # "os":Ljava/io/DataOutputStream;
    :catchall_74
    move-exception v3

    :try_start_75
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_78
    .catchall {:try_start_75 .. :try_end_78} :catchall_79

    goto :goto_7d

    :catchall_79
    move-exception v4

    invoke-virtual {v3, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_7d
    throw v3

    .line 219
    .end local v1    # "os":Ljava/io/DataOutputStream;
    :cond_7e
    const-string v3, "application/x-www-form-urlencoded"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_97

    .line 221
    :try_start_86
    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toJSObject()Lcom/getcapacitor/JSObject;

    move-result-object v1

    .line 222
    .local v1, "obj":Lcom/getcapacitor/JSObject;
    invoke-direct {p0, v1}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->writeObjectRequestBody(Lcom/getcapacitor/JSObject;)V
    :try_end_8d
    .catch Ljava/lang/Exception; {:try_start_86 .. :try_end_8d} :catch_8e

    .end local v1    # "obj":Lcom/getcapacitor/JSObject;
    goto :goto_96

    .line 223
    :catch_8e
    move-exception v1

    .line 225
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->writeRequestBody(Ljava/lang/String;)V

    .line 226
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_96
    goto :goto_d6

    .line 227
    :cond_97
    if-eqz p3, :cond_cf

    const-string v3, "formData"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_cf

    .line 228
    invoke-static {v0}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->extractBoundaryFromContentType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 229
    .local v3, "boundary":Ljava/lang/String;
    if-nez v3, :cond_c7

    .line 233
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v3

    .line 234
    iget-object v4, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "multipart/form-data; boundary="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v5}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 237
    :cond_c7
    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toJSArray()Lcom/getcapacitor/JSArray;

    move-result-object v1

    invoke-direct {p0, v3, v1}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->writeFormDataRequestBody(Ljava/lang/String;Lcom/getcapacitor/JSArray;)V

    .line 238
    .end local v3    # "boundary":Ljava/lang/String;
    goto :goto_d6

    .line 239
    :cond_cf
    invoke-virtual {p2}, Lcom/getcapacitor/JSValue;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->writeRequestBody(Ljava/lang/String;)V

    .line 241
    :goto_d6
    return-void

    .line 197
    :cond_d7
    :goto_d7
    return-void
.end method

.method public setRequestHeaders(Lcom/getcapacitor/JSObject;)V
    .registers 6
    .param p1, "headers"    # Lcom/getcapacitor/JSObject;

    .line 154
    invoke-virtual {p1}, Lcom/getcapacitor/JSObject;->keys()Ljava/util/Iterator;

    move-result-object v0

    .line 155
    .local v0, "keys":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1a

    .line 156
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 157
    .local v1, "key":Ljava/lang/String;
    invoke-virtual {p1, v1}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 158
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v3, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 159
    .end local v1    # "key":Ljava/lang/String;
    .end local v2    # "value":Ljava/lang/String;
    goto :goto_4

    .line 160
    :cond_1a
    return-void
.end method

.method public setRequestMethod(Ljava/lang/String;)V
    .registers 3
    .param p1, "method"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/ProtocolException;
        }
    .end annotation

    .line 92
    iget-object v0, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v0, p1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 93
    return-void
.end method

.method public setSSLSocketFactory(Lcom/getcapacitor/Bridge;)V
    .registers 7
    .param p1, "bridge"    # Lcom/getcapacitor/Bridge;

    .line 504
    :try_start_0
    const-string v0, "io.ionic.sslpinning.SSLPinning"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 505
    .local v0, "sslPinningImpl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v1, "getSSLSocketFactory"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Lcom/getcapacitor/Bridge;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 506
    .local v1, "method":Ljava/lang/reflect/Method;
    new-array v2, v4, [Ljava/lang/Class;

    .line 507
    invoke-virtual {v0, v2}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v2

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v3

    .line 506
    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljavax/net/ssl/SSLSocketFactory;

    .line 510
    .local v2, "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    if-eqz v2, :cond_35

    .line 511
    iget-object v3, p0, Lcom/getcapacitor/plugin/util/CapacitorHttpUrlConnection;->connection:Ljava/net/HttpURLConnection;

    check-cast v3, Ljavax/net/ssl/HttpsURLConnection;

    invoke-virtual {v3, v2}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V
    :try_end_33
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_33} :catch_34

    goto :goto_35

    .line 513
    .end local v0    # "sslPinningImpl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v1    # "method":Ljava/lang/reflect/Method;
    .end local v2    # "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    :catch_34
    move-exception v0

    :cond_35
    :goto_35
    nop

    .line 514
    return-void
.end method
