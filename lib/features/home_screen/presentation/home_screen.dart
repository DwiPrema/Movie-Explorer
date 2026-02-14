import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
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
      context.read<MovieBloc>().add(LoadMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
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
              return CircularProgressIndicator();
            } else if (state is MovieLoaded) {
              return SizedBox(
                width: double.infinity,
                child: CarouselSlider(
                  items: state.movies
                      .where((movie) => movie.poster != null && movie.poster!.isNotEmpty && movie.posterUrl().isNotEmpty)
                      .map((movie) {
                        return Padding(
                          padding: EdgeInsets.all(16),
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
                    height: 250,
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

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
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
  }
}
