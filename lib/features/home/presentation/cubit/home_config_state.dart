import '../../domain/entity/home_category_entity.dart';
import '../../domain/entity/home_config_image_entity.dart';

abstract class HomeConfigState {
  const HomeConfigState();
}

class HomeConfigInitial extends HomeConfigState {}

class HomeConfigLoading extends HomeConfigState {}

class HomeConfigSuccess extends HomeConfigState {
  const HomeConfigSuccess({
    required this.imageConfig,
    required this.categories,
  });

  final HomeConfigImageEntity imageConfig;
  final List<HomeCategoryEntity> categories;
}

class HomeConfigError extends HomeConfigState {
  const HomeConfigError(this.message);

  final String message;
}
