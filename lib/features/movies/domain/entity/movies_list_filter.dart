import 'package:equatable/equatable.dart';

class MoviesListFilter extends Equatable {
  const MoviesListFilter({
    this.page = 1,
    this.language = 'pt-BR',
    this.region = 'BR',
  });

  final int page;
  final String language;
  final String region;

  MoviesListFilter copyWith({int? page, String? language, String? region}) {
    return MoviesListFilter(
      page: page ?? this.page,
      language: language ?? this.language,
      region: region ?? this.region,
    );
  }

  @override
  List<Object?> get props => <Object?>[page, language, region];
}
