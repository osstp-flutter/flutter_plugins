import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plugins/plugins_sample/easy_loading/custom_animation.dart';

/// Toast工具类
class EasyLoadingShow {
  static void showToast(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        EasyLoading.showToast(message);
      }
    });
  }
  static void showInfo(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    if (!EasyLoading.isShow) EasyLoading.showInfo(message);
  }
  static void showSuccess(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    if (!EasyLoading.isShow) EasyLoading.showSuccess(message);
  }
  static void showError(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    if (!EasyLoading.isShow) EasyLoading.showError(message);
  }
  static void showStatus(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    if (!EasyLoading.isShow) EasyLoading.show(status: message);
  }
  static void showProgress(String? message, {int duration = 2000}) {
    if (message == null) {
      return;
    }
    if (!EasyLoading.isShow) EasyLoading.showProgress(0.8, status: 'downloading...');
  }

  static void cancelToast({int duration = 1000}) {
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }
}
/// 全局配置
/// userInteractions：loading时是否可交互
void configLoading({bool userInteractions = false}) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = userInteractions
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}