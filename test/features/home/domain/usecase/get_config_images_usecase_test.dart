import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:streaming_app/core/network/core_base_reponse.dart';
import 'package:streaming_app/features/home/domain/entity/home_config_image_entity.dart';
import 'package:streaming_app/features/home/domain/repository/home_repository.dart';
import 'package:streaming_app/features/home/domain/usecase/get_config_images_usecase.dart';

import 'get_config_images_usecase_test.mocks.dart';

@GenerateMocks(<Type>[HomeRepository])
void main() {
  late GetConfigImagesUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetConfigImagesUsecase(mockRepository);
  });

  group('GetConfigImagesUsecase', () {
    test('should return HomeConfigImageEntity when repository call succeeds',
        () async {
      const HomeConfigImageEntity mockData = HomeConfigImageEntity(
        baseUrl: 'https://image.tmdb.org/t/p/',
        secureBaseUrl: 'https://image.tmdb.org/t/p/',
        backdropSizes: <String>['w300', 'w780', 'w1280'],
        posterSizes: <String>['w92', 'w154', 'w185'],
      );

      when(mockRepository.configImages()).thenAnswer(
          (_) async => CoreBaseResponse<HomeConfigImageEntity>(data: mockData));

      final CoreBaseResponse<HomeConfigImageEntity> result =
          await usecase.call();

      expect(result.isError, false);
      expect(result.data, isNotNull);
      expect(result.data!.baseUrl, 'https://image.tmdb.org/t/p/');
      expect(result.data!.backdropSizes, isNotNull);
      expect(result.data!.backdropSizes!.length, 3);
      verify(mockRepository.configImages()).called(1);
    });

    test('should return error response when repository fails', () async {
      when(mockRepository.configImages()).thenAnswer(
          (_) async => CoreBaseResponse<HomeConfigImageEntity>(isError: true));

      final CoreBaseResponse<HomeConfigImageEntity> result =
          await usecase.call();

      expect(result.isError, true);
      expect(result.data, isNull);
    });

    test('should return config with null sizes when data is incomplete',
        () async {
      const HomeConfigImageEntity mockData = HomeConfigImageEntity(
          baseUrl: 'https://image.tmdb.org/t/p/',
          secureBaseUrl: 'https://image.tmdb.org/t/p/');

      when(mockRepository.configImages()).thenAnswer(
          (_) async => CoreBaseResponse<HomeConfigImageEntity>(data: mockData));

      final CoreBaseResponse<HomeConfigImageEntity> result =
          await usecase.call();

      expect(result.isError, false);
      expect(result.data!.baseUrl, isNotNull);
      expect(result.data!.backdropSizes, isNull);
    });
  });
}
