import 'package:json_annotation/json_annotation.dart';

import 'movie_response_model.dart';

part 'movies_list_model.g.dart';

@JsonSerializable(createToJson: true)
class MoviesListModel {
  MoviesListModel({
    this.dates,
    this.page,
    this.results = const <MovieResponseModel>[],
    this.totalPages,
    this.totalResults,
  });

  factory MoviesListModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesListModelFromJson(json);

  Dates? dates;
  int? page;
  List<MovieResponseModel> results;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'total_results')
  int? totalResults;
}

@JsonSerializable(createToJson: true)
class Dates {
  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  String? maximum;
  String? minimum;
}
