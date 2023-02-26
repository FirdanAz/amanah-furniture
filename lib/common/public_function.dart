import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<bool> removeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(token);
  }

  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}
