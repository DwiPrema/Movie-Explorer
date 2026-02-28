import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_view_model.dart';
import 'package:movie_explorer/features/home_screen/data/models/selector_category.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_status.dart';
import 'package:movie_explorer/widgets/error_widget/error_widget.dart';
import 'package:movie_explorer/widgets/image/app_cached_image.dart';

class CarouselImage extends StatefulWidget {
  final MovieCategory category;
  const CarouselImage({super.key, required this.category});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocSelector<MovieBloc, MovieState, MovieCategoryViewData>(
      selector: (state) => selectMovieCategory(state, widget.category),
      builder: (context, state) {
        final status = state.status;
        switch (status) {
          case MovieStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case MovieStatus.loading:
            return Column(
              children: [
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentIndex == index ? 25 : 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? AppColors.primaryColor
                            : AppColors.white.withAlpha(100),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  }),
                ),
              ],
            );
          case MovieStatus.success:
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: state.movies
                        .where(
                          (movie) =>
                              movie.poster != null &&
                              movie.poster!.isNotEmpty &&
                              movie.backdropUrl().isNotEmpty,
                        )
                        .map((movie) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: AppCachedImage(
                              aspectRatio: const AspectRatio(
                                aspectRatio: 16 / 9,
                              ),
                              imageUrl: movie.backdropUrl(),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          );
                        })
                        .toList(),
                    options: CarouselOptions(
                      height: screenHeight * 0.3,
                      viewportFraction: 1,
                      autoPlay: true,
                      onPageChanged: (index, reason) => setState(() {
                        _currentIndex = index;
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(state.movies.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentIndex == index ? 25 : 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? AppColors.primaryColor
                            : AppColors.white.withAlpha(100),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  }),
                ),
              ],
            );
          case MovieStatus.error:
            return ErrorPage(errMsg: state.errorMessage ?? "Something Went Wrong !");
        }
      },
    );
  }
}
