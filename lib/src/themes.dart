import 'package:stav/ui_designs/fluent.dart';
import 'package:stav/ui_designs/cupertino.dart';
import 'package:stav/ui_designs/material.dart';
import 'package:stav/src/app_attributes.dart';

class Themes {
  static ThemeData get materialTheme => ThemingAttributes.materialTheme;
  static CupertinoThemeData get cupertinoTheme =>
      ThemingAttributes.cupertinoTheme;
  static FluentThemeData get fluentTheme => ThemingAttributes.fluentTheme;
}
