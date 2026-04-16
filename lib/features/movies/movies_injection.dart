import 'package:get_it/get_it.dart';

import '../../core/injection/injection_module.dart';
import '../home/presentation/cubit/home_config_cubit.dart';
import 'data/datasource/movies_remote_datasource.dart';
import 'data/repository/movies_repository_impl.dart';
import 'domain/repository/movies_repository.dart';
import 'domain/usecase/get_movie_detail_usecase.dart';
import 'domain/usecase/get_movies_now_playing_usecase.dart';
import 'domain/usecase/get_movies_popular_usecase.dart';
import 'presentation/cubits/movie_detail_cubit.dart';

final GetIt getIt = GetIt.instance;

class MoviesInjection implements InjectionModule {
  MoviesInjection._internal();

  static final MoviesInjection _singleton = MoviesInjection._internal();
  static MoviesInjection get instance => _singleton;

  final GetIt injector = GetIt.instance;

  @override
  Future<void> register(GetIt getIt) async {
    injector.registerLazySingleton(() => MoviesRemoteDatasource(injector()));

    injector.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(injector()),
    );

    injector.registerLazySingleton(
      () => GetMovieDetailUsecase(
        injector(),
        homeConfigCubit: injector<HomeConfigCubit>(),
      ),
    );
    injector.registerLazySingleton(() {
      return GetMoviesNowPlayingUsecase(
        injector(),
        homeConfigCubit: injector<HomeConfigCubit>(),
      );
    });
    injector.registerLazySingleton(() {
      return GetMoviesPopularUsecase(
        injector(),
        homeConfigCubit: injector<HomeConfigCubit>(),
      );
    });

    injector.registerLazySingleton(() => MovieDetailCubit(injector()));
  }
}
