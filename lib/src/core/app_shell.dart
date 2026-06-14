import 'package:flutter/widgets.dart';
import 'package:state_shell/src/core/app_attributes.dart';

Widget Function() _root = () => const Placeholder();

class _AppNotifier extends ValueNotifier<Null> {
  _AppNotifier(super.value);

  void notifyChange() => notifyListeners();
}

final _AppNotifier _updater = _AppNotifier(null);

T appTheme<T>() => ThemingAttributes.theme;

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

  void _update() => _updater.notifyChange();

  set darkTheme(dynamic theme) {
    ThemingAttributes.darkTheme = theme;
    _update();
  }

  set lightTheme(dynamic theme) {
    ThemingAttributes.lightTheme = theme;
    _update();
  }

  get darkTheme => ThemingAttributes.darkTheme;

  get lightTheme => ThemingAttributes.lightTheme;

  String get currentTheme =>
    ThemingAttributes.currentTheme == ThemeMode.light ? "light" : "dark";

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

  void useSystemTheme() {
    ThemingAttributes.currentTheme = ThemeMode.system;
    ThemingAttributes.syncToSystemTheme();
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
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _updater,
    builder: (_, _, _) => _root(),
  );

  @override
  void didChangePlatformBrightness() {
    if (ThemingAttributes.currentTheme == ThemeMode.system) {
      ThemingAttributes.syncToSystemTheme();
      _updater.notifyChange();
    }
    super.didChangePlatformBrightness();
  }
}
