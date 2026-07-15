.class public final Landroidx/core/util/TimeUtils;
.super Ljava/lang/Object;
.source "TimeUtils.java"


# static fields
.field public static final HUNDRED_DAY_FIELD_LEN:I = 0x13

.field private static final SECONDS_PER_DAY:I = 0x15180

.field private static final SECONDS_PER_HOUR:I = 0xe10

.field private static final SECONDS_PER_MINUTE:I = 0x3c

.field private static sFormatStr:[C

.field private static final sFormatSync:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 38
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Landroidx/core/util/TimeUtils;->sFormatSync:Ljava/lang/Object;

    .line 39
    const/16 v0, 0x18

    new-array v0, v0, [C

    sput-object v0, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 179
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static accumField(IIZI)I
    .registers 5
    .param p0, "amt"    # I
    .param p1, "suffix"    # I
    .param p2, "always"    # Z
    .param p3, "zeropad"    # I

    .line 42
    const/16 v0, 0x63

    if-gt p0, v0, :cond_21

    if-eqz p2, :cond_a

    const/4 v0, 0x3

    if-lt p3, v0, :cond_a

    goto :goto_21

    .line 45
    :cond_a
    const/16 v0, 0x9

    if-gt p0, v0, :cond_1e

    if-eqz p2, :cond_14

    const/4 v0, 0x2

    if-lt p3, v0, :cond_14

    goto :goto_1e

    .line 48
    :cond_14
    if-nez p2, :cond_1b

    if-lez p0, :cond_19

    goto :goto_1b

    .line 51
    :cond_19
    const/4 v0, 0x0

    return v0

    .line 49
    :cond_1b
    :goto_1b
    add-int/lit8 v0, p1, 0x1

    return v0

    .line 46
    :cond_1e
    :goto_1e
    add-int/lit8 v0, p1, 0x2

    return v0

    .line 43
    :cond_21
    :goto_21
    add-int/lit8 v0, p1, 0x3

    return v0
.end method

.method public static formatDuration(JJLjava/io/PrintWriter;)V
    .registers 8
    .param p0, "time"    # J
    .param p2, "now"    # J
    .param p4, "pw"    # Ljava/io/PrintWriter;

    .line 172
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-nez v0, :cond_c

    .line 173
    const-string v0, "--"

    invoke-virtual {p4, v0}, Ljava/io/PrintWriter;->print(Ljava/lang/String;)V

    .line 174
    return-void

    .line 176
    :cond_c
    sub-long v0, p0, p2

    const/4 v2, 0x0

    invoke-static {v0, v1, p4, v2}, Landroidx/core/util/TimeUtils;->formatDuration(JLjava/io/PrintWriter;I)V

    .line 177
    return-void
.end method

.method public static formatDuration(JLjava/io/PrintWriter;)V
    .registers 4
    .param p0, "duration"    # J
    .param p2, "pw"    # Ljava/io/PrintWriter;

    .line 167
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Landroidx/core/util/TimeUtils;->formatDuration(JLjava/io/PrintWriter;I)V

    .line 168
    return-void
.end method

.method public static formatDuration(JLjava/io/PrintWriter;I)V
    .registers 9
    .param p0, "duration"    # J
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "fieldLen"    # I

    .line 159
    sget-object v0, Landroidx/core/util/TimeUtils;->sFormatSync:Ljava/lang/Object;

    monitor-enter v0

    .line 160
    :try_start_3
    invoke-static {p0, p1, p3}, Landroidx/core/util/TimeUtils;->formatDurationLocked(JI)I

    move-result v1

    .line 161
    .local v1, "len":I
    new-instance v2, Ljava/lang/String;

    sget-object v3, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4, v1}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p2, v2}, Ljava/io/PrintWriter;->print(Ljava/lang/String;)V

    .line 162
    .end local v1    # "len":I
    monitor-exit v0

    .line 163
    return-void

    .line 162
    :catchall_14
    move-exception v1

    monitor-exit v0
    :try_end_16
    .catchall {:try_start_3 .. :try_end_16} :catchall_14

    throw v1
.end method

