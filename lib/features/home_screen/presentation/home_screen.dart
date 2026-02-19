import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';
import 'package:movie_omdbid_api/features/home_screen/widgets/carousel_card.dart';
import 'package:movie_omdbid_api/features/home_screen/widgets/carousel_image.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieBloc>()
        ..add(LoadMovie(category: MovieCategory.upComing))
        ..add(LoadMovie(category: MovieCategory.nowPlaying))
        ..add(LoadMovie(category: MovieCategory.popular))
        ..add(LoadMovie(category: MovieCategory.topRated));
    });
  }

  @override
  Widget build(BuildContext context) {
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

          const CarouselImage(category: MovieCategory.upComing),

          const SizedBox(height: 50),

          const CarouselCard(
            textTitleCategory: "Now Playing",
            category: MovieCategory.nowPlaying,
          ),

          const SizedBox(height: 50),

          const CarouselCard(
            textTitleCategory: "Popular",
            category: MovieCategory.popular,
          ),

          const SizedBox(height: 50),

          const CarouselCard(
            textTitleCategory: "Top Rated",
            category: MovieCategory.topRated,
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
