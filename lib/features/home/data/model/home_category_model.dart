import 'package:json_annotation/json_annotation.dart';

part 'home_category_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeListCategoriesModel {
  const HomeListCategoriesModel({this.genres = const <HomeCategoryModel>[]});

  factory HomeListCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$HomeListCategoriesModelFromJson(json);

  final List<HomeCategoryModel> genres;
}

@JsonSerializable(createToJson: false)
class HomeCategoryModel {
  const HomeCategoryModel({required this.id, required this.name});

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$HomeCategoryModelFromJson(json);

  final int id;
  final String name;
}
