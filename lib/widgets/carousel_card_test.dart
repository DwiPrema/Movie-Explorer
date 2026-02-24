import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer/core/utils/responsive_helper.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/widgets/movie_card.dart';
import 'package:movie_explorer/widgets/widget_text.dart';

class CarouselCardTest extends StatelessWidget {
  final String? textTitleCategory;
  final MovieCategory? category;
  final List<MovieModel> movies;
  final String? dates;
  final bool isLoading;
  final String? errorMessage;

  const CarouselCardTest({
    super.key,
    this.dates,
    this.isLoading = false,
    required this.errorMessage,
    required this.movies,
    this.textTitleCategory,
    this.category,
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

              if (dates != null)
                Expanded(
                  child: subtitle(
                    dates!,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.right,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            items: movies.where((m) => m.isValid).map((movie) {
              return MovieCard(movie: movie);
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
