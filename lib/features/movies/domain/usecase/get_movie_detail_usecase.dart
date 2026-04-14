import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../entity/movie_detail_entity.dart';
import '../repository/movies_repository.dart';

class GetMovieDetailUsecase
    implements RemoteQueryUsecaseInterface<MovieDetailEntity, int> {
  GetMovieDetailUsecase(this._repository);

  final MoviesRepository _repository;

  @override
  Future<CoreBaseResponse<MovieDetailEntity>> call(int params) async {
    return _repository.getMovieDetails(params);
  }
}
