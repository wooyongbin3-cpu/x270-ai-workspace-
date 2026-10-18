.class Lorg/apache/cordova/engine/SystemWebChromeClient$1;
.super Ljava/lang/Object;
.source "SystemWebChromeClient.java"

# interfaces
.implements Lorg/apache/cordova/CordovaDialogsHelper$Result;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/engine/SystemWebChromeClient;->onJsAlert(Landroid/webkit/WebView;Ljava/lang/String;Ljava/lang/String;Landroid/webkit/JsResult;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/engine/SystemWebChromeClient;

.field final synthetic val$result:Landroid/webkit/JsResult;


# direct methods
.method constructor <init>(Lorg/apache/cordova/engine/SystemWebChromeClient;Landroid/webkit/JsResult;)V
    .registers 3
    .param p1, "this$0"    # Lorg/apache/cordova/engine/SystemWebChromeClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 87
    iput-object p1, p0, Lorg/apache/cordova/engine/SystemWebChromeClient$1;->this$0:Lorg/apache/cordova/engine/SystemWebChromeClient;

    iput-object p2, p0, Lorg/apache/cordova/engine/SystemWebChromeClient$1;->val$result:Landroid/webkit/JsResult;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public gotResult(ZLjava/lang/String;)V
    .registers 4
    .param p1, "success"    # Z
    .param p2, "value"    # Ljava/lang/String;

    .line 89
    if-eqz p1, :cond_8

    .line 90
    iget-object v0, p0, Lorg/apache/cordova/engine/SystemWebChromeClient$1;->val$result:Landroid/webkit/JsResult;

    invoke-virtual {v0}, Landroid/webkit/JsResult;->confirm()V

    goto :goto_d

    .line 92
    :cond_8
    iget-object v0, p0, Lorg/apache/cordova/engine/SystemWebChromeClient$1;->val$result:Landroid/webkit/JsResult;

    invoke-virtual {v0}, Landroid/webkit/JsResult;->cancel()V

    .line 94
    :goto_d
    return-void
.end method
