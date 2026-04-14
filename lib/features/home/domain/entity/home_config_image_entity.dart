import 'package:equatable/equatable.dart';

import '../../data/model/home_config_image_model.dart';

class HomeConfigImageEntity extends Equatable {
  const HomeConfigImageEntity({
    this.baseUrl,
    this.secureBaseUrl,
    this.backdropSizes,
    this.posterSizes,
  });

  factory HomeConfigImageEntity.fromModel(HomeImagesModel model) {
    return HomeConfigImageEntity(
      baseUrl: model.baseUrl,
      secureBaseUrl: model.secureBaseUrl,
      backdropSizes: model.backdropSizes,
      posterSizes: model.posterSizes,
    );
  }

  final String? baseUrl;
  final String? secureBaseUrl;
  final List<String>? backdropSizes;
  final List<String>? posterSizes;

  @override
  List<Object?> get props => <Object?>[
    baseUrl,
    secureBaseUrl,
    backdropSizes,
    posterSizes,
  ];
}
