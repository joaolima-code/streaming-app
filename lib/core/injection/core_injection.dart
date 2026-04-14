import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/home_injection.dart';
import '../../features/movies/movies_injection.dart';
import '../network/api_client.dart';
import 'injection_module.dart';

final GetIt getIt = GetIt.instance;

class CoreInjection implements InjectionModule {
  CoreInjection._();

  @override
  Future<void> register(GetIt getIt) async {
    getIt.registerLazySingleton<Dio>(() => ApiClient().dio);
  }

  static Future<void> setupInjection() async {
    final List<InjectionModule> modules = <InjectionModule>[
      CoreInjection._(),
      HomeInjection.instance,
      MoviesInjection.instance,
    ];

    for (final InjectionModule module in modules) {
      module.register(getIt);
    }
  }
}
