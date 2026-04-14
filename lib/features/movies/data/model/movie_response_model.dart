import 'package:json_annotation/json_annotation.dart';

part 'movie_response_model.g.dart';

@JsonSerializable(createToJson: true)
class MovieResponseModel {
  MovieResponseModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  int id;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? originalLanguage;
  String originalTitle;
  String overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool? video;
  double? voteAverage;
  int? voteCount;
}
