.class Landroidx/webkit/internal/MimeUtil;
.super Ljava/lang/Object;
.source "MimeUtil.java"


# direct methods
.method constructor <init>()V
    .registers 1

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getMimeFromFileName(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    .param p0, "fileName"    # Ljava/lang/String;

    .line 24
    if-nez p0, :cond_4

    .line 25
    const/4 v0, 0x0

    return-object v0

    .line 33
    :cond_4
    invoke-static {p0}, Ljava/net/URLConnection;->guessContentTypeFromName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 35
    .local v0, "mimeType":Ljava/lang/String;
    if-eqz v0, :cond_b

    .line 36
    return-object v0

    .line 39
    :cond_b
    invoke-static {p0}, Landroidx/webkit/internal/MimeUtil;->guessHardcodedMime(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static guessHardcodedMime(Ljava/lang/String;)Ljava/lang/String;
    .registers 7
    .param p0, "fileName"    # Ljava/lang/String;

    .line 47
    const/16 v0, 0x2e

    invoke-virtual {p0, v0}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v1

    .line 48
    .local v1, "finalFullStop":I
    const/4 v2, 0x0

    const/4 v3, -0x1

    if-ne v1, v3, :cond_b

    .line 49
    return-object v2

    .line 52
    :cond_b
    add-int/lit8 v4, v1, 0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    .line 54
    .local v4, "extension":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v5

    sparse-switch v5, :sswitch_data_2c2

    :cond_1c
    goto/16 :goto_263

    :sswitch_1e
    const-string v0, "xhtml"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x5

    goto/16 :goto_264

    :sswitch_29
    const-string v0, "shtml"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1e

    goto/16 :goto_264

    :sswitch_35
    const-string v0, "pjpeg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x12

    goto/16 :goto_264

    :sswitch_41
    const-string v0, "mhtml"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1a

    goto/16 :goto_264

    :sswitch_4d
    const-string v0, "ehtml"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x20

    goto/16 :goto_264

    :sswitch_59
    const-string v0, "xhtm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x7

    goto/16 :goto_264

    :sswitch_64
    const-string v0, "woff"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x29

    goto/16 :goto_264

    :sswitch_70
    const-string v0, "webp"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x18

    goto/16 :goto_264

    :sswitch_7c
    const-string v0, "webm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x0

    goto/16 :goto_264

    :sswitch_87
    const-string v0, "wasm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x4

    goto/16 :goto_264

    :sswitch_92
    const-string v0, "tiff"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x30

    goto/16 :goto_264

    :sswitch_9e
    const-string v0, "svgz"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x17

    goto/16 :goto_264

    :sswitch_aa
    const-string v0, "shtm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1f

    goto/16 :goto_264

    :sswitch_b6
    const-string v0, "opus"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xb

    goto/16 :goto_264

    :sswitch_c2
    const-string v0, "mpeg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x1

    goto/16 :goto_264

    :sswitch_cd
    const-string v0, "json"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x2c

    goto/16 :goto_264

    :sswitch_d9
    const-string v0, "jpeg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xf

    goto/16 :goto_264

    :sswitch_e5
    const-string v0, "jfif"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x11

    goto/16 :goto_264

    :sswitch_f1
    const-string v0, "html"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1c

    goto/16 :goto_264

    :sswitch_fd
    const-string v0, "flac"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x8

    goto/16 :goto_264

    :sswitch_109
    const-string v0, "apng"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x15

    goto/16 :goto_264

    :sswitch_115
    const-string v5, "zip"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1c

    goto/16 :goto_264

    :sswitch_11f
    const-string v0, "xml"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x23

    goto/16 :goto_264

    :sswitch_12b
    const-string v0, "xht"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x6

    goto/16 :goto_264

    :sswitch_136
    const-string v0, "wav"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xc

    goto/16 :goto_264

    :sswitch_142
    const-string v0, "tif"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x31

    goto/16 :goto_264

    :sswitch_14e
    const-string v0, "tgz"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x2b

    goto/16 :goto_264

    :sswitch_15a
    const-string v0, "svg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x16

    goto/16 :goto_264

    :sswitch_166
    const-string v0, "png"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x14

    goto/16 :goto_264

    :sswitch_172
    const-string v0, "pjp"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x13

    goto/16 :goto_264

    :sswitch_17e
    const-string v0, "pdf"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x2d

    goto/16 :goto_264

    :sswitch_18a
    const-string v0, "ogv"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x26

    goto/16 :goto_264

    :sswitch_196
    const-string v0, "ogm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x27

    goto/16 :goto_264

    :sswitch_1a2
    const-string v0, "ogg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x9

    goto/16 :goto_264

    :sswitch_1ae
    const-string v0, "oga"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xa

    goto/16 :goto_264

    :sswitch_1ba
    const-string v0, "mpg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x2

    goto/16 :goto_264

    :sswitch_1c5
    const-string v0, "mp4"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x24

    goto/16 :goto_264

    :sswitch_1d1
    const-string v0, "mp3"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/4 v0, 0x3

    goto/16 :goto_264

    :sswitch_1dc
    const-string v0, "mjs"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x22

    goto/16 :goto_264

    :sswitch_1e8
    const-string v0, "mht"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x19

    goto/16 :goto_264

    :sswitch_1f4
    const-string v0, "m4v"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x25

    goto/16 :goto_264

    :sswitch_200
    const-string v0, "m4a"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xd

    goto :goto_264

    :sswitch_20b
    const-string v0, "jpg"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x10

    goto :goto_264

    :sswitch_216
    const-string v0, "ico"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x28

    goto :goto_264

    :sswitch_221
    const-string v0, "htm"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1d

    goto :goto_264

    :sswitch_22c
    const-string v0, "gif"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0xe

    goto :goto_264

    :sswitch_237
    const-string v0, "css"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x1b

    goto :goto_264

    :sswitch_242
    const-string v0, "bmp"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x2f

    goto :goto_264

    :sswitch_24d
    const-string v0, "js"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x21

    goto :goto_264

    :sswitch_258
    const-string v0, "gz"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    const/16 v0, 0x2a

    goto :goto_264

    :goto_263
    move v0, v3

    :goto_264
    packed-switch v0, :pswitch_data_38c

    .line 136
    return-object v2

    .line 134
    :pswitch_268
    const-string v0, "image/tiff"

    return-object v0

    .line 131
    :pswitch_26b
    const-string v0, "image/bmp"

    return-object v0

    .line 129
    :pswitch_26e
    const-string v0, "application/zip"

    return-object v0

    .line 127
    :pswitch_271
    const-string v0, "application/pdf"

    return-object v0

    .line 125
    :pswitch_274
    const-string v0, "application/json"

    return-object v0

    .line 123
    :pswitch_277
    const-string v0, "application/gzip"

    return-object v0

    .line 120
    :pswitch_27a
    const-string v0, "application/font-woff"

    return-object v0

    .line 118
    :pswitch_27d
    const-string v0, "image/x-icon"

    return-object v0

    .line 116
    :pswitch_280
    const-string v0, "video/ogg"

    return-object v0

    .line 113
    :pswitch_283
    const-string v0, "video/mp4"

    return-object v0

    .line 110
    :pswitch_286
    const-string v0, "text/xml"

    return-object v0

    .line 108
    :pswitch_289
    const-string v0, "text/javascript"

    return-object v0

    .line 105
    :pswitch_28c
    const-string v0, "text/html"

    return-object v0

    .line 99
    :pswitch_28f
    const-string v0, "text/css"

    return-object v0

    .line 97
    :pswitch_292
    const-string v0, "multipart/related"

    return-object v0

    .line 94
    :pswitch_295
    const-string v0, "image/webp"

    return-object v0

    .line 92
    :pswitch_298
    const-string v0, "image/svg+xml"

    return-object v0

    .line 89
    :pswitch_29b
    const-string v0, "image/apng"

    return-object v0

    .line 87
    :pswitch_29e
    const-string v0, "image/png"

    return-object v0

    .line 85
    :pswitch_2a1
    const-string v0, "image/jpeg"

    return-object v0

    .line 79
    :pswitch_2a4
    const-string v0, "image/gif"

    return-object v0

    .line 77
    :pswitch_2a7
    const-string v0, "audio/x-m4a"

    return-object v0

    .line 75
    :pswitch_2aa
    const-string v0, "audio/wav"

    return-object v0

    .line 73
    :pswitch_2ad
    const-string v0, "audio/ogg"

    return-object v0

    .line 69
    :pswitch_2b0
    const-string v0, "audio/flac"

    return-object v0

    .line 67
    :pswitch_2b3
    const-string v0, "application/xhtml+xml"

    return-object v0

    .line 63
    :pswitch_2b6
    const-string v0, "application/wasm"

    return-object v0

    .line 61
    :pswitch_2b9
    const-string v0, "audio/mpeg"

    return-object v0

    .line 59
    :pswitch_2bc
    const-string v0, "video/mpeg"

    return-object v0

    .line 56
    :pswitch_2bf
    const-string v0, "video/webm"

    return-object v0

    :sswitch_data_2c2
    .sparse-switch
        0xcf3 -> :sswitch_258
        0xd49 -> :sswitch_24d
        0x17d85 -> :sswitch_242
        0x18203 -> :sswitch_237
        0x18fc4 -> :sswitch_22c
        0x194e1 -> :sswitch_221
        0x19695 -> :sswitch_216
        0x19be1 -> :sswitch_20b
        0x19fda -> :sswitch_200
        0x19fef -> :sswitch_1f4
        0x1a639 -> :sswitch_1e8
        0x1a676 -> :sswitch_1dc
        0x1a6f0 -> :sswitch_1d1
        0x1a6f1 -> :sswitch_1c5
        0x1a724 -> :sswitch_1ba
        0x1ad89 -> :sswitch_1ae
        0x1ad8f -> :sswitch_1a2
        0x1ad95 -> :sswitch_196
        0x1ad9e -> :sswitch_18a
        0x1b0f2 -> :sswitch_17e
        0x1b1b6 -> :sswitch_172
        0x1b229 -> :sswitch_166
        0x1be64 -> :sswitch_15a
        0x1c067 -> :sswitch_14e
        0x1c091 -> :sswitch_142
        0x1caec -> :sswitch_136
        0x1cf84 -> :sswitch_12b
        0x1d017 -> :sswitch_11f
        0x1d721 -> :sswitch_115
        0x2dca28 -> :sswitch_109
        0x2fff68 -> :sswitch_fd
        0x3107ab -> :sswitch_f1
        0x31bb59 -> :sswitch_e5
        0x31e068 -> :sswitch_d9
        0x31ece8 -> :sswitch_cd
        0x333d85 -> :sswitch_c2
        0x34283f -> :sswitch_b6
        0x35db8e -> :sswitch_aa
        0x360e96 -> :sswitch_9e
        0x3651f5 -> :sswitch_92
        0x3792a4 -> :sswitch_87
        0x379f99 -> :sswitch_7c
        0x379f9c -> :sswitch_70
        0x37c598 -> :sswitch_64
        0x382169 -> :sswitch_59
        0x5c04d90 -> :sswitch_4d
        0x6310998 -> :sswitch_41
        0x65c28d8 -> :sswitch_35
        0x685969e -> :sswitch_29
        0x6cc0c23 -> :sswitch_1e
    .end sparse-switch

    :pswitch_data_38c
    .packed-switch 0x0
        :pswitch_2bf
        :pswitch_2bc
        :pswitch_2bc
        :pswitch_2b9
        :pswitch_2b6
        :pswitch_2b3
        :pswitch_2b3
        :pswitch_2b3
        :pswitch_2b0
        :pswitch_2ad
        :pswitch_2ad
        :pswitch_2ad
        :pswitch_2aa
        :pswitch_2a7
        :pswitch_2a4
        :pswitch_2a1
        :pswitch_2a1
        :pswitch_2a1
        :pswitch_2a1
        :pswitch_2a1
        :pswitch_29e
        :pswitch_29b
        :pswitch_298
        :pswitch_298
        :pswitch_295
        :pswitch_292
        :pswitch_292
        :pswitch_28f
        :pswitch_28c
        :pswitch_28c
        :pswitch_28c
        :pswitch_28c
        :pswitch_28c
        :pswitch_289
        :pswitch_289
        :pswitch_286
        :pswitch_283
        :pswitch_283
        :pswitch_280
        :pswitch_280
        :pswitch_27d
        :pswitch_27a
        :pswitch_277
        :pswitch_277
        :pswitch_274
        :pswitch_271
        :pswitch_26e
        :pswitch_26b
        :pswitch_268
        :pswitch_268
    .end packed-switch
.end method
