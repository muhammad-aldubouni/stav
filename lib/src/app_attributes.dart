import 'package:stav/ui_designs/fluent.dart';
import 'package:stav/ui_designs/cupertino.dart';
import 'package:stav/ui_designs/material.dart';
import 'package:flutter/scheduler.dart';

class ThemingAttributes {
  static Brightness get brightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static ThemeData materialLightTheme = ThemeData.light();
  static ThemeData materialDarkTheme = ThemeData.dark();

  static CupertinoThemeData cupertinoLightTheme = CupertinoThemeData().copyWith(
    brightness: Brightness.light,
  );
  static CupertinoThemeData cupertinoDarkTheme = CupertinoThemeData().copyWith(
    brightness: Brightness.dark,
  );

  static FluentThemeData fluentLightTheme = FluentThemeData.light();
  static FluentThemeData fluentDarkTheme = FluentThemeData.dark();

  static ThemeData materialTheme = ThemingAttributes.materialDarkTheme;
  static CupertinoThemeData cupertinoTheme =
      ThemingAttributes.cupertinoDarkTheme;
  static FluentThemeData fluentTheme = ThemingAttributes.fluentDarkTheme;

  static void setThemeToLight() {
    ThemingAttributes.materialTheme = ThemingAttributes.materialLightTheme;
    ThemingAttributes.cupertinoTheme = ThemingAttributes.cupertinoLightTheme;
    ThemingAttributes.fluentTheme = ThemingAttributes.fluentLightTheme;
  }

  static void setThemeToDark() {
    ThemingAttributes.materialTheme = ThemingAttributes.materialDarkTheme;
    ThemingAttributes.cupertinoTheme = ThemingAttributes.cupertinoDarkTheme;
    ThemingAttributes.fluentTheme = ThemingAttributes.fluentDarkTheme;
  }

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
