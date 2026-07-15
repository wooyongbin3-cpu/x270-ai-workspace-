.class public Landroidx/webkit/internal/WebMessageAdapter;
.super Ljava/lang/Object;
.source "WebMessageAdapter.java"

# interfaces
.implements Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;


# static fields
.field private static final sFeatures:[Ljava/lang/String;


# instance fields
.field private final mWebMessageCompat:Landroidx/webkit/WebMessageCompat;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 42
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "WEB_MESSAGE_ARRAY_BUFFER"

    aput-object v2, v0, v1

    sput-object v0, Landroidx/webkit/internal/WebMessageAdapter;->sFeatures:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroidx/webkit/WebMessageCompat;)V
    .registers 2
    .param p1, "webMessage"    # Landroidx/webkit/WebMessageCompat;

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput-object p1, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    .line 46
    return-void
.end method

.method public static isMessagePayloadTypeSupportedByWebView(I)Z
    .registers 3
    .param p0, "type"    # I

    .line 99
    const/4 v0, 0x1

    if-eqz p0, :cond_10

    if-ne p0, v0, :cond_e

    sget-object v1, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_ARRAY_BUFFER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    .line 101
    invoke-virtual {v1}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_10

    :cond_e
    const/4 v0, 0x0

    goto :goto_11

    :cond_10
    :goto_10
    nop

    .line 99
    :goto_11
    return v0
.end method

