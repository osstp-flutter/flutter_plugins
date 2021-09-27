import 'package:plugins/plugins_sample/adaptive_theme/cupertino_example.dart';
import 'package:plugins/plugins_sample/adaptive_theme/material_example.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// App初始化时候获取主题色
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final savedThemeMode = await AdaptiveTheme.getThemeMode();
//   runApp(AdaptiveThemePage(savedThemeMode: savedThemeMode));
// }

class AdaptiveThemePage extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const AdaptiveThemePage({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  _AdaptiveThemePageppState createState() => _AdaptiveThemePageppState();
}

class _AdaptiveThemePageppState extends State<AdaptiveThemePage> {
  bool isMaterial = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: isMaterial
          ? MaterialExample(
              savedThemeMode: widget.savedThemeMode,
              onChanged: () => setState(() => isMaterial = false))
          : CupertinoExample(
              savedThemeMode: widget.savedThemeMode,
              onChanged: () => setState(() => isMaterial = true)),
    );
  }
}
