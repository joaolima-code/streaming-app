import '../../../movies/domain/entity/movie_detail_entity.dart';

abstract class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends MovieDetailState {
  const MovieDetailSuccess(this.movie);

  final MovieDetailEntity movie;
}

class MovieDetailError extends MovieDetailState {
  const MovieDetailError(this.message);

  final String message;
}
