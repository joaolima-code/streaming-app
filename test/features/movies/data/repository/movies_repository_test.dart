import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/data/model/home_category_model.dart';
import 'package:streaming_app/features/movies/data/datasource/movies_remote_datasource.dart';
import 'package:streaming_app/features/movies/data/model/movie_detail_response_model.dart';
import 'package:streaming_app/features/movies/data/model/movie_response_model.dart';
import 'package:streaming_app/features/movies/data/model/movies_list_model.dart';
import 'package:streaming_app/features/movies/data/repository/movies_repository_impl.dart';
import 'package:streaming_app/features/movies/domain/entity/movie_detail_entity.dart';
import 'package:streaming_app/features/movies/domain/entity/movies_list_entity.dart';
import 'package:streaming_app/features/movies/domain/entity/movies_list_filter.dart';

import 'movies_repository_test.mocks.dart';

@GenerateMocks(<Type>[MoviesRemoteDatasource])
void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMoviesRemoteDatasource();
    repository = MoviesRepositoryImpl(mockDatasource);
  });

  group('MoviesRepositoryImpl', () {
    group('getMoviesPopular', () {
      test('should return MoviesListEntity when call is successful', () async {
        const MoviesListFilter filter = MoviesListFilter();
        final MoviesListModel mockResponse = MoviesListModel(
          page: 1,
          results: <MovieResponseModel>[
            MovieResponseModel(
                id: 1,
                title: 'Movie 1',
                posterPath: '/path',
                backdropPath: '/backdrop',
                overview: 'Overview',
                releaseDate: '2024-08-01',
                voteAverage: 8,
                genreIds: <int>[1, 2])
          ],
          totalPages: 10,
        );

        when(mockDatasource.listPopularMovies(1, 'pt-BR', 'BR'))
            .thenAnswer((_) async => mockResponse);

        final CoreBaseResponse<MoviesListEntity> result =
            await repository.getMoviesPopular(filter);

        expect(result.isError, false);
        expect(result.data, isNotNull);
        expect(result.data!.results.length, 1);
        expect(result.data!.page, 1);
        verify(mockDatasource.listPopularMovies(1, 'pt-BR', 'BR')).called(1);
      });

      test('should return error response when exception occurs', () async {
        const MoviesListFilter filter = MoviesListFilter();

        when(mockDatasource.listPopularMovies(1, 'pt-BR', 'BR'))
            .thenThrow(Exception('Error'));

        final CoreBaseResponse<MoviesListEntity> result =
            await repository.getMoviesPopular(filter);

        expect(result.isError, true);
        expect(result.data, isNull);
      });
    });

    group('getMoviesNowPlaying', () {
      test('should return MoviesListEntity when call is successful', () async {
        const MoviesListFilter filter = MoviesListFilter();
        final MoviesListModel mockResponse = MoviesListModel(
          page: 1,
          results: <MovieResponseModel>[
            MovieResponseModel(
                id: 2,
                title: 'Movie 2',
                posterPath: '/path',
                backdropPath: '/backdrop',
                overview: 'Overview',
                releaseDate: '2024-09-02',
                voteAverage: 7.5,
                genreIds: <int>[3])
          ],
          totalPages: 5,
        );

        when(mockDatasource.listMoviesNowPlaying(1, 'pt-BR', 'BR'))
            .thenAnswer((_) async => mockResponse);

        final CoreBaseResponse<MoviesListEntity> result =
            await repository.getMoviesNowPlaying(filter);

        expect(result.isError, false);
        expect(result.data, isNotNull);
        expect(result.data!.totalPages, 5);
        verify(mockDatasource.listMoviesNowPlaying(1, 'pt-BR', 'BR')).called(1);
      });

      test('should return error response when exception occurs', () async {
        const MoviesListFilter filter = MoviesListFilter(page: 2);

        when(mockDatasource.listMoviesNowPlaying(2, 'pt-BR', 'BR'))
            .thenThrow(Exception('Error'));

        final CoreBaseResponse<MoviesListEntity> result =
            await repository.getMoviesNowPlaying(filter);

        expect(result.isError, true);
        expect(result.data, isNull);
      });
    });

    group('getMovieDetails', () {
      test('should return MovieDetailEntity when call is successful', () async {
        final MovieDetailResponseModel mockResponse = MovieDetailResponseModel(
            id: 1,
            title: 'Movie Detail',
            originalTitle: 'Original Title',
            overview: 'Description',
            posterPath: '/poster',
            backdropPath: '/backdrop',
            releaseDate: '2024-08-01',
            voteAverage: 8.5,
            runtime: 120,
            tagline: 'Tagline',
            genres: <HomeCategoryModel>[],
            voteCount: 1000);

        when(mockDatasource.getMovieDetails(1, 'pt-BR'))
            .thenAnswer((_) async => mockResponse);

        final CoreBaseResponse<MovieDetailEntity> result =
            await repository.getMovieDetails(1);

        expect(result.isError, false);
        expect(result.data, isNotNull);
        expect(result.data!.id, 1);
        expect(result.data!.title, 'Movie Detail');
        verify(mockDatasource.getMovieDetails(1, 'pt-BR')).called(1);
      });

      test('should return error response when exception occurs', () async {
        when(mockDatasource.getMovieDetails(1, 'pt-BR'))
            .thenThrow(Exception('Error'));

        final CoreBaseResponse<MovieDetailEntity> result =
            await repository.getMovieDetails(1);

        expect(result.isError, true);
        expect(result.data, isNull);
      });
    });
  });
}
