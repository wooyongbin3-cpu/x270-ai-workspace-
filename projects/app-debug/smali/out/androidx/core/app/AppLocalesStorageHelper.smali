.class public Landroidx/core/app/AppLocalesStorageHelper;
.super Ljava/lang/Object;
.source "AppLocalesStorageHelper.java"


# static fields
.field static final APPLICATION_LOCALES_RECORD_FILE:Ljava/lang/String; = "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

.field static final DEBUG:Z = false

.field static final LOCALE_RECORD_ATTRIBUTE_TAG:Ljava/lang/String; = "application_locales"

.field static final LOCALE_RECORD_FILE_TAG:Ljava/lang/String; = "locales"

.field static final TAG:Ljava/lang/String; = "AppLocalesStorageHelper"

.field private static final sAppLocaleStorageSync:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 50
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Landroidx/core/app/AppLocalesStorageHelper;->sAppLocaleStorageSync:Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static persistLocales(Landroid/content/Context;Ljava/lang/String;)V
    .registers 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "locales"    # Ljava/lang/String;

    .line 121
    sget-object v0, Landroidx/core/app/AppLocalesStorageHelper;->sAppLocaleStorageSync:Ljava/lang/Object;

    monitor-enter v0

    .line 122
    :try_start_3
    const-string v1, ""

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_12

    .line 123
    const-string v1, "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    invoke-virtual {p0, v1}, Landroid/content/Context;->deleteFile(Ljava/lang/String;)Z

    .line 124
    monitor-exit v0
    :try_end_11
    .catchall {:try_start_3 .. :try_end_11} :catchall_73

    return-void

    .line 129
    :cond_12
    :try_start_12
    const-string v1, "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->openFileOutput(Ljava/lang/String;I)Ljava/io/FileOutputStream;

    move-result-object v1
    :try_end_19
    .catch Ljava/io/FileNotFoundException; {:try_start_12 .. :try_end_19} :catch_5f
    .catchall {:try_start_12 .. :try_end_19} :catchall_73

    .line 134
    .local v1, "fos":Ljava/io/FileOutputStream;
    nop

    .line 135
    :try_start_1a
    invoke-static {}, Landroid/util/Xml;->newSerializer()Lorg/xmlpull/v1/XmlSerializer;

    move-result-object v2
    :try_end_1e
    .catchall {:try_start_1a .. :try_end_1e} :catchall_73

    .line 137
    .local v2, "serializer":Lorg/xmlpull/v1/XmlSerializer;
    const/4 v3, 0x0

    :try_start_1f
    invoke-interface {v2, v1, v3}, Lorg/xmlpull/v1/XmlSerializer;->setOutput(Ljava/io/OutputStream;Ljava/lang/String;)V

    .line 138
    const-string v4, "UTF-8"

    const/4 v5, 0x1

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-interface {v2, v4, v5}, Lorg/xmlpull/v1/XmlSerializer;->startDocument(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 139
    const-string v4, "locales"

    invoke-interface {v2, v3, v4}, Lorg/xmlpull/v1/XmlSerializer;->startTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    .line 140
    const-string v4, "application_locales"

    invoke-interface {v2, v3, v4, p1}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    .line 141
    const-string v4, "locales"

    invoke-interface {v2, v3, v4}, Lorg/xmlpull/v1/XmlSerializer;->endTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    .line 142
    invoke-interface {v2}, Lorg/xmlpull/v1/XmlSerializer;->endDocument()V
    :try_end_3e
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_3e} :catch_43
    .catchall {:try_start_1f .. :try_end_3e} :catchall_41

    .line 151
    if-eqz v1, :cond_54

    .line 153
    goto :goto_4e

    .line 151
    :catchall_41
    move-exception v3

    goto :goto_56

    .line 147
    :catch_43
    move-exception v3

    .line 148
    .local v3, "e":Ljava/lang/Exception;
    :try_start_44
    const-string v4, "AppLocalesStorageHelper"

    const-string v5, "Storing App Locales : Failed to persist app-locales in storage "

    invoke-static {v4, v5, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4b
    .catchall {:try_start_44 .. :try_end_4b} :catchall_41

    .line 151
    nop

    .end local v3    # "e":Ljava/lang/Exception;
    if-eqz v1, :cond_54

    .line 153
    :goto_4e
    :try_start_4e
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_51
    .catch Ljava/io/IOException; {:try_start_4e .. :try_end_51} :catch_52
    .catchall {:try_start_4e .. :try_end_51} :catchall_73

    .line 156
    :goto_51
    goto :goto_54

    .line 154
    :catch_52
    move-exception v3

    goto :goto_51

    .line 159
    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .end local v2    # "serializer":Lorg/xmlpull/v1/XmlSerializer;
    :cond_54
    :goto_54
    :try_start_54
    monitor-exit v0
    :try_end_55
    .catchall {:try_start_54 .. :try_end_55} :catchall_73

    .line 160
    return-void

    .line 151
    .restart local v1    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "serializer":Lorg/xmlpull/v1/XmlSerializer;
    :goto_56
    if-eqz v1, :cond_5d

    .line 153
    :try_start_58
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_5b
    .catch Ljava/io/IOException; {:try_start_58 .. :try_end_5b} :catch_5c
    .catchall {:try_start_58 .. :try_end_5b} :catchall_73

    .line 156
    goto :goto_5d

    .line 154
    :catch_5c
    move-exception v4

    .line 158
    :cond_5d
    :goto_5d
    nop

    .end local p0    # "context":Landroid/content/Context;
    .end local p1    # "locales":Ljava/lang/String;
    :try_start_5e
    throw v3

    .line 130
    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .end local v2    # "serializer":Lorg/xmlpull/v1/XmlSerializer;
    .restart local p0    # "context":Landroid/content/Context;
    .restart local p1    # "locales":Ljava/lang/String;
    :catch_5f
    move-exception v1

    .line 131
    .local v1, "fnfe":Ljava/io/FileNotFoundException;
    const-string v2, "AppLocalesStorageHelper"

    const-string v3, "Storing App Locales : FileNotFoundException: Cannot open file %s for writing "

    const-string v4, "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    monitor-exit v0

    return-void

    .line 159
    .end local v1    # "fnfe":Ljava/io/FileNotFoundException;
    :catchall_73
    move-exception v1

    monitor-exit v0
    :try_end_75
    .catchall {:try_start_5e .. :try_end_75} :catchall_73

    throw v1
.end method

.method public static readLocales(Landroid/content/Context;)Ljava/lang/String;
    .registers 10
    .param p0, "context"    # Landroid/content/Context;

    .line 58
    sget-object v0, Landroidx/core/app/AppLocalesStorageHelper;->sAppLocaleStorageSync:Ljava/lang/Object;

    monitor-enter v0

    .line 59
    :try_start_3
    const-string v1, ""
    :try_end_5
    .catchall {:try_start_3 .. :try_end_5} :catchall_78

    .line 63
    .local v1, "appLocales":Ljava/lang/String;
    :try_start_5
    const-string v2, "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    invoke-virtual {p0, v2}, Landroid/content/Context;->openFileInput(Ljava/lang/String;)Ljava/io/FileInputStream;

    move-result-object v2
    :try_end_b
    .catch Ljava/io/FileNotFoundException; {:try_start_5 .. :try_end_b} :catch_75
    .catchall {:try_start_5 .. :try_end_b} :catchall_78

    .line 70
    .local v2, "fis":Ljava/io/FileInputStream;
    nop

    .line 72
    :try_start_c
    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v3

    .line 73
    .local v3, "parser":Lorg/xmlpull/v1/XmlPullParser;
    const-string v4, "UTF-8"

    invoke-interface {v3, v2, v4}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 75
    invoke-interface {v3}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v4

    .line 76
    .local v4, "outerDepth":I
    :cond_19
    :goto_19
    invoke-interface {v3}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v5

    move v6, v5

    .local v6, "type":I
    const/4 v7, 0x1

    if-eq v5, v7, :cond_46

    const/4 v5, 0x3

    if-ne v6, v5, :cond_2a

    .line 77
    invoke-interface {v3}, Lorg/xmlpull/v1/XmlPullParser;->getDepth()I

    move-result v7

    if-le v7, v4, :cond_46

    .line 78
    :cond_2a
    if-eq v6, v5, :cond_19

    const/4 v5, 0x4

    if-ne v6, v5, :cond_30

    .line 79
    goto :goto_19

    .line 82
    :cond_30
    invoke-interface {v3}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v5

    .line 83
    .local v5, "tagName":Ljava/lang/String;
    const-string v7, "locales"

    invoke-virtual {v5, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_45

    .line 84
    const-string v7, "application_locales"

    const/4 v8, 0x0

    invoke-interface {v3, v8, v7}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7
    :try_end_43
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_c .. :try_end_43} :catch_52
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_43} :catch_50
    .catchall {:try_start_c .. :try_end_43} :catchall_4e

    .line 86
    .end local v1    # "appLocales":Ljava/lang/String;
    .local v7, "appLocales":Ljava/lang/String;
    move-object v1, v7

    goto :goto_46

    .line 88
    .end local v5    # "tagName":Ljava/lang/String;
    .end local v7    # "appLocales":Ljava/lang/String;
    .restart local v1    # "appLocales":Ljava/lang/String;
    :cond_45
    goto :goto_19

    .line 94
    .end local v3    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v4    # "outerDepth":I
    .end local v6    # "type":I
    :cond_46
    :goto_46
    if-eqz v2, :cond_5e

    .line 96
    :goto_48
    :try_start_48
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_4b
    .catch Ljava/io/IOException; {:try_start_48 .. :try_end_4b} :catch_4c
    .catchall {:try_start_48 .. :try_end_4b} :catchall_78

    .line 99
    :goto_4b
    goto :goto_5e

    .line 97
    :catch_4c
    move-exception v3

    goto :goto_4b

    .line 94
    :catchall_4e
    move-exception v3

    goto :goto_6c

    .line 89
    :catch_50
    move-exception v3

    goto :goto_53

    :catch_52
    move-exception v3

    .line 90
    .local v3, "e":Ljava/lang/Exception;
    :goto_53
    :try_start_53
    const-string v4, "AppLocalesStorageHelper"

    const-string v5, "Reading app Locales : Unable to parse through file :androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_5a
    .catchall {:try_start_53 .. :try_end_5a} :catchall_4e

    .line 94
    nop

    .end local v3    # "e":Ljava/lang/Exception;
    if-eqz v2, :cond_5e

    .line 96
    goto :goto_48

    .line 103
    :cond_5e
    :goto_5e
    :try_start_5e
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_65

    goto :goto_6a

    .line 111
    :cond_65
    const-string v3, "androidx.appcompat.app.AppCompatDelegate.application_locales_record_file"

    invoke-virtual {p0, v3}, Landroid/content/Context;->deleteFile(Ljava/lang/String;)Z

    .line 113
    :goto_6a
    monitor-exit v0
    :try_end_6b
    .catchall {:try_start_5e .. :try_end_6b} :catchall_78

    return-object v1

    .line 94
    :goto_6c
    if-eqz v2, :cond_73

    .line 96
    :try_start_6e
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_71
    .catch Ljava/io/IOException; {:try_start_6e .. :try_end_71} :catch_72
    .catchall {:try_start_6e .. :try_end_71} :catchall_78

    .line 99
    goto :goto_73

    .line 97
    :catch_72
    move-exception v4

    .line 101
    :cond_73
    :goto_73
    nop

    .end local p0    # "context":Landroid/content/Context;
    :try_start_74
    throw v3

    .line 64
    .end local v2    # "fis":Ljava/io/FileInputStream;
    .restart local p0    # "context":Landroid/content/Context;
    :catch_75
    move-exception v2

    .line 69
    .local v2, "fnfe":Ljava/io/FileNotFoundException;
    monitor-exit v0

    return-object v1

    .line 114
    .end local v1    # "appLocales":Ljava/lang/String;
    .end local v2    # "fnfe":Ljava/io/FileNotFoundException;
    :catchall_78
    move-exception v1

    monitor-exit v0
    :try_end_7a
    .catchall {:try_start_74 .. :try_end_7a} :catchall_78

    throw v1
.end method
