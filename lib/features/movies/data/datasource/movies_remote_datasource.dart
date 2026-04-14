import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/movie_detail_response_model.dart';
import '../model/movies_list_model.dart';

part 'movies_remote_datasource.g.dart';

@RestApi()
abstract class MoviesRemoteDatasource {
  factory MoviesRemoteDatasource(Dio dio, {String baseUrl}) =
      _MoviesRemoteDatasource;

  @GET('/movie/now_playing')
  Future<MoviesListModel> listMoviesNowPlaying(
    @Query('page') int page,
    @Query('language') String language,
    @Query('region') String region,
  );

  @GET('/movie/popular')
  Future<MoviesListModel> listPopularMovies(
    @Query('page') int page,
    @Query('language') String language,
    @Query('region') String region,
  );

  @GET('/movie/{movie_id}')
  Future<MovieDetailResponseModel> getMovieDetails(
    @Path('movie_id') int movieId,
    @Query('language') String language,
  );
}
