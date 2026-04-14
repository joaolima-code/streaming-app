import '../../../../core/network/core_base_reponse.dart';
import '../../domain/entity/movie_detail_entity.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../../domain/entity/movies_list_filter.dart';
import '../../domain/repository/movies_repository.dart';
import '../datasource/movies_remote_datasource.dart';
import '../model/movie_detail_response_model.dart';
import '../model/movies_list_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this._datasource);

  final MoviesRemoteDatasource _datasource;

  @override
  Future<CoreBaseResponse<MovieDetailEntity>> getMovieDetails(
    int movieId,
  ) async {
    try {
      final MovieDetailResponseModel response = await _datasource
          .getMovieDetails(movieId, 'en-US');
      return CoreBaseResponse<MovieDetailEntity>(
        data: MovieDetailEntity.fromModel(response),
      );
    } catch (e) {
      return CoreBaseResponse<MovieDetailEntity>(isError: true);
    }
  }

  @override
  Future<CoreBaseResponse<MoviesListEntity>> getMoviesNowPlaying(
    MoviesListFilter filter,
  ) async {
    try {
      final MoviesListModel response = await _datasource.listMoviesNowPlaying(
        filter.page,
        'pt-BR',
        'BR',
      );

      return CoreBaseResponse<MoviesListEntity>(
        data: MoviesListEntity.fromModel(response),
      );
    } catch (e) {
      return CoreBaseResponse<MoviesListEntity>(isError: true);
    }
  }

  @override
  Future<CoreBaseResponse<MoviesListEntity>> getMoviesPopular(
    MoviesListFilter filter,
  ) async {
    try {
      final MoviesListModel response = await _datasource.listPopularMovies(
        filter.page,
        'pt-BR',
        'BR',
      );

      return CoreBaseResponse<MoviesListEntity>(
        data: MoviesListEntity.fromModel(response),
      );
    } catch (e) {
      return CoreBaseResponse<MoviesListEntity>(isError: true);
    }
  }
}
