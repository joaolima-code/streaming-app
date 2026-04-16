import 'package:equatable/equatable.dart';

import '../../../../core/helper/date_helper.dart';
import '../../../home/domain/entity/home_category_entity.dart';
import '../../data/model/movie_response_model.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.id,
    this.cardImagePath,
    this.bannerImagePath,
    this.title,
    this.description,
    this.genreIds = const <int>[],
    this.categories = const <HomeCategoryEntity>[],
    this.popularity,
    this.releaseDate,
    this.voteAverage = 0.0,
    this.voteCount,
  });

  factory MovieEntity.fromModel(MovieResponseModel model) => MovieEntity(
    id: model.id,
    cardImagePath: model.posterPath,
    bannerImagePath: model.backdropPath,
    title: model.title,
    description: model.overview,
    genreIds: model.genreIds ?? <int>[],
    popularity: model.popularity,
    releaseDate: model.releaseDate.toMonthYear(),
    voteAverage: model.voteAverage ?? 0.0,
    voteCount: model.voteCount,
  );

  final int id;
  final String? cardImagePath;
  final String? bannerImagePath;
  final List<int> genreIds;
  final List<HomeCategoryEntity> categories;
  final String? title;
  final String? description;
  final double? popularity;
  final String? releaseDate;
  final double voteAverage;
  final int? voteCount;

  MovieEntity copyWith({
    int? id,
    String? cardImagePath,
    String? bannerImagePath,
    List<int>? genreIds,
    List<HomeCategoryEntity>? categories,
    String? title,
    String? description,
    double? popularity,
    String? releaseDate,
    double? voteAverage,
    int? voteCount,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      cardImagePath: cardImagePath ?? this.cardImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      genreIds: genreIds ?? this.genreIds,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      description: description ?? this.description,
      popularity: popularity ?? this.popularity,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    cardImagePath,
    bannerImagePath,
    title,
    description,
    genreIds,
    categories,
    popularity,
    releaseDate,
    voteAverage,
    voteCount,
  ];
}