.method private static toWebMessagePortCompats([Ljava/lang/reflect/InvocationHandler;)[Landroidx/webkit/WebMessagePortCompat;
    .registers 5
    .param p0, "ports"    # [Ljava/lang/reflect/InvocationHandler;

    .line 139
    array-length v0, p0

    new-array v0, v0, [Landroidx/webkit/WebMessagePortCompat;

    .line 140
    .local v0, "compatPorts":[Landroidx/webkit/WebMessagePortCompat;
    const/4 v1, 0x0

    .local v1, "n":I
    :goto_4
    array-length v2, p0

    if-ge v1, v2, :cond_13

    .line 141
    new-instance v2, Landroidx/webkit/internal/WebMessagePortImpl;

    aget-object v3, p0, v1

    invoke-direct {v2, v3}, Landroidx/webkit/internal/WebMessagePortImpl;-><init>(Ljava/lang/reflect/InvocationHandler;)V

    aput-object v2, v0, v1

    .line 140
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 143
    .end local v1    # "n":I
    :cond_13
    return-object v0
.end method

.method public static webMessageCompatFromBoundaryInterface(Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;)Landroidx/webkit/WebMessageCompat;
    .registers 6
    .param p0, "boundaryInterface"    # Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;

    .line 116
    nop

    .line 117
    invoke-interface {p0}, Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;->getPorts()[Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    .line 116
    invoke-static {v0}, Landroidx/webkit/internal/WebMessageAdapter;->toWebMessagePortCompats([Ljava/lang/reflect/InvocationHandler;)[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v0

    .line 118
    .local v0, "ports":[Landroidx/webkit/WebMessagePortCompat;
    sget-object v1, Landroidx/webkit/internal/WebViewFeatureInternal;->WEB_MESSAGE_ARRAY_BUFFER:Landroidx/webkit/internal/ApiFeature$NoFramework;

    invoke-virtual {v1}, Landroidx/webkit/internal/ApiFeature$NoFramework;->isSupportedByWebView()Z

    move-result v1

    if-eqz v1, :cond_3a

    .line 119
    const-class v1, Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;

    .line 122
    invoke-interface {p0}, Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;->getMessagePayload()Ljava/lang/reflect/InvocationHandler;

    move-result-object v2

    .line 120
    invoke-static {v1, v2}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;

    .line 123
    .local v1, "payloadInterface":Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;
    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;->getType()I

    move-result v2

    .line 124
    .local v2, "type":I
    packed-switch v2, :pswitch_data_44

    .line 131
    const/4 v3, 0x0

    return-object v3

    .line 128
    :pswitch_26
    new-instance v3, Landroidx/webkit/WebMessageCompat;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;->getAsArrayBuffer()[B

    move-result-object v4

    invoke-direct {v3, v4, v0}, Landroidx/webkit/WebMessageCompat;-><init>([B[Landroidx/webkit/WebMessagePortCompat;)V

    return-object v3

    .line 126
    :pswitch_30
    new-instance v3, Landroidx/webkit/WebMessageCompat;

    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;->getAsString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v0}, Landroidx/webkit/WebMessageCompat;-><init>(Ljava/lang/String;[Landroidx/webkit/WebMessagePortCompat;)V

    return-object v3

    .line 134
    .end local v1    # "payloadInterface":Lorg/chromium/support_lib_boundary/WebMessagePayloadBoundaryInterface;
    .end local v2    # "type":I
    :cond_3a
    new-instance v1, Landroidx/webkit/WebMessageCompat;

    invoke-interface {p0}, Lorg/chromium/support_lib_boundary/WebMessageBoundaryInterface;->getData()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Landroidx/webkit/WebMessageCompat;-><init>(Ljava/lang/String;[Landroidx/webkit/WebMessagePortCompat;)V

    return-object v1

    :pswitch_data_44
    .packed-switch 0x0
        :pswitch_30
        :pswitch_26
    .end packed-switch
.end method


# virtual methods
.method public getData()Ljava/lang/String;
    .registers 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 55
    iget-object v0, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    invoke-virtual {v0}, Landroidx/webkit/WebMessageCompat;->getData()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMessagePayload()Ljava/lang/reflect/InvocationHandler;
    .registers 4

    .line 61
    iget-object v0, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    invoke-virtual {v0}, Landroidx/webkit/WebMessageCompat;->getType()I

    move-result v0

    packed-switch v0, :pswitch_data_4c

    .line 70
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown web message payload type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    .line 71
    invoke-virtual {v2}, Landroidx/webkit/WebMessageCompat;->getType()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 66
    :pswitch_28
    new-instance v0, Landroidx/webkit/internal/WebMessagePayloadAdapter;

    iget-object v1, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    .line 67
    invoke-virtual {v1}, Landroidx/webkit/WebMessageCompat;->getArrayBuffer()[B

    move-result-object v1

    invoke-static {v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    invoke-direct {v0, v1}, Landroidx/webkit/internal/WebMessagePayloadAdapter;-><init>([B)V

    .line 68
    .local v0, "adapter":Landroidx/webkit/internal/WebMessagePayloadAdapter;
    goto :goto_46

    .line 63
    .end local v0    # "adapter":Landroidx/webkit/internal/WebMessagePayloadAdapter;
    :pswitch_3a
    new-instance v0, Landroidx/webkit/internal/WebMessagePayloadAdapter;

    iget-object v1, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    invoke-virtual {v1}, Landroidx/webkit/WebMessageCompat;->getData()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/webkit/internal/WebMessagePayloadAdapter;-><init>(Ljava/lang/String;)V

    .line 64
    .restart local v0    # "adapter":Landroidx/webkit/internal/WebMessagePayloadAdapter;
    nop

    .line 73
    :goto_46
    invoke-static {v0}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->createInvocationHandlerFor(Ljava/lang/Object;)Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_4c
    .packed-switch 0x0
        :pswitch_3a
        :pswitch_28
    .end packed-switch
.end method

.method public getPorts()[Ljava/lang/reflect/InvocationHandler;
    .registers 5

    .line 78
    iget-object v0, p0, Landroidx/webkit/internal/WebMessageAdapter;->mWebMessageCompat:Landroidx/webkit/WebMessageCompat;

    invoke-virtual {v0}, Landroidx/webkit/WebMessageCompat;->getPorts()[Landroidx/webkit/WebMessagePortCompat;

    move-result-object v0

    .line 79
    .local v0, "ports":[Landroidx/webkit/WebMessagePortCompat;
    if-nez v0, :cond_a

    const/4 v1, 0x0

    return-object v1

    .line 81
    :cond_a
    array-length v1, v0

    new-array v1, v1, [Ljava/lang/reflect/InvocationHandler;

    .line 82
    .local v1, "invocationHandlers":[Ljava/lang/reflect/InvocationHandler;
    const/4 v2, 0x0

    .local v2, "n":I
    :goto_e
    array-length v3, v0

    if-ge v2, v3, :cond_1c

    .line 83
    aget-object v3, v0, v2

    invoke-virtual {v3}, Landroidx/webkit/WebMessagePortCompat;->getInvocationHandler()Ljava/lang/reflect/InvocationHandler;

    move-result-object v3

    aput-object v3, v1, v2

    .line 82
    add-int/lit8 v2, v2, 0x1

    goto :goto_e

    .line 85
    .end local v2    # "n":I
    :cond_1c
    return-object v1
.end method

.method public getSupportedFeatures()[Ljava/lang/String;
    .registers 2

    .line 91
    sget-object v0, Landroidx/webkit/internal/WebMessageAdapter;->sFeatures:[Ljava/lang/String;

    return-object v0
.end method
