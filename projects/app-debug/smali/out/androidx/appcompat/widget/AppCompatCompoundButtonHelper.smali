.class Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;
.super Ljava/lang/Object;
.source "AppCompatCompoundButtonHelper.java"


# instance fields
.field private mButtonTintList:Landroid/content/res/ColorStateList;

.field private mButtonTintMode:Landroid/graphics/PorterDuff$Mode;

.field private mHasButtonTint:Z

.field private mHasButtonTintMode:Z

.field private mSkipNextApply:Z

.field private final mView:Landroid/widget/CompoundButton;


# direct methods
.method constructor <init>(Landroid/widget/CompoundButton;)V
    .registers 3
    .param p1, "view"    # Landroid/widget/CompoundButton;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintList:Landroid/content/res/ColorStateList;

    .line 39
    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintMode:Landroid/graphics/PorterDuff$Mode;

    .line 40
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTint:Z

    .line 41
    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTintMode:Z

    .line 46
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    .line 47
    return-void
.end method


# virtual methods
.method applyButtonTint()V
    .registers 3

    .line 126
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    invoke-static {v0}, Landroidx/core/widget/CompoundButtonCompat;->getButtonDrawable(Landroid/widget/CompoundButton;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 128
    .local v0, "buttonDrawable":Landroid/graphics/drawable/Drawable;
    if-eqz v0, :cond_3e

    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTint:Z

    if-nez v1, :cond_10

    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTintMode:Z

    if-eqz v1, :cond_3e

    .line 129
    :cond_10
    invoke-static {v0}, Landroidx/core/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 130
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 131
    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTint:Z

    if-eqz v1, :cond_21

    .line 132
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintList:Landroid/content/res/ColorStateList;

    invoke-static {v0, v1}, Landroidx/core/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    .line 134
    :cond_21
    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTintMode:Z

    if-eqz v1, :cond_2a

    .line 135
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintMode:Landroid/graphics/PorterDuff$Mode;

    invoke-static {v0, v1}, Landroidx/core/graphics/drawable/DrawableCompat;->setTintMode(Landroid/graphics/drawable/Drawable;Landroid/graphics/PorterDuff$Mode;)V

    .line 139
    :cond_2a
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v1

    if-eqz v1, :cond_39

    .line 140
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    invoke-virtual {v1}, Landroid/widget/CompoundButton;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 142
    :cond_39
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    invoke-virtual {v1, v0}, Landroid/widget/CompoundButton;->setButtonDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 144
    :cond_3e
    return-void
.end method

.method getSupportButtonTintList()Landroid/content/res/ColorStateList;
    .registers 2

    .line 101
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintList:Landroid/content/res/ColorStateList;

    return-object v0
.end method

.method getSupportButtonTintMode()Landroid/graphics/PorterDuff$Mode;
    .registers 2

    .line 112
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintMode:Landroid/graphics/PorterDuff$Mode;

    return-object v0
.end method

.method loadFromAttributes(Landroid/util/AttributeSet;I)V
    .registers 13
    .param p1, "attrs"    # Landroid/util/AttributeSet;
    .param p2, "defStyleAttr"    # I

    .line 50
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    .line 51
    invoke-virtual {v0}, Landroid/widget/CompoundButton;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Landroidx/appcompat/R$styleable;->CompoundButton:[I

    const/4 v2, 0x0

    invoke-static {v0, p1, v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;Landroid/util/AttributeSet;[III)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v1

    .line 53
    .local v1, "a":Landroidx/appcompat/widget/TintTypedArray;
    iget-object v3, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    invoke-virtual {v0}, Landroid/widget/CompoundButton;->getContext()Landroid/content/Context;

    move-result-object v4

    sget-object v5, Landroidx/appcompat/R$styleable;->CompoundButton:[I

    .line 54
    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->getWrappedTypeArray()Landroid/content/res/TypedArray;

    move-result-object v7

    .line 53
    const/4 v9, 0x0

    move-object v6, p1

    move v8, p2

    .end local p1    # "attrs":Landroid/util/AttributeSet;
    .end local p2    # "defStyleAttr":I
    .local v6, "attrs":Landroid/util/AttributeSet;
    .local v8, "defStyleAttr":I
    invoke-static/range {v3 .. v9}, Landroidx/core/view/ViewCompat;->saveAttributeDataForStyleable(Landroid/view/View;Landroid/content/Context;[ILandroid/util/AttributeSet;Landroid/content/res/TypedArray;II)V

    .line 56
    const/4 p1, 0x0

    .line 57
    .local p1, "buttonDrawableLoaded":Z
    :try_start_22
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_buttonCompat:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_44

    .line 58
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_buttonCompat:I

    invoke-virtual {v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result p2
    :try_end_30
    .catchall {:try_start_22 .. :try_end_30} :catchall_96

    .line 59
    .local p2, "resourceId":I
    if-eqz p2, :cond_44

    .line 61
    :try_start_32
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    iget-object v3, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    .line 62
    invoke-virtual {v3}, Landroid/widget/CompoundButton;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, p2}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 61
    invoke-virtual {v0, v3}, Landroid/widget/CompoundButton;->setButtonDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_41
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_32 .. :try_end_41} :catch_43
    .catchall {:try_start_32 .. :try_end_41} :catchall_96

    .line 63
    const/4 p1, 0x1

    .line 67
    goto :goto_44

    .line 64
    :catch_43
    move-exception v0

    .line 70
    .end local p2    # "resourceId":I
    :cond_44
    :goto_44
    if-nez p1, :cond_65

    :try_start_46
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_android_button:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_65

    .line 71
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_android_button:I

    invoke-virtual {v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result p2

    .line 73
    .restart local p2    # "resourceId":I
    if-eqz p2, :cond_65

    .line 74
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    iget-object v2, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    .line 75
    invoke-virtual {v2}, Landroid/widget/CompoundButton;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, p2}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 74
    invoke-virtual {v0, v2}, Landroid/widget/CompoundButton;->setButtonDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 78
    .end local p2    # "resourceId":I
    :cond_65
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_buttonTint:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_78

    .line 79
    iget-object p2, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    sget v0, Landroidx/appcompat/R$styleable;->CompoundButton_buttonTint:I

    .line 80
    invoke-virtual {v1, v0}, Landroidx/appcompat/widget/TintTypedArray;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    .line 79
    invoke-static {p2, v0}, Landroidx/core/widget/CompoundButtonCompat;->setButtonTintList(Landroid/widget/CompoundButton;Landroid/content/res/ColorStateList;)V

    .line 82
    :cond_78
    sget p2, Landroidx/appcompat/R$styleable;->CompoundButton_buttonTintMode:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_91

    .line 83
    iget-object p2, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mView:Landroid/widget/CompoundButton;

    sget v0, Landroidx/appcompat/R$styleable;->CompoundButton_buttonTintMode:I

    .line 85
    const/4 v2, -0x1

    invoke-virtual {v1, v0, v2}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v0

    .line 84
    const/4 v2, 0x0

    invoke-static {v0, v2}, Landroidx/appcompat/widget/DrawableUtils;->parseTintMode(ILandroid/graphics/PorterDuff$Mode;)Landroid/graphics/PorterDuff$Mode;

    move-result-object v0

    .line 83
    invoke-static {p2, v0}, Landroidx/core/widget/CompoundButtonCompat;->setButtonTintMode(Landroid/widget/CompoundButton;Landroid/graphics/PorterDuff$Mode;)V
    :try_end_91
    .catchall {:try_start_46 .. :try_end_91} :catchall_96

    .line 89
    .end local p1    # "buttonDrawableLoaded":Z
    :cond_91
    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 90
    nop

    .line 91
    return-void

    .line 89
    :catchall_96
    move-exception v0

    move-object p1, v0

    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 90
    throw p1
.end method

.method onSetButtonDrawable()V
    .registers 2

    .line 116
    iget-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mSkipNextApply:Z

    if-eqz v0, :cond_8

    .line 117
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mSkipNextApply:Z

    .line 118
    return-void

    .line 121
    :cond_8
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mSkipNextApply:Z

    .line 122
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->applyButtonTint()V

    .line 123
    return-void
.end method

.method setSupportButtonTintList(Landroid/content/res/ColorStateList;)V
    .registers 3
    .param p1, "tint"    # Landroid/content/res/ColorStateList;

    .line 94
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintList:Landroid/content/res/ColorStateList;

    .line 95
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTint:Z

    .line 97
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->applyButtonTint()V

    .line 98
    return-void
.end method

.method setSupportButtonTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .registers 3
    .param p1, "tintMode"    # Landroid/graphics/PorterDuff$Mode;

    .line 105
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mButtonTintMode:Landroid/graphics/PorterDuff$Mode;

    .line 106
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->mHasButtonTintMode:Z

    .line 108
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCompoundButtonHelper;->applyButtonTint()V

    .line 109
    return-void
.end method
