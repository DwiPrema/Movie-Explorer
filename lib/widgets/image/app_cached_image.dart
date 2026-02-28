import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final AspectRatio aspectRatio;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final image = AspectRatio(
      aspectRatio: aspectRatio.aspectRatio,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => const _ImageLoading(),
        errorWidget: (context, url, error) => const _ImageError(),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}

class _ImageLoading extends StatelessWidget {
  const _ImageLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        "assets/images/image_placeholder.jpg",
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}

//Error Image
class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );
  }
}
