import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/core_base_reponse.dart';
import '../../../movies/domain/entity/movie_entity.dart';
import '../../../movies/domain/entity/movies_list_entity.dart';
import '../../../movies/domain/entity/movies_list_filter.dart';
import '../../../movies/domain/usecase/get_movies_popular_usecase.dart';
import 'carousel_state.dart';

class PopularCarouselCubit extends Cubit<MoviesListState> {
  PopularCarouselCubit(this._getMoviesPopularUsecase)
    : super(MoviesListInitial());

  final GetMoviesPopularUsecase _getMoviesPopularUsecase;
  MoviesListFilter _currentFilter = const MoviesListFilter();

  Future<void> loadMovies() async {
    if (state is MoviesListLoading) {
      return;
    }

    emit(MoviesListLoading());
    try {
      final CoreBaseResponse<MoviesListEntity> response =
          await _getMoviesPopularUsecase(_currentFilter);

      if (response.isError) {
        emit(MoviesListError('Erro ao carregar filmes populares'));
        return;
      }

      if (response.data == null) {
        emit(MoviesListError('Dados não disponíveis'));
        return;
      }

      emit(
        MoviesListSuccess(
          movies: response.data!.results,
          currentPage: response.data!.page ?? 1,
          totalPages: response.data!.totalPages ?? 1,
        ),
      );
    } catch (e) {
      emit(MoviesListError(e.toString()));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state is! MoviesListSuccess) {
      return;
    }

    final MoviesListSuccess currentState = state as MoviesListSuccess;
    if (!currentState.hasMorePages) {
      return;
    }

    try {
      _currentFilter = _currentFilter.copyWith(
        page: currentState.currentPage + 1,
      );
      final CoreBaseResponse<MoviesListEntity> response =
          await _getMoviesPopularUsecase(_currentFilter);

      if (response.isError) {
        _currentFilter = _currentFilter.copyWith(page: _currentFilter.page - 1);
        return;
      }

      if (response.data == null) {
        _currentFilter = _currentFilter.copyWith(page: _currentFilter.page - 1);
        return;
      }

      final List<MovieEntity> newMovies = <MovieEntity>[
        ...currentState.movies,
        ...response.data!.results,
      ];

      emit(
        MoviesListSuccess(
          movies: newMovies,
          currentPage: _currentFilter.page,
          totalPages: response.data!.totalPages ?? 1,
        ),
      );
    } catch (e) {
      _currentFilter = _currentFilter.copyWith(page: _currentFilter.page - 1);
    }
  }
}