.method public static formatDuration(JLjava/lang/StringBuilder;)V
    .registers 7
    .param p0, "duration"    # J
    .param p2, "builder"    # Ljava/lang/StringBuilder;

    .line 151
    sget-object v0, Landroidx/core/util/TimeUtils;->sFormatSync:Ljava/lang/Object;

    monitor-enter v0

    .line 152
    const/4 v1, 0x0

    :try_start_4
    invoke-static {p0, p1, v1}, Landroidx/core/util/TimeUtils;->formatDurationLocked(JI)I

    move-result v2

    .line 153
    .local v2, "len":I
    sget-object v3, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    invoke-virtual {p2, v3, v1, v2}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 154
    nop

    .end local v2    # "len":I
    monitor-exit v0

    .line 155
    return-void

    .line 154
    :catchall_10
    move-exception v1

    monitor-exit v0
    :try_end_12
    .catchall {:try_start_4 .. :try_end_12} :catchall_10

    throw v1
.end method

.method private static formatDurationLocked(JI)I
    .registers 23
    .param p0, "duration"    # J
    .param p2, "fieldLen"    # I

    .line 79
    move-wide/from16 v0, p0

    move/from16 v2, p2

    sget-object v3, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    array-length v3, v3

    if-ge v3, v2, :cond_d

    .line 80
    new-array v3, v2, [C

    sput-object v3, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    .line 83
    :cond_d
    sget-object v4, Landroidx/core/util/TimeUtils;->sFormatStr:[C

    .line 85
    .local v4, "formatStr":[C
    const-wide/16 v5, 0x0

    cmp-long v3, v0, v5

    const/16 v7, 0x20

    if-nez v3, :cond_26

    .line 86
    const/4 v3, 0x0

    .line 87
    .local v3, "pos":I
    add-int/lit8 v2, v2, -0x1

    .line 88
    .end local p2    # "fieldLen":I
    .local v2, "fieldLen":I
    :goto_1a
    if-ge v3, v2, :cond_1f

    .line 89
    aput-char v7, v4, v3

    goto :goto_1a

    .line 91
    :cond_1f
    const/16 v5, 0x30

    aput-char v5, v4, v3

    .line 92
    add-int/lit8 v5, v3, 0x1

    return v5

    .line 96
    .end local v2    # "fieldLen":I
    .end local v3    # "pos":I
    .restart local p2    # "fieldLen":I
    :cond_26
    cmp-long v3, v0, v5

    if-lez v3, :cond_2d

    .line 97
    const/16 v3, 0x2b

    .local v3, "prefix":C
    goto :goto_30

    .line 99
    .end local v3    # "prefix":C
    :cond_2d
    const/16 v3, 0x2d

    .line 100
    .restart local v3    # "prefix":C
    neg-long v0, v0

    .line 103
    .end local p0    # "duration":J
    .local v0, "duration":J
    :goto_30
    const-wide/16 v5, 0x3e8

    rem-long v8, v0, v5

    long-to-int v10, v8

    .line 104
    .local v10, "millis":I
    div-long v5, v0, v5

    long-to-double v5, v5

    invoke-static {v5, v6}, Ljava/lang/Math;->floor(D)D

    move-result-wide v5

    double-to-int v5, v5

    .line 105
    .local v5, "seconds":I
    const/4 v6, 0x0

    .local v6, "days":I
    const/4 v8, 0x0

    .local v8, "hours":I
    const/4 v9, 0x0

    .line 107
    .local v9, "minutes":I
    const v11, 0x15180

    if-le v5, v11, :cond_49

    .line 108
    div-int v6, v5, v11

    .line 109
    mul-int/2addr v11, v6

    sub-int/2addr v5, v11

    .line 111
    :cond_49
    const/16 v11, 0xe10

    if-le v5, v11, :cond_54

    .line 112
    div-int/lit16 v8, v5, 0xe10

    .line 113
    mul-int/lit16 v11, v8, 0xe10

    sub-int/2addr v5, v11

    move v11, v8

    goto :goto_55

    .line 111
    :cond_54
    move v11, v8

    .line 115
    .end local v8    # "hours":I
    .local v11, "hours":I
    :goto_55
    const/16 v8, 0x3c

    if-le v5, v8, :cond_61

    .line 116
    div-int/lit8 v9, v5, 0x3c

    .line 117
    mul-int/lit8 v8, v9, 0x3c

    sub-int/2addr v5, v8

    move v12, v5

    move v13, v9

    goto :goto_63

    .line 115
    :cond_61
    move v12, v5

    move v13, v9

    .line 120
    .end local v5    # "seconds":I
    .end local v9    # "minutes":I
    .local v12, "seconds":I
    .local v13, "minutes":I
    :goto_63
    const/4 v5, 0x0

    .line 122
    .local v5, "pos":I
    const/4 v15, 0x2

    const/4 v8, 0x0

    const/4 v9, 0x1

    if-eqz v2, :cond_a7

    .line 123
    invoke-static {v6, v9, v8, v8}, Landroidx/core/util/TimeUtils;->accumField(IIZI)I

    move-result v16

    .line 124
    .local v16, "myLen":I
    move/from16 v17, v7

    if-lez v16, :cond_73

    move v7, v9

    goto :goto_74

    :cond_73
    move v7, v8

    :goto_74
    invoke-static {v11, v9, v7, v15}, Landroidx/core/util/TimeUtils;->accumField(IIZI)I

    move-result v7

    add-int v16, v16, v7

    .line 125
    if-lez v16, :cond_7e

    move v7, v9

    goto :goto_7f

    :cond_7e
    move v7, v8

    :goto_7f
    invoke-static {v13, v9, v7, v15}, Landroidx/core/util/TimeUtils;->accumField(IIZI)I

    move-result v7

    add-int v16, v16, v7

    .line 126
    if-lez v16, :cond_89

    move v7, v9

    goto :goto_8a

    :cond_89
    move v7, v8

    :goto_8a
    invoke-static {v12, v9, v7, v15}, Landroidx/core/util/TimeUtils;->accumField(IIZI)I

    move-result v7

    add-int v16, v16, v7

    .line 127
    if-lez v16, :cond_94

    const/4 v7, 0x3

    goto :goto_95

    :cond_94
    move v7, v8

    :goto_95
    invoke-static {v10, v15, v9, v7}, Landroidx/core/util/TimeUtils;->accumField(IIZI)I

    move-result v7

    add-int/2addr v7, v9

    add-int v16, v16, v7

    move/from16 v7, v16

    .line 128
    .end local v16    # "myLen":I
    .local v7, "myLen":I
    :goto_9e
    if-ge v7, v2, :cond_a7

    .line 129
    aput-char v17, v4, v5

    .line 130
    add-int/lit8 v5, v5, 0x1

    .line 131
    add-int/lit8 v7, v7, 0x1

    goto :goto_9e

    .line 135
    .end local v7    # "myLen":I
    :cond_a7
    aput-char v3, v4, v5

    .line 136
    add-int/lit8 v7, v5, 0x1

    .line 138
    .end local v5    # "pos":I
    .local v7, "pos":I
    move v5, v7

    .line 139
    .local v5, "start":I
    if-eqz v2, :cond_b1

    move/from16 v16, v9

    goto :goto_b3

    :cond_b1
    move/from16 v16, v8

    .line 140
    .local v16, "zeropad":Z
    :goto_b3
    move/from16 v17, v8

    const/4 v8, 0x0

    move/from16 v18, v9

    const/4 v9, 0x0

    move/from16 v19, v5

    move v5, v6

    .end local v6    # "days":I
    .local v5, "days":I
    .local v19, "start":I
    const/16 v6, 0x64

    move/from16 v14, v19

    .end local v19    # "start":I
    .local v14, "start":I
    invoke-static/range {v4 .. v9}, Landroidx/core/util/TimeUtils;->printField([CICIZI)I

    move-result v7

    .line 141
    move/from16 v19, v5

    .end local v5    # "days":I
    .local v19, "days":I
    if-eq v7, v14, :cond_cb

    move/from16 v8, v18

    goto :goto_cd

    :cond_cb
    move/from16 v8, v17

    :goto_cd
    if-eqz v16, :cond_d1

    move v9, v15

    goto :goto_d3

    :cond_d1
    move/from16 v9, v17

    :goto_d3
    const/16 v6, 0x68

    move v5, v11

    .end local v11    # "hours":I
    .local v5, "hours":I
    invoke-static/range {v4 .. v9}, Landroidx/core/util/TimeUtils;->printField([CICIZI)I

    move-result v7

    .line 142
    .end local v5    # "hours":I
    .restart local v11    # "hours":I
    if-eq v7, v14, :cond_df

    move/from16 v8, v18

    goto :goto_e1

    :cond_df
    move/from16 v8, v17

    :goto_e1
    if-eqz v16, :cond_e5

    move v9, v15

    goto :goto_e7

    :cond_e5
    move/from16 v9, v17

    :goto_e7
    const/16 v6, 0x6d

    move v5, v13

    .end local v13    # "minutes":I
    .local v5, "minutes":I
    invoke-static/range {v4 .. v9}, Landroidx/core/util/TimeUtils;->printField([CICIZI)I

    move-result v7

    .line 143
    .end local v5    # "minutes":I
    .restart local v13    # "minutes":I
    if-eq v7, v14, :cond_f3

    move/from16 v8, v18

    goto :goto_f5

    :cond_f3
    move/from16 v8, v17

    :goto_f5
    if-eqz v16, :cond_f9

    move v9, v15

    goto :goto_fb

    :cond_f9
    move/from16 v9, v17

    :goto_fb
    const/16 v6, 0x73

    move v5, v12

    .end local v12    # "seconds":I
    .local v5, "seconds":I
    invoke-static/range {v4 .. v9}, Landroidx/core/util/TimeUtils;->printField([CICIZI)I

    move-result v7

    .line 144
    .end local v5    # "seconds":I
    .restart local v12    # "seconds":I
    if-eqz v16, :cond_108

    if-eq v7, v14, :cond_108

    const/4 v9, 0x3

    goto :goto_10a

    :cond_108
    move/from16 v9, v17

    :goto_10a
    const/16 v6, 0x6d

    const/4 v8, 0x1

    move v5, v10

    .end local v10    # "millis":I
    .local v5, "millis":I
    invoke-static/range {v4 .. v9}, Landroidx/core/util/TimeUtils;->printField([CICIZI)I

    move-result v6

    .line 145
    .end local v7    # "pos":I
    .local v6, "pos":I
    const/16 v7, 0x73

    aput-char v7, v4, v6

    .line 146
    add-int/lit8 v7, v6, 0x1

    return v7
.end method

.method private static printField([CICIZI)I
    .registers 9
    .param p0, "formatStr"    # [C
    .param p1, "amt"    # I
    .param p2, "suffix"    # C
    .param p3, "pos"    # I
    .param p4, "always"    # Z
    .param p5, "zeropad"    # I

    .line 56
    if-nez p4, :cond_4

    if-lez p1, :cond_3c

    .line 57
    :cond_4
    move v0, p3

    .line 58
    .local v0, "startPos":I
    if-eqz p4, :cond_a

    const/4 v1, 0x3

    if-ge p5, v1, :cond_e

    :cond_a
    const/16 v1, 0x63

    if-le p1, v1, :cond_1a

    .line 59
    :cond_e
    div-int/lit8 v1, p1, 0x64

    .line 60
    .local v1, "dig":I
    add-int/lit8 v2, v1, 0x30

    int-to-char v2, v2

    aput-char v2, p0, p3

    .line 61
    add-int/lit8 p3, p3, 0x1

    .line 62
    mul-int/lit8 v2, v1, 0x64

    sub-int/2addr p1, v2

    .line 64
    .end local v1    # "dig":I
    :cond_1a
    if-eqz p4, :cond_1f

    const/4 v1, 0x2

    if-ge p5, v1, :cond_25

    :cond_1f
    const/16 v1, 0x9

    if-gt p1, v1, :cond_25

    if-eq v0, p3, :cond_31

    .line 65
    :cond_25
    div-int/lit8 v1, p1, 0xa

    .line 66
    .restart local v1    # "dig":I
    add-int/lit8 v2, v1, 0x30

    int-to-char v2, v2

    aput-char v2, p0, p3

    .line 67
    add-int/lit8 p3, p3, 0x1

    .line 68
    mul-int/lit8 v2, v1, 0xa

    sub-int/2addr p1, v2

    .line 70
    .end local v1    # "dig":I
    :cond_31
    add-int/lit8 v1, p1, 0x30

    int-to-char v1, v1

    aput-char v1, p0, p3

    .line 71
    add-int/lit8 p3, p3, 0x1

    .line 72
    aput-char p2, p0, p3

    .line 73
    add-int/lit8 p3, p3, 0x1

    .line 75
    .end local v0    # "startPos":I
    :cond_3c
    return p3
.end method
