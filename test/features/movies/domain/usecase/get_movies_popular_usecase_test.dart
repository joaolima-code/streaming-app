import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/domain/entity/home_category_entity.dart';
import 'package:streaming_app/features/home/presentation/cubit/home_config_cubit.dart';
import 'package:streaming_app/features/movies/domain/entity/movie_entity.dart';
import 'package:streaming_app/features/movies/domain/entity/movies_list_entity.dart';
import 'package:streaming_app/features/movies/domain/entity/movies_list_filter.dart';
import 'package:streaming_app/features/movies/domain/repository/movies_repository.dart';
import 'package:streaming_app/features/movies/domain/usecase/get_movies_popular_usecase.dart';

import 'get_movies_popular_usecase_test.mocks.dart';

@GenerateMocks(<Type>[MoviesRepository, HomeConfigCubit])
void main() {
  late GetMoviesPopularUsecase usecase;
  late MockMoviesRepository mockRepository;
  late MockHomeConfigCubit mockHomeConfigCubit;

  setUp(() {
    mockRepository = MockMoviesRepository();
    mockHomeConfigCubit = MockHomeConfigCubit();
    usecase = GetMoviesPopularUsecase(
      mockRepository,
      homeConfigCubit: mockHomeConfigCubit,
    );
  });

  group('GetMoviesPopularUsecase', () {
    test('should return MoviesListEntity when repository call succeeds',
        () async {
      const MoviesListFilter filter = MoviesListFilter();
      const MoviesListEntity mockData = MoviesListEntity(
          page: 1,
          results: <MovieEntity>[
            MovieEntity(
                id: 1,
                title: 'Movie 1',
                bannerImagePath: '/backdrop',
                cardImagePath: '/poster',
                releaseDate: '2024-08-01',
                voteAverage: 8,
                genreIds: <int>[1, 2])
          ],
          totalPages: 10);

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockHomeConfigCubit.categories).thenReturn(<HomeCategoryEntity>[]);
      when(mockRepository.getMoviesPopular(filter)).thenAnswer(
          (_) async => CoreBaseResponse<MoviesListEntity>(data: mockData));

      final CoreBaseResponse<MoviesListEntity> result =
          await usecase.call(filter);

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.results.length, 1);
      verify(mockRepository.getMoviesPopular(filter)).called(1);
    });

    test('should return error response when repository fails', () async {
      const MoviesListFilter filter = MoviesListFilter();

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockHomeConfigCubit.categories).thenReturn(<HomeCategoryEntity>[]);
      when(mockRepository.getMoviesPopular(filter)).thenAnswer(
          (_) async => CoreBaseResponse<MoviesListEntity>(isError: true));

      final CoreBaseResponse<MoviesListEntity> result =
          await usecase.call(filter);

      expect(result.isError, true);
      expect(result.data, isNull);
    });

    test('should handle exception and return error response', () async {
      const MoviesListFilter filter = MoviesListFilter();

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockHomeConfigCubit.categories).thenReturn(<HomeCategoryEntity>[]);
      when(mockRepository.getMoviesPopular(filter))
          .thenThrow(Exception('Error'));

      final CoreBaseResponse<MoviesListEntity> result =
          await usecase.call(filter);

      expect(result.isError, true);
    });

    test('should return empty movies list when results are empty', () async {
      const MoviesListFilter filter = MoviesListFilter();
      const MoviesListEntity mockData =
          MoviesListEntity(page: 1, totalPages: 1);

      when(mockHomeConfigCubit.imageConfig).thenReturn(null);
      when(mockHomeConfigCubit.categories).thenReturn(<HomeCategoryEntity>[]);
      when(mockRepository.getMoviesPopular(filter)).thenAnswer(
          (_) async => CoreBaseResponse<MoviesListEntity>(data: mockData));

      final CoreBaseResponse<MoviesListEntity> result =
          await usecase.call(filter);

      expect(result.isError, false);
      expect(result.data!.results.isEmpty, true);
    });
  });
}
