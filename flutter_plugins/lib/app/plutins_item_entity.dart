import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PluginsItemEntity {
  PluginsItemEntity(
      {required this.icon,
      required this.title,
      required this.version,
      required this.gitUrl,
      required this.pubUrl,
      required this.supportPlatform,
      required this.description,
      required this.updateContent,
      required this.updateTime,
      required this.widgetBuilder,
      required this.router,
      required this.type});

  PluginsItemEntity.fromJson(Map<String, dynamic> json) {
    icon = json['icon'] as String;
    title = json['title'] as String;
    version = json['version'] as String;
    gitUrl = json['gitUrl'] as String;
    pubUrl = json['pubUrl'] as String;
    supportPlatform = json['supportPlatform'] as String;
    description = json['description'] as String;
    updateContent = json['updateContent'] as String;
    updateTime = json['updateTime'] as String;
    widgetBuilder = json['widgetBuilder'] as WidgetBuilder;
    router = json['router'] as String;
    type = json['type'] as int;
  }

  late String icon;
  late String title; //标题
  late String version; //插件版本
  late String gitUrl; //插件gitUrl
  late String pubUrl; //插件pubUrl
  late String supportPlatform; //支持环境
  late String description; //描述
  late String updateContent; //更新内容
  late String updateTime; //更新时间
  late String contribution; //贡献人
  late WidgetBuilder widgetBuilder; // Navigator导航跳转
  late String router; //路由配置 fluro框架跳转
  late int type;//当前没有利用

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['version'] = version;
    data['gitUrl'] = gitUrl;
    data['pubUrl'] = pubUrl;
    data['supportPlatform'] = supportPlatform;
    data['description'] = description;
    data['updateContent'] = updateContent;
    data['updateTime'] = updateTime;
    data['widgetBuilder'] = widgetBuilder;
    data['router'] = router;
    data['type'] = type;
    return data;
  }
}
