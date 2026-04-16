import 'dart:async';

import 'package:flutter/material.dart';
import '../../features/home/domain/entity/home_category_entity.dart';
import '../../features/movies/domain/entity/movie_entity.dart';
import '../theme/app_colors.dart';
import 'cached_image_widget.dart';

class MovieCarouselMain extends StatefulWidget {
  const MovieCarouselMain({
    required this.items,
    required this.onItemTap,
    super.key,
  });

  final List<MovieEntity> items;
  final Function(String movieId) onItemTap;

  @override
  State<MovieCarouselMain> createState() => _MovieCarouselMainState();
}

class _MovieCarouselMainState extends State<MovieCarouselMain>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _nextPage();
            }
          });

    _startTimer();
  }

  void _startTimer() {
    _progressController.forward(from: 0);
  }

  void _nextPage() {
    if (_currentPage < widget.items.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment:
          Alignment.bottomCenter, // Alinha os filhos ao centro/baixo por padrão
      children: <Widget>[
        SizedBox(
          height: screenHeight * 0.55,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (int index) {
              setState(() => _currentPage = index);
              _progressController.forward(from: 0);
            },
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCarouselItem(context, widget.items[index]);
            },
          ),
        ),
        Positioned(
          bottom: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              widget.items.length,
              (int index) => _buildProgressDot(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDot(int index) {
    final bool isSelected = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 4,
      width: isSelected ? 30 : 6,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: isSelected
          ? AnimatedBuilder(
              animation: _progressController,
              builder: (BuildContext context, Widget? child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressController.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }

  Widget _buildCarouselItem(BuildContext context, MovieEntity item) {
    return GestureDetector(
      onTap: () => widget.onItemTap(item.id.toString()),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedImageWidget(
            imageUrl: item.bannerImagePath,
            width: double.infinity,
            height: double.infinity,
            borderRadius: 0,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: <Color>[
                  AppColors.background.withValues(alpha: 0.7),
                  AppColors.background.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent,
                  AppColors.background.withValues(alpha: 0.7),
                  AppColors.background.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent,
                  AppColors.background.withValues(alpha: 0.75),
                  AppColors.background.withValues(alpha: 0.9),
                  AppColors.background,
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    item.title ?? 'Title nao encontrado',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  if (item.voteAverage > 0) ...<Widget>[
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.ratingStar,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (item.releaseDate != null)
                          Text(
                            item.releaseDate!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (item.categories.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    Row(
                      children: item.categories.take(3).map((
                        HomeCategoryEntity category,
                      ) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    item.description ?? 'Descrição nao encontrada',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
