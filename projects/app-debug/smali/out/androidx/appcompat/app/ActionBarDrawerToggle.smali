.class public Landroidx/appcompat/app/ActionBarDrawerToggle;
.super Ljava/lang/Object;
.source "ActionBarDrawerToggle.java"

# interfaces
.implements Landroidx/drawerlayout/widget/DrawerLayout$DrawerListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/app/ActionBarDrawerToggle$ToolbarCompatDelegate;,
        Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;,
        Landroidx/appcompat/app/ActionBarDrawerToggle$DelegateProvider;,
        Landroidx/appcompat/app/ActionBarDrawerToggle$FrameworkActionBarDelegate;
    }
.end annotation


# instance fields
.field private final mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

.field private final mCloseDrawerContentDescRes:I

.field mDrawerIndicatorEnabled:Z

.field private final mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

.field private mDrawerSlideAnimationEnabled:Z

.field private mHasCustomUpIndicator:Z

.field private mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

.field private final mOpenDrawerContentDescRes:I

.field private mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

.field mToolbarNavigationClickListener:Landroid/view/View$OnClickListener;

.field private mWarnedForDisplayHomeAsUp:Z


# direct methods
.method constructor <init>(Landroid/app/Activity;Landroidx/appcompat/widget/Toolbar;Landroidx/drawerlayout/widget/DrawerLayout;Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;II)V
    .registers 9
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "toolbar"    # Landroidx/appcompat/widget/Toolbar;
    .param p3, "drawerLayout"    # Landroidx/drawerlayout/widget/DrawerLayout;
    .param p4, "slider"    # Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;
    .param p5, "openDrawerContentDescRes"    # I
    .param p6, "closeDrawerContentDescRes"    # I

    .line 194
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 119
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerSlideAnimationEnabled:Z

    .line 121
    iput-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    .line 129
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mWarnedForDisplayHomeAsUp:Z

    .line 195
    if-eqz p2, :cond_1d

    .line 196
    new-instance v0, Landroidx/appcompat/app/ActionBarDrawerToggle$ToolbarCompatDelegate;

    invoke-direct {v0, p2}, Landroidx/appcompat/app/ActionBarDrawerToggle$ToolbarCompatDelegate;-><init>(Landroidx/appcompat/widget/Toolbar;)V

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    .line 197
    new-instance v0, Landroidx/appcompat/app/ActionBarDrawerToggle$1;

    invoke-direct {v0, p0}, Landroidx/appcompat/app/ActionBarDrawerToggle$1;-><init>(Landroidx/appcompat/app/ActionBarDrawerToggle;)V

    invoke-virtual {p2, v0}, Landroidx/appcompat/widget/Toolbar;->setNavigationOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_32

    .line 207
    :cond_1d
    instance-of v0, p1, Landroidx/appcompat/app/ActionBarDrawerToggle$DelegateProvider;

    if-eqz v0, :cond_2b

    .line 208
    move-object v0, p1

    check-cast v0, Landroidx/appcompat/app/ActionBarDrawerToggle$DelegateProvider;

    invoke-interface {v0}, Landroidx/appcompat/app/ActionBarDrawerToggle$DelegateProvider;->getDrawerToggleDelegate()Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    move-result-object v0

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    goto :goto_32

    .line 210
    :cond_2b
    new-instance v0, Landroidx/appcompat/app/ActionBarDrawerToggle$FrameworkActionBarDelegate;

    invoke-direct {v0, p1}, Landroidx/appcompat/app/ActionBarDrawerToggle$FrameworkActionBarDelegate;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    .line 213
    :goto_32
    iput-object p3, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    .line 214
    iput p5, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mOpenDrawerContentDescRes:I

    .line 215
    iput p6, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mCloseDrawerContentDescRes:I

    .line 216
    if-nez p4, :cond_48

    .line 217
    new-instance v0, Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    iget-object v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    invoke-interface {v1}, Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;->getActionBarThemedContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    goto :goto_4a

    .line 219
    :cond_48
    iput-object p4, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    .line 222
    :goto_4a
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->getThemeUpIndicator()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    .line 223
    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;Landroidx/drawerlayout/widget/DrawerLayout;II)V
    .registers 12
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "drawerLayout"    # Landroidx/drawerlayout/widget/DrawerLayout;
    .param p3, "openDrawerContentDescRes"    # I
    .param p4, "closeDrawerContentDescRes"    # I

    .line 152
    const/4 v2, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move v5, p3

    move v6, p4

    .end local p1    # "activity":Landroid/app/Activity;
    .end local p2    # "drawerLayout":Landroidx/drawerlayout/widget/DrawerLayout;
    .end local p3    # "openDrawerContentDescRes":I
    .end local p4    # "closeDrawerContentDescRes":I
    .local v1, "activity":Landroid/app/Activity;
    .local v3, "drawerLayout":Landroidx/drawerlayout/widget/DrawerLayout;
    .local v5, "openDrawerContentDescRes":I
    .local v6, "closeDrawerContentDescRes":I
    invoke-direct/range {v0 .. v6}, Landroidx/appcompat/app/ActionBarDrawerToggle;-><init>(Landroid/app/Activity;Landroidx/appcompat/widget/Toolbar;Landroidx/drawerlayout/widget/DrawerLayout;Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;II)V

    .line 154
    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;Landroidx/drawerlayout/widget/DrawerLayout;Landroidx/appcompat/widget/Toolbar;II)V
    .registers 13
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "drawerLayout"    # Landroidx/drawerlayout/widget/DrawerLayout;
    .param p3, "toolbar"    # Landroidx/appcompat/widget/Toolbar;
    .param p4, "openDrawerContentDescRes"    # I
    .param p5, "closeDrawerContentDescRes"    # I

    .line 183
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v2, p3

    move v5, p4

    move v6, p5

    .end local p1    # "activity":Landroid/app/Activity;
    .end local p2    # "drawerLayout":Landroidx/drawerlayout/widget/DrawerLayout;
    .end local p3    # "toolbar":Landroidx/appcompat/widget/Toolbar;
    .end local p4    # "openDrawerContentDescRes":I
    .end local p5    # "closeDrawerContentDescRes":I
    .local v1, "activity":Landroid/app/Activity;
    .local v2, "toolbar":Landroidx/appcompat/widget/Toolbar;
    .local v3, "drawerLayout":Landroidx/drawerlayout/widget/DrawerLayout;
    .local v5, "openDrawerContentDescRes":I
    .local v6, "closeDrawerContentDescRes":I
    invoke-direct/range {v0 .. v6}, Landroidx/appcompat/app/ActionBarDrawerToggle;-><init>(Landroid/app/Activity;Landroidx/appcompat/widget/Toolbar;Landroidx/drawerlayout/widget/DrawerLayout;Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;II)V

    .line 185
    return-void
