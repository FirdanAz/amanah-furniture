import 'package:flutter/material.dart';

/// Digunakan untuk fungsi/method yang digunakan secara global
/// contoh :
/// * urlLauncher
/// * navigator (versi singkat)
class PublicFunction {
  static void navigatorPush(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static void navigatorPushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => widget));
  }

  static void navigatorPushAndRemoved(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }
}
