// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_config_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeConfigImageModel _$HomeConfigImageModelFromJson(
  Map<String, dynamic> json,
) => HomeConfigImageModel(
  images: HomeImagesModel.fromJson(json['images'] as Map<String, dynamic>),
  changeKeys: (json['changeKeys'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

HomeImagesModel _$HomeImagesModelFromJson(Map<String, dynamic> json) =>
    HomeImagesModel(
      baseUrl: json['baseUrl'] as String?,
      secureBaseUrl: json['secureBaseUrl'] as String?,
      backdropSizes: (json['backdropSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      logoSizes: (json['logoSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      posterSizes: (json['posterSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileSizes: (json['profileSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stillSizes: (json['stillSizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
