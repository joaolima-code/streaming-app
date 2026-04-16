import '../../../movies/domain/entity/movie_entity.dart';

abstract class MoviesListState {}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListSuccess extends MoviesListState {
  MoviesListSuccess({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });

  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;

  bool get hasMorePages => currentPage < totalPages;
}

class MoviesListError extends MoviesListState {
  MoviesListError(this.message);
  final String message;
}
