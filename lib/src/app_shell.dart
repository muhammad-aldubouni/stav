import 'package:stav/ui_designs/fluent.dart';
import 'package:stav/ui_designs/cupertino.dart';
import 'package:stav/ui_designs/material.dart';
import 'package:stav/src/app_attributes.dart';

_AppState? _state;
Widget Function() _root = () => const Placeholder();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  void run({Widget Function()? appRoot}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (appRoot != null) {
      _root = appRoot;
    }
    runApp(this);
  }

  void _update() {
    Future.delayed(const Duration(seconds: 0), () async {
      bool isUpdated = false;
      while (!isUpdated) {
        await Future.delayed(const Duration(milliseconds: 1), () {
          if (_state != null) {
            _state?.update();
            isUpdated = true;
          }
        });
      }
    });
  }

  void _currentThemeChanged(ThemeMode changedTheme) {
    if (changedTheme == ThemingAttributes.currentTheme) {
      if (changedTheme == ThemeMode.dark) {
        ThemingAttributes.setThemeToDark();
      } else {
        ThemingAttributes.setThemeToLight();
      }
    } else {
      Brightness currentBrightness =
          changedTheme == ThemeMode.dark ? Brightness.dark : Brightness.light;

      if (ThemingAttributes.currentTheme != ThemeMode.system) {
        return;
      }
      if (ThemingAttributes.brightness == currentBrightness) {
        if (ThemingAttributes.brightness == Brightness.dark) {
          ThemingAttributes.setThemeToDark();
        } else {
          ThemingAttributes.setThemeToLight();
        }
      }
    }
  }

  set materialDarkTheme(ThemeData theme) {
    ThemingAttributes.materialDarkTheme = theme;
    _currentThemeChanged(ThemeMode.dark);
    _update();
  }

  set materialLightTheme(ThemeData theme) {
    ThemingAttributes.materialLightTheme = theme;
    _currentThemeChanged(ThemeMode.light);
    _update();
  }

  set cupertinoDarkTheme(CupertinoThemeData theme) {
    ThemingAttributes.cupertinoDarkTheme = theme;
    _currentThemeChanged(ThemeMode.dark);
    _update();
  }

  set cuoertinoLightTheme(CupertinoThemeData theme) {
    ThemingAttributes.cupertinoLightTheme = theme;
    _currentThemeChanged(ThemeMode.light);
    _update();
  }

  set fluentDarkTheme(FluentThemeData theme) {
    ThemingAttributes.fluentDarkTheme = theme;
    _currentThemeChanged(ThemeMode.dark);
    _update();
  }

  set fluentLightTheme(FluentThemeData theme) {
    ThemingAttributes.fluentLightTheme = theme;
    _currentThemeChanged(ThemeMode.light);
    _update();
  }

  void useLightTheme() {
    ThemingAttributes.currentTheme = ThemeMode.light;
    ThemingAttributes.setThemeToLight();
    _update();
  }

  void useDarkTheme() {
    ThemingAttributes.currentTheme = ThemeMode.dark;
    ThemingAttributes.setThemeToDark();
    _update();
  }

  void toggleTheme() {
    if (ThemingAttributes.currentTheme == ThemeMode.dark) {
      useLightTheme();
    } else if (ThemingAttributes.currentTheme == ThemeMode.light) {
      useDarkTheme();
    } else {
      if (ThemingAttributes.brightness == Brightness.dark) {
        useLightTheme();
      } else {
        useLightTheme();
      }
    }
    _update();
  }

  void useSystemTheme() {
    ThemingAttributes.currentTheme = ThemeMode.system;
    ThemingAttributes.syncToSystemTheme();
    _update();
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    _state = this;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _root();

  @override
  void didChangePlatformBrightness() {
    if (ThemingAttributes.currentTheme == ThemeMode.system) {
      ThemingAttributes.syncToSystemTheme();
      update();
    }
    super.didChangePlatformBrightness();
  }
}
