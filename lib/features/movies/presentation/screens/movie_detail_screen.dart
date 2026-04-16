import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typogaphy.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../home/domain/entity/home_category_entity.dart';
import '../../domain/entity/movie_detail_entity.dart';
import '../cubits/movie_detail_cubit.dart';
import '../cubits/movie_detail_state.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({required this.movieId, super.key});

  final String? movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    final MovieDetailCubit cubit = GetIt.instance<MovieDetailCubit>();
    if (widget.movieId != null) {
      cubit.loadMovieDetail(int.parse(widget.movieId!));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final double opacity = (offset / 200).clamp(0.0, 1.0);
    setState(() => _appBarOpacity = opacity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>.value(
      value: GetIt.instance<MovieDetailCubit>(),
      child: Scaffold(body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (BuildContext context, MovieDetailState state) {
        if (state is MovieDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MovieDetailError) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.error_outline, size: 64),
                      const SizedBox(height: 16),
                      Text(state.message),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        child: const Text('Voltar'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ])),
          );
        }

        if (state is MovieDetailSuccess) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.sizeOf(context).height * 0.4,
                backgroundColor: AppColors.background.withValues(
                  alpha: _appBarOpacity.clamp(0.0, 1.0),
                ),
                elevation: _appBarOpacity > 0.5 ? 1 : 0,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)),
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                  Transform.scale(
                      scale: 1 +
                          (_scrollController.hasClients
                              ? _scrollController.offset / 1000
                              : 0.0),
                      child: CachedImageWidget(
                          imageUrl: state.movie.bannerImagePath,
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: 0)),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.6),
                        AppColors.background
                      ])))
                ])),
              ),
              SliverToBoxAdapter(
                  child: _buildDetailContent(context, state.movie))
            ],
          );
        }

        return const SizedBox.shrink();
      })),
    );
  }

  Widget _buildDetailContent(BuildContext context, MovieDetailEntity movie) {
    return ColoredBox(
        color: AppColors.background,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(movie.title, style: AppTypography.displayLarge),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.ratingStar,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(movie.voteAverage.toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ))
                                    ])),
                            const SizedBox(width: 16),
                            if (movie.releaseDate != null)
                              Text(
                                movie.releaseDate!.split('-').first,
                                style: AppTypography.bodyLarge,
                              ),
                            const SizedBox(width: 16),
                            if (movie.runtime != null)
                              Row(children: <Widget>[
                                const Icon(Icons.access_time,
                                    size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 6),
                                Text('${movie.runtime} min',
                                    style: AppTypography.bodyMedium)
                              ])
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text('Sinopse', style: AppTypography.titleLarge),
                        const SizedBox(height: 8),
                        Text(movie.description, style: AppTypography.bodyLarge),
                      ])),
              if (movie.categories.isNotEmpty) ...<Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Gêneros',
                              style: AppTypography.titleLarge),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.categories
                                .map<Widget>(
                                  (HomeCategoryEntity genre) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primary),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(genre.name,
                                          style: AppTypography.labelLarge)),
                                )
                                .toList(),
                          )
                        ])),
                const SizedBox(height: 24),
              ],
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppButton(
                          label: 'Ver Agora',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Abrindo player...')));
                          },
                          icon: Icons.play_circle_outline,
                        ),
                        const SizedBox(height: 12),
                        AppButton(
                            label: 'Adicionar à Watchlist',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Adicionado à watchlist')));
                            },
                            variant: AppButtonVariant.outline,
                            icon: Icons.bookmark_border)
                      ])),
              const SizedBox(height: 32),
            ]));
  }
}
