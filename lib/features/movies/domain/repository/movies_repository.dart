import '../../../../core/network/core_base_reponse.dart';
import '../entity/movie_detail_entity.dart';
import '../entity/movies_list_entity.dart';
import '../entity/movies_list_filter.dart';

abstract class MoviesRepository {
  Future<CoreBaseResponse<MoviesListEntity>> getMoviesNowPlaying(
    MoviesListFilter filter,
  );

  Future<CoreBaseResponse<MoviesListEntity>> getMoviesPopular(
    MoviesListFilter filter,
  );

  Future<CoreBaseResponse<MovieDetailEntity>> getMovieDetails(int movieId);
}
