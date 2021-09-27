import 'package:plugins/app/plutins_item_entity.dart';
import 'package:plugins/plugins_sample/adaptive_theme/adaptive_theme_page.dart';
import 'package:plugins/plugins_sample/animated_text_kit/animated_text_kit_page.dart';
import 'package:plugins/plugins_sample/easy_loading/easy_loading_page.dart';
import 'package:plugins/plugins_sample/webview_flutter/webview_flutter_page.dart';
import 'package:plugins/routers/routers_config.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// others模块 分类1 路由集合
List<Map<String, WidgetBuilder>> othersRouters() {
  // 将数据构造成内容
  List<Map<String, WidgetBuilder>> list = [];
  Map<String, WidgetBuilder> result = Map();
  List.generate(othersWidgetBuilderEntityList.length, (index) {
    PluginsItemEntity tempEntity = othersWidgetBuilderEntityList[index];
    result.addAll({tempEntity.title: tempEntity.widgetBuilder});
  });

  list.add(result);
  return list;
}

List<PluginsItemEntity> othersWidgetBuilderEntityList = [
  PluginsItemEntity(
      icon: '',
      title: 'adaptive_theme',
      version: '^2.2.0',
      gitUrl: 'https://github.com/BirjuVachhani/adaptive_theme.git',
      pubUrl: 'https://pub.dev/packages/adaptive_theme',
      supportPlatform: 'FLUTTER ANDROID IOS LINUX MACOS WEB WINDOWS',
      description: '主题管理插件',
      updateContent: '',
      updateTime: '2021.08.28',
      widgetBuilder: (context) {
        return AdaptiveThemePage();
      },
      router: Routes.adaptiveThemePage,
      type: 2),
  PluginsItemEntity(
      icon: '',
      title: 'webview_flutter',
      version: '^2.0.12',
      gitUrl: '',
      pubUrl: 'https://pub.dev/packages/webview_flutter',
      supportPlatform: 'FLUTTER ANDROID IOS',
      description: 'iOS WKWebView, Android WebView',
      updateContent: '',
      updateTime: '',
      widgetBuilder: (context) {
        return WebViewExample();
      },
      router: Routes.webViewFlutter,
      type: 2),
  PluginsItemEntity(
      icon: '',
      title: 'flutter_easyloading',
      version: '^3.0.3',
      gitUrl: 'https://github.com/nslog11/flutter_easyloading.git',
      pubUrl: 'https://pub.dev/packages/flutter_easyloading',
      supportPlatform: 'FLUTTER ANDROID IOS LINUX MACOS WEB WINDOWS',
      description: '自定义loading动画,toast',
      updateContent: '',
      updateTime: '2021.08.30',
      widgetBuilder: (context) {
        return FlutterEasyLoadingPage();
      },
      router: Routes.flutterEasyLoading,
      type: 2),
  PluginsItemEntity(
      icon: '',
      title: 'animated_text_kit',
      version: '^4.2.1',
      gitUrl: 'https://github.com/aagarwal1012/Animated-Text-Kit',
      pubUrl: 'https://pub.dev/packages/animated_text_kit/versions',
      supportPlatform: 'FLUTTER ANDROID IOS LINUX MACOS WEB WINDOWS',
      description: '自定义loading动画,toast',
      updateContent: '',
      updateTime: '2021.09.17',
      widgetBuilder: (context) {
        return AnimatedTextKitPage();
      },
      router: Routes.animatedTextKit,
      type: 2),
];
