import 'package:equatable/equatable.dart';

import '../../../../core/helper/date_helper.dart';
import '../../../home/data/model/home_category_model.dart';
import '../../../home/domain/entity/home_category_entity.dart';
import '../../data/model/movie_detail_response_model.dart';

class MovieDetailEntity extends Equatable {
  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.originalTitle,
    this.bannerImagePath,
    this.categories = const <HomeCategoryEntity>[],
    this.cardImagePath,
    this.runtime,
    this.tagline,
    this.releaseDate,
    this.voteAverage = 0.0,
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
        releaseDate: model.releaseDate.toMonthYear(),
        voteAverage: model.voteAverage ?? 0.0,
        voteCount: model.voteCount,
        runtime: model.runtime,
        tagline: model.tagline,
        categories:
            model.genres
                ?.map(
                  (HomeCategoryModel genre) =>
                      HomeCategoryEntity(id: genre.id, name: genre.name),
                )
                .toList() ??
            <HomeCategoryEntity>[],
      );

  final int id;
  final String title;
  final String description;
  final String originalTitle;
  final String? bannerImagePath;
  final String? cardImagePath;
  final double voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<HomeCategoryEntity> categories;
  final int? runtime;
  final String? tagline;

  MovieDetailEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? originalTitle,
    String? bannerImagePath,
    String? cardImagePath,
    double? voteAverage,
    int? voteCount,
    String? releaseDate,
    List<HomeCategoryEntity>? categories,
    int? runtime,
    String? tagline,
  }) {
    return MovieDetailEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      originalTitle: originalTitle ?? this.originalTitle,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      cardImagePath: cardImagePath ?? this.cardImagePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      categories: categories ?? this.categories,
      runtime: runtime ?? this.runtime,
      tagline: tagline ?? this.tagline,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    description,
    originalTitle,
    bannerImagePath,
    cardImagePath,
    voteAverage,
    voteCount,
    releaseDate,
    categories,
    runtime,
    tagline,
  ];
}
