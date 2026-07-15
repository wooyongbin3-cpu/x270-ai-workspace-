.class public Lcom/getcapacitor/plugin/SystemBars;
.super Lcom/getcapacitor/Plugin;
.source "SystemBars.java"


# annotations
.annotation runtime Lcom/getcapacitor/annotation/CapacitorPlugin;
.end annotation


# static fields
.field static final BAR_GESTURE_BAR:Ljava/lang/String; = "NavigationBar"

.field static final BAR_STATUS_BAR:Ljava/lang/String; = "StatusBar"

.field static final INSETS_HANDLING_CSS:Ljava/lang/String; = "css"

.field static final INSETS_HANDLING_DISABLE:Ljava/lang/String; = "disable"

.field static final STYLE_DARK:Ljava/lang/String; = "DARK"

.field static final STYLE_DEFAULT:Ljava/lang/String; = "DEFAULT"

.field static final STYLE_LIGHT:Ljava/lang/String; = "LIGHT"

.field private static final WEBVIEW_VERSION_WITH_SAFE_AREA_FIX:I = 0x8c

.field private static final WEBVIEW_VERSION_WITH_SAFE_AREA_KEYBOARD_FIX:I = 0x90

.field static final viewportMetaJSFunction:Ljava/lang/String; = "function capacitorSystemBarsCheckMetaViewport() {\n    const meta = document.querySelectorAll(\"meta[name=viewport]\");\n    if (meta.length == 0) {\n        return false;\n    }\n    // get the last found meta viewport tag\n    const metaContent = meta[meta.length - 1].content;\n    return metaContent.includes(\"viewport-fit=cover\");\n}\ncapacitorSystemBarsCheckMetaViewport();\n"


# instance fields
.field private currentGestureBarStyle:Ljava/lang/String;

.field private currentStatusBarStyle:Ljava/lang/String;

.field private hasViewportCover:Z

.field private insetsHandling:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$EvylPBzZjLdoAOeHbCFhbstdvp8(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Z)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/plugin/SystemBars;->lambda$initSystemBars$0(Ljava/lang/String;Z)V

    return-void
.end method

.method public static synthetic $r8$lambda$HlI18or9g2v3jxTp55f72skUXyo(Lcom/getcapacitor/plugin/SystemBars;FFFF)V
    .registers 5

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/getcapacitor/plugin/SystemBars;->lambda$injectSafeAreaCSS$7(FFFF)V

    return-void
.end method

