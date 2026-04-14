import '../../../home/domain/entity/home_category_entity.dart';
import '../../data/model/movie_detail_response_model.dart';

class MovieDetailEntity {
  MovieDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.originalTitle,
    this.bannerImagePath,
    this.categories = const <HomeCategoryEntity>[],
    this.cardImagePath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetailEntity.fromModel(MovieDetailResponseModel model) =>
      MovieDetailEntity(
        id: model.id,
        title: model.title,
        description: model.overview,
        originalTitle: model.originalTitle,
        bannerImagePath: model.backdropPath,
        cardImagePath: model.posterPath,
        releaseDate: model.releaseDate,
        voteAverage: model.voteAverage,
        voteCount: model.voteCount,
      );

  int id;
  String title;
  String description;
  String originalTitle;
  String? bannerImagePath;
  String? cardImagePath;
  double? voteAverage;
  int? voteCount;
  String? releaseDate;
  List<HomeCategoryEntity> categories;
  int? runtime;
  String? tagline;

  // String get fullPathCardImage =>
}
