import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/core/routes/app_routes.dart';
import 'package:movie_explorer/features/movie_detail/presentation/view_model.dart';
import 'package:movie_explorer/widgets/image/app_cached_image.dart';
import 'package:movie_explorer/widgets/reusable_widget/readmore_text.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class DetailHeader extends StatelessWidget {
  final MovieDetailViewModel state;
  const DetailHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppCachedImage(
                  imageUrl: state.backdropUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.bgColor,
                        AppColors.bgColor.withAlpha(127),
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.bgColor.withAlpha(127),
                        AppColors.bgColor,
                      ],
                    ),
                  ),
                ),
              ),

              // Back button & title
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, AppRoutes.home);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.white.withAlpha(50),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    subtitle(
                      "DISPLAY MOVIE DETAILS",
                      align: TextAlign.center,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ),

              // Movie title
              Positioned(
                left: 16,
                bottom: 5,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.title,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "RacingSansOne",
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subtitle(
                  "${state.popularity} popularity",
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(height: 16),
                ReadmoreText(text: state.overview),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
