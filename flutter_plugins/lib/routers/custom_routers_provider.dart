import 'package:plugins/app/plutins_item_entity.dart';
import 'package:plugins/plugins_sample/adaptive_theme/adaptive_theme_page.dart';
import 'package:plugins/plugins_sample/webview_flutter/webview_flutter_page.dart';
import 'package:plugins/routers/routers_config.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// others模块 分类1 路由集合
customRouters() {
  //
  Map<String, WidgetBuilder> result = Map();
  List.generate(customWidgetBuilderEntityList.length, (index) {
    PluginsItemEntity tempEntity = customWidgetBuilderEntityList[index];
    result.addAll({tempEntity.title: tempEntity.widgetBuilder});
  });




  // 将数据构造成内容
  List<Map<String, WidgetBuilder>> list = [];
  list.add(result);
  return list;
}

List<PluginsItemEntity> customWidgetBuilderEntityList = [
  PluginsItemEntity(
      icon: '',
      title: 'no found page',
      version: '^1.1.0',
      gitUrl: '',
      pubUrl: '',
      supportPlatform: 'FLUTTER ANDROID IOS',
      description: 'empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty empty',
      updateContent: 'updateContent',
      updateTime: '2021.02.05',
      widgetBuilder: (context) {
        return WebViewExample();
      },
      router: 'ffheufheuhf',
      type: 2),
];
