.class public Lorg/apache/cordova/LOG;
.super Ljava/lang/Object;
.source "LOG.java"


# static fields
.field public static final DEBUG:I = 0x3

.field public static final ERROR:I = 0x6

.field public static final INFO:I = 0x4

.field public static LOGLEVEL:I = 0x0

.field public static final VERBOSE:I = 0x2

.field public static final WARN:I = 0x5


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 38
    const/4 v0, 0x6

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;

    .line 91
    const/4 v0, 0x3

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 92
    :cond_8
    return-void
.end method

.method public static d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .line 143
    const/4 v0, 0x3

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 144
    :cond_8
    return-void
.end method

.method public static varargs d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 208
    const/4 v0, 0x3

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_c

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 209
    :cond_c
    return-void
.end method

.method public static e(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;

    .line 121
    const/4 v0, 0x6

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 122
    :cond_8
    return-void
.end method

.method public static e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .line 186
    const/4 v0, 0x6

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 187
    :cond_8
    return-void
.end method

.method public static varargs e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 241
    const/4 v0, 0x6

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_c

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    :cond_c
    return-void
.end method

.method public static i(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;

    .line 101
    const/4 v0, 0x4

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 102
    :cond_8
    return-void
.end method

.method public static i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .line 154
    const/4 v0, 0x4

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 155
    :cond_8
    return-void
.end method

.method public static varargs i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 219
    const/4 v0, 0x4

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_c

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 220
    :cond_c
    return-void
.end method

.method public static isLoggable(I)Z
    .registers 2
    .param p0, "logLevel"    # I

    .line 71
    sget v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt p0, v0, :cond_6

    const/4 v0, 0x1

    goto :goto_7

    :cond_6
    const/4 v0, 0x0

    :goto_7
    return v0
.end method

.method public static setLogLevel(I)V
    .registers 3
    .param p0, "logLevel"    # I

    .line 46
    sput p0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    .line 47
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Changing log level to "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CordovaLog"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    return-void
.end method

.method public static setLogLevel(Ljava/lang/String;)V
    .registers 3
    .param p0, "logLevel"    # Ljava/lang/String;

    .line 56
    const-string v0, "VERBOSE"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    const/4 v0, 0x2

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    goto :goto_3b

    .line 57
    :cond_c
    const-string v0, "DEBUG"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_18

    const/4 v0, 0x3

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    goto :goto_3b

    .line 58
    :cond_18
    const-string v0, "INFO"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_24

    const/4 v0, 0x4

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    goto :goto_3b

    .line 59
    :cond_24
    const-string v0, "WARN"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_30

    const/4 v0, 0x5

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    goto :goto_3b

    .line 60
    :cond_30
    const-string v0, "ERROR"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3b

    const/4 v0, 0x6

    sput v0, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    .line 61
    :cond_3b
    :goto_3b
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Changing log level to "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CordovaLog"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    return-void
.end method

.method public static v(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;

    .line 81
    const/4 v0, 0x2

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    :cond_8
    return-void
.end method

.method public static v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .line 132
    const/4 v0, 0x2

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1, p2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 133
    :cond_8
    return-void
.end method

.method public static varargs v(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 197
    const/4 v0, 0x2

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_c

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 198
    :cond_c
    return-void
.end method

.method public static w(Ljava/lang/String;Ljava/lang/String;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;

    .line 111
    const/4 v0, 0x5

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 112
    :cond_8
    return-void
.end method

.method public static w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "e"    # Ljava/lang/Throwable;

    .line 175
    const/4 v0, 0x5

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 176
    :cond_8
    return-void
.end method

.method public static varargs w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .registers 5
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 230
    const/4 v0, 0x5

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_c

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 231
    :cond_c
    return-void
.end method

.method public static w(Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 4
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "e"    # Ljava/lang/Throwable;

    .line 164
    const/4 v0, 0x5

    sget v1, Lorg/apache/cordova/LOG;->LOGLEVEL:I

    if-lt v0, v1, :cond_8

    invoke-static {p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 165
    :cond_8
    return-void
.end method
