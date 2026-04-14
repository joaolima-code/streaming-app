// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListCategoriesModel _$HomeListCategoriesModelFromJson(
  Map<String, dynamic> json,
) => HomeListCategoriesModel(
  genres:
      (json['genres'] as List<dynamic>?)
          ?.map((e) => HomeCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HomeCategoryModel>[],
);

HomeCategoryModel _$HomeCategoryModelFromJson(Map<String, dynamic> json) =>
    HomeCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );
