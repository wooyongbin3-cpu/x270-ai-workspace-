.class public Landroidx/webkit/internal/NavigationAdapter;
.super Ljava/lang/Object;
.source "NavigationAdapter.java"

# interfaces
.implements Landroidx/webkit/Navigation;


# instance fields
.field mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

.field mPage:Landroidx/webkit/internal/PageImpl;


# direct methods
.method public constructor <init>(Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;)V
    .registers 2
    .param p1, "impl"    # Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    .line 34
    return-void
.end method


# virtual methods
.method public didCommit()Z
    .registers 2

    .line 87
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->didCommit()Z

    move-result v0

    return v0
.end method

.method public didCommitErrorPage()Z
    .registers 2

    .line 92
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->didCommitErrorPage()Z

    move-result v0

    return v0
.end method

.method public getPage()Landroidx/webkit/Page;
    .registers 3

    .line 38
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->getPage()Ljava/lang/reflect/InvocationHandler;

    move-result-object v0

    if-nez v0, :cond_a

    const/4 v0, 0x0

    return-object v0

    .line 40
    :cond_a
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mPage:Landroidx/webkit/internal/PageImpl;

    if-nez v0, :cond_23

    .line 41
    const-class v0, Lorg/chromium/support_lib_boundary/WebViewPageBoundaryInterface;

    iget-object v1, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    .line 43
    invoke-interface {v1}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->getPage()Ljava/lang/reflect/InvocationHandler;

    move-result-object v1

    .line 42
    invoke-static {v0, v1}, Lorg/chromium/support_lib_boundary/util/BoundaryInterfaceReflectionUtil;->castToSuppLibClass(Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/chromium/support_lib_boundary/WebViewPageBoundaryInterface;

    .line 44
    .local v0, "boundaryInterface":Lorg/chromium/support_lib_boundary/WebViewPageBoundaryInterface;
    new-instance v1, Landroidx/webkit/internal/PageImpl;

    invoke-direct {v1, v0}, Landroidx/webkit/internal/PageImpl;-><init>(Lorg/chromium/support_lib_boundary/WebViewPageBoundaryInterface;)V

    iput-object v1, p0, Landroidx/webkit/internal/NavigationAdapter;->mPage:Landroidx/webkit/internal/PageImpl;

    .line 46
    .end local v0    # "boundaryInterface":Lorg/chromium/support_lib_boundary/WebViewPageBoundaryInterface;
    :cond_23
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mPage:Landroidx/webkit/internal/PageImpl;

    return-object v0
.end method

.method public getStatusCode()I
    .registers 2

    .line 97
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->getStatusCode()I

    move-result v0

    return v0
.end method

.method public isBack()Z
    .registers 2

    .line 77
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isBack()Z

    move-result v0

    return v0
.end method

.method public isForward()Z
    .registers 2

    .line 82
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isForward()Z

    move-result v0

    return v0
.end method

.method public isHistory()Z
    .registers 2

    .line 67
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isHistory()Z

    move-result v0

    return v0
.end method

.method public isReload()Z
    .registers 2

    .line 62
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isReload()Z

    move-result v0

    return v0
.end method

.method public isRestore()Z
    .registers 2

    .line 72
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isRestore()Z

    move-result v0

    return v0
.end method

.method public isSameDocument()Z
    .registers 2

    .line 57
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->isSameDocument()Z

    move-result v0

    return v0
.end method

.method public wasInitiatedByPage()Z
    .registers 2

    .line 52
    iget-object v0, p0, Landroidx/webkit/internal/NavigationAdapter;->mImpl:Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;

    invoke-interface {v0}, Lorg/chromium/support_lib_boundary/WebViewNavigationBoundaryInterface;->wasInitiatedByPage()Z

    move-result v0

    return v0
.end method
