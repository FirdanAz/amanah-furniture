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

  static String? emailValidator(value) {
    bool emailValidate = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValidate ? 'Email tidak valid' : null;
  }

  static String? passwordValidator(value) {
    return value.toString().length < 8
        ? 'Kata sandi tidak boleh kurang dari 8 karakter'
        : null;
  }
}
