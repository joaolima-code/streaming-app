import '../../../../core/network/core_base_reponse.dart';
import '../../domain/entity/home_category_entity.dart';
import '../../domain/entity/home_config_image_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_remote_datasource.dart';
import '../model/home_category_model.dart';
import '../model/home_config_image_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDatasource);

  final HomeRemoteDatasource _remoteDatasource;

  @override
  Future<CoreBaseResponse<HomeConfigImageEntity>> configImages() async {
    try {
      final HomeConfigImageModel response = await _remoteDatasource
          .configImages();

      return CoreBaseResponse<HomeConfigImageEntity>(
        data: HomeConfigImageEntity.fromModel(response.images),
      );
    } catch (e) {
      return CoreBaseResponse<HomeConfigImageEntity>(isError: true);
    }
  }

  @override
  Future<CoreBaseResponse<List<HomeCategoryEntity>>>
  listMovieCategories() async {
    try {
      final HomeListCategoriesModel response = await _remoteDatasource
          .listCategories();

      return CoreBaseResponse<List<HomeCategoryEntity>>(
        data: response.genres
            .map(
              (HomeCategoryModel category) =>
                  HomeCategoryEntity.fromModel(category),
            )
            .toList(),
      );
    } catch (e) {
      return CoreBaseResponse<List<HomeCategoryEntity>>(isError: true);
    }
  }
}
