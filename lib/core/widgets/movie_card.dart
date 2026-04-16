import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typogaphy.dart';
import 'cached_image_widget.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.onTap,
    this.width = 160,
    this.height = 240,
    super.key,
  });

  final String? imageUrl;
  final String title;
  final double? rating;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CachedImageWidget(
                imageUrl: imageUrl,
                width: width,
                height: height,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
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
                        size: 14,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating?.toStringAsFixed(1) ?? 'N/A',
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: width,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
