import '../../features/home/domain/entity/home_category_entity.dart';
import '../../features/home/domain/entity/home_config_image_entity.dart';
import '../../features/movies/data/model/movie_response_model.dart';
import '../../features/movies/domain/entity/movie_detail_entity.dart';
import '../../features/movies/domain/entity/movie_entity.dart';

class MovieConfigHelper {
  MovieConfigHelper._();

  static List<MovieEntity> addConfigEntities({
    required List<MovieEntity> movies,
    required HomeConfigImageEntity imageConfig,
    required List<HomeCategoryEntity> categories,
    String posterSize = 'w500',
    String backdropSize = 'w780',
  }) {
    return movies.map((MovieEntity movie) {
      return configMovieEntity(
        movie: movie,
        imageConfig: imageConfig,
        categories: categories,
        posterSize: posterSize,
        backdropSize: backdropSize,
      );
    }).toList();
  }

  static MovieEntity configMovieEntity({
    required MovieEntity movie,
    required HomeConfigImageEntity imageConfig,
    required List<HomeCategoryEntity> categories,
    String posterSize = 'w500',
    String backdropSize = 'w780',
  }) {
    final String? cardImagePath = _buildImageUrl(
      basePath: movie.cardImagePath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: posterSize,
    );

    final String? bannerImagePath = _buildImageUrl(
      basePath: movie.bannerImagePath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: backdropSize,
    );

    final List<HomeCategoryEntity> mappedCategories = mapGenreIdsToCategories(
      genreIds: movie.genreIds,
      categories: categories,
    );

    return movie.copyWith(
      cardImagePath: cardImagePath,
      bannerImagePath: bannerImagePath,
      categories: mappedCategories,
    );
  }

  static MovieDetailEntity configDetailMovieEntity({
    required MovieDetailEntity movie,
    required HomeConfigImageEntity imageConfig,
    String posterSize = 'w500',
    String backdropSize = 'w780',
  }) {
    final String? cardImagePath = _buildImageUrl(
      basePath: movie.cardImagePath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: posterSize,
    );

    final String? bannerImagePath = _buildImageUrl(
      basePath: movie.bannerImagePath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: backdropSize,
    );

    return movie.copyWith(
      cardImagePath: cardImagePath,
      bannerImagePath: bannerImagePath,
    );
  }

  static String? _buildImageUrl({
    required String? basePath,
    required String? baseUrl,
    // TODO(JOAO): usar a lista consumida da home
    required String size,
  }) {
    if (basePath == null || basePath.isEmpty || baseUrl == null) {
      return null;
    }

    final String normalizedBaseUrl = baseUrl.endsWith('/')
        ? baseUrl
        : '$baseUrl/';

    final String normalizedPath = basePath.startsWith('/')
        ? basePath
        : '/$basePath';

    return '$normalizedBaseUrl$size$normalizedPath';
  }

  static List<HomeCategoryEntity> mapGenreIdsToCategories({
    required List<int> genreIds,
    required List<HomeCategoryEntity> categories,
  }) {
    if (genreIds.isEmpty || categories.isEmpty) {
      return <HomeCategoryEntity>[];
    }

    final Map<int, HomeCategoryEntity> categoryMap = <int, HomeCategoryEntity>{
      for (final HomeCategoryEntity category in categories)
        category.id: category,
    };

    return genreIds
        .map((int id) => categoryMap[id])
        .where((HomeCategoryEntity? category) => category != null)
        .cast<HomeCategoryEntity>()
        .toList();
  }
}
