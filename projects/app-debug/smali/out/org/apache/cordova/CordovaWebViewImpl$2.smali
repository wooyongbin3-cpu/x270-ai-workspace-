.class Lorg/apache/cordova/CordovaWebViewImpl$2;
.super Ljava/lang/Object;
.source "CordovaWebViewImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/CordovaWebViewImpl;->loadUrlIntoView(Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/CordovaWebViewImpl;

.field final synthetic val$currentLoadUrlTimeout:I

.field final synthetic val$loadError:Ljava/lang/Runnable;

.field final synthetic val$loadUrlTimeoutValue:I


# direct methods
.method constructor <init>(Lorg/apache/cordova/CordovaWebViewImpl;IILjava/lang/Runnable;)V
    .registers 5
    .param p1, "this$0"    # Lorg/apache/cordova/CordovaWebViewImpl;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 171
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    iput p2, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$loadUrlTimeoutValue:I

    iput p3, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$currentLoadUrlTimeout:I

    iput-object p4, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$loadError:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    .line 175
    :try_start_0
    monitor-enter p0
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_1} :catch_c

    .line 176
    :try_start_1
    iget v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$loadUrlTimeoutValue:I

    int-to-long v0, v0

    invoke-virtual {p0, v0, v1}, Ljava/lang/Object;->wait(J)V

    .line 177
    monitor-exit p0

    .line 180
    goto :goto_10

    .line 177
    :catchall_9
    move-exception v0

    monitor-exit p0
    :try_end_b
    .catchall {:try_start_1 .. :try_end_b} :catchall_9

    :try_start_b
    throw v0
    :try_end_c
    .catch Ljava/lang/InterruptedException; {:try_start_b .. :try_end_c} :catch_c

    .line 178
    :catch_c
    move-exception v0

    .line 179
    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 183
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :goto_10
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetloadUrlTimeout(Lorg/apache/cordova/CordovaWebViewImpl;)I

    move-result v0

    iget v1, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$currentLoadUrlTimeout:I

    if-ne v0, v1, :cond_36

    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetcordova(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/CordovaInterface;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    if-eqz v0, :cond_36

    .line 184
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetcordova(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/CordovaInterface;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->val$loadError:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_49

    .line 185
    :cond_36
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$2;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetcordova(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/CordovaInterface;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    if-nez v0, :cond_49

    .line 186
    const-string v0, "CordovaWebViewImpl"

    const-string v1, "Cordova activity does not exist."

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 188
    :cond_49
    :goto_49
    return-void
.end method
