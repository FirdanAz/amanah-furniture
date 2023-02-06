import 'package:amanah_furniture/common/color_app.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorApp.accent;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      primaryColor: ColorApp.primary,
      primarySwatch: primaryMaterialColor,
      accentColor: ColorApp.accent,
      brightness: Brightness.light,
    );
  }
}
