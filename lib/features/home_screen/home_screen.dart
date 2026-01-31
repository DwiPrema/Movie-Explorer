import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
      context.read<MovieProvider>().load("harry potter");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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

          Consumer<MovieProvider>(
            builder: (_, provider, _) {
              if (provider.isLoading) {
                return Center(child: const CircularProgressIndicator());
              }

              return SizedBox(
                height: 250,
                child: CarouselSlider(
                  items: provider.movies
                      .where((movie) => movie.poster.isNotEmpty)
                      .map((movie) {
                        return Image.network(
                          movie.poster,
                          fit: BoxFit.cover,
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
                              color: Colors.blue,
                            );
                          },
                        );
                      })
                      .take(2)
                      .toList(),
                  options: CarouselOptions(viewportFraction: 1, autoPlay: true),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
