.class Landroidx/webkit/internal/WebViewFeatureInternal$1;
.super Landroidx/webkit/internal/ApiFeature$T;
.source "WebViewFeatureInternal.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/webkit/internal/WebViewFeatureInternal;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final mVersionPattern:Ljava/util/regex/Pattern;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p1, "publicFeatureValue"    # Ljava/lang/String;
    .param p2, "internalFeatureValue"    # Ljava/lang/String;

    .line 438
    invoke-direct {p0, p1, p2}, Landroidx/webkit/internal/ApiFeature$T;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 439
    const-string v0, "\\A\\d+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    iput-object v0, p0, Landroidx/webkit/internal/WebViewFeatureInternal$1;->mVersionPattern:Ljava/util/regex/Pattern;

    return-void
.end method


# virtual methods
.method public isSupportedByWebView()Z
    .registers 8

    .line 443
    invoke-super {p0}, Landroidx/webkit/internal/ApiFeature$T;->isSupportedByWebView()Z

    move-result v0

    .line 444
    .local v0, "supported":Z
    if-eqz v0, :cond_3b

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_d

    goto :goto_3b

    .line 450
    :cond_d
    invoke-static {}, Landroidx/webkit/WebViewCompat;->getCurrentLoadedWebViewPackage()Landroid/content/pm/PackageInfo;

    move-result-object v1

    .line 451
    .local v1, "info":Landroid/content/pm/PackageInfo;
    const/4 v2, 0x0

    if-nez v1, :cond_15

    return v2

    .line 452
    :cond_15
    iget-object v3, p0, Landroidx/webkit/internal/WebViewFeatureInternal$1;->mVersionPattern:Ljava/util/regex/Pattern;

    iget-object v4, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v3

    .line 453
    .local v3, "m":Ljava/util/regex/Matcher;
    invoke-virtual {v3}, Ljava/util/regex/Matcher;->find()Z

    move-result v4

    if-eqz v4, :cond_3a

    iget-object v4, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/util/regex/Matcher;->start()I

    move-result v5

    .line 454
    invoke-virtual {v3}, Ljava/util/regex/Matcher;->end()I

    move-result v6

    .line 453
    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    const/16 v5, 0x69

    if-lt v4, v5, :cond_3a

    const/4 v2, 0x1

    :cond_3a
    return v2

    .line 445
    .end local v1    # "info":Landroid/content/pm/PackageInfo;
    .end local v3    # "m":Ljava/util/regex/Matcher;
    :cond_3b
    :goto_3b
    return v0
.end method
