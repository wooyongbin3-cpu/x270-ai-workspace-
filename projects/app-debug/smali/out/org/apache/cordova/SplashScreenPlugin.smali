.class public Lorg/apache/cordova/SplashScreenPlugin;
.super Lorg/apache/cordova/CordovaPlugin;
.source "SplashScreenPlugin.java"


# static fields
.field private static final DEFAULT_AUTO_HIDE:Z = true

.field private static final DEFAULT_DELAY_TIME:I = -0x1

.field private static final DEFAULT_FADE:Z = true

.field private static final DEFAULT_FADE_TIME:I = 0x1f4

.field static final PLUGIN_NAME:Ljava/lang/String; = "CordovaSplashScreenPlugin"


# instance fields
.field private autoHide:Z

.field private delayTime:I

.field private fadeDuration:I

.field private isFadeEnabled:Z

.field private keepOnScreen:Z


# direct methods
.method static bridge synthetic -$$Nest$fgetfadeDuration(Lorg/apache/cordova/SplashScreenPlugin;)I
    .registers 1

    iget p0, p0, Lorg/apache/cordova/SplashScreenPlugin;->fadeDuration:I

    return p0
.end method

.method public constructor <init>()V
    .registers 2

    .line 37
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 68
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->keepOnScreen:Z

    return-void
.end method

.method private attemptCloseOnPageFinished()V
    .registers 3

    .line 166
    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->autoHide:Z

    if-eqz v0, :cond_c

    iget v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_c

    .line 167
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->keepOnScreen:Z

    .line 169
    :cond_c
    return-void
.end method

.method private setupSplashScreen(Landroidx/core/splashscreen/SplashScreen;)V
    .registers 6
    .param p1, "splashScreen"    # Landroidx/core/splashscreen/SplashScreen;

    .line 126
    new-instance v0, Lorg/apache/cordova/SplashScreenPlugin$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lorg/apache/cordova/SplashScreenPlugin$$ExternalSyntheticLambda0;-><init>(Lorg/apache/cordova/SplashScreenPlugin;)V

    invoke-virtual {p1, v0}, Landroidx/core/splashscreen/SplashScreen;->setKeepOnScreenCondition(Landroidx/core/splashscreen/SplashScreen$KeepOnScreenCondition;)V

    .line 129
    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->autoHide:Z

    if-eqz v0, :cond_2b

    iget v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_2b

    .line 130
    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lorg/apache/cordova/SplashScreenPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 131
    .local v0, "splashScreenDelayHandler":Landroid/os/Handler;
    new-instance v1, Lorg/apache/cordova/SplashScreenPlugin$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lorg/apache/cordova/SplashScreenPlugin$$ExternalSyntheticLambda1;-><init>(Lorg/apache/cordova/SplashScreenPlugin;)V

    iget v2, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 140
    .end local v0    # "splashScreenDelayHandler":Landroid/os/Handler;
    :cond_2b
    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->isFadeEnabled:Z

    if-eqz v0, :cond_37

    .line 142
    new-instance v0, Lorg/apache/cordova/SplashScreenPlugin$1;

    invoke-direct {v0, p0}, Lorg/apache/cordova/SplashScreenPlugin$1;-><init>(Lorg/apache/cordova/SplashScreenPlugin;)V

    invoke-virtual {p1, v0}, Landroidx/core/splashscreen/SplashScreen;->setOnExitAnimationListener(Landroidx/core/splashscreen/SplashScreen$OnExitAnimationListener;)V

    .line 163
    :cond_37
    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .registers 6
    .param p1, "action"    # Ljava/lang/String;
    .param p2, "args"    # Lorg/json/JSONArray;
    .param p3, "callbackContext"    # Lorg/apache/cordova/CallbackContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 95
    const-string v0, "hide"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_14

    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->autoHide:Z

    if-nez v0, :cond_14

    .line 100
    iput-boolean v1, p0, Lorg/apache/cordova/SplashScreenPlugin;->keepOnScreen:Z

    .line 105
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    .line 106
    const/4 v0, 0x1

    return v0

    .line 102
    :cond_14
    return v1
.end method

.method synthetic lambda$setupSplashScreen$0$org-apache-cordova-SplashScreenPlugin()Z
    .registers 2

    .line 126
    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->keepOnScreen:Z

    return v0
.end method

.method synthetic lambda$setupSplashScreen$1$org-apache-cordova-SplashScreenPlugin()V
    .registers 2

    .line 131
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->keepOnScreen:Z

    return-void
.end method

.method public onMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 4
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/Object;

    .line 111
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    sparse-switch v0, :sswitch_data_2e

    :cond_7
    goto :goto_1c

    :sswitch_8
    const-string v0, "setupSplashScreen"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const/4 v0, 0x0

    goto :goto_1d

    :sswitch_12
    const-string v0, "onPageFinished"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const/4 v0, 0x1

    goto :goto_1d

    :goto_1c
    const/4 v0, -0x1

    :goto_1d
    packed-switch v0, :pswitch_data_38

    goto :goto_2c

    .line 117
    :pswitch_21
    invoke-direct {p0}, Lorg/apache/cordova/SplashScreenPlugin;->attemptCloseOnPageFinished()V

    goto :goto_2c

    .line 113
    :pswitch_25
    move-object v0, p2

    check-cast v0, Landroidx/core/splashscreen/SplashScreen;

    invoke-direct {p0, v0}, Lorg/apache/cordova/SplashScreenPlugin;->setupSplashScreen(Landroidx/core/splashscreen/SplashScreen;)V

    .line 114
    nop

    .line 121
    :goto_2c
    const/4 v0, 0x0

    return-object v0

    :sswitch_data_2e
    .sparse-switch
        -0x1e1dec60 -> :sswitch_12
        0x2081e8d0 -> :sswitch_8
    .end sparse-switch

    :pswitch_data_38
    .packed-switch 0x0
        :pswitch_25
        :pswitch_21
    .end packed-switch
.end method

.method protected pluginInitialize()V
    .registers 6

    .line 73
    iget-object v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v1, "AutoHideSplashScreen"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/CordovaPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->autoHide:Z

    .line 74
    iget-object v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v1, "SplashScreenDelay"

    const/4 v3, -0x1

    invoke-virtual {v0, v1, v3}, Lorg/apache/cordova/CordovaPreferences;->getInteger(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Auto Hide: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lorg/apache/cordova/SplashScreenPlugin;->autoHide:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CordovaSplashScreenPlugin"

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    iget v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    const-string v4, "ms"

    if-eq v0, v3, :cond_52

    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Delay: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v3, p0, Lorg/apache/cordova/SplashScreenPlugin;->delayTime:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 81
    :cond_52
    iget-object v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v3, "FadeSplashScreen"

    invoke-virtual {v0, v3, v2}, Lorg/apache/cordova/CordovaPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->isFadeEnabled:Z

    .line 82
    iget-object v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v2, "FadeSplashScreenDuration"

    const/16 v3, 0x1f4

    invoke-virtual {v0, v2, v3}, Lorg/apache/cordova/CordovaPreferences;->getInteger(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->fadeDuration:I

    .line 83
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Fade: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v2, p0, Lorg/apache/cordova/SplashScreenPlugin;->isFadeEnabled:Z

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    iget-boolean v0, p0, Lorg/apache/cordova/SplashScreenPlugin;->isFadeEnabled:Z

    if-eqz v0, :cond_a0

    .line 85
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Fade Duration: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v2, p0, Lorg/apache/cordova/SplashScreenPlugin;->fadeDuration:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 87
    :cond_a0
    return-void
.end method
