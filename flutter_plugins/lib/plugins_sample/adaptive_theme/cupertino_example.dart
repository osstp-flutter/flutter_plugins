import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoExample extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const CupertinoExample(
      {Key? key, this.savedThemeMode, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAdaptiveTheme(
      light: CupertinoThemeData(brightness: Brightness.light),
      dark: CupertinoThemeData(brightness: Brightness.dark),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme) => CupertinoApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        home: SettingPage(onChanged: onChanged),
      ),
    );
  }
}

class SettingPage extends StatefulWidget {
  final VoidCallback onChanged;

  const SettingPage({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Example'),
      ),
      child: SafeArea(
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Current Theme Mode',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                CupertinoAdaptiveTheme.of(context).mode.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  height: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              CupertinoButton.filled(
                onPressed: () =>
                    CupertinoAdaptiveTheme.of(context).toggleThemeMode(),
                child: Text('Toggle Theme Mode'),
              ),
              SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () => CupertinoAdaptiveTheme.of(context).setDark(),
                child: Text('Set Dark'),
              ),
              SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () => CupertinoAdaptiveTheme.of(context).setLight(),
                child: Text('set Light'),
              ),
              SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: () => CupertinoAdaptiveTheme.of(context).setSystem(),
                child: Text('Set System Default'),
              ),
              Spacer(flex: 2),
              CupertinoButton(
                onPressed: widget.onChanged,
                child: Text('Switch to Material'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
