import 'package:plugins/app/theme_state.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/app/utils/toast_utils.dart';
import 'package:plugins/routers/routers_config.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 初始配置Routers
    final router = FluroRouter();
    Routes.configureRoutes(router);
    // 配置置loading
    configLoading();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: ThemeState(),
    );
  }
}
