import 'package:json_annotation/json_annotation.dart';

part 'home_config_image_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeConfigImageModel {
  HomeConfigImageModel({required this.images, this.changeKeys});

  factory HomeConfigImageModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfigImageModelFromJson(json);

  HomeImagesModel images;
  List<String>? changeKeys;
}

@JsonSerializable(createToJson: false)
class HomeImagesModel {
  HomeImagesModel({
    this.baseUrl,
    this.secureBaseUrl,
    this.backdropSizes,
    this.logoSizes,
    this.posterSizes,
    this.profileSizes,
    this.stillSizes,
  });

  factory HomeImagesModel.fromJson(Map<String, dynamic> json) =>
      _$HomeImagesModelFromJson(json);

  String? baseUrl;
  String? secureBaseUrl;
  List<String>? backdropSizes;
  List<String>? logoSizes;
  List<String>? posterSizes;
  List<String>? profileSizes;
  List<String>? stillSizes;
}
