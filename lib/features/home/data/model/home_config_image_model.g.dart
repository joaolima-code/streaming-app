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
      baseUrl: json['base_url'] as String?,
      secureBaseUrl: json['secure_base_url'] as String?,
      backdropSizes: (json['backdrop_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      logoSizes: (json['logo_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      posterSizes: (json['poster_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileSizes: (json['profile_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      stillSizes: (json['still_sizes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
