.class public Landroidx/appcompat/app/AlertController$AlertParams;
.super Ljava/lang/Object;
.source "AlertController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/appcompat/app/AlertController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "AlertParams"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/appcompat/app/AlertController$AlertParams$OnPrepareListViewListener;
    }
.end annotation


# instance fields
.field public mAdapter:Landroid/widget/ListAdapter;

.field public mCancelable:Z

.field public mCheckedItem:I

.field public mCheckedItems:[Z

.field public final mContext:Landroid/content/Context;

.field public mCursor:Landroid/database/Cursor;

.field public mCustomTitleView:Landroid/view/View;

.field public mForceInverseBackground:Z

.field public mIcon:Landroid/graphics/drawable/Drawable;

.field public mIconAttrId:I

.field public mIconId:I

.field public final mInflater:Landroid/view/LayoutInflater;

.field public mIsCheckedColumn:Ljava/lang/String;

.field public mIsMultiChoice:Z

.field public mIsSingleChoice:Z

.field public mItems:[Ljava/lang/CharSequence;

.field public mLabelColumn:Ljava/lang/String;

.field public mMessage:Ljava/lang/CharSequence;

.field public mNegativeButtonIcon:Landroid/graphics/drawable/Drawable;

.field public mNegativeButtonListener:Landroid/content/DialogInterface$OnClickListener;

.field public mNegativeButtonText:Ljava/lang/CharSequence;

.field public mNeutralButtonIcon:Landroid/graphics/drawable/Drawable;

.field public mNeutralButtonListener:Landroid/content/DialogInterface$OnClickListener;

.field public mNeutralButtonText:Ljava/lang/CharSequence;

.field public mOnCancelListener:Landroid/content/DialogInterface$OnCancelListener;

.field public mOnCheckboxClickListener:Landroid/content/DialogInterface$OnMultiChoiceClickListener;

.field public mOnClickListener:Landroid/content/DialogInterface$OnClickListener;

.field public mOnDismissListener:Landroid/content/DialogInterface$OnDismissListener;

.field public mOnItemSelectedListener:Landroid/widget/AdapterView$OnItemSelectedListener;

.field public mOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

.field public mOnPrepareListViewListener:Landroidx/appcompat/app/AlertController$AlertParams$OnPrepareListViewListener;

.field public mPositiveButtonIcon:Landroid/graphics/drawable/Drawable;

.field public mPositiveButtonListener:Landroid/content/DialogInterface$OnClickListener;

.field public mPositiveButtonText:Ljava/lang/CharSequence;

.field public mRecycleOnMeasure:Z

.field public mTitle:Ljava/lang/CharSequence;

.field public mView:Landroid/view/View;

.field public mViewLayoutResId:I

.field public mViewSpacingBottom:I

.field public mViewSpacingLeft:I

.field public mViewSpacingRight:I

.field public mViewSpacingSpecified:Z

.field public mViewSpacingTop:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3
    .param p1, "context"    # Landroid/content/Context;

    .line 924
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 869
    const/4 v0, 0x0

    iput v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconId:I

    .line 871
    iput v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconAttrId:I

    .line 897
    iput-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingSpecified:Z

    .line 901
    const/4 v0, -0x1

    iput v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCheckedItem:I

    .line 909
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mRecycleOnMeasure:Z

    .line 925
    iput-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mContext:Landroid/content/Context;

    .line 926
    iput-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCancelable:Z

    .line 927
    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mInflater:Landroid/view/LayoutInflater;

    .line 928
    return-void
.end method

.method private createListView(Landroidx/appcompat/app/AlertController;)V
    .registers 17
    .param p1, "dialog"    # Landroidx/appcompat/app/AlertController;

    .line 988
    move-object/from16 v6, p1

    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mInflater:Landroid/view/LayoutInflater;

    iget v1, v6, Landroidx/appcompat/app/AlertController;->mListLayout:I

    .line 989
    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    move-object v5, v0

    check-cast v5, Landroidx/appcompat/app/AlertController$RecycleListView;

    .line 992
    .local v5, "listView":Landroidx/appcompat/app/AlertController$RecycleListView;
    iget-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIsMultiChoice:Z

    const/4 v14, 0x1

    if-eqz v0, :cond_35

    .line 993
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCursor:Landroid/database/Cursor;

    if-nez v0, :cond_28

    .line 994
    new-instance v7, Landroidx/appcompat/app/AlertController$AlertParams$1;

    iget-object v9, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mContext:Landroid/content/Context;

    iget v10, v6, Landroidx/appcompat/app/AlertController;->mMultiChoiceItemLayout:I

    const v11, 0x1020014

    iget-object v12, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mItems:[Ljava/lang/CharSequence;

    move-object v8, p0

    move-object v13, v5

    .end local v5    # "listView":Landroidx/appcompat/app/AlertController$RecycleListView;
    .local v13, "listView":Landroidx/appcompat/app/AlertController$RecycleListView;
    invoke-direct/range {v7 .. v13}, Landroidx/appcompat/app/AlertController$AlertParams$1;-><init>(Landroidx/appcompat/app/AlertController$AlertParams;Landroid/content/Context;II[Ljava/lang/CharSequence;Landroidx/appcompat/app/AlertController$RecycleListView;)V

    .end local v13    # "listView":Landroidx/appcompat/app/AlertController$RecycleListView;
    .restart local v5    # "listView":Landroidx/appcompat/app/AlertController$RecycleListView;
    .local v7, "adapter":Landroid/widget/ListAdapter;
    goto :goto_6d

    .line 1009
    .end local v7    # "adapter":Landroid/widget/ListAdapter;
    :cond_28
    new-instance v0, Landroidx/appcompat/app/AlertController$AlertParams$2;

    iget-object v2, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mContext:Landroid/content/Context;

    iget-object v3, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCursor:Landroid/database/Cursor;

    const/4 v4, 0x0

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Landroidx/appcompat/app/AlertController$AlertParams$2;-><init>(Landroidx/appcompat/app/AlertController$AlertParams;Landroid/content/Context;Landroid/database/Cursor;ZLandroidx/appcompat/app/AlertController$RecycleListView;Landroidx/appcompat/app/AlertController;)V

    move-object v7, v0

    .restart local v7    # "adapter":Landroid/widget/ListAdapter;
    goto :goto_6d

    .line 1038
    .end local v7    # "adapter":Landroid/widget/ListAdapter;
    :cond_35
    iget-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIsSingleChoice:Z

    if-eqz v0, :cond_3d

    .line 1039
    iget v0, v6, Landroidx/appcompat/app/AlertController;->mSingleChoiceItemLayout:I

    move v9, v0

    .local v0, "layout":I
    goto :goto_40

    .line 1041
    .end local v0    # "layout":I
    :cond_3d
    iget v0, v6, Landroidx/appcompat/app/AlertController;->mListItemLayout:I

    move v9, v0

    .line 1044
    .local v9, "layout":I
    :goto_40
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCursor:Landroid/database/Cursor;

    const v2, 0x1020014

    if-eqz v0, :cond_5c

    .line 1045
    new-instance v7, Landroid/widget/SimpleCursorAdapter;

    iget-object v8, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mContext:Landroid/content/Context;

    iget-object v10, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCursor:Landroid/database/Cursor;

    new-array v11, v14, [Ljava/lang/String;

    const/4 v0, 0x0

    iget-object v3, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mLabelColumn:Ljava/lang/String;

    aput-object v3, v11, v0

    filled-new-array {v2}, [I

    move-result-object v12

    invoke-direct/range {v7 .. v12}, Landroid/widget/SimpleCursorAdapter;-><init>(Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V

    .restart local v7    # "adapter":Landroid/widget/ListAdapter;
    goto :goto_6d

    .line 1047
    .end local v7    # "adapter":Landroid/widget/ListAdapter;
    :cond_5c
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mAdapter:Landroid/widget/ListAdapter;

    if-eqz v0, :cond_63

    .line 1048
    iget-object v7, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mAdapter:Landroid/widget/ListAdapter;

    .restart local v7    # "adapter":Landroid/widget/ListAdapter;
    goto :goto_6d

    .line 1050
    .end local v7    # "adapter":Landroid/widget/ListAdapter;
    :cond_63
    new-instance v0, Landroidx/appcompat/app/AlertController$CheckedItemAdapter;

    iget-object v3, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mContext:Landroid/content/Context;

    iget-object v4, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mItems:[Ljava/lang/CharSequence;

    invoke-direct {v0, v3, v9, v2, v4}, Landroidx/appcompat/app/AlertController$CheckedItemAdapter;-><init>(Landroid/content/Context;II[Ljava/lang/CharSequence;)V

    move-object v7, v0

    .line 1054
    .end local v9    # "layout":I
    .restart local v7    # "adapter":Landroid/widget/ListAdapter;
    :goto_6d
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnPrepareListViewListener:Landroidx/appcompat/app/AlertController$AlertParams$OnPrepareListViewListener;

    if-eqz v0, :cond_76

    .line 1055
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnPrepareListViewListener:Landroidx/appcompat/app/AlertController$AlertParams$OnPrepareListViewListener;

    invoke-interface {v0, v5}, Landroidx/appcompat/app/AlertController$AlertParams$OnPrepareListViewListener;->onPrepareListView(Landroid/widget/ListView;)V

    .line 1061
    :cond_76
    iput-object v7, v6, Landroidx/appcompat/app/AlertController;->mAdapter:Landroid/widget/ListAdapter;

    .line 1062
    iget v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCheckedItem:I

    iput v0, v6, Landroidx/appcompat/app/AlertController;->mCheckedItem:I

    .line 1064
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnClickListener:Landroid/content/DialogInterface$OnClickListener;

    if-eqz v0, :cond_89

    .line 1065
    new-instance v0, Landroidx/appcompat/app/AlertController$AlertParams$3;

    invoke-direct {v0, p0, v6}, Landroidx/appcompat/app/AlertController$AlertParams$3;-><init>(Landroidx/appcompat/app/AlertController$AlertParams;Landroidx/appcompat/app/AlertController;)V

    invoke-virtual {v5, v0}, Landroidx/appcompat/app/AlertController$RecycleListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    goto :goto_95

    .line 1074
    :cond_89
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnCheckboxClickListener:Landroid/content/DialogInterface$OnMultiChoiceClickListener;

    if-eqz v0, :cond_95

    .line 1075
    new-instance v0, Landroidx/appcompat/app/AlertController$AlertParams$4;

    invoke-direct {v0, p0, v5, v6}, Landroidx/appcompat/app/AlertController$AlertParams$4;-><init>(Landroidx/appcompat/app/AlertController$AlertParams;Landroidx/appcompat/app/AlertController$RecycleListView;Landroidx/appcompat/app/AlertController;)V

    invoke-virtual {v5, v0}, Landroidx/appcompat/app/AlertController$RecycleListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 1088
    :cond_95
    :goto_95
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnItemSelectedListener:Landroid/widget/AdapterView$OnItemSelectedListener;

    if-eqz v0, :cond_9e

    .line 1089
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mOnItemSelectedListener:Landroid/widget/AdapterView$OnItemSelectedListener;

    invoke-virtual {v5, v0}, Landroidx/appcompat/app/AlertController$RecycleListView;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)V

    .line 1092
    :cond_9e
    iget-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIsSingleChoice:Z

    if-eqz v0, :cond_a6

    .line 1093
    invoke-virtual {v5, v14}, Landroidx/appcompat/app/AlertController$RecycleListView;->setChoiceMode(I)V

    goto :goto_ae

    .line 1094
    :cond_a6
    iget-boolean v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIsMultiChoice:Z

    if-eqz v0, :cond_ae

    .line 1095
    const/4 v0, 0x2

    invoke-virtual {v5, v0}, Landroidx/appcompat/app/AlertController$RecycleListView;->setChoiceMode(I)V

    .line 1097
    :cond_ae
    :goto_ae
    iput-object v5, v6, Landroidx/appcompat/app/AlertController;->mListView:Landroid/widget/ListView;

    .line 1098
    return-void
.end method


# virtual methods
.method public apply(Landroidx/appcompat/app/AlertController;)V
    .registers 15
    .param p1, "dialog"    # Landroidx/appcompat/app/AlertController;

    .line 931
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCustomTitleView:Landroid/view/View;

    if-eqz v0, :cond_a

    .line 932
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCustomTitleView:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setCustomTitle(Landroid/view/View;)V

    goto :goto_32

    .line 934
    :cond_a
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mTitle:Ljava/lang/CharSequence;

    if-eqz v0, :cond_13

    .line 935
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mTitle:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setTitle(Ljava/lang/CharSequence;)V

    .line 937
    :cond_13
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIcon:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_1c

    .line 938
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIcon:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setIcon(Landroid/graphics/drawable/Drawable;)V

    .line 940
    :cond_1c
    iget v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconId:I

    if-eqz v0, :cond_25

    .line 941
    iget v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconId:I

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setIcon(I)V

    .line 943
    :cond_25
    iget v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconAttrId:I

    if-eqz v0, :cond_32

    .line 944
    iget v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mIconAttrId:I

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->getIconAttributeResId(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setIcon(I)V

    .line 947
    :cond_32
    :goto_32
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mMessage:Ljava/lang/CharSequence;

    if-eqz v0, :cond_3b

    .line 948
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mMessage:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AlertController;->setMessage(Ljava/lang/CharSequence;)V

    .line 950
    :cond_3b
    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mPositiveButtonText:Ljava/lang/CharSequence;

    if-nez v0, :cond_46

    iget-object v0, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mPositiveButtonIcon:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_44

    goto :goto_46

    :cond_44
    move-object v7, p1

    goto :goto_53

    .line 951
    :cond_46
    :goto_46
    iget-object v3, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mPositiveButtonText:Ljava/lang/CharSequence;

    iget-object v4, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mPositiveButtonListener:Landroid/content/DialogInterface$OnClickListener;

    const/4 v5, 0x0

    iget-object v6, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mPositiveButtonIcon:Landroid/graphics/drawable/Drawable;

    const/4 v2, -0x1

    move-object v1, p1

    .end local p1    # "dialog":Landroidx/appcompat/app/AlertController;
    .local v1, "dialog":Landroidx/appcompat/app/AlertController;
    invoke-virtual/range {v1 .. v6}, Landroidx/appcompat/app/AlertController;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/os/Message;Landroid/graphics/drawable/Drawable;)V

    move-object v7, v1

    .line 954
    .end local v1    # "dialog":Landroidx/appcompat/app/AlertController;
    .local v7, "dialog":Landroidx/appcompat/app/AlertController;
    :goto_53
    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNegativeButtonText:Ljava/lang/CharSequence;

    if-nez p1, :cond_5b

    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNegativeButtonIcon:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_66

    .line 955
    :cond_5b
    iget-object v9, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNegativeButtonText:Ljava/lang/CharSequence;

    iget-object v10, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNegativeButtonListener:Landroid/content/DialogInterface$OnClickListener;

    const/4 v11, 0x0

    iget-object v12, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNegativeButtonIcon:Landroid/graphics/drawable/Drawable;

    const/4 v8, -0x2

    invoke-virtual/range {v7 .. v12}, Landroidx/appcompat/app/AlertController;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/os/Message;Landroid/graphics/drawable/Drawable;)V

    .line 958
    :cond_66
    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNeutralButtonText:Ljava/lang/CharSequence;

    if-nez p1, :cond_6e

    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNeutralButtonIcon:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_79

    .line 959
    :cond_6e
    iget-object v9, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNeutralButtonText:Ljava/lang/CharSequence;

    iget-object v10, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNeutralButtonListener:Landroid/content/DialogInterface$OnClickListener;

    const/4 v11, 0x0

    iget-object v12, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mNeutralButtonIcon:Landroid/graphics/drawable/Drawable;

    const/4 v8, -0x3

    invoke-virtual/range {v7 .. v12}, Landroidx/appcompat/app/AlertController;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;Landroid/os/Message;Landroid/graphics/drawable/Drawable;)V

    .line 964
    :cond_79
    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mItems:[Ljava/lang/CharSequence;

    if-nez p1, :cond_85

    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mCursor:Landroid/database/Cursor;

    if-nez p1, :cond_85

    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mAdapter:Landroid/widget/ListAdapter;

    if-eqz p1, :cond_88

    .line 965
    :cond_85
    invoke-direct {p0, v7}, Landroidx/appcompat/app/AlertController$AlertParams;->createListView(Landroidx/appcompat/app/AlertController;)V

    .line 967
    :cond_88
    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mView:Landroid/view/View;

    if-eqz p1, :cond_a4

    .line 968
    iget-boolean p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingSpecified:Z

    if-eqz p1, :cond_9e

    .line 969
    iget-object v8, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mView:Landroid/view/View;

    iget v9, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingLeft:I

    iget v10, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingTop:I

    iget v11, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingRight:I

    iget v12, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewSpacingBottom:I

    invoke-virtual/range {v7 .. v12}, Landroidx/appcompat/app/AlertController;->setView(Landroid/view/View;IIII)V

    goto :goto_ad

    .line 972
    :cond_9e
    iget-object p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mView:Landroid/view/View;

    invoke-virtual {v7, p1}, Landroidx/appcompat/app/AlertController;->setView(Landroid/view/View;)V

    goto :goto_ad

    .line 974
    :cond_a4
    iget p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewLayoutResId:I

    if-eqz p1, :cond_ad

    .line 975
    iget p1, p0, Landroidx/appcompat/app/AlertController$AlertParams;->mViewLayoutResId:I

    invoke-virtual {v7, p1}, Landroidx/appcompat/app/AlertController;->setView(I)V

    .line 985
    :cond_ad
    :goto_ad
    return-void
.end method
