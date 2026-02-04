import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/home_screen/movie_provider.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';
import 'package:provider/provider.dart';

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
      context.read<MovieProvider>().loadMany([
        "batman",
        "joker",
        "harry potter",
        "avengers",
        "spiderman",
      ]);
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

        Consumer<MovieProvider>(
          builder: (_, provider, _) {
            if (provider.isLoading) {
              return Center(child: const CircularProgressIndicator());
            }

            return SizedBox(
              width: double.infinity,
              child: CarouselSlider(
                items: provider.movies
                    .where(
                      (movie) =>
                          movie.poster != "N/A" && movie.poster.isNotEmpty,
                    )
                    .map((movie) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            movie.poster,
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
          },
        ),

        SizedBox(height: 32),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _currentIndex == index ? 25 : 12,
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
