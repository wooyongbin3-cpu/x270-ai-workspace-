.class Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;
.super Ljava/lang/Object;
.source "NativeToJsMessageQueue.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/cordova/NativeToJsMessageQueue;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "JsMessage"
.end annotation


# instance fields
.field final jsPayloadOrCallbackId:Ljava/lang/String;

.field final pluginResult:Lorg/apache/cordova/PluginResult;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .registers 3
    .param p1, "js"    # Ljava/lang/String;

    .line 392
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 393
    if-eqz p1, :cond_b

    .line 396
    iput-object p1, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    .line 397
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    .line 398
    return-void

    .line 394
    :cond_b
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0
.end method

.method constructor <init>(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V
    .registers 4
    .param p1, "pluginResult"    # Lorg/apache/cordova/PluginResult;
    .param p2, "callbackId"    # Ljava/lang/String;

    .line 399
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 400
    if-eqz p2, :cond_c

    if-eqz p1, :cond_c

    .line 403
    iput-object p2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    .line 404
    iput-object p1, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    .line 405
    return-void

    .line 401
    :cond_c
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0
.end method

.method static calculateEncodedLengthHelper(Lorg/apache/cordova/PluginResult;)I
    .registers 6
    .param p0, "pluginResult"    # Lorg/apache/cordova/PluginResult;

    .line 408
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMessageType()I

    move-result v0

    const/4 v1, 0x1

    packed-switch v0, :pswitch_data_5a

    .line 430
    :pswitch_8
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    return v0

    .line 421
    :pswitch_11
    const/4 v0, 0x1

    .line 422
    .local v0, "ret":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_13
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMultipartMessagesSize()I

    move-result v2

    if-ge v1, v2, :cond_30

    .line 423
    invoke-virtual {p0, v1}, Lorg/apache/cordova/PluginResult;->getMultipartMessage(I)Lorg/apache/cordova/PluginResult;

    move-result-object v2

    invoke-static {v2}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->calculateEncodedLengthHelper(Lorg/apache/cordova/PluginResult;)I

    move-result v2

    .line 424
    .local v2, "length":I
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    .line 425
    .local v3, "argLength":I
    add-int/lit8 v4, v3, 0x1

    add-int/2addr v4, v2

    add-int/2addr v0, v4

    .line 422
    .end local v2    # "length":I
    .end local v3    # "argLength":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_13

    .line 427
    .end local v1    # "i":I
    :cond_30
    return v0

    .line 417
    .end local v0    # "ret":I
    :pswitch_31
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    return v0

    .line 419
    :pswitch_3b
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    return v0

    .line 411
    :pswitch_45
    return v1

    .line 413
    :pswitch_46
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    return v0

    .line 415
    :pswitch_50
    invoke-virtual {p0}, Lorg/apache/cordova/PluginResult;->getStrMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v1

    return v0

    :pswitch_data_5a
    .packed-switch 0x1
        :pswitch_50
        :pswitch_8
        :pswitch_46
        :pswitch_45
        :pswitch_45
        :pswitch_3b
        :pswitch_31
        :pswitch_11
    .end packed-switch
.end method

.method static encodeAsMessageHelper(Ljava/lang/StringBuilder;Lorg/apache/cordova/PluginResult;)V
    .registers 5
    .param p0, "sb"    # Ljava/lang/StringBuilder;
    .param p1, "pluginResult"    # Lorg/apache/cordova/PluginResult;

    .line 444
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessageType()I

    move-result v0

    packed-switch v0, :pswitch_data_80

    .line 478
    :pswitch_7
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_7f

    .line 468
    :pswitch_10
    const/16 v0, 0x4d

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 469
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_16
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMultipartMessagesSize()I

    move-result v1

    if-ge v0, v1, :cond_36

    .line 470
    invoke-virtual {p1, v0}, Lorg/apache/cordova/PluginResult;->getMultipartMessage(I)Lorg/apache/cordova/PluginResult;

    move-result-object v1

    .line 471
    .local v1, "multipartMessage":Lorg/apache/cordova/PluginResult;
    invoke-static {v1}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->calculateEncodedLengthHelper(Lorg/apache/cordova/PluginResult;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 472
    const/16 v2, 0x20

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 473
    invoke-static {p0, v1}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->encodeAsMessageHelper(Ljava/lang/StringBuilder;Lorg/apache/cordova/PluginResult;)V

    .line 469
    .end local v1    # "multipartMessage":Lorg/apache/cordova/PluginResult;
    add-int/lit8 v0, v0, 0x1

    goto :goto_16

    .line 475
    .end local v0    # "i":I
    :cond_36
    goto :goto_7f

    .line 460
    :pswitch_37
    const/16 v0, 0x53

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 461
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 462
    goto :goto_7f

    .line 464
    :pswitch_44
    const/16 v0, 0x41

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 465
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 466
    goto :goto_7f

    .line 449
    :pswitch_51
    const/16 v0, 0x4e

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 450
    goto :goto_7f

    .line 446
    :pswitch_57
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 447
    goto :goto_7f

    .line 452
    :pswitch_64
    const/16 v0, 0x6e

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 453
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    goto :goto_7f

    .line 456
    :pswitch_72
    const/16 v0, 0x73

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 457
    invoke-virtual {p1}, Lorg/apache/cordova/PluginResult;->getStrMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 458
    nop

    .line 480
    :goto_7f
    return-void

    :pswitch_data_80
    .packed-switch 0x1
        :pswitch_72
        :pswitch_7
        :pswitch_64
        :pswitch_57
        :pswitch_51
        :pswitch_44
        :pswitch_37
        :pswitch_10
    .end packed-switch
.end method


# virtual methods
.method buildJsMessage(Ljava/lang/StringBuilder;)V
    .registers 7
    .param p1, "sb"    # Ljava/lang/StringBuilder;

    .line 504
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getMessageType()I

    move-result v0

    const-string v1, "\')"

    packed-switch v0, :pswitch_data_6a

    .line 530
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_69

    .line 506
    :pswitch_15
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getMultipartMessagesSize()I

    move-result v0

    .line 507
    .local v0, "size":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1c
    if-ge v1, v0, :cond_3a

    .line 508
    iget-object v2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v2, v1}, Lorg/apache/cordova/PluginResult;->getMultipartMessage(I)Lorg/apache/cordova/PluginResult;

    move-result-object v2

    .line 509
    .local v2, "subresult":Lorg/apache/cordova/PluginResult;
    new-instance v3, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;

    iget-object v4, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    invoke-direct {v3, v2, v4}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;-><init>(Lorg/apache/cordova/PluginResult;Ljava/lang/String;)V

    .line 510
    .local v3, "submessage":Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;
    invoke-virtual {v3, p1}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->buildJsMessage(Ljava/lang/StringBuilder;)V

    .line 511
    add-int/lit8 v4, v0, -0x1

    if-ge v1, v4, :cond_37

    .line 512
    const-string v4, ","

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 507
    .end local v2    # "subresult":Lorg/apache/cordova/PluginResult;
    .end local v3    # "submessage":Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;
    :cond_37
    add-int/lit8 v1, v1, 0x1

    goto :goto_1c

    .line 515
    .end local v1    # "i":I
    :cond_3a
    goto :goto_69

    .line 517
    .end local v0    # "size":I
    :pswitch_3b
    const-string v0, "atob(\'"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    .line 518
    invoke-virtual {v2}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 519
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 520
    goto :goto_69

    .line 522
    :pswitch_4f
    const-string v0, "cordova.require(\'cordova/base64\').toArrayBuffer(\'"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    .line 523
    invoke-virtual {v2}, Lorg/apache/cordova/PluginResult;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 524
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 525
    goto :goto_69

    .line 527
    :pswitch_63
    const-string v0, "null"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 528
    nop

    .line 532
    :goto_69
    return-void

    :pswitch_data_6a
    .packed-switch 0x5
        :pswitch_63
        :pswitch_4f
        :pswitch_3b
        :pswitch_15
    .end packed-switch
.end method

.method calculateEncodedLength()I
    .registers 4

    .line 435
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    if-nez v0, :cond_d

    .line 436
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 438
    :cond_d
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getStatus()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 439
    .local v0, "statusLen":I
    add-int/lit8 v1, v0, 0x2

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x1

    .line 440
    .local v1, "ret":I
    iget-object v2, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-static {v2}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->calculateEncodedLengthHelper(Lorg/apache/cordova/PluginResult;)I

    move-result v2

    add-int/2addr v2, v1

    return v2
.end method

.method encodeAsJsMessage(Ljava/lang/StringBuilder;)V
    .registers 6
    .param p1, "sb"    # Ljava/lang/StringBuilder;

    .line 535
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    if-nez v0, :cond_a

    .line 536
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_61

    .line 538
    :cond_a
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getStatus()I

    move-result v0

    .line 539
    .local v0, "status":I
    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-virtual {v1}, Lorg/apache/cordova/PluginResult$Status;->ordinal()I

    move-result v1

    if-eq v0, v1, :cond_23

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->NO_RESULT:Lorg/apache/cordova/PluginResult$Status;

    invoke-virtual {v1}, Lorg/apache/cordova/PluginResult$Status;->ordinal()I

    move-result v1

    if-ne v0, v1, :cond_21

    goto :goto_23

    :cond_21
    const/4 v1, 0x0

    goto :goto_24

    :cond_23
    :goto_23
    const/4 v1, 0x1

    .line 540
    .local v1, "success":Z
    :goto_24
    const-string v2, "cordova.callbackFromNative(\'"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    .line 541
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 542
    const-string v3, "\',"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 543
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 544
    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 545
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 546
    const-string v3, ",["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 547
    invoke-virtual {p0, p1}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->buildJsMessage(Ljava/lang/StringBuilder;)V

    .line 548
    const-string v2, "],"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    .line 549
    invoke-virtual {v3}, Lorg/apache/cordova/PluginResult;->getKeepCallback()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 550
    const-string v3, ");"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 552
    .end local v0    # "status":I
    .end local v1    # "success":Z
    :goto_61
    return-void
.end method

.method encodeAsMessage(Ljava/lang/StringBuilder;)V
    .registers 9
    .param p1, "sb"    # Ljava/lang/StringBuilder;

    .line 483
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    if-nez v0, :cond_10

    .line 484
    const/16 v0, 0x4a

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    .line 485
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 486
    return-void

    .line 488
    :cond_10
    iget-object v0, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v0}, Lorg/apache/cordova/PluginResult;->getStatus()I

    move-result v0

    .line 489
    .local v0, "status":I
    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->NO_RESULT:Lorg/apache/cordova/PluginResult$Status;

    invoke-virtual {v1}, Lorg/apache/cordova/PluginResult$Status;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ne v0, v1, :cond_22

    move v1, v2

    goto :goto_23

    :cond_22
    move v1, v3

    .line 490
    .local v1, "noResult":Z
    :goto_23
    sget-object v4, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-virtual {v4}, Lorg/apache/cordova/PluginResult$Status;->ordinal()I

    move-result v4

    if-ne v0, v4, :cond_2c

    goto :goto_2d

    :cond_2c
    move v2, v3

    .line 491
    .local v2, "resultOk":Z
    :goto_2d
    iget-object v3, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-virtual {v3}, Lorg/apache/cordova/PluginResult;->getKeepCallback()Z

    move-result v3

    .line 493
    .local v3, "keepCallback":Z
    if-nez v1, :cond_3b

    if-eqz v2, :cond_38

    goto :goto_3b

    :cond_38
    const/16 v4, 0x46

    goto :goto_3d

    :cond_3b
    :goto_3b
    const/16 v4, 0x53

    :goto_3d
    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 494
    if-eqz v3, :cond_46

    const/16 v5, 0x31

    goto :goto_48

    :cond_46
    const/16 v5, 0x30

    :goto_48
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 495
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 496
    const/16 v5, 0x20

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->jsPayloadOrCallbackId:Ljava/lang/String;

    .line 497
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 498
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 500
    iget-object v4, p0, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->pluginResult:Lorg/apache/cordova/PluginResult;

    invoke-static {p1, v4}, Lorg/apache/cordova/NativeToJsMessageQueue$JsMessage;->encodeAsMessageHelper(Ljava/lang/StringBuilder;Lorg/apache/cordova/PluginResult;)V

    .line 501
    return-void
.end method
