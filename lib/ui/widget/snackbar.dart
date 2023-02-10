import 'package:flutter/material.dart';
import 'package:amanah_furniture/common/color_app.dart';

SnackBar _getSnackBar({
  required Widget content,
  Color? color,
  Duration? duration,
}) {
  return SnackBar(
    content: content,
    duration: duration ?? const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    backgroundColor: color ?? ColorApp.primary,
  );
}

void showSnackBar(
  BuildContext context, {
  required Widget content,
  Color? color,
  Duration? duration,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(
        duration: duration,
        color: color,
        content: content,
      ),
    );
