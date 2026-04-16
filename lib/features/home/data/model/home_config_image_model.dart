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

  @JsonKey(name: 'base_url')
  String? baseUrl;

  @JsonKey(name: 'secure_base_url')
  String? secureBaseUrl;

  @JsonKey(name: 'backdrop_sizes')
  List<String>? backdropSizes;

  @JsonKey(name: 'logo_sizes')
  List<String>? logoSizes;

  @JsonKey(name: 'poster_sizes')
  List<String>? posterSizes;

  @JsonKey(name: 'profile_sizes')
  List<String>? profileSizes;

  @JsonKey(name: 'still_sizes')
  List<String>? stillSizes;
}
