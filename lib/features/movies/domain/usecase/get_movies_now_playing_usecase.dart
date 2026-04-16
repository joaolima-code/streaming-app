import '../../../../core/helper/movie_config_helper.dart';
import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../../../home/domain/entity/home_category_entity.dart';
import '../../../home/domain/entity/home_config_image_entity.dart';
import '../../../home/presentation/cubit/home_config_cubit.dart';
import '../entity/movie_entity.dart';
import '../entity/movies_list_entity.dart';
import '../entity/movies_list_filter.dart';
import '../repository/movies_repository.dart';

class GetMoviesNowPlayingUsecase
    implements RemoteQueryUsecaseInterface<MoviesListEntity, MoviesListFilter> {
  GetMoviesNowPlayingUsecase(this._repository, {required this.homeConfigCubit});

  final MoviesRepository _repository;
  final HomeConfigCubit homeConfigCubit;

  @override
  Future<CoreBaseResponse<MoviesListEntity>> call(
    MoviesListFilter filter,
  ) async {
    final HomeConfigImageEntity? imageConfig = homeConfigCubit.imageConfig;
    final List<HomeCategoryEntity> categories = homeConfigCubit.categories;

    try {
      final CoreBaseResponse<MoviesListEntity> response =
          await _repository.getMoviesNowPlaying(filter);

      if (response.isError || response.data == null) {
        return response;
      }

      final MoviesListEntity moviesList = response.data!;

      if (imageConfig != null && moviesList.results.isNotEmpty) {
        final List<MovieEntity> enrichedMovies =
            MovieConfigHelper.addConfigEntities(
                movies: moviesList.results,
                imageConfig: imageConfig,
                categories: categories);

        return CoreBaseResponse<MoviesListEntity>(
            data: MoviesListEntity(
                page: moviesList.page,
                results: enrichedMovies,
                totalPages: moviesList.totalPages));
      } else if (categories.isNotEmpty) {
        final List<MovieEntity> enrichedMovies = moviesList.results.map((
          MovieEntity movie,
        ) {
          if (movie.genreIds.isNotEmpty) {
            return movie.copyWith(
                categories: MovieConfigHelper.mapGenreIdsToCategories(
                    genreIds: movie.genreIds, categories: categories));
          }
          return movie;
        }).toList();

        return CoreBaseResponse<MoviesListEntity>(
            data: MoviesListEntity(
                page: moviesList.page,
                results: enrichedMovies,
                totalPages: moviesList.totalPages));
      }

      return CoreBaseResponse<MoviesListEntity>(data: moviesList);
    } catch (e) {
      return CoreBaseResponse<MoviesListEntity>(isError: true);
    }
  }
}
