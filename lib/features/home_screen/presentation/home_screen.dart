import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/features/home_screen/widgets/carousel_card_category.dart';
import 'package:movie_explorer/features/home_screen/widgets/carousel_backdrop.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

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
      context.read<MovieBloc>().add(LoadHomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MovieBloc>().add(LoadHomeScreen());
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
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

          const CarouselCardCategory(
            textTitleCategory: "Now Playing",
            category: MovieCategory.nowPlaying,
            isDates: true,
          ),

          const SizedBox(height: 50),

          const CarouselCardCategory(
            textTitleCategory: "Popular",
            category: MovieCategory.popular,
          ),

          const SizedBox(height: 50),

          const CarouselCardCategory(
            textTitleCategory: "Top Rated",
            category: MovieCategory.topRated,
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
