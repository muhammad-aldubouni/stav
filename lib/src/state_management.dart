import 'package:stav/ui_designs/material.dart';

class Observer<T> extends StatefulWidget {
  final Notifier<T> notifier;
  final Widget Function() builder;
  const Observer({super.key, required this.notifier, required this.builder});
  @override
  State<Observer> createState() => _ObserverState<T>();
}

class _ObserverState<T> extends State<Observer> {
  late Notifier _old;
  @override
  void initState() {
    super.initState();
    assert(() {
      _old = widget.notifier;
      return true;
    }());
    widget.notifier._observers.add(this);
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (_old != widget.notifier) {
        _old._observers.remove(this);
        widget.notifier._observers.add(this);
      }

      return true;
    }());

    return widget.builder();
  }

  void _update() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.notifier._observers.remove(this);
    super.dispose();
  }
}

class Notifier<T> {
  final List<_ObserverState> _observers = [];

  late T data;
  Notifier(this.data);
  void notifyChange() {
    for (_ObserverState state in _observers) {
      state._update();
    }
  }

  void update(void Function(T data) updater) {
    updater(data);
    notifyChange();
  }
}

extension NotifierExt on Object? {
  Notifier<T> toNotifier<T>() => Notifier<T>(this as T);
}

Notifier<T> toNotifier<T>(T data) => Notifier(data);
