import 'package:equatable/equatable.dart';

import '../../data/model/movie_response_model.dart';
import '../../data/model/movies_list_model.dart';
import 'movie_entity.dart';

class MoviesListEntity extends Equatable {
  const MoviesListEntity({
    this.page,
    this.results = const <MovieEntity>[],
    this.totalPages,
  });

  factory MoviesListEntity.fromModel(MoviesListModel model) => MoviesListEntity(
    page: model.page,
    results: model.results
        .map((MovieResponseModel result) => MovieEntity.fromModel(result))
        .toList(),
    totalPages: model.totalPages,
  );

  final int? page;
  final List<MovieEntity> results;
  final int? totalPages;

  @override
  List<Object?> get props => <Object?>[page, results, totalPages];
}
