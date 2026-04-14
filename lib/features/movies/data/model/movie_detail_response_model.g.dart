// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailResponseModel _$MovieDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailResponseModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  originalTitle: json['originalTitle'] as String,
  overview: json['overview'] as String,
  backdropPath: json['backdropPath'] as String,
  adult: json['adult'] as bool?,
  budget: (json['budget'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)
      ?.map((e) => HomeCategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  homepage: json['homepage'] as String?,
  imdbId: json['imdbId'] as String?,
  originCountry: (json['originCountry'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  originalLanguage: json['originalLanguage'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  posterPath: json['posterPath'] as String?,
  releaseDate: json['releaseDate'] as String?,
  revenue: (json['revenue'] as num?)?.toInt(),
  runtime: (json['runtime'] as num?)?.toInt(),
  status: json['status'] as String?,
  tagline: json['tagline'] as String?,
  video: json['video'] as bool?,
  voteAverage: (json['voteAverage'] as num?)?.toDouble(),
  voteCount: (json['voteCount'] as num?)?.toInt(),
);
