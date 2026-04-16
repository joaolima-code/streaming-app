// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesListModel _$MoviesListModelFromJson(Map<String, dynamic> json) =>
    MoviesListModel(
      dates: json['dates'] == null
          ? null
          : Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num?)?.toInt(),
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => MovieResponseModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <MovieResponseModel>[],
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalResults: (json['total_results'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MoviesListModelToJson(MoviesListModel instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
  maximum: json['maximum'] as String?,
  minimum: json['minimum'] as String?,
);

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
  'maximum': instance.maximum,
  'minimum': instance.minimum,
};
