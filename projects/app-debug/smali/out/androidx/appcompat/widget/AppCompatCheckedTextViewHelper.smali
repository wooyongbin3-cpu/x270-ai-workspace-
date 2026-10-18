.class Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;
.super Ljava/lang/Object;
.source "AppCompatCheckedTextViewHelper.java"


# instance fields
.field private mCheckMarkTintList:Landroid/content/res/ColorStateList;

.field private mCheckMarkTintMode:Landroid/graphics/PorterDuff$Mode;

.field private mHasCheckMarkTint:Z

.field private mHasCheckMarkTintMode:Z

.field private mSkipNextApply:Z

.field private final mView:Landroid/widget/CheckedTextView;


# direct methods
.method constructor <init>(Landroid/widget/CheckedTextView;)V
    .registers 3
    .param p1, "view"    # Landroid/widget/CheckedTextView;

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintList:Landroid/content/res/ColorStateList;

    .line 43
    iput-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintMode:Landroid/graphics/PorterDuff$Mode;

    .line 44
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTint:Z

    .line 45
    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTintMode:Z

    .line 50
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    .line 51
    return-void
.end method


# virtual methods
.method applyCheckMarkTint()V
    .registers 3

    .line 132
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    invoke-static {v0}, Landroidx/core/widget/CheckedTextViewCompat;->getCheckMarkDrawable(Landroid/widget/CheckedTextView;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 134
    .local v0, "checkMarkDrawable":Landroid/graphics/drawable/Drawable;
    if-eqz v0, :cond_3e

    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTint:Z

    if-nez v1, :cond_10

    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTintMode:Z

    if-eqz v1, :cond_3e

    .line 135
    :cond_10
    invoke-static {v0}, Landroidx/core/graphics/drawable/DrawableCompat;->wrap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 136
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 137
    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTint:Z

    if-eqz v1, :cond_21

    .line 138
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintList:Landroid/content/res/ColorStateList;

    invoke-static {v0, v1}, Landroidx/core/graphics/drawable/DrawableCompat;->setTintList(Landroid/graphics/drawable/Drawable;Landroid/content/res/ColorStateList;)V

    .line 140
    :cond_21
    iget-boolean v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTintMode:Z

    if-eqz v1, :cond_2a

    .line 141
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintMode:Landroid/graphics/PorterDuff$Mode;

    invoke-static {v0, v1}, Landroidx/core/graphics/drawable/DrawableCompat;->setTintMode(Landroid/graphics/drawable/Drawable;Landroid/graphics/PorterDuff$Mode;)V

    .line 145
    :cond_2a
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v1

    if-eqz v1, :cond_39

    .line 146
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    invoke-virtual {v1}, Landroid/widget/CheckedTextView;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 148
    :cond_39
    iget-object v1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    invoke-virtual {v1, v0}, Landroid/widget/CheckedTextView;->setCheckMarkDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 150
    :cond_3e
    return-void
.end method

.method getSupportCheckMarkTintList()Landroid/content/res/ColorStateList;
    .registers 2

    .line 107
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintList:Landroid/content/res/ColorStateList;

    return-object v0
.end method

.method getSupportCheckMarkTintMode()Landroid/graphics/PorterDuff$Mode;
    .registers 2

    .line 118
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintMode:Landroid/graphics/PorterDuff$Mode;

    return-object v0
.end method

.method loadFromAttributes(Landroid/util/AttributeSet;I)V
    .registers 13
    .param p1, "attrs"    # Landroid/util/AttributeSet;
    .param p2, "defStyleAttr"    # I

    .line 54
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    .line 55
    invoke-virtual {v0}, Landroid/widget/CheckedTextView;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Landroidx/appcompat/R$styleable;->CheckedTextView:[I

    const/4 v2, 0x0

    invoke-static {v0, p1, v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->obtainStyledAttributes(Landroid/content/Context;Landroid/util/AttributeSet;[III)Landroidx/appcompat/widget/TintTypedArray;

    move-result-object v1

    .line 57
    .local v1, "a":Landroidx/appcompat/widget/TintTypedArray;
    iget-object v3, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    invoke-virtual {v0}, Landroid/widget/CheckedTextView;->getContext()Landroid/content/Context;

    move-result-object v4

    sget-object v5, Landroidx/appcompat/R$styleable;->CheckedTextView:[I

    .line 58
    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->getWrappedTypeArray()Landroid/content/res/TypedArray;

    move-result-object v7

    .line 57
    const/4 v9, 0x0

    move-object v6, p1

    move v8, p2

    .end local p1    # "attrs":Landroid/util/AttributeSet;
    .end local p2    # "defStyleAttr":I
    .local v6, "attrs":Landroid/util/AttributeSet;
    .local v8, "defStyleAttr":I
    invoke-static/range {v3 .. v9}, Landroidx/core/view/ViewCompat;->saveAttributeDataForStyleable(Landroid/view/View;Landroid/content/Context;[ILandroid/util/AttributeSet;Landroid/content/res/TypedArray;II)V

    .line 60
    const/4 p1, 0x0

    .line 61
    .local p1, "checkMarkDrawableLoaded":Z
    :try_start_22
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkCompat:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_44

    .line 62
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkCompat:I

    invoke-virtual {v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result p2
    :try_end_30
    .catchall {:try_start_22 .. :try_end_30} :catchall_96

    .line 64
    .local p2, "resourceId":I
    if-eqz p2, :cond_44

    .line 66
    :try_start_32
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    iget-object v3, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    .line 67
    invoke-virtual {v3}, Landroid/widget/CheckedTextView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, p2}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 66
    invoke-virtual {v0, v3}, Landroid/widget/CheckedTextView;->setCheckMarkDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_41
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_32 .. :try_end_41} :catch_43
    .catchall {:try_start_32 .. :try_end_41} :catchall_96

    .line 68
    const/4 p1, 0x1

    .line 72
    goto :goto_44

    .line 69
    :catch_43
    move-exception v0

    .line 75
    .end local p2    # "resourceId":I
    :cond_44
    :goto_44
    if-nez p1, :cond_65

    :try_start_46
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_android_checkMark:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_65

    .line 77
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_android_checkMark:I

    invoke-virtual {v1, p2, v2}, Landroidx/appcompat/widget/TintTypedArray;->getResourceId(II)I

    move-result p2

    .line 79
    .restart local p2    # "resourceId":I
    if-eqz p2, :cond_65

    .line 80
    iget-object v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    iget-object v2, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    .line 81
    invoke-virtual {v2}, Landroid/widget/CheckedTextView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, p2}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 80
    invoke-virtual {v0, v2}, Landroid/widget/CheckedTextView;->setCheckMarkDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 84
    .end local p2    # "resourceId":I
    :cond_65
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkTint:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_78

    .line 85
    iget-object p2, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    sget v0, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkTint:I

    .line 86
    invoke-virtual {v1, v0}, Landroidx/appcompat/widget/TintTypedArray;->getColorStateList(I)Landroid/content/res/ColorStateList;

    move-result-object v0

    .line 85
    invoke-static {p2, v0}, Landroidx/core/widget/CheckedTextViewCompat;->setCheckMarkTintList(Landroid/widget/CheckedTextView;Landroid/content/res/ColorStateList;)V

    .line 88
    :cond_78
    sget p2, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkTintMode:I

    invoke-virtual {v1, p2}, Landroidx/appcompat/widget/TintTypedArray;->hasValue(I)Z

    move-result p2

    if-eqz p2, :cond_91

    .line 89
    iget-object p2, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mView:Landroid/widget/CheckedTextView;

    sget v0, Landroidx/appcompat/R$styleable;->CheckedTextView_checkMarkTintMode:I

    .line 91
    const/4 v2, -0x1

    invoke-virtual {v1, v0, v2}, Landroidx/appcompat/widget/TintTypedArray;->getInt(II)I

    move-result v0

    .line 90
    const/4 v2, 0x0

    invoke-static {v0, v2}, Landroidx/appcompat/widget/DrawableUtils;->parseTintMode(ILandroid/graphics/PorterDuff$Mode;)Landroid/graphics/PorterDuff$Mode;

    move-result-object v0

    .line 89
    invoke-static {p2, v0}, Landroidx/core/widget/CheckedTextViewCompat;->setCheckMarkTintMode(Landroid/widget/CheckedTextView;Landroid/graphics/PorterDuff$Mode;)V
    :try_end_91
    .catchall {:try_start_46 .. :try_end_91} :catchall_96

    .line 95
    .end local p1    # "checkMarkDrawableLoaded":Z
    :cond_91
    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 96
    nop

    .line 97
    return-void

    .line 95
    :catchall_96
    move-exception v0

    move-object p1, v0

    invoke-virtual {v1}, Landroidx/appcompat/widget/TintTypedArray;->recycle()V

    .line 96
    throw p1
.end method

.method onSetCheckMarkDrawable()V
    .registers 2

    .line 122
    iget-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mSkipNextApply:Z

    if-eqz v0, :cond_8

    .line 123
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mSkipNextApply:Z

    .line 124
    return-void

    .line 127
    :cond_8
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mSkipNextApply:Z

    .line 128
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->applyCheckMarkTint()V

    .line 129
    return-void
.end method

.method setSupportCheckMarkTintList(Landroid/content/res/ColorStateList;)V
    .registers 3
    .param p1, "tint"    # Landroid/content/res/ColorStateList;

    .line 100
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintList:Landroid/content/res/ColorStateList;

    .line 101
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTint:Z

    .line 103
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->applyCheckMarkTint()V

    .line 104
    return-void
.end method

.method setSupportCheckMarkTintMode(Landroid/graphics/PorterDuff$Mode;)V
    .registers 3
    .param p1, "tintMode"    # Landroid/graphics/PorterDuff$Mode;

    .line 111
    iput-object p1, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mCheckMarkTintMode:Landroid/graphics/PorterDuff$Mode;

    .line 112
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->mHasCheckMarkTintMode:Z

    .line 114
    invoke-virtual {p0}, Landroidx/appcompat/widget/AppCompatCheckedTextViewHelper;->applyCheckMarkTint()V

    .line 115
    return-void
.end method
