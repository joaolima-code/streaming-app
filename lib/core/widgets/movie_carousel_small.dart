import 'package:flutter/material.dart';
import '../../features/movies/domain/entity/movie_entity.dart';
import '../theme/app_colors.dart';
import 'cached_image_widget.dart';

class MovieCarouselSmall extends StatefulWidget {
  const MovieCarouselSmall({
    required this.items,
    required this.onItemTap,
    this.onLoadMore,
    this.isLoading = false,
    this.hasMorePages = false,
    super.key,
  });

  final List<MovieEntity> items;
  final Function(String movieId) onItemTap;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  final bool hasMorePages;

  @override
  State<MovieCarouselSmall> createState() => _MovieCarouselSmallState();
}

class _MovieCarouselSmallState extends State<MovieCarouselSmall> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.items.length +
                  (widget.hasMorePages && !widget.isLoading ? 1 : 0),
              cacheExtent: 500,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (BuildContext context, int index) {
                if (index == widget.items.length) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: widget.onLoadMore,
                        child: Center(
                          child: widget.isLoading
                              ? const CircularProgressIndicator()
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                      Icon(Icons.add_circle_outline, size: 40),
                                      SizedBox(height: 8),
                                      Text('Carregar mais')
                                    ]),
                        ),
                      ));
                }

                return _buildCarouselItem(context, index);
              },
            ))
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int index) {
    if (index >= widget.items.length) {
      return const SizedBox.shrink();
    }

    final MovieEntity item = widget.items[index];
    return Container(
        constraints: const BoxConstraints(maxWidth: 190),
        padding: const EdgeInsets.only(right: 8),
        child: GestureDetector(
            onTap: () => widget.onItemTap(item.id.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: CachedImageWidget(
                      imageUrl: item.cardImagePath, width: 180, height: 200),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(item.title ?? 'Title nao encontrado',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                if (item.voteAverage > 0) ...<Widget>[
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.ratingStar,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.star_rounded,
                                      size: 14, color: Colors.black),
                                  const SizedBox(width: 4),
                                  Text(item.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          height: 1.2,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black))
                                ],
                              )),
                          const SizedBox(width: 12),
                          if (item.releaseDate != null)
                            Text(item.releaseDate!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.2,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70))
                        ]),
                  )
                ]
              ],
            )));
  }
}
