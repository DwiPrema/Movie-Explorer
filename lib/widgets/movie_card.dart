import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/core/routes/app_routes.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_model.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.toDetail,
          arguments: movie.movieId,
        );
      },
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterUrl(size: "w342"),
                  ),
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
