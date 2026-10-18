.class public Landroidx/core/app/NotificationCompat$CallStyle;
.super Landroidx/core/app/NotificationCompat$Style;
.source "NotificationCompat.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/app/NotificationCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CallStyle"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/app/NotificationCompat$CallStyle$Api28Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$Api23Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$Api21Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$Api24Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$Api20Impl;,
        Landroidx/core/app/NotificationCompat$CallStyle$CallType;
    }
.end annotation


# static fields
.field public static final CALL_TYPE_INCOMING:I = 0x1

.field public static final CALL_TYPE_ONGOING:I = 0x2

.field public static final CALL_TYPE_SCREENING:I = 0x3

.field public static final CALL_TYPE_UNKNOWN:I = 0x0

.field private static final KEY_ACTION_PRIORITY:Ljava/lang/String; = "key_action_priority"

.field private static final TEMPLATE_CLASS_NAME:Ljava/lang/String; = "androidx.core.app.NotificationCompat$CallStyle"


# instance fields
.field private mAnswerButtonColor:Ljava/lang/Integer;

.field private mAnswerIntent:Landroid/app/PendingIntent;

.field private mCallType:I

.field private mDeclineButtonColor:Ljava/lang/Integer;

.field private mDeclineIntent:Landroid/app/PendingIntent;

.field private mHangUpIntent:Landroid/app/PendingIntent;

.field private mIsVideo:Z

.field private mPerson:Landroidx/core/app/Person;

.field private mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

.field private mVerificationText:Ljava/lang/CharSequence;


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 4654
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$Style;-><init>()V

    .line 4655
    return-void
.end method

.method private constructor <init>(ILandroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    .registers 8
    .param p1, "callType"    # I
    .param p2, "person"    # Landroidx/core/app/Person;
    .param p3, "hangUpIntent"    # Landroid/app/PendingIntent;
    .param p4, "declineIntent"    # Landroid/app/PendingIntent;
    .param p5, "answerIntent"    # Landroid/app/PendingIntent;

    .line 4736
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$Style;-><init>()V

    .line 4737
    if-eqz p2, :cond_1a

    invoke-virtual {p2}, Landroidx/core/app/Person;->getName()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1a

    .line 4740
    iput p1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    .line 4741
    iput-object p2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    .line 4742
    iput-object p5, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    .line 4743
    iput-object p4, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    .line 4744
    iput-object p3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    .line 4745
    return-void

    .line 4738
    :cond_1a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "person must have a non-empty a name"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Landroidx/core/app/NotificationCompat$Builder;)V
    .registers 2
    .param p1, "builder"    # Landroidx/core/app/NotificationCompat$Builder;

    .line 4662
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$Style;-><init>()V

    .line 4663
    invoke-virtual {p0, p1}, Landroidx/core/app/NotificationCompat$CallStyle;->setBuilder(Landroidx/core/app/NotificationCompat$Builder;)V

    .line 4664
    return-void
.end method