.end method

.method private setPosition(F)V
    .registers 4
    .param p1, "position"    # F

    .line 506
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v0, p1, v0

    if-nez v0, :cond_d

    .line 507
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;->setVerticalMirror(Z)V

    goto :goto_18

    .line 508
    :cond_d
    const/4 v0, 0x0

    cmpl-float v0, p1, v0

    if-nez v0, :cond_18

    .line 509
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;->setVerticalMirror(Z)V

    .line 511
    :cond_18
    :goto_18
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    invoke-virtual {v0, p1}, Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;->setProgress(F)V

    .line 512
    return-void
.end method


# virtual methods
.method public getDrawerArrowDrawable()Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;
    .registers 2

    .line 370
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    return-object v0
.end method

.method getThemeUpIndicator()Landroid/graphics/drawable/Drawable;
    .registers 2

    .line 502
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    invoke-interface {v0}, Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;->getThemeUpIndicator()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public getToolbarNavigationClickListener()Landroid/view/View$OnClickListener;
    .registers 2

    .line 470
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mToolbarNavigationClickListener:Landroid/view/View$OnClickListener;

    return-object v0
.end method

.method public isDrawerIndicatorEnabled()Z
    .registers 2

    .line 339
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    return v0
.end method

.method public isDrawerSlideAnimationEnabled()Z
    .registers 2

    .line 399
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerSlideAnimationEnabled:Z

    return v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 3
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .line 257
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHasCustomUpIndicator:Z

    if-nez v0, :cond_a

    .line 258
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->getThemeUpIndicator()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    .line 260
    :cond_a
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->syncState()V

    .line 261
    return-void
