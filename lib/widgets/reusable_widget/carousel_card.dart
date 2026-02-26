import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer/core/utils/responsive_helper.dart';
import 'package:movie_explorer/core/models/movie_model.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/widgets/reusable_widget/movie_card.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class CarouselCard extends StatelessWidget {
  final String? textTitleCategory;
  final MovieCategory? category;
  final List<MovieModel> movies;
  final String? dates;
  final bool isDates;
  final bool isLoading;
  final String? errorMessage;
  final void Function(MovieModel movie) onMovieTap;

  const CarouselCard({
    super.key,
    this.dates,
    this.isDates = false,
    this.isLoading = false,
    this.errorMessage,
    required this.movies,
    this.textTitleCategory,
    this.category,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return title("Sorry! Something Went Wrong :(");
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (textTitleCategory != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: title(
                    textTitleCategory!,
                    fontSize: 16,
                    align: TextAlign.left,
                  ),
                ),

              (isDates)
                  ? Expanded(
                      child: subtitle(
                        dates ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        align: TextAlign.right,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            items: movies.where((m) => m.isValid).map((movie) {
              return MovieCard(
                movie: movie,
                onTap: () {
                  onMovieTap(movie);
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: ResponsiveHelper.heightCarousel(screenWidth),
              autoPlay: false,
              viewportFraction: ResponsiveHelper.viewportFraction(screenWidth),
              aspectRatio: 2 / 3,
              enableInfiniteScroll: false,
              initialPage: 0,
              enlargeCenterPage: false,
              padEnds: false,
            ),
          ),
        ),
      ],
    );
  }
}
