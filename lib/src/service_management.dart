import 'package:stav/ui_designs/material.dart';
import 'package:leak_tracker/leak_tracker.dart';

class ServiceContainer {
  static final Map<String, (dynamic, bool)> _services = {};
  static void registerService<T>(
    T service, {
    String? serviceName,
    bool unregisterWhenGettingService = false,
  }) =>
      _services[serviceName ?? T.toString()] = (
        service,
        unregisterWhenGettingService,
      );

  static T getService<T>({String? serviceName}) {
    var service = _services[serviceName ?? T.toString()];
    if (service != null) {
      if (service.$2) {
        ServiceContainer.unregisterService<T>(serviceName: serviceName);
      }
      return service.$1;
    } else {
      throw "couldn't find service : ${T.toString()}/$serviceName";
    }
  }

  static void registerViewModel<T>(T viewModel) =>
      ServiceContainer.registerService(viewModel);

  static T getViewModel<T>() => ServiceContainer.getService();

  static bool unregisterService<T>({String? serviceName}) {
    var deletedValue = _services.remove((serviceName ?? T.toString()));
    return deletedValue != null ? true : false;
  }
}

abstract class BaseViewModel<T> {
  T get newInstance;

  void navigateTo({
    BuildContext? ctx,
    required void Function(BuildContext? ctx) navigate,
    String? path,
    bool preserveViewModel = false,
  }) {
    if (preserveViewModel) {
      navigate(ctx);
      return;
    }
    T service = newInstance;
    ServiceContainer.registerService(
      service,
      serviceName: service.runtimeType.toString(),
    );
    forceGC();
    navigate(ctx);
  }
}
