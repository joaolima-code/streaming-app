import '../../../../core/helper/movie_config_helper.dart';
import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../../../home/domain/entity/home_category_entity.dart';
import '../../../home/domain/entity/home_config_image_entity.dart';
import '../../data/model/movie_response_model.dart';
import '../entity/movie_entity.dart';
import '../entity/movies_list_entity.dart';
import '../entity/movies_list_filter.dart';
import '../repository/movies_repository.dart';

class GetMoviesPopularUsecase
    implements RemoteQueryUsecaseInterface<MoviesListEntity, MoviesListFilter> {
  GetMoviesPopularUsecase(
    this._repository, {
    this.imageConfig,
    this.categories = const <HomeCategoryEntity>[],
  });

  final MoviesRepository _repository;
  final HomeConfigImageEntity? imageConfig;
  final List<HomeCategoryEntity> categories;

  @override
  Future<CoreBaseResponse<MoviesListEntity>> call(
    MoviesListFilter filter,
  ) async {
    try {
      final CoreBaseResponse<MoviesListEntity> response = await _repository
          .getMoviesPopular(filter);

      if (response.isError || response.data == null) {
        return response;
      }

      final MoviesListEntity moviesList = response.data!;

      if (imageConfig != null && moviesList.results.isNotEmpty) {
        final List<MovieResponseModel> movieResponseModels = moviesList.results
            .map(
              (MovieEntity movie) => MovieResponseModel(
                id: movie.id,
                title: movie.title ?? '',
                originalTitle: movie.title ?? '',
                overview: movie.description ?? '',
                posterPath: movie.cardImagePath,
                backdropPath: movie.bannerImagePath,
                genreIds: movie.genreIds.isNotEmpty ? movie.genreIds : null,
                popularity: movie.popularity,
                releaseDate: movie.releaseDate,
                voteAverage: movie.voteAverage,
                voteCount: movie.voteCount,
              ),
            )
            .toList();

        final List<MovieEntity> enrichedMovies =
            MovieConfigHelper.addConfigEntities(
              movies: movieResponseModels,
              imageConfig: imageConfig!,
              categories: categories,
            );

        return CoreBaseResponse<MoviesListEntity>(
          data: MoviesListEntity(
            page: moviesList.page,
            results: enrichedMovies,
            totalPages: moviesList.totalPages,
          ),
        );
      } else if (categories.isNotEmpty) {
        final List<MovieEntity> enrichedMovies = moviesList.results.map((
          MovieEntity movie,
        ) {
          if (movie.genreIds.isNotEmpty) {
            return movie.copyWith(
              categories: MovieConfigHelper.mapGenreIdsToCategories(
                genreIds: movie.genreIds,
                categories: categories,
              ),
            );
          }
          return movie;
        }).toList();

        return CoreBaseResponse<MoviesListEntity>(
          data: MoviesListEntity(
            page: moviesList.page,
            results: enrichedMovies,
            totalPages: moviesList.totalPages,
          ),
        );
      }

      return CoreBaseResponse<MoviesListEntity>(data: moviesList);
    } catch (e) {
      return CoreBaseResponse<MoviesListEntity>(isError: true);
    }
  }
}
