import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isPortrait;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isPortrait = false,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheHeight: height != null && height!.isFinite && height! > 0
          ? (height! * MediaQuery.of(context).devicePixelRatio).round()
          : null,
      memCacheWidth: width != null && width!.isFinite && width! > 0
          ? (width! * MediaQuery.of(context).devicePixelRatio).round()
          : null,
      maxHeightDiskCache: 1000,
      maxWidthDiskCache: 1000,
      placeholder: (context, url) =>
          isPortrait ? Image.asset("assets/images/image_placeholder_portrait.jpg", fit: BoxFit.cover) : Image.asset("assets/images/image_placeholder.jpg", fit: BoxFit.cover),
      errorWidget: (context, url, error) => const _ImageError(),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
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
