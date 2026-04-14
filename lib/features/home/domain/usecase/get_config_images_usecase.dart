import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../entity/home_config_image_entity.dart';
import '../repository/home_repository.dart';

class GetConfigImagesUsecase
    implements RemoteUsecaseInterface<HomeConfigImageEntity> {
  GetConfigImagesUsecase(this._repository);

  final HomeRepository _repository;

  @override
  Future<CoreBaseResponse<HomeConfigImageEntity>> call() {
    return _repository.configImages();
  }
}
