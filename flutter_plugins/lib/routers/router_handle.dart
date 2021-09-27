import 'package:plugins/plugins_sample/adaptive_theme/adaptive_theme_page.dart';
import 'package:plugins/plugins_sample/animated_text_kit/animated_text_kit_page.dart';
import 'package:plugins/plugins_sample/easy_loading/easy_loading_page.dart';
import 'package:plugins/plugins_sample/webview_flutter/webview_flutter_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var adaptiveThemePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return AdaptiveThemePage();
    });
var webViewExampleHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return WebViewExample();
    });
var flutter_easyloadingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return FlutterEasyLoadingPage();
    });
var animatedTextKitHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return AnimatedTextKitPage();
    });



// var demoRouteHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//       String? message = params["message"]?.first;
//       String? colorHex = params["color_hex"]?.first;
//       String? result = params["result"]?.first;
//       Color color = Color(0xFFFFFFFF);
//       if (colorHex != null && colorHex.length > 0) {
//         color = Color(ColorHelpers.fromHexString(colorHex));
//       }
//       return DemoSimpleComponent(
//           message: message ?? 'Testing', color: color, result: result);
//     });
//
// var demoFunctionHandler = Handler(
//     type: HandlerType.function,
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//       String? message = params["message"]?.first;
//       showDialog(
//         context: context!,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               "Hey Hey!",
//               style: TextStyle(
//                 color: const Color(0xFF00D6F7),
//                 fontFamily: "Lazer84",
//                 fontSize: 22.0,
//               ),
//             ),
//             content: Text("$message"),
//             actions: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   child: Text("OK"),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     });

/// Handles deep links into the app
/// To test on Android:
///
/// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.theyakka.fluro`
// var deepLinkHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//       String? colorHex = params["color_hex"]?.first;
//       String? result = params["result"]?.first;
//       Color color = Color(0xFFFFFFFF);
//       if (colorHex != null && colorHex.length > 0) {
//         color = Color(ColorHelpers.fromHexString(colorHex));
//       }
//       return DemoSimpleComponent(
//           message: "DEEEEEP LINK!!!", color: color, result: result);
//     });
