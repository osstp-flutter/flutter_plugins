import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plugins/app/not_found_page.dart';
import 'package:plugins/app/utils/theme_utils.dart';
import 'package:plugins/routers/routers_config.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'tabbar_page.dart';
import 'package:get/get.dart';

class ThemeState extends StatelessWidget {
  const ThemeState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: getTheme(isDarkMode: false),
      dark: getTheme(isDarkMode: true),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: 'Plugins',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: MyBottomBarState(),
        // routes: totalRouters(), // 获取所有的路由
        onGenerateRoute: Routes.router.generator,
        localizationsDelegates: [

        ],
        // 因为使用了fluro，这里设置主要针对Web
        onUnknownRoute: (_) {
          return MaterialPageRoute<void>(
            builder: (BuildContext context) => const NotFoundPage(),
          );
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyBottomBarState extends StatefulWidget {
  const MyBottomBarState({Key? key}) : super(key: key);

  @override
  _MyBottomBarStateState createState() => _MyBottomBarStateState();
}

class _MyBottomBarStateState extends State<MyBottomBarState> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: Duration(milliseconds: 200),
      data: Theme.of(context),
      child: BottomBarState(),
    );
  }
}
