import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/presentation/cubit/home_config_cubit.dart';
import 'package:streaming_app/features/movies/domain/entity/movie_detail_entity.dart';
import 'package:streaming_app/features/movies/domain/repository/movies_repository.dart';
import 'package:streaming_app/features/movies/domain/usecase/get_movie_detail_usecase.dart';

import 'get_movie_detail_usecase_test.mocks.dart';

@GenerateMocks(<Type>[MoviesRepository, HomeConfigCubit])
void main() {
  late GetMovieDetailUsecase usecase;
  late MockMoviesRepository mockRepository;
  late MockHomeConfigCubit mockHomeConfigCubit;

  setUp(() {
    mockRepository = MockMoviesRepository();
    mockHomeConfigCubit = MockHomeConfigCubit();
    usecase = GetMovieDetailUsecase(
      mockRepository,
      homeConfigCubit: mockHomeConfigCubit,
    );
  });

  group('GetMovieDetailUsecase', () {
    test('should return MovieDetailEntity when repository call succeeds',
        () async {
      const int movieId = 1;
      const MovieDetailEntity mockData = MovieDetailEntity(
        id: 1,
        title: 'Movie Detail',
        description: 'Description',
        originalTitle: 'Original Title',
        bannerImagePath: '/backdrop',
        cardImagePath: '/poster',
        runtime: 120,
        tagline: 'Tagline',
        releaseDate: '2024',
        voteAverage: 8.5,
        voteCount: 1000,
      );

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockRepository.getMovieDetails(movieId)).thenAnswer(
          (_) async => CoreBaseResponse<MovieDetailEntity>(data: mockData));

      final CoreBaseResponse<MovieDetailEntity> result =
          await usecase.call(movieId);

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.id, 1);
      expect(result.data!.title, 'Movie Detail');
      expect(result.data!.runtime, 120);
      verify(mockRepository.getMovieDetails(movieId)).called(1);
    });

    test('should return error response when repository fails', () async {
      const int movieId = 1;

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockRepository.getMovieDetails(movieId)).thenAnswer(
          (_) async => CoreBaseResponse<MovieDetailEntity>(isError: true));

      final CoreBaseResponse<MovieDetailEntity> result =
          await usecase.call(movieId);

      expect(result.isError, true);
      expect(result.data, isNull);
    });

    test('should handle exception and return error response', () async {
      const int movieId = 1;

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockRepository.getMovieDetails(movieId))
          .thenThrow(Exception('Error'));

      final CoreBaseResponse<MovieDetailEntity> result =
          await usecase.call(movieId);

      expect(result.isError, true);
    });

    test('should return null data when repository returns null', () async {
      const int movieId = 1;

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockRepository.getMovieDetails(movieId))
          .thenAnswer((_) async => CoreBaseResponse<MovieDetailEntity>());

      final CoreBaseResponse<MovieDetailEntity> result =
          await usecase.call(movieId);

      expect(result.isError, false);
      expect(result.data, isNull);
    });

    test('should fetch detail for different movie IDs', () async {
      const int movieId2 = 2;
      const MovieDetailEntity mockData = MovieDetailEntity(
        id: 2,
        title: 'Another Movie',
        description: 'Description',
        originalTitle: 'Another Title',
      );

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockRepository.getMovieDetails(movieId2)).thenAnswer(
          (_) async => CoreBaseResponse<MovieDetailEntity>(data: mockData));

      final CoreBaseResponse<MovieDetailEntity> result =
          await usecase.call(movieId2);

      expect(result.isError, false);
      expect(result.data!.id, 2);
      expect(result.data!.title, 'Another Movie');
      verify(mockRepository.getMovieDetails(movieId2)).called(1);
    });
  });
}
