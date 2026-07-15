.class Lcom/getcapacitor/plugin/SystemBars$1;
.super Lcom/getcapacitor/WebViewListener;
.source "SystemBars.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/getcapacitor/plugin/SystemBars;->handleOnStart()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/getcapacitor/plugin/SystemBars;


# direct methods
.method constructor <init>(Lcom/getcapacitor/plugin/SystemBars;)V
    .registers 2
    .param p1, "this$0"    # Lcom/getcapacitor/plugin/SystemBars;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 77
    iput-object p1, p0, Lcom/getcapacitor/plugin/SystemBars$1;->this$0:Lcom/getcapacitor/plugin/SystemBars;

    invoke-direct {p0}, Lcom/getcapacitor/WebViewListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 4
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .line 80
    invoke-super {p0, p1, p2}, Lcom/getcapacitor/WebViewListener;->onPageCommitVisible(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 81
    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars$1;->this$0:Lcom/getcapacitor/plugin/SystemBars;

    invoke-virtual {v0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->requestApplyInsets()V

    .line 82
    return-void
.end method
