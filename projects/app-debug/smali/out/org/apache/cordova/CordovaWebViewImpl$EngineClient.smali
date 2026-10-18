.class public Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;
.super Ljava/lang/Object;
.source "CordovaWebViewImpl.java"

# interfaces
.implements Lorg/apache/cordova/CordovaWebViewEngine$Client;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/cordova/CordovaWebViewImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "EngineClient"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/CordovaWebViewImpl;


# direct methods
.method protected constructor <init>(Lorg/apache/cordova/CordovaWebViewImpl;)V
    .registers 2
    .param p1, "this$0"    # Lorg/apache/cordova/CordovaWebViewImpl;

    .line 545
    iput-object p1, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public clearLoadTimeoutTimer()V
    .registers 3

    .line 548
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetloadUrlTimeout(Lorg/apache/cordova/CordovaWebViewImpl;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fputloadUrlTimeout(Lorg/apache/cordova/CordovaWebViewImpl;I)V

    .line 549
    return-void
.end method

.method public onDispatchKeyEvent(Landroid/view/KeyEvent;)Ljava/lang/Boolean;
    .registers 7
    .param p1, "event"    # Landroid/view/KeyEvent;

    .line 614
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    .line 615
    .local v0, "keyCode":I
    const/4 v1, 0x4

    const/4 v2, 0x1

    .line 620
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 615
    if-ne v0, v1, :cond_e

    move v1, v2

    goto :goto_f

    :cond_e
    const/4 v1, 0x0

    .line 616
    .local v1, "isBackButton":Z
    :goto_f
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v4

    if-nez v4, :cond_40

    .line 617
    if-eqz v1, :cond_20

    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v2}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetmCustomView(Lorg/apache/cordova/CordovaWebViewImpl;)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_20

    .line 618
    return-object v3

    .line 619
    :cond_20
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v2}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetboundKeyCodes(Lorg/apache/cordova/CordovaWebViewImpl;)Ljava/util/Set;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_31

    .line 620
    return-object v3

    .line 621
    :cond_31
    if-eqz v1, :cond_92

    .line 622
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    iget-object v2, v2, Lorg/apache/cordova/CordovaWebViewImpl;->engine:Lorg/apache/cordova/CordovaWebViewEngine;

    invoke-interface {v2}, Lorg/apache/cordova/CordovaWebViewEngine;->canGoBack()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    return-object v2

    .line 624
    :cond_40
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v4

    if-ne v4, v2, :cond_92

    .line 625
    if-eqz v1, :cond_56

    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v2}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetmCustomView(Lorg/apache/cordova/CordovaWebViewImpl;)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_56

    .line 626
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-virtual {v2}, Lorg/apache/cordova/CordovaWebViewImpl;->hideCustomView()V

    .line 627
    return-object v3

    .line 628
    :cond_56
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v2}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetboundKeyCodes(Lorg/apache/cordova/CordovaWebViewImpl;)Ljava/util/Set;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_82

    .line 629
    const/4 v2, 0x0

    .line 630
    .local v2, "eventName":Ljava/lang/String;
    sparse-switch v0, :sswitch_data_94

    goto :goto_79

    .line 638
    :sswitch_6b
    const-string v2, "searchbutton"

    .line 639
    goto :goto_79

    .line 641
    :sswitch_6e
    const-string v2, "menubutton"

    .line 642
    goto :goto_79

    .line 632
    :sswitch_71
    const-string v2, "volumedownbutton"

    .line 633
    goto :goto_79

    .line 635
    :sswitch_74
    const-string v2, "volumeupbutton"

    .line 636
    goto :goto_79

    .line 644
    :sswitch_77
    const-string v2, "backbutton"

    .line 647
    :goto_79
    if-eqz v2, :cond_81

    .line 648
    iget-object v4, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v4, v2}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$msendJavascriptEvent(Lorg/apache/cordova/CordovaWebViewImpl;Ljava/lang/String;)V

    .line 649
    return-object v3

    .line 647
    .end local v2    # "eventName":Ljava/lang/String;
    :cond_81
    goto :goto_91

    .line 651
    :cond_82
    if-eqz v1, :cond_91

    .line 652
    iget-object v2, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    iget-object v2, v2, Lorg/apache/cordova/CordovaWebViewImpl;->engine:Lorg/apache/cordova/CordovaWebViewEngine;

    invoke-interface {v2}, Lorg/apache/cordova/CordovaWebViewEngine;->goBack()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    return-object v2

    .line 651
    :cond_91
    :goto_91
    nop

    .line 655
    :cond_92
    const/4 v2, 0x0

    return-object v2

    :sswitch_data_94
    .sparse-switch
        0x4 -> :sswitch_77
        0x18 -> :sswitch_74
        0x19 -> :sswitch_71
        0x52 -> :sswitch_6e
        0x54 -> :sswitch_6b
    .end sparse-switch
