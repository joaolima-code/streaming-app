import 'package:json_annotation/json_annotation.dart';

part 'movie_response_model.g.dart';

@JsonSerializable(createToJson: true)
class MovieResponseModel {
  MovieResponseModel({
    required this.id,
    required this.title,
    required this.overview,
    this.originalTitle,
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
  String overview;
  double? popularity;
  String title;
  bool? video;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @JsonKey(name: 'vote_count')
  int? voteCount;
}
