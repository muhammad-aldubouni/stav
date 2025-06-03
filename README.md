<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

stav is a minimalist flutter package that streamlines MVVM architecture with explicit control over the view model lifecycle, simplifies state management, and enables dynamic theming across Material, Cupertino, and Fluent design languages.

## Features

🟢 easy MVVM and state management  
🟢 explicit control of view models lifecycle  
🟢 straightforward service locator for registering services and view models  
🟢 simple way to deal with theming for Material, Cupertino, and Fluent design languages  


## Getting started

Add `stav` to your `pubspec.yaml` dependencies and run `flutter pub get`.

```yaml
dependencies:
  stav:
    git:
        url: "https://github.com/muhammad-aldubouni/stav.git"
```

## Usage

### 1. Import the package

```dart
import 'package:stav/stav.dart';
```

### 2. Create your ViewModel

Every property should be a `Notifier<T>`:

```dart
class CounterViewModel extends BaseViewModel<CounterViewModel> {
  final Notifier<int> count = Notifier<int>(0);

  @override
  CounterViewModel get newInstance => CounterViewModel();

  void increment() {
    count.value++;
    count.notifyChange();
  }
}
```

### 3. Register your ViewModel

```dart
ServicesLocator.registerViewModel(CounterViewModel());
```

### 4. Use Observer for reactive UI

```dart
Observer<int>(
  notifier: ServicesLocator.getViewModel<CounterViewModel>().count,
  builder: () => Text(
    '${ServicesLocator.getViewModel<CounterViewModel>().count.value}',
  ),
)
```

### 5. Theming

Set or switch themes using the `App` class:

```dart
final app = App();
app.materialDarkTheme = ThemeData.dark();
app.materialLightTheme = ThemeData.light();
app.useSystemTheme(); // or app.useDarkTheme(), app.useLightTheme()
```

### 6. Start your app

```dart
void main() {
  final app = App();
  app.run(appRoot: () => MyHomePage());
}
```
### 7. Navigate

```dart
ServicesLocator.getViewModel<CounterViewModel>().navigateTo(
  navigate: <Your Navigation Function>,
  preserveViewModel: true,
);
```
## Additional information

When using `stav`, try to import (material.dart, cupertino.dart, fluent.dart) from the `ui_designs` part of the package as shown:

```dart
import 'package:stav/ui_designs/material.dart';
```