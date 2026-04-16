import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/domain/entity/movie_entity.dart';
import 'carousel_state.dart';
import 'home_central_state.dart';
import 'now_playing_carousel_cubit.dart';
import 'popular_carousel_cubit.dart';

class HomeCentralCubit extends Cubit<HomeCentralState> {
  HomeCentralCubit({
    required NowPlayingCarouselCubit nowPlayingCarouselCubit,
    required PopularCarouselCubit popularCarouselCubit,
  }) : _nowPlayingCarouselCubit = nowPlayingCarouselCubit,
       _popularCarouselCubit = popularCarouselCubit,
       super(HomeCentralInitial());

  final NowPlayingCarouselCubit _nowPlayingCarouselCubit;
  final PopularCarouselCubit _popularCarouselCubit;
  final List<MovieEntity> _hypeMovies = <MovieEntity>[];

  StreamSubscription<MoviesListState>? _nowPlayingSub;
  StreamSubscription<MoviesListState>? _popularSub;

  Future<void> initializeHome() async {
    emit(HomeCentralLoading());

    _setupListeners();

    try {
      await Future.wait(<Future<void>>[
        _nowPlayingCarouselCubit.loadMovies(),
        _popularCarouselCubit.loadMovies(),
      ]);
    } catch (e) {
      emit(HomeCentralError(e.toString()));
    }
  }

  void _setupListeners() {
    _nowPlayingSub?.cancel();
    _popularSub?.cancel();

    _nowPlayingSub = _nowPlayingCarouselCubit.stream.listen(
      (MoviesListState state) => _updateState(state),
    );
    _popularSub = _popularCarouselCubit.stream.listen(
      (MoviesListState state) => _updateState(state),
    );
  }

  void _updateState(MoviesListState currentState) {
    if (currentState is MoviesListError) {
      emit(SnackError(currentState.message));
      return;
    }

    final MoviesListState nowPlayingState = _nowPlayingCarouselCubit.state;
    final MoviesListState popularState = _popularCarouselCubit.state;

    List<MovieEntity> nowPlayingMovies = <MovieEntity>[];
    if (nowPlayingState is MoviesListSuccess) {
      nowPlayingMovies = nowPlayingState.movies;
    }

    List<MovieEntity> popularMovies = <MovieEntity>[];
    if (popularState is MoviesListSuccess) {
      popularMovies = popularState.movies;
    }

    if (nowPlayingMovies.isNotEmpty || popularMovies.isNotEmpty) {
      _calculateHypeMovies(<MovieEntity>[
        ...nowPlayingMovies,
        ...popularMovies,
      ]);
    }

    emit(
      HomeCentralSuccess(
        hypeMovies: _hypeMovies,
        isNowPlayingLoading: nowPlayingState is MoviesListLoading,
        nowPlayingMovies: nowPlayingMovies,
        isPopularLoading: popularState is MoviesListLoading,
        popularMovies: popularMovies,
      ),
    );
  }

  void _calculateHypeMovies(List<MovieEntity> movies) {
    if (movies.isEmpty || _hypeMovies.isNotEmpty) {
      return;
    }

    final List<MovieEntity> uniqueMovies = movies.toSet().toList();
    uniqueMovies.sort(
      (MovieEntity a, MovieEntity b) => b.voteAverage.compareTo(a.voteAverage),
    );

    _hypeMovies.clear();
    _hypeMovies.addAll(uniqueMovies.take(3));
  }

  Future<void> loadMoreNowPlaying() async {
    await _nowPlayingCarouselCubit.loadMoreMovies();
  }

  Future<void> loadMorePopular() async {
    await _popularCarouselCubit.loadMoreMovies();
  }

  @override
  Future<void> close() {
    _nowPlayingSub?.cancel();
    _popularSub?.cancel();
    return super.close();
  }
}