.end method

.method public onDrawerClosed(Landroid/view/View;)V
    .registers 3
    .param p1, "drawerView"    # Landroid/view/View;

    .line 443
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    .line 444
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-eqz v0, :cond_d

    .line 445
    iget v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mOpenDrawerContentDescRes:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarDescription(I)V

    .line 447
    :cond_d
    return-void
.end method

.method public onDrawerOpened(Landroid/view/View;)V
    .registers 3
    .param p1, "drawerView"    # Landroid/view/View;

    .line 428
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    .line 429
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-eqz v0, :cond_e

    .line 430
    iget v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mCloseDrawerContentDescRes:I

    invoke-virtual {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarDescription(I)V

    .line 432
    :cond_e
    return-void
.end method

.method public onDrawerSlide(Landroid/view/View;F)V
    .registers 5
    .param p1, "drawerView"    # Landroid/view/View;
    .param p2, "slideOffset"    # F

    .line 412
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerSlideAnimationEnabled:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_13

    .line 413
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v1, p2}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    goto :goto_16

    .line 415
    :cond_13
    invoke-direct {p0, v1}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    .line 417
    :goto_16
    return-void
.end method

.method public onDrawerStateChanged(I)V
    .registers 2
    .param p1, "newState"    # I

    .line 458
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 4
    .param p1, "item"    # Landroid/view/MenuItem;

    .line 273
    if-eqz p1, :cond_14

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const v1, 0x102002c

    if-ne v0, v1, :cond_14

    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-eqz v0, :cond_14

    .line 274
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->toggle()V

    .line 275
    const/4 v0, 0x1

    return v0

    .line 277
    :cond_14
    const/4 v0, 0x0

    return v0
.end method

.method setActionBarDescription(I)V
    .registers 3
    .param p1, "contentDescRes"    # I

    .line 498
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    invoke-interface {v0, p1}, Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;->setActionBarDescription(I)V

    .line 499
    return-void
.end method

.method setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V
    .registers 5
    .param p1, "upDrawable"    # Landroid/graphics/drawable/Drawable;
    .param p2, "contentDescRes"    # I

    .line 488
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mWarnedForDisplayHomeAsUp:Z

    if-nez v0, :cond_16

    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    invoke-interface {v0}, Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;->isNavigationVisible()Z

    move-result v0

    if-nez v0, :cond_16

    .line 489
    const-string v0, "ActionBarDrawerToggle"

    const-string v1, "DrawerToggle may not show up because NavigationIcon is not visible. You may need to call actionbar.setDisplayHomeAsUpEnabled(true);"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 492
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mWarnedForDisplayHomeAsUp:Z

    .line 494
    :cond_16
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mActivityImpl:Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;

    invoke-interface {v0, p1, p2}, Landroidx/appcompat/app/ActionBarDrawerToggle$Delegate;->setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V

    .line 495
    return-void
.end method

.method public setDrawerArrowDrawable(Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;)V
    .registers 2
    .param p1, "drawable"    # Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    .line 379
    iput-object p1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    .line 380
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->syncState()V

    .line 381
    return-void
.end method

.method public setDrawerIndicatorEnabled(Z)V
    .registers 5
    .param p1, "enable"    # Z

    .line 353
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-eq p1, v0, :cond_24

    .line 354
    if-eqz p1, :cond_1c

    .line 355
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    .line 356
    iget-object v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    const v2, 0x800003

    invoke-virtual {v1, v2}, Landroidx/drawerlayout/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v1

    if-eqz v1, :cond_16

    .line 357
    iget v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mCloseDrawerContentDescRes:I

    goto :goto_18

    :cond_16
    iget v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mOpenDrawerContentDescRes:I

    .line 355
    :goto_18
    invoke-virtual {p0, v0, v1}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V

    goto :goto_22

    .line 359
    :cond_1c
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V

    .line 361
    :goto_22
    iput-boolean p1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    .line 363
    :cond_24
    return-void
.end method

