

## Features

🟢 state management  
🟢 simple way to deal with dynaming theming for any ui package


## Getting started

Add `state_shell` to your `pubspec.yaml` dependencies and run `flutter pub get`.

```yaml
dependencies:
  state_shell:
    git:
        url: "https://github.com/muhammad-aldubouni/state_shell.git"
```

## Usage

### 1. Import the package

```dart
import 'package:stav/stav.dart';
```



### 2. define a notifier 

```dart
Notifier<int> counter = Notifier(0);
```


### 3. Use the Notifier with an Observer to manage state

```dart
Observer(
  notifier: counter,
  builder: () => Text(
    '${count.data}',
  ),
)
```



### 4. Theming

Set or switch themes using the `app` object:

```dart
final app = App();
app.darkTheme = ThemeData.dark();
app.lightTheme = ThemeData.light();
app.useSystemTheme(); // or app.useDarkTheme(), app.useLightTheme()
app.run(appRoot: () => MyHomePage());
```