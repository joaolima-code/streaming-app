import '../../../movies/domain/entity/movie_entity.dart';

abstract class HomeCentralState {
  const HomeCentralState();
}

class HomeCentralInitial extends HomeCentralState {}

class HomeCentralLoading extends HomeCentralState {}

class HomeCentralSuccess extends HomeCentralState {
  const HomeCentralSuccess({
    required this.hypeMovies,
    required this.isNowPlayingLoading,
    required this.nowPlayingMovies,
    required this.isPopularLoading,
    required this.popularMovies,
  });

  final List<MovieEntity> hypeMovies;
  final bool isNowPlayingLoading;
  final List<MovieEntity> nowPlayingMovies;
  final bool isPopularLoading;
  final List<MovieEntity> popularMovies;
}

class HomeCentralError extends HomeCentralState {
  const HomeCentralError(this.message);

  final String message;
}

class SnackError extends HomeCentralState {
  const SnackError(this.message);

  final String message;
}