.end method

.method public onNavigationAttempt(Ljava/lang/String;)Z
    .registers 6
    .param p1, "url"    # Ljava/lang/String;

    .line 661
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginManager;->onOverrideUrlLoading(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_e

    .line 662
    return v1

    .line 663
    :cond_e
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginManager;->shouldAllowNavigation(Ljava/lang/String;)Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_1c

    .line 664
    return v2

    .line 665
    :cond_1c
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lorg/apache/cordova/PluginManager;->shouldOpenExternalUrl(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_33

    .line 666
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    const/4 v3, 0x0

    invoke-virtual {v0, p1, v1, v2, v3}, Lorg/apache/cordova/CordovaWebViewImpl;->showWebPage(Ljava/lang/String;ZZLjava/util/Map;)V

    .line 667
    return v1

    .line 669
    :cond_33
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Blocked (possibly sub-frame) navigation to non-allowed URL: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "CordovaWebViewImpl"

    invoke-static {v2, v0}, Lorg/apache/cordova/LOG;->w(Ljava/lang/String;Ljava/lang/String;)V

    .line 670
    return v1
.end method

.method public onPageFinishedLoading(Ljava/lang/String;)V
    .registers 5
    .param p1, "url"    # Ljava/lang/String;

    .line 575
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onPageFinished("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CordovaWebViewImpl"

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 577
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->clearLoadTimeoutTimer()V

    .line 580
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    const-string v1, "onPageFinished"

    invoke-virtual {v0, v1, p1}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 583
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    iget-object v0, v0, Lorg/apache/cordova/CordovaWebViewImpl;->engine:Lorg/apache/cordova/CordovaWebViewEngine;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaWebViewEngine;->getView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_47

    .line 584
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;

    invoke-direct {v1, p0}, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient$1;-><init>(Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 603
    .local v0, "t":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 607
    .end local v0    # "t":Ljava/lang/Thread;
    :cond_47
    const-string v0, "about:blank"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5b

    .line 608
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    const-string v1, "exit"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 610
    :cond_5b
    return-void
.end method

.method public onPageStarted(Ljava/lang/String;)V
    .registers 4
    .param p1, "newUrl"    # Ljava/lang/String;

    .line 553
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onPageDidNavigate("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CordovaWebViewImpl"

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 554
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetboundKeyCodes(Lorg/apache/cordova/CordovaWebViewImpl;)Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 555
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/cordova/PluginManager;->onReset()V

    .line 556
    iget-object v0, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v0}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v0

    const-string v1, "onPageStarted"

    invoke-virtual {v0, v1, p1}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 557
    return-void
.end method

.method public onReceivedError(ILjava/lang/String;Ljava/lang/String;)V
    .registers 7
    .param p1, "errorCode"    # I
    .param p2, "description"    # Ljava/lang/String;
    .param p3, "failingUrl"    # Ljava/lang/String;

    .line 561
    invoke-virtual {p0}, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->clearLoadTimeoutTimer()V

    .line 562
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 564
    .local v0, "data":Lorg/json/JSONObject;
    :try_start_8
    const-string v1, "errorCode"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 565
    const-string v1, "description"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 566
    const-string v1, "url"

    invoke-virtual {v0, v1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_17
    .catch Lorg/json/JSONException; {:try_start_8 .. :try_end_17} :catch_18

    .line 569
    goto :goto_1c

    .line 567
    :catch_18
    move-exception v1

    .line 568
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    .line 570
    .end local v1    # "e":Lorg/json/JSONException;
    :goto_1c
    iget-object v1, p0, Lorg/apache/cordova/CordovaWebViewImpl$EngineClient;->this$0:Lorg/apache/cordova/CordovaWebViewImpl;

    invoke-static {v1}, Lorg/apache/cordova/CordovaWebViewImpl;->-$$Nest$fgetpluginManager(Lorg/apache/cordova/CordovaWebViewImpl;)Lorg/apache/cordova/PluginManager;

    move-result-object v1

    const-string v2, "onReceivedError"

    invoke-virtual {v1, v2, v0}, Lorg/apache/cordova/PluginManager;->postMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 571
    return-void
.end method
