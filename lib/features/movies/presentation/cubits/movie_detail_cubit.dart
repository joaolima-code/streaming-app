import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/core_base_reponse.dart';
import '../../domain/entity/movie_detail_entity.dart';
import '../../domain/usecase/get_movie_detail_usecase.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this._getMovieDetailUsecase) : super(MovieDetailInitial());

  final GetMovieDetailUsecase _getMovieDetailUsecase;

  Future<void> loadMovieDetail(int movieId) async {
    emit(MovieDetailLoading());

    try {
      final CoreBaseResponse<MovieDetailEntity> response =
          await _getMovieDetailUsecase(movieId);

      if (response.isError || response.data == null) {
        emit(const MovieDetailError('Erro ao carregar detalhes do filme'));
        return;
      }

      emit(MovieDetailSuccess(response.data!));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
