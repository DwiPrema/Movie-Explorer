import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/widgets/image/app_cached_image.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class MovieTileCard extends StatelessWidget {
  final String titleMovie;
  final String posterUrl;
  final List<String> genres;
  final String popularity;

  const MovieTileCard({
    super.key,
    required this.titleMovie,
    required this.posterUrl,
    required this.genres,
    required this.popularity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 2/3,
                  child: AppCachedImage(
                    aspectRatio: const AspectRatio(aspectRatio: 2/3),
                    imageUrl: posterUrl)),
              ),
          ),

          const SizedBox(width: 16),

          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 4/3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleMovie,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "RacingSansOne",
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                      ),
                    ),
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: genres
                              .map((genre) => _GenreChip(label: genre))
                              .take(4)
                              .toList(),
                        ),
                
                        const SizedBox(height: 12),
                
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            subtitle(
                              popularity,
                              fontSize: 12,
                              color: AppColors.grey,
                              align: TextAlign.left,
                              fontWeight: FontWeight.w900,
                            ),
                          ],
                        ),
                      ],
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

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withAlpha(155),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.grey, fontSize: 10),
      ),
    );
  }
}
