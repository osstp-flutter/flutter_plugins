// Author: Birju Vachhani
// Created Date: April 16, 2021

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class MaterialExample extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const MaterialExample(
      {Key? key, this.savedThemeMode, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      dark:
          // getTheme(),
          ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: SettingPage(onChanged: onChanged),
        builder: (BuildContext context, widget) => SettingPage(onChanged: onChanged),
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
    return AnimatedTheme(
      duration: Duration(milliseconds: 300),
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Material Example'),
        ),
        body: SafeArea(
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
                  AdaptiveTheme.of(context).mode.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    height: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => AdaptiveTheme.of(context).toggleThemeMode(),
                  child: Text('Toggle Theme Mode'),
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: 4, vertical: 2),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => AdaptiveTheme.of(context).setDark(),
                  child: Text('Set Dark'),
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: 4, vertical: 2),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => AdaptiveTheme.of(context).setLight(),
                  child: Text('set Light'),
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: 4, vertical: 2),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => AdaptiveTheme.of(context).setSystem(),
                  child: Text('Set System Default'),
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: 4, vertical: 2),
                  ),
                ),
                Spacer(flex: 2),
                TextButton(
                  onPressed: widget.onChanged,
                  child: Text('Switch to Material'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
