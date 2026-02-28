import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/core/view_model/view_model.dart';
import 'package:movie_explorer/widgets/image/app_cached_image.dart';

class DetailCard extends StatelessWidget {
  final MovieDetailViewModel state;

  const DetailCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff303030),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Poster
                        Flexible(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AppCachedImage(
                              aspectRatio: const AspectRatio(aspectRatio: 2/3),
                              imageUrl: state.posterUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
          
                        // Movie info
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _InfoText("Original title", state.originalTitle),
                              _InfoText(
                                "Original language",
                                state.originalLanguage,
                              ),
                              _InfoText("Released date", state.releaseDate),
                              _InfoText(
                                "Production country",
                                state.productionCountriesText,
                              ),
                              _InfoText("Status", state.status),
                              _InfoText("Tagline", state.tagline),
                              _InfoText("Genres", state.genresText),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "RedHatDisplay",
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "RedHatDisplay",
                color: AppColors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