.method public static forIncomingCall(Landroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 9
    .param p0, "person"    # Landroidx/core/app/Person;
    .param p1, "declineIntent"    # Landroid/app/PendingIntent;
    .param p2, "answerIntent"    # Landroid/app/PendingIntent;

    .line 4679
    new-instance v0, Landroidx/core/app/NotificationCompat$CallStyle;

    .line 4681
    const-string v1, "declineIntent is required"

    invoke-static {p1, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    move-object v4, v1

    check-cast v4, Landroid/app/PendingIntent;

    .line 4682
    const-string v1, "answerIntent is required"

    invoke-static {p2, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    move-object v5, v1

    check-cast v5, Landroid/app/PendingIntent;

    const/4 v1, 0x1

    const/4 v3, 0x0

    move-object v2, p0

    .end local p0    # "person":Landroidx/core/app/Person;
    .local v2, "person":Landroidx/core/app/Person;
    invoke-direct/range {v0 .. v5}, Landroidx/core/app/NotificationCompat$CallStyle;-><init>(ILandroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 4679
    return-object v0
.end method

.method public static forOngoingCall(Landroidx/core/app/Person;Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 8
    .param p0, "person"    # Landroidx/core/app/Person;
    .param p1, "hangUpIntent"    # Landroid/app/PendingIntent;

    .line 4698
    new-instance v0, Landroidx/core/app/NotificationCompat$CallStyle;

    .line 4699
    const-string v1, "hangUpIntent is required"

    invoke-static {p1, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    move-object v3, v1

    check-cast v3, Landroid/app/PendingIntent;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x2

    move-object v2, p0

    .end local p0    # "person":Landroidx/core/app/Person;
    .local v2, "person":Landroidx/core/app/Person;
    invoke-direct/range {v0 .. v5}, Landroidx/core/app/NotificationCompat$CallStyle;-><init>(ILandroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 4698
    return-object v0
.end method

.method public static forScreeningCall(Landroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 9
    .param p0, "person"    # Landroidx/core/app/Person;
    .param p1, "hangUpIntent"    # Landroid/app/PendingIntent;
    .param p2, "answerIntent"    # Landroid/app/PendingIntent;

    .line 4719
    new-instance v0, Landroidx/core/app/NotificationCompat$CallStyle;

    .line 4720
    const-string v1, "hangUpIntent is required"

    invoke-static {p1, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    move-object v3, v1

    check-cast v3, Landroid/app/PendingIntent;

    .line 4722
    const-string v1, "answerIntent is required"

    invoke-static {p2, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    move-object v5, v1

    check-cast v5, Landroid/app/PendingIntent;

    const/4 v1, 0x3

    const/4 v4, 0x0

    move-object v2, p0

    .end local p0    # "person":Landroidx/core/app/Person;
    .local v2, "person":Landroidx/core/app/Person;
    invoke-direct/range {v0 .. v5}, Landroidx/core/app/NotificationCompat$CallStyle;-><init>(ILandroidx/core/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 4719
    return-object v0
.end method

.method private getDefaultText()Ljava/lang/String;
    .registers 3

    .line 4993
    iget v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    packed-switch v0, :pswitch_data_34

    .line 5004
    const/4 v0, 0x0

    return-object v0

    .line 5001
    :pswitch_7
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Landroidx/core/R$string;->call_notification_screening_text:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 4998
    :pswitch_16
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Landroidx/core/R$string;->call_notification_ongoing_text:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 4995
    :pswitch_25
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Landroidx/core/R$string;->call_notification_incoming_text:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :pswitch_data_34
    .packed-switch 0x1
        :pswitch_25
        :pswitch_16
        :pswitch_7
    .end packed-switch
.end method

.method private isActionAddedByCallStyle(Landroidx/core/app/NotificationCompat$Action;)Z
    .registers 4
    .param p1, "action"    # Landroidx/core/app/NotificationCompat$Action;

    .line 5064
    if-eqz p1, :cond_10

    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "key_action_priority"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    const/4 v0, 0x1

    goto :goto_11

    :cond_10
    const/4 v0, 0x0

    :goto_11
    return v0
.end method

.method private makeAction(IILjava/lang/Integer;ILandroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Action;
    .registers 11
    .param p1, "icon"    # I
    .param p2, "title"    # I
    .param p3, "colorInt"    # Ljava/lang/Integer;
    .param p4, "defaultColorRes"    # I
    .param p5, "intent"    # Landroid/app/PendingIntent;

    .line 5046
    if-nez p3, :cond_e

    .line 5047
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-static {v0, p4}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    .line 5049
    :cond_e
    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-direct {v0}, Landroid/text/SpannableStringBuilder;-><init>()V

    .line 5050
    .local v0, "stringBuilder":Landroid/text/SpannableStringBuilder;
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 5051
    new-instance v1, Landroid/text/style/ForegroundColorSpan;

    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {v1, v2}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v2

    const/16 v3, 0x12

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v4, v2, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 5054
    new-instance v1, Landroidx/core/app/NotificationCompat$Action$Builder;

    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v2, v2, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    .line 5055
    invoke-static {v2, p1}, Landroidx/core/graphics/drawable/IconCompat;->createWithResource(Landroid/content/Context;I)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v2

    invoke-direct {v1, v2, v0, p5}, Landroidx/core/app/NotificationCompat$Action$Builder;-><init>(Landroidx/core/graphics/drawable/IconCompat;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    .line 5056
    invoke-virtual {v1}, Landroidx/core/app/NotificationCompat$Action$Builder;->build()Landroidx/core/app/NotificationCompat$Action;

    move-result-object v1

    .line 5057
    .local v1, "action":Landroidx/core/app/NotificationCompat$Action;
    invoke-virtual {v1}, Landroidx/core/app/NotificationCompat$Action;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    const-string v3, "key_action_priority"

    const/4 v4, 0x1

    invoke-virtual {v2, v3, v4}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 5058
    return-object v1
.end method

.method private makeAnswerAction()Landroidx/core/app/NotificationCompat$Action;
    .registers 10

    .line 5028
    sget v0, Landroidx/core/R$drawable;->ic_call_answer_video_low:I

    .line 5029
    .local v0, "videoIcon":I
    sget v1, Landroidx/core/R$drawable;->ic_call_answer_low:I

    .line 5030
    .local v1, "icon":I
    nop

    .line 5031
    sget v0, Landroidx/core/R$drawable;->ic_call_answer_video:I

    .line 5032
    sget v1, Landroidx/core/R$drawable;->ic_call_answer:I

    .line 5035
    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    if-nez v2, :cond_f

    const/4 v2, 0x0

    goto :goto_2c

    .line 5036
    :cond_f
    iget-boolean v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    if-eqz v2, :cond_15

    move v4, v0

    goto :goto_16

    :cond_15
    move v4, v1

    .line 5037
    :goto_16
    iget-boolean v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    if-eqz v2, :cond_1e

    sget v2, Landroidx/core/R$string;->call_notification_answer_video_action:I

    move v5, v2

    goto :goto_21

    .line 5038
    :cond_1e
    sget v2, Landroidx/core/R$string;->call_notification_answer_action:I

    move v5, v2

    :goto_21
    iget-object v6, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    sget v7, Landroidx/core/R$color;->call_notification_answer_color:I

    iget-object v8, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    .line 5035
    move-object v3, p0

    invoke-direct/range {v3 .. v8}, Landroidx/core/app/NotificationCompat$CallStyle;->makeAction(IILjava/lang/Integer;ILandroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Action;

    move-result-object v2

    :goto_2c
    return-object v2
.end method

.method private makeNegativeAction()Landroidx/core/app/NotificationCompat$Action;
    .registers 8

    .line 5009
    sget v0, Landroidx/core/R$drawable;->ic_call_decline_low:I

    .line 5010
    .local v0, "icon":I
    nop

    .line 5011
    sget v2, Landroidx/core/R$drawable;->ic_call_decline:I

    .line 5013
    .end local v0    # "icon":I
    .local v2, "icon":I
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    if-nez v0, :cond_17

    .line 5014
    sget v3, Landroidx/core/R$string;->call_notification_hang_up_action:I

    iget-object v4, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    sget v5, Landroidx/core/R$color;->call_notification_decline_color:I

    iget-object v6, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    move-object v1, p0

    invoke-direct/range {v1 .. v6}, Landroidx/core/app/NotificationCompat$CallStyle;->makeAction(IILjava/lang/Integer;ILandroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Action;

    move-result-object v0

    return-object v0

    .line 5019
    :cond_17
    move-object v1, p0

    sget v3, Landroidx/core/R$string;->call_notification_decline_action:I

    iget-object v4, v1, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    sget v5, Landroidx/core/R$color;->call_notification_decline_color:I

    iget-object v6, v1, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    invoke-direct/range {v1 .. v6}, Landroidx/core/app/NotificationCompat$CallStyle;->makeAction(IILjava/lang/Integer;ILandroid/app/PendingIntent;)Landroidx/core/app/NotificationCompat$Action;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public addCompatExtras(Landroid/os/Bundle;)V
    .registers 4
    .param p1, "extras"    # Landroid/os/Bundle;

    .line 4857
    invoke-super {p0, p1}, Landroidx/core/app/NotificationCompat$Style;->addCompatExtras(Landroid/os/Bundle;)V

    .line 4861
    const-string v0, "android.callType"

    iget v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 4862
    const-string v0, "android.callIsVideo"

    iget-boolean v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 4863
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    if-eqz v0, :cond_36

    .line 4864
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_2b

    .line 4865
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    .line 4866
    invoke-virtual {v0}, Landroidx/core/app/Person;->toAndroidPerson()Landroid/app/Person;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/app/NotificationCompat$CallStyle$Api28Impl;->castToParcelable(Landroid/app/Person;)Landroid/os/Parcelable;

    move-result-object v0

    .line 4865
    const-string v1, "android.callPerson"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    goto :goto_36

    .line 4868
    :cond_2b
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v0}, Landroidx/core/app/Person;->toBundle()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "android.callPersonCompat"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 4871
    :cond_36
    :goto_36
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    if-eqz v0, :cond_4e

    .line 4872
    nop

    .line 4873
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    .line 4874
    invoke-virtual {v0, v1}, Landroidx/core/graphics/drawable/IconCompat;->toIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;

    move-result-object v0

    .line 4873
    invoke-static {v0}, Landroidx/core/app/NotificationCompat$CallStyle$Api23Impl;->castToParcelable(Landroid/graphics/drawable/Icon;)Landroid/os/Parcelable;

    move-result-object v0

    const-string v1, "android.verificationIcon"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 4880
    :cond_4e
    const-string v0, "android.verificationText"

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationText:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    .line 4881
    const-string v0, "android.answerIntent"

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 4882
    const-string v0, "android.declineIntent"

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 4883
    const-string v0, "android.hangUpIntent"

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 4884
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    if-eqz v0, :cond_79

    .line 4885
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const-string v1, "android.answerColor"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 4887
    :cond_79
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    if-eqz v0, :cond_88

    .line 4888
    iget-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const-string v1, "android.declineColor"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 4890
    :cond_88
    return-void
.end method

.method public apply(Landroidx/core/app/NotificationBuilderWithBuilderAccessor;)V
    .registers 7
    .param p1, "builderAccessor"    # Landroidx/core/app/NotificationBuilderWithBuilderAccessor;

    .line 4905
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_9d

    .line 4906
    const/4 v0, 0x0

    .line 4907
    .local v0, "style":Landroid/app/Notification$CallStyle;
    iget v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    packed-switch v1, :pswitch_data_114

    .line 4921
    const/4 v1, 0x3

    const-string v2, "NotifCompat"

    invoke-static {v2, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_5d

    .line 4922
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized call type in CallStyle: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    .line 4923
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 4922
    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_5d

    .line 4917
    :pswitch_32
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v1}, Landroidx/core/app/Person;->toAndroidPerson()Landroid/app/Person;

    move-result-object v1

    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    invoke-static {v1, v2, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->forScreeningCall(Landroid/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Landroid/app/Notification$CallStyle;

    move-result-object v0

    .line 4919
    goto :goto_5d

    .line 4913
    :pswitch_41
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v1}, Landroidx/core/app/Person;->toAndroidPerson()Landroid/app/Person;

    move-result-object v1

    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    invoke-static {v1, v2}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->forOngoingCall(Landroid/app/Person;Landroid/app/PendingIntent;)Landroid/app/Notification$CallStyle;

    move-result-object v0

    .line 4915
    goto :goto_5d

    .line 4909
    :pswitch_4e
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v1}, Landroidx/core/app/Person;->toAndroidPerson()Landroid/app/Person;

    move-result-object v1

    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    invoke-static {v1, v2, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->forIncomingCall(Landroid/app/Person;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)Landroid/app/Notification$CallStyle;

    move-result-object v0

    .line 4911
    nop

    .line 4927
    :cond_5d
    :goto_5d
    if-eqz v0, :cond_9b

    .line 4928
    invoke-interface {p1}, Landroidx/core/app/NotificationBuilderWithBuilderAccessor;->getBuilder()Landroid/app/Notification$Builder;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/Notification$CallStyle;->setBuilder(Landroid/app/Notification$Builder;)V

    .line 4929
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    if-eqz v1, :cond_73

    .line 4930
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-static {v0, v1}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->setAnswerButtonColorHint(Landroid/app/Notification$CallStyle;I)Landroid/app/Notification$CallStyle;

    .line 4932
    :cond_73
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    if-eqz v1, :cond_80

    .line 4933
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-static {v0, v1}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->setDeclineButtonColorHint(Landroid/app/Notification$CallStyle;I)Landroid/app/Notification$CallStyle;

    .line 4935
    :cond_80
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationText:Ljava/lang/CharSequence;

    invoke-static {v0, v1}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->setVerificationText(Landroid/app/Notification$CallStyle;Ljava/lang/CharSequence;)Landroid/app/Notification$CallStyle;

    .line 4936
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    if-eqz v1, :cond_96

    .line 4937
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v2, v2, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    .line 4938
    invoke-virtual {v1, v2}, Landroidx/core/graphics/drawable/IconCompat;->toIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;

    move-result-object v1

    .line 4937
    invoke-static {v0, v1}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->setVerificationIcon(Landroid/app/Notification$CallStyle;Landroid/graphics/drawable/Icon;)Landroid/app/Notification$CallStyle;

    .line 4940
    :cond_96
    iget-boolean v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    invoke-static {v0, v1}, Landroidx/core/app/NotificationCompat$CallStyle$Api31Impl;->setIsVideo(Landroid/app/Notification$CallStyle;Z)Landroid/app/Notification$CallStyle;

    .line 4942
    .end local v0    # "style":Landroid/app/Notification$CallStyle;
    :cond_9b
    goto/16 :goto_113

    .line 4947
    :cond_9d
    invoke-interface {p1}, Landroidx/core/app/NotificationBuilderWithBuilderAccessor;->getBuilder()Landroid/app/Notification$Builder;

    move-result-object v0

    .line 4950
    .local v0, "builder":Landroid/app/Notification$Builder;
    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    const/4 v2, 0x0

    if-eqz v1, :cond_ad

    iget-object v1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v1}, Landroidx/core/app/Person;->getName()Ljava/lang/CharSequence;

    move-result-object v1

    goto :goto_ae

    :cond_ad
    move-object v1, v2

    .line 4951
    .local v1, "title":Ljava/lang/CharSequence;
    :goto_ae
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 4956
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    if-eqz v3, :cond_cc

    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    const-string v4, "android.text"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_cc

    .line 4957
    iget-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v2, v2, Landroidx/core/app/NotificationCompat$Builder;->mExtras:Landroid/os/Bundle;

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    goto :goto_cd

    :cond_cc
    nop

    .line 4958
    .local v2, "text":Ljava/lang/CharSequence;
    :goto_cd
    if-nez v2, :cond_d3

    .line 4959
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$CallStyle;->getDefaultText()Ljava/lang/String;

    move-result-object v2

    .line 4961
    :cond_d3
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    .line 4964
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    if-eqz v3, :cond_10d

    .line 4966
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v3}, Landroidx/core/app/Person;->getIcon()Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v3

    if-eqz v3, :cond_f3

    .line 4967
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    .line 4968
    invoke-virtual {v3}, Landroidx/core/app/Person;->getIcon()Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v3

    iget-object v4, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroidx/core/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v3, v4}, Landroidx/core/graphics/drawable/IconCompat;->toIcon(Landroid/content/Context;)Landroid/graphics/drawable/Icon;

    move-result-object v3

    .line 4967
    invoke-static {v0, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api23Impl;->setLargeIcon(Landroid/app/Notification$Builder;Landroid/graphics/drawable/Icon;)V

    .line 4972
    :cond_f3
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1c

    if-lt v3, v4, :cond_103

    .line 4973
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v3}, Landroidx/core/app/Person;->toAndroidPerson()Landroid/app/Person;

    move-result-object v3

    invoke-static {v0, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api28Impl;->addPerson(Landroid/app/Notification$Builder;Landroid/app/Person;)Landroid/app/Notification$Builder;

    goto :goto_10d

    .line 4974
    :cond_103
    nop

    .line 4975
    iget-object v3, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    invoke-virtual {v3}, Landroidx/core/app/Person;->getUri()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api21Impl;->addPerson(Landroid/app/Notification$Builder;Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 4982
    :cond_10d
    :goto_10d
    nop

    .line 4983
    const-string v3, "call"

    invoke-static {v0, v3}, Landroidx/core/app/NotificationCompat$CallStyle$Api21Impl;->setCategory(Landroid/app/Notification$Builder;Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 4986
    .end local v0    # "builder":Landroid/app/Notification$Builder;
    .end local v1    # "title":Ljava/lang/CharSequence;
    .end local v2    # "text":Ljava/lang/CharSequence;
    :goto_113
    return-void

    :pswitch_data_114
    .packed-switch 0x1
        :pswitch_4e
        :pswitch_41
        :pswitch_32
    .end packed-switch
.end method

.method public displayCustomViewInline()Z
    .registers 2

    .line 4813
    const/4 v0, 0x1

    return v0
.end method

.method public getActionsListWithSystemActions()Ljava/util/ArrayList;
    .registers 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Landroidx/core/app/NotificationCompat$Action;",
            ">;"
        }
    .end annotation

    .line 5077
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$CallStyle;->makeNegativeAction()Landroidx/core/app/NotificationCompat$Action;

    move-result-object v0

    .line 5078
    .local v0, "firstAction":Landroidx/core/app/NotificationCompat$Action;
    invoke-direct {p0}, Landroidx/core/app/NotificationCompat$CallStyle;->makeAnswerAction()Landroidx/core/app/NotificationCompat$Action;

    move-result-object v1

    .line 5081
    .local v1, "lastAction":Landroidx/core/app/NotificationCompat$Action;
    const/4 v2, 0x3

    .line 5082
    .local v2, "nonContextualActionSlotsRemaining":I
    new-instance v3, Ljava/util/ArrayList;

    const/4 v4, 0x3

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(I)V

    .line 5083
    .local v3, "resultActions":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroidx/core/app/NotificationCompat$Action;>;"
    if-lez v2, :cond_16

    .line 5084
    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 5085
    add-int/lit8 v2, v2, -0x1

    .line 5089
    :cond_16
    iget-object v4, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mBuilder:Landroidx/core/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroidx/core/app/NotificationCompat$Builder;->mActions:Ljava/util/ArrayList;

    .line 5090
    .local v4, "existingActions":Ljava/util/List;, "Ljava/util/List<Landroidx/core/app/NotificationCompat$Action;>;"
    const/4 v5, 0x1

    if-eqz v4, :cond_4d

    .line 5091
    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_21
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_4d

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroidx/core/app/NotificationCompat$Action;

    .line 5092
    .local v7, "action":Landroidx/core/app/NotificationCompat$Action;
    invoke-virtual {v7}, Landroidx/core/app/NotificationCompat$Action;->isContextual()Z

    move-result v8

    if-eqz v8, :cond_37

    .line 5094
    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_43

    .line 5095
    :cond_37
    invoke-direct {p0, v7}, Landroidx/core/app/NotificationCompat$CallStyle;->isActionAddedByCallStyle(Landroidx/core/app/NotificationCompat$Action;)Z

    move-result v8

    if-eqz v8, :cond_3e

    goto :goto_43

    .line 5099
    :cond_3e
    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 5100
    add-int/lit8 v2, v2, -0x1

    .line 5103
    :goto_43
    if-eqz v1, :cond_4c

    if-ne v2, v5, :cond_4c

    .line 5104
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 5105
    add-int/lit8 v2, v2, -0x1

    .line 5107
    .end local v7    # "action":Landroidx/core/app/NotificationCompat$Action;
    :cond_4c
    goto :goto_21

    .line 5110
    :cond_4d
    if-eqz v1, :cond_54

    if-lt v2, v5, :cond_54

    .line 5111
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 5113
    :cond_54
    return-object v3
.end method

.method protected getClassName()Ljava/lang/String;
    .registers 2

    .line 4897
    const-string v0, "androidx.core.app.NotificationCompat$CallStyle"

    return-object v0
.end method

.method protected restoreFromCompatExtras(Landroid/os/Bundle;)V
    .registers 5
    .param p1, "extras"    # Landroid/os/Bundle;

    .line 4822
    invoke-super {p0, p1}, Landroidx/core/app/NotificationCompat$Style;->restoreFromCompatExtras(Landroid/os/Bundle;)V

    .line 4824
    const-string v0, "android.callType"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mCallType:I

    .line 4825
    const-string v0, "android.callIsVideo"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    .line 4826
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_2f

    .line 4827
    const-string v0, "android.callPerson"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2f

    .line 4828
    nop

    .line 4830
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/app/Person;

    .line 4828
    invoke-static {v0}, Landroidx/core/app/Person;->fromAndroidPerson(Landroid/app/Person;)Landroidx/core/app/Person;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    goto :goto_41

    .line 4831
    :cond_2f
    const-string v0, "android.callPersonCompat"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_41

    .line 4832
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/app/Person;->fromBundle(Landroid/os/Bundle;)Landroidx/core/app/Person;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mPerson:Landroidx/core/app/Person;

    .line 4834
    :cond_41
    :goto_41
    const-string v0, "android.verificationIcon"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_56

    .line 4835
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Icon;

    invoke-static {v0}, Landroidx/core/graphics/drawable/IconCompat;->createFromIcon(Landroid/graphics/drawable/Icon;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    goto :goto_69

    .line 4837
    :cond_56
    const-string v0, "android.verificationIconCompat"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_69

    .line 4838
    nop

    .line 4840
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    .line 4839
    invoke-static {v0}, Landroidx/core/graphics/drawable/IconCompat;->createFromBundle(Landroid/os/Bundle;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    .line 4842
    :cond_69
    :goto_69
    const-string v0, "android.verificationText"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationText:Ljava/lang/CharSequence;

    .line 4843
    const-string v0, "android.answerIntent"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerIntent:Landroid/app/PendingIntent;

    .line 4844
    const-string v0, "android.declineIntent"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineIntent:Landroid/app/PendingIntent;

    .line 4845
    const-string v0, "android.hangUpIntent"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mHangUpIntent:Landroid/app/PendingIntent;

    .line 4846
    const-string v0, "android.answerColor"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_a1

    .line 4847
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_a2

    :cond_a1
    move-object v0, v2

    :goto_a2
    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    .line 4848
    const-string v0, "android.declineColor"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b5

    .line 4849
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_b6

    :cond_b5
    nop

    :goto_b6
    iput-object v2, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    .line 4850
    return-void
.end method

.method public setAnswerButtonColorHint(I)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 3
    .param p1, "color"    # I

    .line 4791
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mAnswerButtonColor:Ljava/lang/Integer;

    .line 4792
    return-object p0
.end method

.method public setDeclineButtonColorHint(I)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 3
    .param p1, "color"    # I

    .line 4802
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mDeclineButtonColor:Ljava/lang/Integer;

    .line 4803
    return-object p0
.end method

.method public setIsVideo(Z)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 2
    .param p1, "isVideo"    # Z

    .line 4752
    iput-boolean p1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mIsVideo:Z

    .line 4753
    return-object p0
.end method

.method public setVerificationIcon(Landroid/graphics/Bitmap;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 3
    .param p1, "verificationIcon"    # Landroid/graphics/Bitmap;

    .line 4772
    invoke-static {p1}, Landroidx/core/graphics/drawable/IconCompat;->createWithBitmap(Landroid/graphics/Bitmap;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v0

    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    .line 4773
    return-object p0
.end method

.method public setVerificationIcon(Landroid/graphics/drawable/Icon;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 3
    .param p1, "verificationIcon"    # Landroid/graphics/drawable/Icon;

    .line 4762
    if-nez p1, :cond_4

    const/4 v0, 0x0

    goto :goto_8

    .line 4763
    :cond_4
    invoke-static {p1}, Landroidx/core/graphics/drawable/IconCompat;->createFromIcon(Landroid/graphics/drawable/Icon;)Landroidx/core/graphics/drawable/IconCompat;

    move-result-object v0

    :goto_8
    iput-object v0, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationIcon:Landroidx/core/graphics/drawable/IconCompat;

    .line 4764
    return-object p0
.end method

.method public setVerificationText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$CallStyle;
    .registers 2
    .param p1, "verificationText"    # Ljava/lang/CharSequence;

    .line 4781
    iput-object p1, p0, Landroidx/core/app/NotificationCompat$CallStyle;->mVerificationText:Ljava/lang/CharSequence;

    .line 4782
    return-object p0
.end method
