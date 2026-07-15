.class Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;
.super Ljava/lang/Object;
.source "CordovaWebViewImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->onPageFinishedLoading(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;


# direct methods
.method constructor <init>(Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;)V
    .registers 2
    .param p1, "this$1"    # Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;

    .line 584
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;->this$1:Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    .line 588
    const-wide/16 v0, 0x7d0

    :try_start_2
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V

    .line 589
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;->this$1:Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;

    iget-object v0, v0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetcordova(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/CordovaInterface;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    if-eqz v0, :cond_28

    .line 590
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;->this$1:Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;

    iget-object v0, v0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetcordova(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/CordovaInterface;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1$1;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1$1;-><init>(Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_2f

    .line 597
    :cond_28
    const-string v0, "CordovaWebViewImpl"

    const-string v1, "Cordova activity does not exist."

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2f
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2f} :catch_30

    .line 600
    :goto_2f
    goto :goto_31

    .line 599
    :catch_30
    move-exception v0

    .line 601
    :goto_31
    return-void
.end method
