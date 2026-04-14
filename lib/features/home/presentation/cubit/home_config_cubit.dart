import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/core_base_reponse.dart';
import '../../domain/entity/home_category_entity.dart';
import '../../domain/entity/home_config_image_entity.dart';
import '../../domain/usecase/get_config_images_usecase.dart';
import '../../domain/usecase/get_list_movie_category_usecase.dart';
import 'home_config_state.dart';

class HomeConfigCubit extends Cubit<HomeConfigState> {
  HomeConfigCubit({
    required GetConfigImagesUsecase getConfigImagesUsecase,
    required GetListMovieCategoryUsecase getListMovieCategoryUsecase,
  }) : _getConfigImagesUsecase = getConfigImagesUsecase,
       _getListMovieCategoryUsecase = getListMovieCategoryUsecase,
       super(HomeConfigInitial());

  final GetConfigImagesUsecase _getConfigImagesUsecase;
  final GetListMovieCategoryUsecase _getListMovieCategoryUsecase;

  Future<void> init() async {
    emit(HomeConfigLoading());

    try {
      final List<CoreBaseResponse<dynamic>> results = await Future.wait(
        <Future<CoreBaseResponse<dynamic>>>[
          _getConfigImagesUsecase(),
          _getListMovieCategoryUsecase(),
        ],
      );

      final CoreBaseResponse<dynamic> imageConfigResponse = results[0];
      final CoreBaseResponse<dynamic> categoriesResponse = results[1];

      if (imageConfigResponse.isError || categoriesResponse.isError) {
        final String errorMessage = imageConfigResponse.isError
            ? 'Error ao buscar configuração de imagens'
            : 'Error ao buscar categorias';
        emit(HomeConfigError(errorMessage));
        return;
      }

      final HomeConfigImageEntity? imageConfig =
          imageConfigResponse.data as HomeConfigImageEntity?;
      final List<HomeCategoryEntity> categories =
          categoriesResponse.data as List<HomeCategoryEntity>? ??
          <HomeCategoryEntity>[];

      if (imageConfig == null) {
        emit(const HomeConfigError('Configuração de imagem não encontrada'));
        return;
      }

      emit(HomeConfigSuccess(imageConfig: imageConfig, categories: categories));
    } catch (e) {
      emit(HomeConfigError('Erro ao inicializar config: $e'));
    }
  }

  HomeConfigImageEntity? get imageConfig {
    if (state is HomeConfigSuccess) {
      return (state as HomeConfigSuccess).imageConfig;
    }
    return null;
  }

  List<HomeCategoryEntity> get categories {
    if (state is HomeConfigSuccess) {
      return (state as HomeConfigSuccess).categories;
    }
    return <HomeCategoryEntity>[];
  }
}
