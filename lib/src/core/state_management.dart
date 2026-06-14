import 'package:flutter/material.dart';

/// The UI Widget that listens to a specific [Notifier].
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

  // Uses the public API to subscribe/unsubscribe
  void _subscribe() => _activeNotifier.addListener(_update);
  void _unsubscribe() => _activeNotifier.removeListener(_update);

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

/// A lightweight, fine-grained observable property wrapper.
class Notifier<T> {
  // Private set ensures external code can't clear or overwrite the listeners
  final Set<VoidCallback> _listeners = {};

  late T data;
  Notifier(this.data);

  /// Allows UI widgets or pure Dart classes/tests to listen to changes.
  void addListener(VoidCallback listener) => _listeners.add(listener);

  /// Cleans up subscriptions to prevent memory leaks.
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  /// Loops through copy list and triggers all registered functions.
  void notifyChange() {
    final listenersCopy = List<VoidCallback>.from(_listeners);
    for (VoidCallback listener in listenersCopy) {
      listener();
    }
  }

  /// Updates the value and notifies listeners only if the data actually changed.
  void update(T Function(T data) updater) {
    final newData = updater(data);
    if (newData == data) return;
    data = newData;
    notifyChange();
  }
}

// Syntactic Sugar Extensions
extension NotifierExt on Object? {
  Notifier<T> toNotifier<T>() => Notifier<T>(this as T);
}

Notifier<T> toNotifier<T>(T data) => Notifier(data);
