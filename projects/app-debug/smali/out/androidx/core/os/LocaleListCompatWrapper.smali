.class final Landroidx/core/os/LocaleListCompatWrapper;
.super Ljava/lang/Object;
.source "LocaleListCompatWrapper.java"

# interfaces
.implements Landroidx/core/os/LocaleListInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/core/os/LocaleListCompatWrapper$Api21Impl;
    }
.end annotation


# static fields
.field private static final EN_LATN:Ljava/util/Locale;

.field private static final LOCALE_AR_XB:Ljava/util/Locale;

.field private static final LOCALE_EN_XA:Ljava/util/Locale;

.field private static final sEmptyList:[Ljava/util/Locale;


# instance fields
.field private final mList:[Ljava/util/Locale;

.field private final mStringRepresentation:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 42
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/util/Locale;

    sput-object v0, Landroidx/core/os/LocaleListCompatWrapper;->sEmptyList:[Ljava/util/Locale;

    .line 173
    new-instance v0, Ljava/util/Locale;

    const-string v1, "en"

    const-string v2, "XA"

    invoke-direct {v0, v1, v2}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Landroidx/core/os/LocaleListCompatWrapper;->LOCALE_EN_XA:Ljava/util/Locale;

    .line 174
    new-instance v0, Ljava/util/Locale;

    const-string v1, "ar"

    const-string v2, "XB"

    invoke-direct {v0, v1, v2}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Landroidx/core/os/LocaleListCompatWrapper;->LOCALE_AR_XB:Ljava/util/Locale;

    .line 219
    const-string v0, "en-Latn"

    invoke-static {v0}, Landroidx/core/os/LocaleListCompat;->forLanguageTagCompat(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v0

    sput-object v0, Landroidx/core/os/LocaleListCompatWrapper;->EN_LATN:Ljava/util/Locale;

    return-void
.end method

.method varargs constructor <init>([Ljava/util/Locale;)V
    .registers 10
    .param p1, "list"    # [Ljava/util/Locale;

    .line 122
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 123
    array-length v0, p1

    if-nez v0, :cond_f

    .line 124
    sget-object v0, Landroidx/core/os/LocaleListCompatWrapper;->sEmptyList:[Ljava/util/Locale;

    iput-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    .line 125
    const-string v0, ""

    iput-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mStringRepresentation:Ljava/lang/String;

    goto :goto_78

    .line 127
    :cond_f
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 128
    .local v0, "localeList":Ljava/util/List;, "Ljava/util/List<Ljava/util/Locale;>;"
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 129
    .local v1, "seenLocales":Ljava/util/HashSet;, "Ljava/util/HashSet<Ljava/util/Locale;>;"
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 130
    .local v2, "sb":Ljava/lang/StringBuilder;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1f
    array-length v4, p1

    if-ge v3, v4, :cond_67

    .line 131
    aget-object v4, p1, v3

    .line 132
    .local v4, "l":Ljava/util/Locale;
    if-eqz v4, :cond_48

    .line 134
    invoke-virtual {v1, v4}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_45

    .line 135
    invoke-virtual {v4}, Ljava/util/Locale;->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Locale;

    .line 136
    .local v5, "localeClone":Ljava/util/Locale;
    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 137
    invoke-static {v2, v5}, Landroidx/core/os/LocaleListCompatWrapper;->toLanguageTag(Ljava/lang/StringBuilder;Ljava/util/Locale;)V

    .line 138
    array-length v6, p1

    add-int/lit8 v6, v6, -0x1

    if-ge v3, v6, :cond_42

    .line 139
    const/16 v6, 0x2c

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 141
    :cond_42
    invoke-virtual {v1, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 130
    .end local v4    # "l":Ljava/util/Locale;
    .end local v5    # "localeClone":Ljava/util/Locale;
    :cond_45
    add-int/lit8 v3, v3, 0x1

    goto :goto_1f

    .line 133
    .restart local v4    # "l":Ljava/util/Locale;
    :cond_48
    new-instance v5, Ljava/lang/NullPointerException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "list["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] is null"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 144
    .end local v3    # "i":I
    .end local v4    # "l":Ljava/util/Locale;
    :cond_67
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/util/Locale;

    invoke-interface {v0, v3}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/util/Locale;

    iput-object v3, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    .line 145
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Landroidx/core/os/LocaleListCompatWrapper;->mStringRepresentation:Ljava/lang/String;

    .line 147
    .end local v0    # "localeList":Ljava/util/List;, "Ljava/util/List<Ljava/util/Locale;>;"
    .end local v1    # "seenLocales":Ljava/util/HashSet;, "Ljava/util/HashSet<Ljava/util/Locale;>;"
    .end local v2    # "sb":Ljava/lang/StringBuilder;
    :goto_78
    return-void
.end method

.method private computeFirstMatch(Ljava/util/Collection;Z)Ljava/util/Locale;
    .registers 5
    .param p2, "assumeEnglishIsSupported"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;Z)",
            "Ljava/util/Locale;"
        }
    .end annotation

    .line 261
    .local p1, "supportedLocales":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-direct {p0, p1, p2}, Landroidx/core/os/LocaleListCompatWrapper;->computeFirstMatchIndex(Ljava/util/Collection;Z)I

    move-result v0

    .line 262
    .local v0, "bestIndex":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_9

    const/4 v1, 0x0

    goto :goto_d

    :cond_9
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v1, v1, v0

    :goto_d
    return-object v1
.end method

.method private computeFirstMatchIndex(Ljava/util/Collection;Z)I
    .registers 9
    .param p2, "assumeEnglishIsSupported"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;Z)I"
        }
    .end annotation

    .line 223
    .local p1, "supportedLocales":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v0, v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_8

    .line 224
    return v2

    .line 226
    :cond_8
    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v0, v0

    if-nez v0, :cond_f

    .line 227
    const/4 v0, -0x1

    return v0

    .line 230
    :cond_f
    const v0, 0x7fffffff

    .line 232
    .local v0, "bestIndex":I
    if-eqz p2, :cond_20

    .line 233
    sget-object v1, Landroidx/core/os/LocaleListCompatWrapper;->EN_LATN:Ljava/util/Locale;

    invoke-direct {p0, v1}, Landroidx/core/os/LocaleListCompatWrapper;->findFirstMatchIndex(Ljava/util/Locale;)I

    move-result v1

    .line 234
    .local v1, "idx":I
    if-nez v1, :cond_1d

    .line 235
    return v2

    .line 236
    :cond_1d
    if-ge v1, v0, :cond_20

    .line 237
    move v0, v1

    .line 240
    .end local v1    # "idx":I
    :cond_20
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_24
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 241
    .local v3, "languageTag":Ljava/lang/String;
    invoke-static {v3}, Landroidx/core/os/LocaleListCompat;->forLanguageTagCompat(Ljava/lang/String;)Ljava/util/Locale;

    move-result-object v4

    .line 244
    .local v4, "supportedLocale":Ljava/util/Locale;
    invoke-direct {p0, v4}, Landroidx/core/os/LocaleListCompatWrapper;->findFirstMatchIndex(Ljava/util/Locale;)I

    move-result v5

    .line 245
    .local v5, "idx":I
    if-nez v5, :cond_3b

    .line 246
    return v2

    .line 247
    :cond_3b
    if-ge v5, v0, :cond_3e

    .line 248
    move v0, v5

    .line 250
    .end local v3    # "languageTag":Ljava/lang/String;
    .end local v4    # "supportedLocale":Ljava/util/Locale;
    .end local v5    # "idx":I
    :cond_3e
    goto :goto_24

    .line 251
    :cond_3f
    const v1, 0x7fffffff

    if-ne v0, v1, :cond_45

    .line 253
    return v2

    .line 255
    :cond_45
    return v0
.end method

.method private findFirstMatchIndex(Ljava/util/Locale;)I
    .registers 4
    .param p1, "supportedLocale"    # Ljava/util/Locale;

    .line 210
    const/4 v0, 0x0

    .local v0, "idx":I
    :goto_1
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v1, v1

    if-ge v0, v1, :cond_14

    .line 211
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v1, v1, v0

    invoke-static {p1, v1}, Landroidx/core/os/LocaleListCompatWrapper;->matchScore(Ljava/util/Locale;Ljava/util/Locale;)I

    move-result v1

    .line 212
    .local v1, "score":I
    if-lez v1, :cond_11

    .line 213
    return v0

    .line 210
    .end local v1    # "score":I
    :cond_11
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 216
    .end local v0    # "idx":I
    :cond_14
    const v0, 0x7fffffff

    return v0
.end method

.method private static getLikelyScript(Ljava/util/Locale;)Ljava/lang/String;
    .registers 3
    .param p0, "locale"    # Ljava/util/Locale;

    .line 162
    nop

    .line 163
    invoke-static {p0}, Landroidx/core/os/LocaleListCompatWrapper$Api21Impl;->getScript(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 164
    .local v0, "script":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_c

    .line 165
    return-object v0

    .line 167
    :cond_c
    const-string v1, ""

    return-object v1
.end method

.method private static isPseudoLocale(Ljava/util/Locale;)Z
    .registers 2
    .param p0, "locale"    # Ljava/util/Locale;

    .line 177
    sget-object v0, Landroidx/core/os/LocaleListCompatWrapper;->LOCALE_EN_XA:Ljava/util/Locale;

    invoke-virtual {v0, p0}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    sget-object v0, Landroidx/core/os/LocaleListCompatWrapper;->LOCALE_AR_XB:Ljava/util/Locale;

    invoke-virtual {v0, p0}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    goto :goto_13

    :cond_11
    const/4 v0, 0x0

    goto :goto_14

    :cond_13
    :goto_13
    const/4 v0, 0x1

    :goto_14
    return v0
.end method

.method private static matchScore(Ljava/util/Locale;Ljava/util/Locale;)I
    .registers 7
    .param p0, "supported"    # Ljava/util/Locale;
    .param p1, "desired"    # Ljava/util/Locale;

    .line 182
    invoke-virtual {p0, p1}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_8

    .line 183
    return v1

    .line 185
    :cond_8
    invoke-virtual {p0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_18

    .line 186
    return v2

    .line 188
    :cond_18
    invoke-static {p0}, Landroidx/core/os/LocaleListCompatWrapper;->isPseudoLocale(Ljava/util/Locale;)Z

    move-result v0

    if-nez v0, :cond_51

    invoke-static {p1}, Landroidx/core/os/LocaleListCompatWrapper;->isPseudoLocale(Ljava/util/Locale;)Z

    move-result v0

    if-eqz v0, :cond_25

    goto :goto_51

    .line 193
    :cond_25
    invoke-static {p0}, Landroidx/core/os/LocaleListCompatWrapper;->getLikelyScript(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 194
    .local v0, "supportedScr":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_48

    .line 198
    invoke-virtual {p0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    .line 199
    .local v3, "supportedRegion":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_46

    invoke-virtual {p1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_44

    goto :goto_46

    .line 201
    :cond_44
    move v1, v2

    goto :goto_47

    .line 200
    :cond_46
    :goto_46
    nop

    .line 199
    :goto_47
    return v1

    .line 203
    .end local v3    # "supportedRegion":Ljava/lang/String;
    :cond_48
    invoke-static {p1}, Landroidx/core/os/LocaleListCompatWrapper;->getLikelyScript(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 206
    .local v1, "desiredScr":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    return v2

    .line 191
    .end local v0    # "supportedScr":Ljava/lang/String;
    .end local v1    # "desiredScr":Ljava/lang/String;
    :cond_51
    :goto_51
    return v2
.end method

.method static toLanguageTag(Ljava/lang/StringBuilder;Ljava/util/Locale;)V
    .registers 4
    .param p0, "builder"    # Ljava/lang/StringBuilder;
    .param p1, "locale"    # Ljava/util/Locale;

    .line 151
    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 152
    invoke-virtual {p1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    .line 155
    .local v0, "country":Ljava/lang/String;
    if-eqz v0, :cond_1f

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1f

    .line 156
    const/16 v1, 0x2d

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 157
    invoke-virtual {p1}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 159
    :cond_1f
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .registers 8
    .param p1, "other"    # Ljava/lang/Object;

    .line 76
    const/4 v0, 0x1

    if-ne p1, p0, :cond_4

    .line 77
    return v0

    .line 79
    :cond_4
    instance-of v1, p1, Landroidx/core/os/LocaleListCompatWrapper;

    const/4 v2, 0x0

    if-nez v1, :cond_a

    .line 80
    return v2

    .line 82
    :cond_a
    move-object v1, p1

    check-cast v1, Landroidx/core/os/LocaleListCompatWrapper;

    iget-object v1, v1, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    .line 83
    .local v1, "otherList":[Ljava/util/Locale;
    iget-object v3, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v3, v3

    array-length v4, v1

    if-eq v3, v4, :cond_16

    .line 84
    return v2

    .line 86
    :cond_16
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_17
    iget-object v4, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v4, v4

    if-ge v3, v4, :cond_2c

    .line 87
    iget-object v4, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v4, v4, v3

    aget-object v5, v1, v3

    invoke-virtual {v4, v5}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_29

    .line 88
    return v2

    .line 86
    :cond_29
    add-int/lit8 v3, v3, 0x1

    goto :goto_17

    .line 91
    .end local v3    # "i":I
    :cond_2c
    return v0
.end method

.method public get(I)Ljava/util/Locale;
    .registers 3
    .param p1, "index"    # I

    .line 51
    if-ltz p1, :cond_c

    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v0, v0

    if-ge p1, v0, :cond_c

    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v0, v0, p1

    goto :goto_d

    :cond_c
    const/4 v0, 0x0

    :goto_d
    return-object v0
.end method

.method public getFirstMatch([Ljava/lang/String;)Ljava/util/Locale;
    .registers 4
    .param p1, "supportedLocales"    # [Ljava/lang/String;

    .line 267
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Landroidx/core/os/LocaleListCompatWrapper;->computeFirstMatch(Ljava/util/Collection;Z)Ljava/util/Locale;

    move-result-object v0

    return-object v0
.end method

.method public getLocaleList()Ljava/lang/Object;
    .registers 2

    .line 46
    const/4 v0, 0x0

    return-object v0
.end method

.method public hashCode()I
    .registers 8

    .line 96
    const/4 v0, 0x1

    .line 97
    .local v0, "result":I
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_5
    if-ge v3, v2, :cond_14

    aget-object v4, v1, v3

    .line 98
    .local v4, "locale":Ljava/util/Locale;
    mul-int/lit8 v5, v0, 0x1f

    invoke-virtual {v4}, Ljava/util/Locale;->hashCode()I

    move-result v6

    add-int v0, v5, v6

    .line 97
    .end local v4    # "locale":Ljava/util/Locale;
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 100
    :cond_14
    return v0
.end method

.method public indexOf(Ljava/util/Locale;)I
    .registers 4
    .param p1, "locale"    # Ljava/util/Locale;

    .line 66
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v1, v1

    if-ge v0, v1, :cond_14

    .line 67
    iget-object v1, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_11

    .line 68
    return v0

    .line 66
    :cond_11
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 71
    .end local v0    # "i":I
    :cond_14
    const/4 v0, -0x1

    return v0
.end method

.method public isEmpty()Z
    .registers 2

    .line 56
    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v0, v0

    if-nez v0, :cond_7

    const/4 v0, 0x1

    goto :goto_8

    :cond_7
    const/4 v0, 0x0

    :goto_8
    return v0
.end method

.method public size()I
    .registers 2

    .line 61
    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v0, v0

    return v0
.end method

.method public toLanguageTags()Ljava/lang/String;
    .registers 2

    .line 119
    iget-object v0, p0, Landroidx/core/os/LocaleListCompatWrapper;->mStringRepresentation:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .registers 4

    .line 105
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 106
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 107
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_b
    iget-object v2, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v2, v2

    if-ge v1, v2, :cond_26

    .line 108
    iget-object v2, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    aget-object v2, v2, v1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 109
    iget-object v2, p0, Landroidx/core/os/LocaleListCompatWrapper;->mList:[Ljava/util/Locale;

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_23

    .line 110
    const/16 v2, 0x2c

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 107
    :cond_23
    add-int/lit8 v1, v1, 0x1

    goto :goto_b

    .line 113
    .end local v1    # "i":I
    :cond_26
    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 114
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
