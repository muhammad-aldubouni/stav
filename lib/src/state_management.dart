import 'package:flutter/material.dart';

class Observer extends StatefulWidget {
  final Notifier notifier;
  final Widget Function() builder;
  const Observer({super.key, required this.notifier, required this.builder});

  @override
  State<Observer> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  late Notifier _activeNotifier;

  @override
  void initState() {
    super.initState();
    _activeNotifier = widget.notifier;
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant Observer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.notifier != _activeNotifier) {
      _unsubscribe();
      _activeNotifier = widget.notifier;
      _subscribe();
    }
  }

  void _subscribe() => _activeNotifier._observers.add(this);
  void _unsubscribe() => _activeNotifier._observers.remove(this);

  void _update() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder();
}

class Notifier<T> {
  final Set<_ObserverState> _observers = {};

  late T data;
  Notifier(this.data);

  void notifyChange() {
    final observersCopy = List<_ObserverState>.from(_observers);
    for (_ObserverState state in observersCopy) {
      state._update();
    }
  }

  void update(T Function(T data) updater) {
    final newData = updater(data);
    if (newData == data) return;
    data = newData;
    notifyChange();
  }
}

extension NotifierExt on Object? {
  Notifier<T> toNotifier<T>() => Notifier<T>(this as T);
}

Notifier<T> toNotifier<T>(T data) => Notifier(data);