.method public static synthetic $r8$lambda$MxcIqheKqAh0CeZVgL9o8jfnslI(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Lcom/getcapacitor/plugin/SystemBars;->lambda$setStyle$1(Ljava/lang/String;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method public static synthetic $r8$lambda$QMjT0isIammsCKWnfmRyRvdoGco(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/plugin/SystemBars;->lambda$hide$3(Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method public static synthetic $r8$lambda$UjDIyPOa6OlxC3ysdJABQVA9OtA(Lcom/getcapacitor/plugin/SystemBars;Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/plugin/SystemBars;->lambda$initWindowInsetsListener$6(Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$_TR-y5xYaIeYtWKuA4ceEIMUVag(Lcom/getcapacitor/plugin/SystemBars;)V
    .registers 1

    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->lambda$onDOMReady$5()V

    return-void
.end method

.method public static synthetic $r8$lambda$mx3q8c48aQqW-qpHkXPpUu2eByA(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/plugin/SystemBars;->lambda$show$2(Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ze9BKCK53rNqvFx6uwVYQomNzYY(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/getcapacitor/plugin/SystemBars;->lambda$onDOMReady$4(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>()V
    .registers 2

    .line 28
    invoke-direct {p0}, Lcom/getcapacitor/Plugin;-><init>()V

    .line 58
    const-string v0, "css"

    iput-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    .line 59
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/getcapacitor/plugin/SystemBars;->hasViewportCover:Z

    .line 61
    const-string v0, "DEFAULT"

    iput-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->currentStatusBarStyle:Ljava/lang/String;

    .line 62
    iput-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->currentGestureBarStyle:Ljava/lang/String;

    return-void
.end method

.method private calcSafeAreaInsets(Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/graphics/Insets;
    .registers 7
    .param p1, "insets"    # Landroidx/core/view/WindowInsetsCompat;

    .line 169
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v0

    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->displayCutout()I

    move-result v1

    or-int/2addr v0, v1

    invoke-virtual {p1, v0}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v0

    .line 170
    .local v0, "safeArea":Landroidx/core/graphics/Insets;
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->ime()I

    move-result v1

    invoke-virtual {p1, v1}, Landroidx/core/view/WindowInsetsCompat;->isVisible(I)Z

    move-result v1

    if-eqz v1, :cond_23

    .line 171
    iget v1, v0, Landroidx/core/graphics/Insets;->left:I

    iget v2, v0, Landroidx/core/graphics/Insets;->top:I

    iget v3, v0, Landroidx/core/graphics/Insets;->right:I

    const/4 v4, 0x0

    invoke-static {v1, v2, v3, v4}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v1

    return-object v1

    .line 173
    :cond_23
    iget v1, v0, Landroidx/core/graphics/Insets;->left:I

    iget v2, v0, Landroidx/core/graphics/Insets;->top:I

    iget v3, v0, Landroidx/core/graphics/Insets;->right:I

    iget v4, v0, Landroidx/core/graphics/Insets;->bottom:I

    invoke-static {v1, v2, v3, v4}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v1

    return-object v1
.end method

.method private getBottomInset(Landroidx/core/graphics/Insets;Z)I
    .registers 5
    .param p1, "systemBarsInsets"    # Landroidx/core/graphics/Insets;
    .param p2, "keyboardVisible"    # Z

    .line 353
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->getWebViewMajorVersion()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0x90

    if-ge v0, v1, :cond_10

    .line 358
    if-eqz p2, :cond_10

    .line 359
    const/4 v0, 0x0

    return v0

    .line 363
    :cond_10
    iget v0, p1, Landroidx/core/graphics/Insets;->bottom:I

    return v0
.end method

.method private getStyleForTheme()Ljava/lang/String;
    .registers 3

    .line 327
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    .line 328
    .local v0, "currentNightMode":I
    const/16 v1, 0x20

    if-eq v0, v1, :cond_17

    .line 329
    const-string v1, "LIGHT"

    return-object v1

    .line 331
    :cond_17
    const-string v1, "DARK"

    return-object v1
.end method

.method private getWebViewMajorVersion()Ljava/lang/Integer;
    .registers 5

    .line 343
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroidx/webkit/WebViewCompat;->getCurrentWebViewPackage(Landroid/content/Context;)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 344
    .local v0, "info":Landroid/content/pm/PackageInfo;
    const/4 v1, 0x0

    if-eqz v0, :cond_1e

    iget-object v2, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    if-eqz v2, :cond_1e

    .line 345
    iget-object v2, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    const-string v3, "\\."

    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 346
    .local v2, "versionSegments":[Ljava/lang/String;
    aget-object v1, v2, v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    return-object v1

    .line 349
    .end local v2    # "versionSegments":[Ljava/lang/String;
    :cond_1e
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    return-object v1
.end method

.method private initSafeAreaCSSVariables()V
    .registers 7

    .line 177
    const-string v0, "css"

    iget-object v1, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_36

    .line 180
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_23

    .line 181
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 182
    .local v0, "v":Landroid/view/View;
    invoke-static {v0}, Landroidx/core/view/ViewCompat;->getRootWindowInsets(Landroid/view/View;)Landroidx/core/view/WindowInsetsCompat;

    move-result-object v0

    .line 183
    .local v0, "insets":Landroidx/core/view/WindowInsetsCompat;
    goto :goto_25

    .line 184
    .end local v0    # "insets":Landroidx/core/view/WindowInsetsCompat;
    :cond_23
    sget-object v0, Landroidx/core/view/WindowInsetsCompat;->CONSUMED:Landroidx/core/view/WindowInsetsCompat;

    .line 187
    .restart local v0    # "insets":Landroidx/core/view/WindowInsetsCompat;
    :goto_25
    if-eqz v0, :cond_36

    .line 188
    invoke-direct {p0, v0}, Lcom/getcapacitor/plugin/SystemBars;->calcSafeAreaInsets(Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/graphics/Insets;

    move-result-object v1

    .line 189
    .local v1, "safeAreaInsets":Landroidx/core/graphics/Insets;
    iget v2, v1, Landroidx/core/graphics/Insets;->top:I

    iget v3, v1, Landroidx/core/graphics/Insets;->right:I

    iget v4, v1, Landroidx/core/graphics/Insets;->bottom:I

    iget v5, v1, Landroidx/core/graphics/Insets;->left:I

    invoke-direct {p0, v2, v3, v4, v5}, Lcom/getcapacitor/plugin/SystemBars;->injectSafeAreaCSS(IIII)V

    .line 192
    .end local v0    # "insets":Landroidx/core/view/WindowInsetsCompat;
    .end local v1    # "safeAreaInsets":Landroidx/core/graphics/Insets;
    :cond_36
    return-void
.end method

.method private initSystemBars()V
    .registers 7

    .line 96
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getConfig()Lcom/getcapacitor/PluginConfig;

    move-result-object v0

    const-string v1, "style"

    const-string v2, "DEFAULT"

    invoke-virtual {v0, v1, v2}, Lcom/getcapacitor/PluginConfig;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 97
    .local v0, "style":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getConfig()Lcom/getcapacitor/PluginConfig;

    move-result-object v1

    const-string v2, "hidden"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lcom/getcapacitor/PluginConfig;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    .line 99
    .local v1, "hidden":Z
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getConfig()Lcom/getcapacitor/PluginConfig;

    move-result-object v2

    const-string v3, "insetsHandling"

    const-string v4, "css"

    invoke-virtual {v2, v3, v4}, Lcom/getcapacitor/PluginConfig;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 100
    .local v2, "configuredInsetsHandling":Ljava/lang/String;
    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_63

    const-string v3, "disable"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_38

    goto :goto_63

    .line 103
    :cond_38
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unknown insetsHandling value \'"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "\'. Falling back to \'"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "\'."

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v5, "SystemBars"

    invoke-static {v5, v3}, Lcom/getcapacitor/Logger;->warn(Ljava/lang/String;Ljava/lang/String;)V

    .line 107
    iput-object v4, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    goto :goto_65

    .line 101
    :cond_63
    :goto_63
    iput-object v2, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    .line 110
    :goto_65
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->initWindowInsetsListener()V

    .line 111
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->initSafeAreaCSSVariables()V

    .line 113
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v3

    new-instance v4, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda5;

    invoke-direct {v4, p0, v0, v1}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda5;-><init>(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Z)V

    invoke-virtual {v3, v4}, Lcom/getcapacitor/Bridge;->executeOnMainThread(Ljava/lang/Runnable;)V

    .line 117
    return-void
.end method

.method private initWindowInsetsListener()V
    .registers 3

    .line 195
    const-string v0, "disable"

    iget-object v1, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 196
    return-void

    .line 199
    :cond_b
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    new-instance v1, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda1;-><init>(Lcom/getcapacitor/plugin/SystemBars;)V

    invoke-static {v0, v1}, Landroidx/core/view/ViewCompat;->setOnApplyWindowInsetsListener(Landroid/view/View;Landroidx/core/view/OnApplyWindowInsetsListener;)V

    .line 248
    return-void
.end method

.method private injectSafeAreaCSS(IIII)V
    .registers 13
    .param p1, "top"    # I
    .param p2, "right"    # I
    .param p3, "bottom"    # I
    .param p4, "left"    # I

    .line 252
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 253
    .local v0, "density":F
    int-to-float v1, p1

    div-float v4, v1, v0

    .line 254
    .local v4, "topPx":F
    int-to-float v1, p2

    div-float v5, v1, v0

    .line 255
    .local v5, "rightPx":F
    int-to-float v1, p3

    div-float v6, v1, v0

    .line 256
    .local v6, "bottomPx":F
    int-to-float v1, p4

    div-float v7, v1, v0

    .line 259
    .local v7, "leftPx":F
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v1

    new-instance v2, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda4;

    move-object v3, p0

    invoke-direct/range {v2 .. v7}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda4;-><init>(Lcom/getcapacitor/plugin/SystemBars;FFFF)V

    invoke-virtual {v1, v2}, Lcom/getcapacitor/Bridge;->executeOnMainThread(Ljava/lang/Runnable;)V

    .line 280
    return-void
.end method

.method private synthetic lambda$hide$3(Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 4
    .param p1, "bar"    # Ljava/lang/String;
    .param p2, "call"    # Lcom/getcapacitor/PluginCall;

    .line 145
    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/getcapacitor/plugin/SystemBars;->setHidden(ZLjava/lang/String;)V

    .line 146
    invoke-virtual {p2}, Lcom/getcapacitor/PluginCall;->resolve()V

    .line 147
    return-void
.end method

.method private synthetic lambda$initSystemBars$0(Ljava/lang/String;Z)V
    .registers 4
    .param p1, "style"    # Ljava/lang/String;
    .param p2, "hidden"    # Z

    .line 114
    const-string v0, ""

    invoke-direct {p0, p1, v0}, Lcom/getcapacitor/plugin/SystemBars;->setStyle(Ljava/lang/String;Ljava/lang/String;)V

    .line 115
    invoke-direct {p0, p2, v0}, Lcom/getcapacitor/plugin/SystemBars;->setHidden(ZLjava/lang/String;)V

    .line 116
    return-void
.end method

.method private synthetic lambda$initWindowInsetsListener$6(Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;
    .registers 14
    .param p1, "v"    # Landroid/view/View;
    .param p2, "insets"    # Landroidx/core/view/WindowInsetsCompat;

    .line 200
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->getWebViewMajorVersion()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0x8c

    const/4 v2, 0x0

    if-lt v0, v1, :cond_13

    iget-boolean v0, p0, Lcom/getcapacitor/plugin/SystemBars;->hasViewportCover:Z

    if-eqz v0, :cond_13

    const/4 v0, 0x1

    goto :goto_14

    :cond_13
    move v0, v2

    .line 202
    .local v0, "shouldPassthroughInsets":Z
    :goto_14
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v1

    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->displayCutout()I

    move-result v3

    or-int/2addr v1, v3

    invoke-virtual {p2, v1}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v1

    .line 203
    .local v1, "systemBarsInsets":Landroidx/core/graphics/Insets;
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->ime()I

    move-result v3

    invoke-virtual {p2, v3}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v3

    .line 204
    .local v3, "imeInsets":Landroidx/core/graphics/Insets;
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->ime()I

    move-result v4

    invoke-virtual {p2, v4}, Landroidx/core/view/WindowInsetsCompat;->isVisible(I)Z

    move-result v4

    .line 206
    .local v4, "keyboardVisible":Z
    if-eqz v0, :cond_70

    .line 208
    if-eqz v4, :cond_38

    iget v5, v3, Landroidx/core/graphics/Insets;->bottom:I

    goto :goto_39

    :cond_38
    move v5, v2

    :goto_39
    invoke-virtual {p1, v2, v2, v2, v5}, Landroid/view/View;->setPadding(IIII)V

    .line 210
    invoke-direct {p0, p2}, Lcom/getcapacitor/plugin/SystemBars;->calcSafeAreaInsets(Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/graphics/Insets;

    move-result-object v2

    .line 211
    .local v2, "safeAreaInsets":Landroidx/core/graphics/Insets;
    iget v5, v2, Landroidx/core/graphics/Insets;->top:I

    iget v6, v2, Landroidx/core/graphics/Insets;->right:I

    iget v7, v2, Landroidx/core/graphics/Insets;->bottom:I

    iget v8, v2, Landroidx/core/graphics/Insets;->left:I

    invoke-direct {p0, v5, v6, v7, v8}, Lcom/getcapacitor/plugin/SystemBars;->injectSafeAreaCSS(IIII)V

    .line 213
    new-instance v5, Landroidx/core/view/WindowInsetsCompat$Builder;

    invoke-direct {v5, p2}, Landroidx/core/view/WindowInsetsCompat$Builder;-><init>(Landroidx/core/view/WindowInsetsCompat;)V

    .line 215
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v6

    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->displayCutout()I

    move-result v7

    or-int/2addr v6, v7

    iget v7, v1, Landroidx/core/graphics/Insets;->left:I

    iget v8, v1, Landroidx/core/graphics/Insets;->top:I

    iget v9, v1, Landroidx/core/graphics/Insets;->right:I

    .line 220
    invoke-direct {p0, v1, v4}, Lcom/getcapacitor/plugin/SystemBars;->getBottomInset(Landroidx/core/graphics/Insets;Z)I

    move-result v10

    .line 216
    invoke-static {v7, v8, v9, v10}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v7

    .line 214
    invoke-virtual {v5, v6, v7}, Landroidx/core/view/WindowInsetsCompat$Builder;->setInsets(ILandroidx/core/graphics/Insets;)Landroidx/core/view/WindowInsetsCompat$Builder;

    move-result-object v5

    .line 223
    invoke-virtual {v5}, Landroidx/core/view/WindowInsetsCompat$Builder;->build()Landroidx/core/view/WindowInsetsCompat;

    move-result-object v5

    .line 213
    return-object v5

    .line 226
    .end local v2    # "safeAreaInsets":Landroidx/core/graphics/Insets;
    :cond_70
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x23

    if-lt v5, v6, :cond_86

    .line 228
    iget v5, v1, Landroidx/core/graphics/Insets;->left:I

    iget v6, v1, Landroidx/core/graphics/Insets;->top:I

    iget v7, v1, Landroidx/core/graphics/Insets;->right:I

    .line 232
    if-eqz v4, :cond_81

    iget v8, v3, Landroidx/core/graphics/Insets;->bottom:I

    goto :goto_83

    :cond_81
    iget v8, v1, Landroidx/core/graphics/Insets;->bottom:I

    .line 228
    :goto_83
    invoke-virtual {p1, v5, v6, v7, v8}, Landroid/view/View;->setPadding(IIII)V

    .line 239
    :cond_86
    new-instance v5, Landroidx/core/view/WindowInsetsCompat$Builder;

    invoke-direct {v5, p2}, Landroidx/core/view/WindowInsetsCompat$Builder;-><init>(Landroidx/core/view/WindowInsetsCompat;)V

    .line 240
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v6

    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->displayCutout()I

    move-result v7

    or-int/2addr v6, v7

    invoke-static {v2, v2, v2, v2}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v2

    invoke-virtual {v5, v6, v2}, Landroidx/core/view/WindowInsetsCompat$Builder;->setInsets(ILandroidx/core/graphics/Insets;)Landroidx/core/view/WindowInsetsCompat$Builder;

    move-result-object v2

    .line 241
    invoke-virtual {v2}, Landroidx/core/view/WindowInsetsCompat$Builder;->build()Landroidx/core/view/WindowInsetsCompat;

    move-result-object v2

    .line 243
    .local v2, "newInsets":Landroidx/core/view/WindowInsetsCompat;
    invoke-direct {p0, v2}, Lcom/getcapacitor/plugin/SystemBars;->calcSafeAreaInsets(Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/graphics/Insets;

    move-result-object v5

    .line 244
    .local v5, "safeAreaInsets":Landroidx/core/graphics/Insets;
    iget v6, v5, Landroidx/core/graphics/Insets;->top:I

    iget v7, v5, Landroidx/core/graphics/Insets;->right:I

    iget v8, v5, Landroidx/core/graphics/Insets;->bottom:I

    iget v9, v5, Landroidx/core/graphics/Insets;->left:I

    invoke-direct {p0, v6, v7, v8, v9}, Lcom/getcapacitor/plugin/SystemBars;->injectSafeAreaCSS(IIII)V

    .line 246
    return-object v2
.end method

.method private synthetic lambda$injectSafeAreaCSS$7(FFFF)V
    .registers 10
    .param p1, "topPx"    # F
    .param p2, "rightPx"    # F
    .param p3, "bottomPx"    # F
    .param p4, "leftPx"    # F

    .line 260
    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->bridge:Lcom/getcapacitor/Bridge;

    if-eqz v0, :cond_36

    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    if-eqz v0, :cond_36

    .line 261
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    float-to-int v1, p1

    .line 271
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    float-to-int v2, p2

    .line 272
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    float-to-int v3, p3

    .line 273
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    float-to-int v4, p4

    .line 274
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v1, v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v1

    .line 261
    const-string v2, "try {\n  document.documentElement.style.setProperty(\"--safe-area-inset-top\", \"%dpx\");\n  document.documentElement.style.setProperty(\"--safe-area-inset-right\", \"%dpx\");\n  document.documentElement.style.setProperty(\"--safe-area-inset-bottom\", \"%dpx\");\n  document.documentElement.style.setProperty(\"--safe-area-inset-left\", \"%dpx\");\n} catch(e) { console.error(\'Error injecting safe area CSS:\', e); }\n"

    invoke-static {v0, v2, v1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 277
    .local v0, "script":Ljava/lang/String;
    iget-object v1, p0, Lcom/getcapacitor/plugin/SystemBars;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v1}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    .line 279
    .end local v0    # "script":Ljava/lang/String;
    :cond_36
    return-void
.end method

.method private synthetic lambda$onDOMReady$4(Ljava/lang/String;)V
    .registers 3
    .param p1, "res"    # Ljava/lang/String;

    .line 160
    const-string v0, "true"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/getcapacitor/plugin/SystemBars;->hasViewportCover:Z

    .line 162
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebView;->requestApplyInsets()V

    .line 163
    return-void
.end method

.method private synthetic lambda$onDOMReady$5()V
    .registers 4

    .line 159
    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->bridge:Lcom/getcapacitor/Bridge;

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    new-instance v1, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda7;-><init>(Lcom/getcapacitor/plugin/SystemBars;)V

    const-string v2, "function capacitorSystemBarsCheckMetaViewport() {\n    const meta = document.querySelectorAll(\"meta[name=viewport]\");\n    if (meta.length == 0) {\n        return false;\n    }\n    // get the last found meta viewport tag\n    const metaContent = meta[meta.length - 1].content;\n    return metaContent.includes(\"viewport-fit=cover\");\n}\ncapacitorSystemBarsCheckMetaViewport();\n"

    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    .line 164
    return-void
.end method

.method private synthetic lambda$setStyle$1(Ljava/lang/String;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 4
    .param p1, "style"    # Ljava/lang/String;
    .param p2, "bar"    # Ljava/lang/String;
    .param p3, "call"    # Lcom/getcapacitor/PluginCall;

    .line 125
    invoke-direct {p0, p1, p2}, Lcom/getcapacitor/plugin/SystemBars;->setStyle(Ljava/lang/String;Ljava/lang/String;)V

    .line 126
    invoke-virtual {p3}, Lcom/getcapacitor/PluginCall;->resolve()V

    .line 127
    return-void
.end method

.method private synthetic lambda$show$2(Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .registers 4
    .param p1, "bar"    # Ljava/lang/String;
    .param p2, "call"    # Lcom/getcapacitor/PluginCall;

    .line 135
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lcom/getcapacitor/plugin/SystemBars;->setHidden(ZLjava/lang/String;)V

    .line 136
    invoke-virtual {p2}, Lcom/getcapacitor/PluginCall;->resolve()V

    .line 137
    return-void
.end method

.method private setHidden(ZLjava/lang/String;)V
    .registers 8
    .param p1, "hide"    # Z
    .param p2, "bar"    # Ljava/lang/String;

    .line 303
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 304
    .local v0, "window":Landroid/view/Window;
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/core/view/WindowCompat;->getInsetsController(Landroid/view/Window;Landroid/view/View;)Landroidx/core/view/WindowInsetsControllerCompat;

    move-result-object v1

    .line 306
    .local v1, "windowInsetsControllerCompat":Landroidx/core/view/WindowInsetsControllerCompat;
    const-string v2, "NavigationBar"

    const-string v3, "StatusBar"

    if-eqz p1, :cond_40

    .line 307
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_24

    .line 308
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->hide(I)V

    goto :goto_3f

    .line 309
    :cond_24
    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_32

    .line 310
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->statusBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->hide(I)V

    goto :goto_3f

    .line 311
    :cond_32
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3f

    .line 312
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->navigationBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->hide(I)V

    .line 314
    :cond_3f
    :goto_3f
    return-void

    .line 317
    :cond_40
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_4e

    .line 318
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->show(I)V

    goto :goto_69

    .line 319
    :cond_4e
    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5c

    .line 320
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->statusBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->show(I)V

    goto :goto_69

    .line 321
    :cond_5c
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_69

    .line 322
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->navigationBars()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->show(I)V

    .line 324
    :cond_69
    :goto_69
    return-void
.end method

.method private setStyle(Ljava/lang/String;Ljava/lang/String;)V
    .registers 8
    .param p1, "style"    # Ljava/lang/String;
    .param p2, "bar"    # Ljava/lang/String;

    .line 283
    const-string v0, "DEFAULT"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    .line 284
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->getStyleForTheme()Ljava/lang/String;

    move-result-object p1

    .line 287
    :cond_c
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 288
    .local v0, "window":Landroid/view/Window;
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/core/view/WindowCompat;->getInsetsController(Landroid/view/Window;Landroid/view/View;)Landroidx/core/view/WindowInsetsControllerCompat;

    move-result-object v1

    .line 289
    .local v1, "windowInsetsControllerCompat":Landroidx/core/view/WindowInsetsControllerCompat;
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const-string v3, "DARK"

    if-nez v2, :cond_2c

    const-string v2, "StatusBar"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_37

    .line 290
    :cond_2c
    iput-object p1, p0, Lcom/getcapacitor/plugin/SystemBars;->currentStatusBarStyle:Ljava/lang/String;

    .line 291
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->setAppearanceLightStatusBars(Z)V

    .line 294
    :cond_37
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_45

    const-string v2, "NavigationBar"

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_50

    .line 295
    :cond_45
    iput-object p1, p0, Lcom/getcapacitor/plugin/SystemBars;->currentGestureBarStyle:Ljava/lang/String;

    .line 296
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Landroidx/core/view/WindowInsetsControllerCompat;->setAppearanceLightNavigationBars(Z)V

    .line 299
    :cond_50
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getContext()Landroid/content/Context;

    move-result-object v3

    const v4, 0x1010054

    invoke-virtual {p0, v3, v4}, Lcom/getcapacitor/plugin/SystemBars;->getThemeColor(Landroid/content/Context;I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackgroundColor(I)V

    .line 300
    return-void
.end method


# virtual methods
.method public getThemeColor(Landroid/content/Context;I)I
    .registers 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrRes"    # I

    .line 335
    new-instance v0, Landroid/util/TypedValue;

    invoke-direct {v0}, Landroid/util/TypedValue;-><init>()V

    .line 337
    .local v0, "typedValue":Landroid/util/TypedValue;
    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    .line 338
    .local v1, "theme":Landroid/content/res/Resources$Theme;
    const/4 v2, 0x1

    invoke-virtual {v1, p2, v0, v2}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    .line 339
    iget v2, v0, Landroid/util/TypedValue;->data:I

    return v2
.end method

.method protected handleOnConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 4
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .line 89
    invoke-super {p0, p1}, Lcom/getcapacitor/Plugin;->handleOnConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 91
    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->currentGestureBarStyle:Ljava/lang/String;

    const-string v1, "NavigationBar"

    invoke-direct {p0, v0, v1}, Lcom/getcapacitor/plugin/SystemBars;->setStyle(Ljava/lang/String;Ljava/lang/String;)V

    .line 92
    iget-object v0, p0, Lcom/getcapacitor/plugin/SystemBars;->currentStatusBarStyle:Ljava/lang/String;

    const-string v1, "StatusBar"

    invoke-direct {p0, v0, v1}, Lcom/getcapacitor/plugin/SystemBars;->setStyle(Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    return-void
.end method

.method protected handleOnStart()V
    .registers 3

    .line 74
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->handleOnStart()V

    .line 76
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    new-instance v1, Lcom/getcapacitor/plugin/SystemBars$1;

    invoke-direct {v1, p0}, Lcom/getcapacitor/plugin/SystemBars$1;-><init>(Lcom/getcapacitor/plugin/SystemBars;)V

    invoke-virtual {v0, v1}, Lcom/getcapacitor/Bridge;->addWebViewListener(Lcom/getcapacitor/WebViewListener;)V

    .line 85
    return-void
.end method

.method public hide(Lcom/getcapacitor/PluginCall;)V
    .registers 5
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 142
    const-string v0, "bar"

    const-string v1, ""

    invoke-virtual {p1, v0, v1}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 144
    .local v0, "bar":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v1

    new-instance v2, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda6;

    invoke-direct {v2, p0, v0, p1}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda6;-><init>(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v1, v2}, Lcom/getcapacitor/Bridge;->executeOnMainThread(Ljava/lang/Runnable;)V

    .line 148
    return-void
.end method

.method public load()V
    .registers 3

    .line 66
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v0

    invoke-virtual {v0}, Lcom/getcapacitor/Bridge;->getWebView()Landroid/webkit/WebView;

    move-result-object v0

    const-string v1, "CapacitorSystemBarsAndroidInterface"

    invoke-virtual {v0, p0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->load()V

    .line 69
    invoke-direct {p0}, Lcom/getcapacitor/plugin/SystemBars;->initSystemBars()V

    .line 70
    return-void
.end method

.method public onDOMReady()V
    .registers 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 157
    const-string v0, "css"

    iget-object v1, p0, Lcom/getcapacitor/plugin/SystemBars;->insetsHandling:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    .line 158
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda2;-><init>(Lcom/getcapacitor/plugin/SystemBars;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 166
    :cond_16
    return-void
.end method

.method public setAnimation(Lcom/getcapacitor/PluginCall;)V
    .registers 2
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 152
    invoke-virtual {p1}, Lcom/getcapacitor/PluginCall;->resolve()V

    .line 153
    return-void
.end method

.method public setStyle(Lcom/getcapacitor/PluginCall;)V
    .registers 6
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 121
    const-string v0, "bar"

    const-string v1, ""

    invoke-virtual {p1, v0, v1}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 122
    .local v0, "bar":Ljava/lang/String;
    const-string v1, "style"

    const-string v2, "DEFAULT"

    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 124
    .local v1, "style":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v2

    new-instance v3, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda3;

    invoke-direct {v3, p0, v1, v0, p1}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda3;-><init>(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v2, v3}, Lcom/getcapacitor/Bridge;->executeOnMainThread(Ljava/lang/Runnable;)V

    .line 128
    return-void
.end method

.method public show(Lcom/getcapacitor/PluginCall;)V
    .registers 5
    .param p1, "call"    # Lcom/getcapacitor/PluginCall;
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 132
    const-string v0, "bar"

    const-string v1, ""

    invoke-virtual {p1, v0, v1}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 134
    .local v0, "bar":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/getcapacitor/plugin/SystemBars;->getBridge()Lcom/getcapacitor/Bridge;

    move-result-object v1

    new-instance v2, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0, p1}, Lcom/getcapacitor/plugin/SystemBars$$ExternalSyntheticLambda0;-><init>(Lcom/getcapacitor/plugin/SystemBars;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v1, v2}, Lcom/getcapacitor/Bridge;->executeOnMainThread(Ljava/lang/Runnable;)V

    .line 138
    return-void
.end method
