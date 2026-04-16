import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_typogaphy.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../movies/domain/entity/movie_entity.dart';
import '../cubit/home_central_cubit.dart';
import '../cubit/home_central_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCentralCubit>.value(
        value: GetIt.instance<HomeCentralCubit>()..initializeHome(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(child:
                  BlocBuilder<HomeCentralCubit, HomeCentralState>(
                      builder: (BuildContext context, HomeCentralState state) {
                if (state is HomeCentralLoading) {
                  return const Center(
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator()));
                }

                if (state is HomeCentralError) {
                  return Center(
                      child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(state.message)));
                }

                if (state is HomeCentralSuccess) {
                  return _buildMainContent(context, state);
                }

                return const SizedBox.shrink();
              }))
            ],
          ),
        ));
  }

  Widget _buildMainContent(BuildContext context, HomeCentralSuccess state) {
    return Column(
      children: <Widget>[
        // Criar logica para esse mainCarousel
        if (state.hypeMovies.isNotEmpty) ...<Widget>[
          _buildMainCarousel(context, state),
          const SizedBox(height: 24),
        ],
        _buildCarouselSection(
          context,
          title: 'Em cartaz',
          movies: state.nowPlayingMovies,
          isLoading: state.isNowPlayingLoading,
          onLoadMore: () =>
              context.read<HomeCentralCubit>().loadMoreNowPlaying(),
        ),
        const SizedBox(height: 32),
        _buildCarouselSection(
          context,
          title: 'Populares',
          movies: state.popularMovies,
          isLoading: state.isPopularLoading,
          onLoadMore: () => context.read<HomeCentralCubit>().loadMorePopular(),
        ),
        if (state.popularMovies.isEmpty &&
            state.nowPlayingMovies.isEmpty) ...<Widget>[
          const SizedBox(height: 32),
          const Text('Nenhum filme encontrado.'),
        ],
        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ],
    );
  }

  Widget _buildMainCarousel(BuildContext context, HomeCentralSuccess state) {
    final List<MovieEntity> mainMovies = state.hypeMovies.take(3).toList();

    return MovieCarouselMain(
        items: mainMovies,
        onItemTap: (String movieId) {
          context.push('/movie/$movieId');
        });
  }

  Widget _buildCarouselSection(BuildContext context,
      {required String title,
      required List<MovieEntity> movies,
      required bool isLoading,
      required VoidCallback onLoadMore}) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: AppTypography.headlineMedium),
        ),
        const SizedBox(height: 16),
        MovieCarouselSmall(
            items: movies,
            onItemTap: (String movieId) {
              context.push('/movie/$movieId');
            },
            onLoadMore: onLoadMore,
            isLoading: isLoading,
            hasMorePages: movies.length >= 20)
      ],
    );
  }
}
