class MoviesListFilter {
  const MoviesListFilter({
    this.page = 1,
    this.language = 'pt-BR',
    this.region = 'BR',
  });

  final int page;
  final String language;
  final String region;
}
