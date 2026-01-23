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

  void incrementMethod1() {
    count.data++;
    count.notifyChange();
  }

  void incrementMethod2() => count.update((data) => data+=1);
}
```

### 3. Register your ViewModel

```dart
ServiceContainer.registerViewModel(CounterViewModel());
```

### 4. Use Observer for reactive UI

```dart
Observer<int>(
  notifier: ServiceContainer.getViewModel<CounterViewModel>().count,
  builder: () => Text(
    '${ServiceContainer.getViewModel<CounterViewModel>().count.data}',
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
ServiceContainer.getViewModel<CounterViewModel>().navigateTo(
  navigate: <Your Navigation Function>,
  preserveViewModel: true,
);
```