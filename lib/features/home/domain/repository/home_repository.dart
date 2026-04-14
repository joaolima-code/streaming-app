import '../../../../core/network/core_base_reponse.dart';
import '../entity/home_category_entity.dart';
import '../entity/home_config_image_entity.dart';

abstract class HomeRepository {
  Future<CoreBaseResponse<HomeConfigImageEntity>> configImages();

  Future<CoreBaseResponse<List<HomeCategoryEntity>>> listMovieCategories();
}
