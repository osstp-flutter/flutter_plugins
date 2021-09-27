import 'package:plugins/app/utils/styles_utils.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AdaptiveThemeMode? savedThemeMode;

class ThemeUtils {
  static bool isDart() {
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }

  static Color? getIconColor(BuildContext context) {
    return ThemeUtils.isDart()
        ? Colours.bg_gray
        : Colors.white;
  }

  static Color? getTextColor(BuildContext context) {
    return ThemeUtils.isDart() ? Colours.dark_text : Colours.text;
  }

  static Color? getTextSelectionThemeCursorColor(BuildContext context) {
    return Theme.of(context).textSelectionTheme.cursorColor;
  }


}

/// 自定义主题色
ThemeData getTheme({bool isDarkMode = false}) {
  return ThemeData(
    errorColor: isDarkMode ? Colours.dark_red : Colours.red,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: isDarkMode ? Colours.dark_bg_color : Colours.app_main,
    accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
    // Tab指示器颜色
    indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
    // 页面背景色
    scaffoldBackgroundColor:
        isDarkMode ? Colours.dark_bg_color : Colors.white,
    // 主要用于Material背景色
    canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
    // 文字选择色（输入框选择文字等）
    // textSelectionColor: Colours.app_main.withAlpha(70),
    // textSelectionHandleColor: Colours.app_main,
    // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colours.app_main.withAlpha(70),
      selectionHandleColor: Colours.app_main,
      cursorColor: Colours.app_main,
    ),
    textTheme: TextTheme(
      // TextField输入文字颜色
      subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
      // Text文字样式
      bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,
      subtitle2: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
    ),
    appBarTheme: AppBarTheme(
      elevation: 5.0,
      color: isDarkMode ? Colours.dark_bg_color : Colours.app_main,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 5.0,
      color: isDarkMode ? Colours.dark_bg_color : Colours.app_main,
    ),
    dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6),
    // cupertinoOverrideTheme: CupertinoThemeData(
    //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
    // ),
    // pageTransitionsTheme: NoTransitionsOnWeb(),
    visualDensity: VisualDensity
        .standard, // https://github.com/flutter/flutter/issues/77142
  );
}
