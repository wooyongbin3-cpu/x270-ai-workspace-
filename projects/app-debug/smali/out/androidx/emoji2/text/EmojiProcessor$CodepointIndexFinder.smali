.class final Landroidx/emoji2/text/EmojiProcessor$CodepointIndexFinder;
.super Ljava/lang/Object;
.source "EmojiProcessor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/emoji2/text/EmojiProcessor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "CodepointIndexFinder"
.end annotation


# static fields
.field private static final INVALID_INDEX:I = -0x1


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 789
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static findIndexBackward(Ljava/lang/CharSequence;II)I
    .registers 10
    .param p0, "cs"    # Ljava/lang/CharSequence;
    .param p1, "from"    # I
    .param p2, "numCodePoints"    # I

    .line 804
    move v0, p1

    .line 805
    .local v0, "currentIndex":I
    const/4 v1, 0x0

    .line 806
    .local v1, "waitingHighSurrogate":Z
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 807
    .local v2, "length":I
    const/4 v3, -0x1

    if-ltz v0, :cond_3f

    if-ge v2, v0, :cond_c

    goto :goto_3f

    .line 810
    :cond_c
    if-gez p2, :cond_f

    .line 811
    return v3

    .line 813
    :cond_f
    move v4, p2

    .line 815
    .local v4, "remainingCodePoints":I
    :goto_10
    if-nez v4, :cond_13

    .line 816
    return v0

    .line 819
    :cond_13
    add-int/lit8 v0, v0, -0x1

    .line 820
    if-gez v0, :cond_1c

    .line 821
    if-eqz v1, :cond_1a

    .line 822
    return v3

    .line 824
    :cond_1a
    const/4 v3, 0x0

    return v3

    .line 827
    :cond_1c
    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 828
    .local v5, "c":C
    if-eqz v1, :cond_2d

    .line 829
    invoke-static {v5}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v6

    if-nez v6, :cond_29

    .line 830
    return v3

    .line 832
    :cond_29
    const/4 v1, 0x0

    .line 833
    add-int/lit8 v4, v4, -0x1

    .line 834
    goto :goto_10

    .line 836
    :cond_2d
    invoke-static {v5}, Ljava/lang/Character;->isSurrogate(C)Z

    move-result v6

    if-nez v6, :cond_36

    .line 837
    add-int/lit8 v4, v4, -0x1

    .line 838
    goto :goto_10

    .line 840
    :cond_36
    invoke-static {v5}, Ljava/lang/Character;->isHighSurrogate(C)Z

    move-result v6

    if-eqz v6, :cond_3d

    .line 841
    return v3

    .line 843
    :cond_3d
    const/4 v1, 0x1

    .line 844
    .end local v5    # "c":C
    goto :goto_10

    .line 808
    .end local v4    # "remainingCodePoints":I
    :cond_3f
    :goto_3f
    return v3
.end method

.method static findIndexForward(Ljava/lang/CharSequence;II)I
    .registers 10
    .param p0, "cs"    # Ljava/lang/CharSequence;
    .param p1, "from"    # I
    .param p2, "numCodePoints"    # I

    .line 860
    move v0, p1

    .line 861
    .local v0, "currentIndex":I
    const/4 v1, 0x0

    .line 862
    .local v1, "waitingLowSurrogate":Z
    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    .line 863
    .local v2, "length":I
    const/4 v3, -0x1

    if-ltz v0, :cond_43

    if-ge v2, v0, :cond_c

    goto :goto_43

    .line 866
    :cond_c
    if-gez p2, :cond_f

    .line 867
    return v3

    .line 869
    :cond_f
    move v4, p2

    .line 872
    .local v4, "remainingCodePoints":I
    :goto_10
    if-nez v4, :cond_13

    .line 873
    return v0

    .line 876
    :cond_13
    if-lt v0, v2, :cond_19

    .line 877
    if-eqz v1, :cond_18

    .line 878
    return v3

    .line 880
    :cond_18
    return v2

    .line 883
    :cond_19
    invoke-interface {p0, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 884
    .local v5, "c":C
    if-eqz v1, :cond_2c

    .line 885
    invoke-static {v5}, Ljava/lang/Character;->isLowSurrogate(C)Z

    move-result v6

    if-nez v6, :cond_26

    .line 886
    return v3

    .line 888
    :cond_26
    add-int/lit8 v4, v4, -0x1

    .line 889
    const/4 v1, 0x0

    .line 890
    add-int/lit8 v0, v0, 0x1

    .line 891
    goto :goto_10

    .line 893
    :cond_2c
    invoke-static {v5}, Ljava/lang/Character;->isSurrogate(C)Z

    move-result v6

    if-nez v6, :cond_37

    .line 894
    add-int/lit8 v4, v4, -0x1

    .line 895
    add-int/lit8 v0, v0, 0x1

    .line 896
    goto :goto_10

    .line 898
    :cond_37
    invoke-static {v5}, Ljava/lang/Character;->isLowSurrogate(C)Z

    move-result v6

    if-eqz v6, :cond_3e

    .line 899
    return v3

    .line 901
    :cond_3e
    const/4 v1, 0x1

    .line 902
    nop

    .end local v5    # "c":C
    add-int/lit8 v0, v0, 0x1

    .line 903
    goto :goto_10

    .line 864
    .end local v4    # "remainingCodePoints":I
    :cond_43
    :goto_43
    return v3
.end method
