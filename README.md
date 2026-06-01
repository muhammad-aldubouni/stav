

## Features

🟢 state management  
🟢 simple way to deal with dynaming theming for any ui package  


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


### 3. define a notifier 

```dart
Notifier<int> counter = Notifier(0);
```


### 4. Use the Notifier with an Observer to manage state

```dart
Observer(
  notifier: counter,
  builder: () => Text(
    '${count.data}',
  ),
)
```



### 5. Theming

Set or switch themes using the `app` object:

```dart
final app = App();
app.darkTheme = ThemeData.dark();
app.lightTheme = ThemeData.light();
app.useSystemTheme(); // or app.useDarkTheme(), app.useLightTheme()
app.run(appRoot: () => MyHomePage());
```