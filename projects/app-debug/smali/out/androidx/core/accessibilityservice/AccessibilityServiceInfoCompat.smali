.class public final Landroidx/core/accessibilityservice/AccessibilityServiceInfoCompat;
.super Ljava/lang/Object;
.source "AccessibilityServiceInfoCompat.java"


# static fields
.field public static final CAPABILITY_CAN_FILTER_KEY_EVENTS:I = 0x8

.field public static final CAPABILITY_CAN_REQUEST_ENHANCED_WEB_ACCESSIBILITY:I = 0x4

.field public static final CAPABILITY_CAN_REQUEST_TOUCH_EXPLORATION:I = 0x2

.field public static final CAPABILITY_CAN_RETRIEVE_WINDOW_CONTENT:I = 0x1

.field public static final FEEDBACK_ALL_MASK:I = -0x1

.field public static final FEEDBACK_BRAILLE:I = 0x20

.field public static final FLAG_INCLUDE_NOT_IMPORTANT_VIEWS:I = 0x2

.field public static final FLAG_REPORT_VIEW_IDS:I = 0x10

.field public static final FLAG_REQUEST_ENHANCED_WEB_ACCESSIBILITY:I = 0x8

.field public static final FLAG_REQUEST_FILTER_KEY_EVENTS:I = 0x20

.field public static final FLAG_REQUEST_TOUCH_EXPLORATION_MODE:I = 0x4


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 181
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static capabilityToString(I)Ljava/lang/String;
    .registers 2
    .param p0, "capability"    # I

    .line 298
    sparse-switch p0, :sswitch_data_12

    .line 308
    const-string v0, "UNKNOWN"

    return-object v0

    .line 306
    :sswitch_6
    const-string v0, "CAPABILITY_CAN_FILTER_KEY_EVENTS"

    return-object v0

    .line 304
    :sswitch_9
    const-string v0, "CAPABILITY_CAN_REQUEST_ENHANCED_WEB_ACCESSIBILITY"

    return-object v0

    .line 302
    :sswitch_c
    const-string v0, "CAPABILITY_CAN_REQUEST_TOUCH_EXPLORATION"

    return-object v0

    .line 300
    :sswitch_f
    const-string v0, "CAPABILITY_CAN_RETRIEVE_WINDOW_CONTENT"

    return-object v0

    :sswitch_data_12
    .sparse-switch
        0x1 -> :sswitch_f
        0x2 -> :sswitch_c
        0x4 -> :sswitch_9
        0x8 -> :sswitch_6
    .end sparse-switch
.end method

.method public static feedbackTypeToString(I)Ljava/lang/String;
    .registers 5
    .param p0, "feedbackType"    # I

    .line 212
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 213
    .local v0, "builder":Ljava/lang/StringBuilder;
    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 214
    :goto_a
    if-lez p0, :cond_43

    .line 215
    invoke-static {p0}, Ljava/lang/Integer;->numberOfTrailingZeros(I)I

    move-result v1

    const/4 v2, 0x1

    shl-int v1, v2, v1

    .line 216
    .local v1, "feedbackTypeFlag":I
    not-int v3, v1

    and-int/2addr p0, v3

    .line 217
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-le v3, v2, :cond_20

    .line 218
    const-string v2, ", "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 220
    :cond_20
    sparse-switch v1, :sswitch_data_4e

    goto :goto_42

    .line 228
    :sswitch_24
    const-string v2, "FEEDBACK_GENERIC"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 229
    goto :goto_42

    .line 234
    :sswitch_2a
    const-string v2, "FEEDBACK_VISUAL"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_42

    .line 222
    :sswitch_30
    const-string v2, "FEEDBACK_AUDIBLE"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 223
    goto :goto_42

    .line 225
    :sswitch_36
    const-string v2, "FEEDBACK_HAPTIC"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 226
    goto :goto_42

    .line 231
    :sswitch_3c
    const-string v2, "FEEDBACK_SPOKEN"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    nop

    .line 237
    .end local v1    # "feedbackTypeFlag":I
    :goto_42
    goto :goto_a

    .line 238
    :cond_43
    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 239
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    nop

    :sswitch_data_4e
    .sparse-switch
        0x1 -> :sswitch_3c
        0x2 -> :sswitch_36
        0x4 -> :sswitch_30
        0x8 -> :sswitch_2a
        0x10 -> :sswitch_24
    .end sparse-switch
.end method

.method public static flagToString(I)Ljava/lang/String;
    .registers 2
    .param p0, "flag"    # I

    .line 251
    sparse-switch p0, :sswitch_data_18

    .line 265
    const/4 v0, 0x0

    return-object v0

    .line 263
    :sswitch_5
    const-string v0, "FLAG_REQUEST_FILTER_KEY_EVENTS"

    return-object v0

    .line 261
    :sswitch_8
    const-string v0, "FLAG_REPORT_VIEW_IDS"

    return-object v0

    .line 259
    :sswitch_b
    const-string v0, "FLAG_REQUEST_ENHANCED_WEB_ACCESSIBILITY"

    return-object v0

    .line 257
    :sswitch_e
    const-string v0, "FLAG_REQUEST_TOUCH_EXPLORATION_MODE"

    return-object v0

    .line 255
    :sswitch_11
    const-string v0, "FLAG_INCLUDE_NOT_IMPORTANT_VIEWS"

    return-object v0

    .line 253
    :sswitch_14
    const-string v0, "DEFAULT"

    return-object v0

    nop

    :sswitch_data_18
    .sparse-switch
        0x1 -> :sswitch_14
        0x2 -> :sswitch_11
        0x4 -> :sswitch_e
        0x8 -> :sswitch_b
        0x10 -> :sswitch_8
        0x20 -> :sswitch_5
    .end sparse-switch
.end method

.method public static getCapabilities(Landroid/accessibilityservice/AccessibilityServiceInfo;)I
    .registers 2
    .param p0, "info"    # Landroid/accessibilityservice/AccessibilityServiceInfo;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "info.getCapabilities()"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 286
    invoke-virtual {p0}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v0

    return v0
.end method

.method public static loadDescription(Landroid/accessibilityservice/AccessibilityServiceInfo;Landroid/content/pm/PackageManager;)Ljava/lang/String;
    .registers 3
    .param p0, "info"    # Landroid/accessibilityservice/AccessibilityServiceInfo;
    .param p1, "packageManager"    # Landroid/content/pm/PackageManager;
    .annotation runtime Landroidx/annotation/ReplaceWith;
        expression = "info.loadDescription(packageManager)"
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 200
    invoke-virtual {p0, p1}, Landroid/accessibilityservice/AccessibilityServiceInfo;->loadDescription(Landroid/content/pm/PackageManager;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
