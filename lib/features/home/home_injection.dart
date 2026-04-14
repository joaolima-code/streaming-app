import 'package:get_it/get_it.dart';

import '../../core/injection/injection_module.dart';
import 'data/datasource/home_remote_datasource.dart';
import 'data/repository/home_repository_impl.dart';
import 'domain/repository/home_repository.dart';
import 'domain/usecase/get_config_images_usecase.dart';
import 'domain/usecase/get_list_movie_category_usecase.dart';
import 'presentation/cubit/home_config_cubit.dart';

class HomeInjection implements InjectionModule {
  HomeInjection._internal();

  static final HomeInjection _singleton = HomeInjection._internal();
  static HomeInjection get instance => _singleton;

  final GetIt injector = GetIt.instance;

  @override
  Future<void> register(GetIt getIt) async {
    injector.registerLazySingleton(() => HomeRemoteDatasource(injector()));

    injector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(injector()),
    );

    injector.registerLazySingleton(() => GetConfigImagesUsecase(injector()));
    injector.registerLazySingleton(
      () => GetListMovieCategoryUsecase(injector()),
    );

    injector.registerSingleton<HomeConfigCubit>(
      HomeConfigCubit(
        getConfigImagesUsecase: injector(),
        getListMovieCategoryUsecase: injector(),
      ),
    );
  }
}
