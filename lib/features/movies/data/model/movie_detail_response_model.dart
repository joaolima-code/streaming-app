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
  String originalTitle;
  String backdropPath;
  bool? adult;
  int? budget;
  List<HomeCategoryModel>? genres;
  String? homepage;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  bool? video;
  double? voteAverage;
  int? voteCount;
}
