import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/home_category_model.dart';

part 'movie_detail_response_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieDetailResponseModel {
  MovieDetailResponseModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.backdropPath,
    this.adult,
    this.budget,
    this.genres,
    this.homepage,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResponseModelFromJson(json);

  int id;
  String title;
  String overview;
  bool? adult;
  int? budget;
  List<HomeCategoryModel>? genres;
  String? homepage;
  double? popularity;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  bool? video;

  @JsonKey(name: 'original_title')
  String originalTitle;

  @JsonKey(name: 'backdrop_path')
  String backdropPath;

  @JsonKey(name: 'imdb_id')
  String? imdbId;

  @JsonKey(name: 'origin_country')
  List<String>? originCountry;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'vote_count')
  int? voteCount;
}
