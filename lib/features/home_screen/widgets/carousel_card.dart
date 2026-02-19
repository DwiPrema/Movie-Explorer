import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/utils/responsive_helper.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_view_model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/selector_category.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_status.dart';
import 'package:movie_omdbid_api/widgets/movie_card.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class CarouselCard extends StatelessWidget {
  final String textTitleCategory;
  final MovieCategory category;
  final bool isDates;

  const CarouselCard({super.key, this.isDates = false, required this.textTitleCategory, required this.category});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocSelector<MovieBloc, MovieState, MovieCategoryViewData>(
      selector: (state) => selectMovieCategory(state, category),
      builder: (context, state) {
        final status = state.status;
        switch (status) {
          case MovieStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case MovieStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MovieStatus.success:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: title(
                          textTitleCategory,
                          fontSize: 16,
                          align: TextAlign.left,
                        ),
                      ),
                      isDates == true
                          ? Expanded(
                              child: subtitle(
                                "Date Range : ${state.dates?.minimum} - ${state.dates?.maximum}",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                align: TextAlign.right,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: state.movies.where((m) => m.isValid).map((movie) {
                      return MovieCard(movie: movie);
                    }).toList(),
                    options: CarouselOptions(
                      height: ResponsiveHelper.heightCarousel(screenWidth),
                      autoPlay: false,
                      viewportFraction: ResponsiveHelper.viewportFraction(
                        screenWidth,
                      ),
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
          case MovieStatus.error:
            return Text(state.errorMessage ?? "Something went wrong :(");
        }
      },
    );
  }
}
