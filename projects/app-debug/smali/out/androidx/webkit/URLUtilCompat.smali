.class public final Landroidx/webkit/URLUtilCompat;
.super Ljava/lang/Object;
.source "URLUtilCompat.java"


# static fields
.field private static final DISPOSITION_PATTERN:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 159
    const-string v0, "\\s*(\\S+?) # Group 1: parameter name\n\\s*=\\s* # Match equals sign\n(?: # non-capturing group of options\n   \'( (?: [^\'\\\\] | \\\\. )* )\' # Group 2: single-quoted\n | \"( (?: [^\"\\\\] | \\\\. )*  )\" # Group 3: double-quoted\n | ( [^\'\"][^;\\s]* ) # Group 4: un-quoted parameter\n)\\s*;? # Optional end semicolon"

    const/4 v1, 0x4

    invoke-static {v0, v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Landroidx/webkit/URLUtilCompat;->DISPOSITION_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static encodePlusCharacters(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 10
    .param p0, "valueChars"    # Ljava/lang/String;
    .param p1, "encoding"    # Ljava/lang/String;

    .line 276
    invoke-static {p1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    .line 277
    .local v0, "charset":Ljava/nio/charset/Charset;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 278
    .local v1, "sb":Ljava/lang/StringBuilder;
    const-string v2, "+"

    invoke-virtual {v0, v2}, Ljava/nio/charset/Charset;->encode(Ljava/lang/String;)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    :goto_15
    if-ge v4, v3, :cond_2d

    aget-byte v5, v2, v4

    .line 279
    .local v5, "b":B
    invoke-static {v5}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    const-string v7, "%02x"

    invoke-static {v7, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 278
    .end local v5    # "b":B
    add-int/lit8 v4, v4, 0x1

    goto :goto_15

    .line 281
    :cond_2d
    const-string v2, "\\+"

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private static extensionDifferentFromMimeType(Ljava/lang/String;Ljava/lang/String;)Z
    .registers 6
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "mimeType"    # Ljava/lang/String;

    .line 140
    const/4 v0, 0x0

    if-nez p1, :cond_4

    .line 141
    return v0

    .line 143
    :cond_4
    const/16 v1, 0x2e

    invoke-virtual {p0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 144
    .local v1, "lastDotIndex":I
    invoke-static {}, Landroid/webkit/MimeTypeMap;->getSingleton()Landroid/webkit/MimeTypeMap;

    move-result-object v2

    add-int/lit8 v3, v1, 0x1

    .line 145
    invoke-virtual {p0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 144
    invoke-virtual {v2, v3}, Landroid/webkit/MimeTypeMap;->getMimeTypeFromExtension(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 146
    .local v2, "typeFromExt":Ljava/lang/String;
    if-eqz v2, :cond_21

    invoke-virtual {v2, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_21

    const/4 v0, 0x1

    :cond_21
    return v0
.end method

.method public static getFilenameFromContentDisposition(Ljava/lang/String;)Ljava/lang/String;
    .registers 12
    .param p0, "contentDisposition"    # Ljava/lang/String;

    .line 188
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v1, ";"

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    .line 189
    .local v0, "parts":[Ljava/lang/String;
    array-length v1, v0

    const/4 v3, 0x0

    if-ge v1, v2, :cond_10

    .line 191
    return-object v3

    .line 193
    :cond_10
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 194
    .local v1, "dispositionType":Ljava/lang/String;
    const-string v4, "inline"

    invoke-virtual {v4, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_20

    .line 198
    return-object v3

    .line 200
    :cond_20
    const/4 v3, 0x1

    aget-object v4, v0, v3

    .line 201
    .local v4, "dispositionParameters":Ljava/lang/String;
    sget-object v5, Landroidx/webkit/URLUtilCompat;->DISPOSITION_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v5, v4}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v5

    .line 202
    .local v5, "matcher":Ljava/util/regex/Matcher;
    const/4 v6, 0x0

    .line 203
    .local v6, "filename":Ljava/lang/String;
    const/4 v7, 0x0

    .line 204
    .local v7, "filenameExt":Ljava/lang/String;
    :cond_2b
    :goto_2b
    invoke-virtual {v5}, Ljava/util/regex/Matcher;->find()Z

    move-result v8

    if-eqz v8, :cond_75

    .line 205
    invoke-virtual {v5, v3}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v8

    .line 207
    .local v8, "parameter":Ljava/lang/String;
    invoke-virtual {v5, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v9

    if-eqz v9, :cond_44

    .line 208
    invoke-virtual {v5, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Landroidx/webkit/URLUtilCompat;->removeSlashEscapes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .local v9, "value":Ljava/lang/String;
    goto :goto_59

    .line 209
    .end local v9    # "value":Ljava/lang/String;
    :cond_44
    const/4 v9, 0x3

    invoke-virtual {v5, v9}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v10

    if-eqz v10, :cond_54

    .line 210
    invoke-virtual {v5, v9}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Landroidx/webkit/URLUtilCompat;->removeSlashEscapes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .restart local v9    # "value":Ljava/lang/String;
    goto :goto_59

    .line 212
    .end local v9    # "value":Ljava/lang/String;
    :cond_54
    const/4 v9, 0x4

    invoke-virtual {v5, v9}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v9

    .line 215
    .restart local v9    # "value":Ljava/lang/String;
    :goto_59
    if-eqz v8, :cond_2b

    if-nez v9, :cond_5e

    .line 216
    goto :goto_2b

    .line 219
    :cond_5e
    const-string v10, "filename*"

    invoke-virtual {v10, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_6b

    .line 220
    invoke-static {v9}, Landroidx/webkit/URLUtilCompat;->parseExtValueString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_74

    .line 221
    :cond_6b
    const-string v10, "filename"

    invoke-virtual {v10, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_74

    .line 222
    move-object v6, v9

    .line 224
    .end local v8    # "parameter":Ljava/lang/String;
    .end local v9    # "value":Ljava/lang/String;
    :cond_74
    :goto_74
    goto :goto_2b

    .line 227
    :cond_75
    if-eqz v7, :cond_78

    .line 228
    return-object v7

    .line 230
    :cond_78
    return-object v6
.end method

.method public static guessFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 7
    .param p0, "url"    # Ljava/lang/String;
    .param p1, "contentDisposition"    # Ljava/lang/String;
    .param p2, "mimeType"    # Ljava/lang/String;

    .line 72
    if-eqz p1, :cond_d

    .line 73
    invoke-static {p1}, Landroidx/webkit/URLUtilCompat;->getFilenameFromContentDisposition(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 74
    .local v0, "filename":Ljava/lang/String;
    if-eqz v0, :cond_d

    .line 75
    invoke-static {v0}, Landroidx/webkit/URLUtilCompat;->replacePathSeparators(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 80
    .end local v0    # "filename":Ljava/lang/String;
    :cond_d
    const-string v0, "downloadfile"

    .line 82
    .restart local v0    # "filename":Ljava/lang/String;
    invoke-static {p0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 83
    .local v1, "parsedUri":Landroid/net/Uri;
    if-eqz v1, :cond_1f

    .line 84
    invoke-virtual {v1}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object v2

    .line 85
    .local v2, "lastPathSegment":Ljava/lang/String;
    if-eqz v2, :cond_1f

    .line 86
    invoke-static {v2}, Landroidx/webkit/URLUtilCompat;->replacePathSeparators(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 91
    .end local v2    # "lastPathSegment":Ljava/lang/String;
    :cond_1f
    const/16 v2, 0x2e

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-ltz v2, :cond_2f

    invoke-static {v0, p2}, Landroidx/webkit/URLUtilCompat;->extensionDifferentFromMimeType(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2e

    goto :goto_2f

    .line 95
    :cond_2e
    return-object v0

    .line 92
    :cond_2f
    :goto_2f
    invoke-static {p2}, Landroidx/webkit/URLUtilCompat;->suggestExtensionFromMimeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 93
    .local v2, "extensionFromMimeType":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private static parseExtValueString(Ljava/lang/String;)Ljava/lang/String;
    .registers 6
    .param p0, "raw"    # Ljava/lang/String;

    .line 248
    const-string v0, "\'"

    const/4 v1, 0x3

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    .line 249
    .local v0, "parts":[Ljava/lang/String;
    array-length v2, v0

    const/4 v3, 0x0

    if-ge v2, v1, :cond_c

    .line 250
    return-object v3

    .line 253
    :cond_c
    const/4 v1, 0x0

    aget-object v1, v0, v1

    .line 255
    .local v1, "encoding":Ljava/lang/String;
    const/4 v2, 0x2

    aget-object v2, v0, v2

    .line 260
    .local v2, "valueChars":Ljava/lang/String;
    :try_start_12
    invoke-static {v2, v1}, Landroidx/webkit/URLUtilCompat;->encodePlusCharacters(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 263
    .local v4, "valueWithEncodedPlus":Ljava/lang/String;
    invoke-static {v4, v1}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3
    :try_end_1a
    .catch Ljava/lang/RuntimeException; {:try_start_12 .. :try_end_1a} :catch_1d
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_12 .. :try_end_1a} :catch_1b

    return-object v3

    .line 264
    .end local v4    # "valueWithEncodedPlus":Ljava/lang/String;
    :catch_1b
    move-exception v4

    goto :goto_1e

    :catch_1d
    move-exception v4

    .line 265
    .local v4, "ignored":Ljava/lang/Exception;
    :goto_1e
    return-object v3
.end method

.method private static removeSlashEscapes(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .param p0, "raw"    # Ljava/lang/String;

    .line 237
    if-nez p0, :cond_4

    .line 238
    const/4 v0, 0x0

    return-object v0

    .line 240
    :cond_4
    const-string v0, "\\\\(.)"

    const-string v1, "$1"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static replacePathSeparators(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .param p0, "raw"    # Ljava/lang/String;

    .line 103
    const-string v0, "/"

    const-string v1, "_"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static suggestExtensionFromMimeType(Ljava/lang/String;)Ljava/lang/String;
    .registers 4
    .param p0, "mimeType"    # Ljava/lang/String;

    .line 116
    const-string v0, ""

    if-nez p0, :cond_5

    .line 117
    return-object v0

    .line 119
    :cond_5
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p0

    .line 120
    const-string v1, "application/octet-stream"

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_18

    .line 124
    return-object v0

    .line 126
    :cond_18
    invoke-static {}, Landroid/webkit/MimeTypeMap;->getSingleton()Landroid/webkit/MimeTypeMap;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/webkit/MimeTypeMap;->getExtensionFromMimeType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 128
    .local v1, "extensionFromMimeType":Ljava/lang/String;
    if-eqz v1, :cond_36

    .line 129
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 131
    :cond_36
    return-object v0
.end method
