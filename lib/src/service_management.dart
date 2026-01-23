import 'package:stav/ui_designs/material.dart';

class ServiceContainer {
  static final Map<(Type, String?), (dynamic, bool)> _services = {};
  static void registerService<T>(
    T service, {
    String? serviceName,
    bool unregisterWhenGettingService = false,
  }) => _services[(T, serviceName)] = (service, unregisterWhenGettingService);

  static T getService<T>({String? serviceName}) {
    var service = _services[(T, serviceName)];
    if (service != null) {
      if (service.$2) {
        ServiceContainer.unregisterService<T>(serviceName: serviceName);
      }
      return service.$1;
    } else {
      throw "couldn't find service : ${T.toString()}/$serviceName";
    }
  }

  static void registerViewModel<T extends BaseViewModel<T>>(T viewModel) =>
      ServiceContainer.registerService(viewModel);

  static T getViewModel<T extends BaseViewModel<T>>() {
    T viewModel = ServiceContainer.getService();
    viewModel.safeInit();
    return viewModel;
  }

  static bool unregisterService<T>({String? serviceName}) {
    var deletedValue = _services.remove((T, serviceName));
    return deletedValue != null ? true : false;
  }
}

abstract class BaseViewModel<T extends BaseViewModel<T>> {
  T get newInstance;
  void Function() dispose = () {};
  void Function() init = () {};
  bool _initialized = false;

  void safeInit() {
    if (!_initialized) {
      init();
      _initialized = true;
    }
  }

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
    ServiceContainer.registerViewModel<T>(newInstance);
    dispose();
    navigate(ctx);
  }
}
