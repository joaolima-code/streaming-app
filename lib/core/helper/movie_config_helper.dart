import '../../features/home/domain/entity/home_category_entity.dart';
import '../../features/home/domain/entity/home_config_image_entity.dart';
import '../../features/movies/data/model/movie_response_model.dart';
import '../../features/movies/domain/entity/movie_entity.dart';

class MovieConfigHelper {
  MovieConfigHelper._();

  static List<MovieEntity> addConfigEntities({
    required List<MovieResponseModel> movies,
    required HomeConfigImageEntity imageConfig,
    required List<HomeCategoryEntity> categories,
    String posterSize = 'w500',
    String backdropSize = 'w780',
  }) {
    return movies.map((MovieResponseModel movie) {
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
    required MovieResponseModel movie,
    required HomeConfigImageEntity imageConfig,
    required List<HomeCategoryEntity> categories,
    String posterSize = 'w500',
    String backdropSize = 'w780',
  }) {
    final MovieEntity movieEntity = MovieEntity.fromModel(movie);

    final String? cardImagePath = _buildImageUrl(
      basePath: movie.posterPath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: posterSize,
    );

    final String? bannerImagePath = _buildImageUrl(
      basePath: movie.backdropPath,
      baseUrl: imageConfig.secureBaseUrl ?? imageConfig.baseUrl,
      size: backdropSize,
    );

    final List<HomeCategoryEntity> mappedCategories = mapGenreIdsToCategories(
      genreIds: movie.genreIds ?? <int>[],
      categories: categories,
    );

    return MovieEntity(
      id: movieEntity.id,
      cardImagePath: cardImagePath,
      bannerImagePath: bannerImagePath,
      title: movieEntity.title,
      description: movieEntity.description,
      genreIds: movieEntity.genreIds,
      categories: mappedCategories,
      popularity: movieEntity.popularity,
      releaseDate: movieEntity.releaseDate,
      voteAverage: movieEntity.voteAverage,
      voteCount: movieEntity.voteCount,
    );
  }

  static String? _buildImageUrl({
    required String? basePath,
    required String? baseUrl,
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
