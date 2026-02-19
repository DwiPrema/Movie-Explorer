import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_view_model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/selector_category.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_status.dart';

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
            return const Center(child: CircularProgressIndicator());
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
                              movie.posterUrl().isNotEmpty,
                        )
                        .map((movie) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                movie.posterUrl(),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 80,
                                    color: AppColors.primaryColor,
                                  );
                                },
                              ),
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
            return Text(state.errorMessage ?? "Something went wrong :(");
        }
      },
    );
  }
}
