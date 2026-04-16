import '../../../../core/helper/movie_config_helper.dart';
import '../../../../core/interface/core_usecase_interface.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../../../home/domain/entity/home_config_image_entity.dart';
import '../../../home/presentation/cubit/home_config_cubit.dart';
import '../entity/movie_detail_entity.dart';
import '../repository/movies_repository.dart';

class GetMovieDetailUsecase
    implements RemoteQueryUsecaseInterface<MovieDetailEntity, int> {
  GetMovieDetailUsecase(this._repository, {required this.homeConfigCubit});

  final MoviesRepository _repository;
  final HomeConfigCubit homeConfigCubit;

  @override
  Future<CoreBaseResponse<MovieDetailEntity>> call(int params) async {
    final HomeConfigImageEntity? imageConfig = homeConfigCubit.imageConfig;

    try {
      final CoreBaseResponse<MovieDetailEntity> response =
          await _repository.getMovieDetails(params);

      if (response.isError || response.data == null) {
        return response;
      }

      final MovieDetailEntity resultMovie = response.data!;

      if (imageConfig != null) {
        final MovieDetailEntity enrichedMovie =
            MovieConfigHelper.configDetailMovieEntity(
                movie: resultMovie, imageConfig: imageConfig);

        return CoreBaseResponse<MovieDetailEntity>(data: enrichedMovie);
      }

      return CoreBaseResponse<MovieDetailEntity>(data: resultMovie);
    } catch (e) {
      return CoreBaseResponse<MovieDetailEntity>(isError: true);
    }
  }
}
