.class Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;
.super Lorg/apache/cordova/ConfigXmlParser;
.source "AllowListPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/cordova/AllowListPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CustomConfigXmlParser"
.end annotation


# instance fields
.field private prefs:Lorg/apache/cordova/CordovaPreferences;

.field final synthetic this$0:Lorg/apache/cordova/AllowListPlugin;


# direct methods
.method private constructor <init>(Lorg/apache/cordova/AllowListPlugin;)V
    .registers 2

    .line 76
    iput-object p1, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-direct {p0}, Lorg/apache/cordova/ConfigXmlParser;-><init>()V

    .line 77
    new-instance p1, Lorg/apache/cordova/CordovaPreferences;

    invoke-direct {p1}, Lorg/apache/cordova/CordovaPreferences;-><init>()V

    iput-object p1, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->prefs:Lorg/apache/cordova/CordovaPreferences;

    return-void
.end method

.method synthetic constructor <init>(Lorg/apache/cordova/AllowListPlugin;Lorg/apache/cordova/AllowListPlugin-IA;)V
    .registers 3

    invoke-direct {p0, p1}, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;-><init>(Lorg/apache/cordova/AllowListPlugin;)V

    return-void
.end method


# virtual methods
.method public handleEndTag(Lorg/xmlpull/v1/XmlPullParser;)V
    .registers 2
    .param p1, "xml"    # Lorg/xmlpull/v1/XmlPullParser;

    .line 113
    return-void
.end method

.method public handleStartTag(Lorg/xmlpull/v1/XmlPullParser;)V
    .registers 10
    .param p1, "xml"    # Lorg/xmlpull/v1/XmlPullParser;

    .line 81
    invoke-interface {p1}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v0

    .line 82
    .local v0, "strNode":Ljava/lang/String;
    const-string v1, "content"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    if-eqz v1, :cond_1f

    .line 83
    const-string v1, "src"

    invoke-interface {p1, v2, v1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 84
    .local v1, "startPage":Ljava/lang/String;
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedNavigations(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v1, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .line 85
    .end local v1    # "startPage":Ljava/lang/String;
    goto/16 :goto_bc

    :cond_1f
    const-string v1, "allow-navigation"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const-string v4, "https://*/*"

    const-string v5, "http://*/*"

    const-string v6, "*"

    const-string v7, "href"

    if-eqz v1, :cond_61

    .line 86
    invoke-interface {p1, v2, v7}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 87
    .local v1, "origin":Ljava/lang/String;
    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_57

    .line 88
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedNavigations(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v5, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .line 89
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedNavigations(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v4, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .line 90
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedNavigations(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    const-string v4, "data:*"

    invoke-virtual {v2, v4, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    goto :goto_60

    .line 92
    :cond_57
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedNavigations(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v1, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .line 94
    .end local v1    # "origin":Ljava/lang/String;
    :goto_60
    goto :goto_bc

    :cond_61
    const-string v1, "allow-intent"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_77

    .line 95
    invoke-interface {p1, v2, v7}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 96
    .restart local v1    # "origin":Ljava/lang/String;
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedIntents(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v1, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .end local v1    # "origin":Ljava/lang/String;
    goto :goto_bb

    .line 97
    :cond_77
    const-string v1, "access"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_bb

    .line 98
    const-string v1, "origin"

    invoke-interface {p1, v2, v1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 100
    .restart local v1    # "origin":Ljava/lang/String;
    if-eqz v1, :cond_bc

    .line 101
    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_a0

    .line 102
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedRequests(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v5, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    .line 103
    iget-object v2, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v2}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedRequests(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v2

    invoke-virtual {v2, v4, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    goto :goto_bc

    .line 105
    :cond_a0
    const-string v4, "subdomains"

    invoke-interface {p1, v2, v4}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 106
    .local v2, "subdomains":Ljava/lang/String;
    iget-object v4, p0, Lorg/apache/cordova/AllowListPlugin$CustomConfigXmlParser;->this$0:Lorg/apache/cordova/AllowListPlugin;

    invoke-static {v4}, Lorg/apache/cordova/AllowListPlugin;->-$$Nest$fgetallowedRequests(Lorg/apache/cordova/AllowListPlugin;)Lorg/apache/cordova/AllowList;

    move-result-object v4

    if-eqz v2, :cond_b7

    const-string v5, "true"

    invoke-virtual {v2, v5}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v5

    if-nez v5, :cond_b7

    const/4 v3, 0x1

    :cond_b7
    invoke-virtual {v4, v1, v3}, Lorg/apache/cordova/AllowList;->addAllowListEntry(Ljava/lang/String;Z)V

    goto :goto_bc

    .line 97
    .end local v1    # "origin":Ljava/lang/String;
    .end local v2    # "subdomains":Ljava/lang/String;
    :cond_bb
    :goto_bb
    nop

    .line 110
    :cond_bc
    :goto_bc
    return-void
.end method
