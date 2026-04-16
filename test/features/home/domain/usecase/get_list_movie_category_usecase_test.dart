import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/domain/entity/home_category_entity.dart';
import 'package:streaming_app/features/home/domain/repository/home_repository.dart';
import 'package:streaming_app/features/home/domain/usecase/get_list_movie_category_usecase.dart';

import 'get_list_movie_category_usecase_test.mocks.dart';

@GenerateMocks(<Type>[HomeRepository])
void main() {
  late GetListMovieCategoryUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetListMovieCategoryUsecase(mockRepository);
  });

  group('GetListMovieCategoryUsecase', () {
    test('should return list of categories when repository call succeeds',
        () async {
      final List<HomeCategoryEntity> mockData = <HomeCategoryEntity>[
        const HomeCategoryEntity(id: 1, name: 'Action'),
        const HomeCategoryEntity(id: 2, name: 'Comedy'),
      ];

      when(mockRepository.listMovieCategories()).thenAnswer((_) async =>
          CoreBaseResponse<List<HomeCategoryEntity>>(data: mockData));

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await usecase.call();

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.length, 2);
      expect(result.data!.first.name, 'Action');
      verify(mockRepository.listMovieCategories()).called(1);
    });

    test('should return error response when repository fails', () async {
      when(mockRepository.listMovieCategories()).thenAnswer((_) async =>
          CoreBaseResponse<List<HomeCategoryEntity>>(isError: true));

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await usecase.call();

      expect(result.isError, true);
      expect(result.data, isNull);
    });

    test('should return empty list when repository returns empty data',
        () async {
      when(mockRepository.listMovieCategories()).thenAnswer((_) async =>
          CoreBaseResponse<List<HomeCategoryEntity>>(
              data: <HomeCategoryEntity>[]));

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await usecase.call();

      expect(result.isError, false);
      expect(result.data!.isEmpty, true);
    });
  });
}
