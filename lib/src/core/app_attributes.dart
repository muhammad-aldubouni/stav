import 'dart:ui';
import 'package:flutter/scheduler.dart';

enum ThemeMode { light, dark, system }

class ThemingAttributes {
  static get brightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static dynamic lightTheme;
  static dynamic darkTheme;

  static dynamic theme;

  static void setThemeToLight() => theme = lightTheme;

  static void setThemeToDark() => theme = darkTheme;

  static void syncToSystemTheme() {
    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      ThemingAttributes.setThemeToDark();
    } else {
      ThemingAttributes.setThemeToLight();
    }
  }

  static ThemeMode currentTheme = ThemeMode.system;
}
