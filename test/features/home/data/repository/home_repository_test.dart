import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:streaming_app/features/home/data/model/home_category_model.dart';
import 'package:streaming_app/features/home/data/model/home_config_image_model.dart';
import 'package:streaming_app/features/home/data/repository/home_repository_impl.dart';
import 'package:streaming_app/features/home/domain/entity/home_category_entity.dart';
import 'package:streaming_app/features/home/domain/entity/home_config_image_entity.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks(<Type>[HomeRemoteDatasource])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockHomeRemoteDatasource();
    repository = HomeRepositoryImpl(mockDatasource);
  });

  group('configImages', () {
    test('should return HomeConfigImageEntity when call is successful',
        () async {
      final HomeConfigImageModel mockResponse = HomeConfigImageModel(
          images: HomeImagesModel(
              baseUrl: 'https://image.tmdb.org/t/p/',
              secureBaseUrl: 'https://image.tmdb.org/t/p/',
              backdropSizes: <String>[
            'w300',
            'w780',
            'w1280',
            'original'
          ],
              posterSizes: <String>[
            'w92',
            'w154',
            'w185',
            'w342',
            'w500',
            'w780',
            'original'
          ]));

      when(mockDatasource.configImages()).thenAnswer((_) async => mockResponse);

      final CoreBaseResponse<HomeConfigImageEntity> result =
          await repository.configImages();

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.baseUrl, 'https://image.tmdb.org/t/p/');
      verify(mockDatasource.configImages()).called(1);
    });

    test('should return error response when exception occurs', () async {
      when(mockDatasource.configImages()).thenThrow(Exception('Error'));

      final CoreBaseResponse<HomeConfigImageEntity> result =
          await repository.configImages();

      expect(result.isError, true);
      expect(result.data, isNull);
    });
  });

  group('listMovieCategories', () {
    test('should return list of HomeCategoryEntity when call is successful',
        () async {
      const HomeListCategoriesModel mockResponse =
          HomeListCategoriesModel(genres: <HomeCategoryModel>[
        HomeCategoryModel(id: 1, name: 'Action'),
        HomeCategoryModel(id: 2, name: 'Comedy')
      ]);

      when(mockDatasource.listCategories())
          .thenAnswer((_) async => mockResponse);

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await repository.listMovieCategories();

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.length, 2);
      expect(result.data!.first.name, 'Action');
      verify(mockDatasource.listCategories()).called(1);
    });

    test('should return error response when exception occurs', () async {
      when(mockDatasource.listCategories()).thenThrow(Exception('Error'));

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await repository.listMovieCategories();

      expect(result.isError, true);
      expect(result.data, isNull);
    });

    test('should return empty list when no categories available', () async {
      const HomeListCategoriesModel mockResponse = HomeListCategoriesModel();

      when(mockDatasource.listCategories())
          .thenAnswer((_) async => mockResponse);

      final CoreBaseResponse<List<HomeCategoryEntity>> result =
          await repository.listMovieCategories();

      expect(result.isError, false);
      expect(result.data!.isEmpty, true);
    });
  });
}