.method public setDrawerSlideAnimationEnabled(Z)V
    .registers 3
    .param p1, "enabled"    # Z

    .line 389
    iput-boolean p1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerSlideAnimationEnabled:Z

    .line 390
    if-nez p1, :cond_8

    .line 391
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    .line 393
    :cond_8
    return-void
.end method

.method public setHomeAsUpIndicator(I)V
    .registers 4
    .param p1, "resId"    # I

    .line 327
    const/4 v0, 0x0

    .line 328
    .local v0, "indicator":Landroid/graphics/drawable/Drawable;
    if-eqz p1, :cond_d

    .line 329
    iget-object v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    invoke-virtual {v1}, Landroidx/drawerlayout/widget/DrawerLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 331
    :cond_d
    invoke-virtual {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setHomeAsUpIndicator(Landroid/graphics/drawable/Drawable;)V

    .line 332
    return-void
.end method

.method public setHomeAsUpIndicator(Landroid/graphics/drawable/Drawable;)V
    .registers 4
    .param p1, "indicator"    # Landroid/graphics/drawable/Drawable;

    .line 302
    const/4 v0, 0x0

    if-nez p1, :cond_c

    .line 303
    invoke-virtual {p0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->getThemeUpIndicator()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    .line 304
    iput-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHasCustomUpIndicator:Z

    goto :goto_11

    .line 306
    :cond_c
    iput-object p1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    .line 307
    const/4 v1, 0x1

    iput-boolean v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHasCustomUpIndicator:Z

    .line 310
    :goto_11
    iget-boolean v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-nez v1, :cond_1a

    .line 311
    iget-object v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mHomeAsUpIndicator:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v1, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V

    .line 313
    :cond_1a
    return-void
.end method

.method public setToolbarNavigationClickListener(Landroid/view/View$OnClickListener;)V
    .registers 2
    .param p1, "onToolbarNavigationClickListener"    # Landroid/view/View$OnClickListener;

    .line 484
    iput-object p1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mToolbarNavigationClickListener:Landroid/view/View$OnClickListener;

    .line 485
    return-void
.end method

.method public syncState()V
    .registers 4

    .line 235
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    const v1, 0x800003

    invoke-virtual {v0, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 236
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    goto :goto_15

    .line 238
    :cond_11
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setPosition(F)V

    .line 240
    :goto_15
    iget-boolean v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerIndicatorEnabled:Z

    if-eqz v0, :cond_2b

    .line 241
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mSlider:Landroidx/appcompat/graphics/drawable/DrawerArrowDrawable;

    .line 242
    iget-object v2, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    invoke-virtual {v2, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v1

    if-eqz v1, :cond_26

    .line 243
    iget v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mCloseDrawerContentDescRes:I

    goto :goto_28

    :cond_26
    iget v1, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mOpenDrawerContentDescRes:I

    .line 241
    :goto_28
    invoke-virtual {p0, v0, v1}, Landroidx/appcompat/app/ActionBarDrawerToggle;->setActionBarUpIndicator(Landroid/graphics/drawable/Drawable;I)V

    .line 245
    :cond_2b
    return-void
.end method

.method toggle()V
    .registers 4

    .line 281
    iget-object v0, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    const v1, 0x800003

    invoke-virtual {v0, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->getDrawerLockMode(I)I

    move-result v0

    .line 282
    .local v0, "drawerLockMode":I
    iget-object v2, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    invoke-virtual {v2, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->isDrawerVisible(I)Z

    move-result v2

    if-eqz v2, :cond_1a

    const/4 v2, 0x2

    if-eq v0, v2, :cond_1a

    .line 284
    iget-object v2, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    invoke-virtual {v2, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->closeDrawer(I)V

    goto :goto_22

    .line 285
    :cond_1a
    const/4 v2, 0x1

    if-eq v0, v2, :cond_22

    .line 286
    iget-object v2, p0, Landroidx/appcompat/app/ActionBarDrawerToggle;->mDrawerLayout:Landroidx/drawerlayout/widget/DrawerLayout;

    invoke-virtual {v2, v1}, Landroidx/drawerlayout/widget/DrawerLayout;->openDrawer(I)V

    .line 288
    :cond_22
    :goto_22
    return-void
.end method
