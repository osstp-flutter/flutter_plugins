import 'package:plugins/app/not_found_page.dart';
import 'package:plugins/routers/router_handle.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final FluroRouter router = FluroRouter();
  static String root = "/";

  static String adaptiveThemePage = "/adaptive_theme";
  static String webViewFlutter = "/webview_flutter";
  static String flutterEasyLoading = "/flutter_easyloading";
  static String animatedTextKit = "/animated_text_kit";

  static void configureRoutes(FluroRouter rou) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return const NotFoundPage();
        });
    router.define(adaptiveThemePage, handler: adaptiveThemePageHandler);
    router.define(webViewFlutter, handler: webViewExampleHandler);
    router.define(flutterEasyLoading, handler: flutter_easyloadingHandler);
    router.define(animatedTextKit, handler: animatedTextKitHandler);

  }
}

// Map<String, WidgetBuilder> totalRouters() {
//   return othersRouters();
// }