import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../entity/home_category_entity.dart';
import '../repository/home_repository.dart';

class GetListMovieCategoryUsecase
    implements RemoteUsecaseInterface<List<HomeCategoryEntity>> {
  GetListMovieCategoryUsecase(this._repository);

  final HomeRepository _repository;

  @override
  Future<CoreBaseResponse<List<HomeCategoryEntity>>> call() {
    return _repository.listMovieCategories();
  }
}
