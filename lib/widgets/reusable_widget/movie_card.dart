import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/widgets/image/app_cached_image.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final GestureTapCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withAlpha(150),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCachedImage(
                  imageUrl: movie.posterUrl(size: "w342"),
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "RedHatDisplay",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      subtitle(
                        "Released date : ${movie.year}",
                        align: TextAlign.left,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
