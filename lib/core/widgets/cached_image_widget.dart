import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 12,
    this.placeholder,
    this.errorWidget,
    super.key,
  });

  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final WidgetBuilder? placeholder;
  final WidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child:
            errorWidget?.call(context) ??
            const Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey),
            ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (BuildContext context, String url) =>
            placeholder?.call(context) ??
            Container(
              color: Colors.grey[850],
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        errorWidget: (BuildContext context, String url, Object error) =>
            errorWidget?.call(context) ??
            Container(
              color: Colors.grey[850],
              child: const Center(
                child: Icon(Icons.error_outline, color: Colors.grey),
              ),
            ),
      ),
    );
  }
}
