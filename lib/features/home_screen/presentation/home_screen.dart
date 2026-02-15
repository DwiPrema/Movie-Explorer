import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/core/utils/responsive_helper.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';
import 'package:movie_omdbid_api/widgets/movie_card.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieBloc>()
        ..add(LoadMovie(category: MovieCategory.upComing))
        ..add(LoadMovie(category: MovieCategory.nowPlaying));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/logo_movie.png",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
                title("MovieExplorer"),
              ],
            ),
          ),

          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const CircularProgressIndicator();
              } else if (state is MovieLoaded) {
                final upComing = state.movies[MovieCategory.upComing] ?? [];

                return SizedBox(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: upComing
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
                );
              } else if (state is MovieError) {
                return Center(child: subtitle(state.err));
              } else {
                return Center(child: title("Something went wrong :( !!"));
              }
            },
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

          const SizedBox(height: 50),

          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const CircularProgressIndicator();
              } else if (state is MovieLoaded) {
                final nowPlaying = state.movies[MovieCategory.nowPlaying] ?? [];
                final DateRange? dates = state.dates![MovieCategory.nowPlaying];

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
                              "Now Playing",
                              fontSize: 16,
                              align: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: subtitle(
                              "Date Range : ${dates?.minimum} - ${dates?.maximum}",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              align: TextAlign.right
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CarouselSlider(
                        items: nowPlaying.where((m) => m.isValid).map((movie) {
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
              } else if (state is MovieError) {
                return Center(child: subtitle(state.err));
              } else {
                return Center(child: title("Something went wrong :( !!"));
              }
            },
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
