import 'package:flutter/material.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/widgets/reusable_widget/carousel_card.dart';

class RecommendedMovieSection extends StatelessWidget {
  final List<MovieModel> movies;

  const RecommendedMovieSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselCard(
          movies: movies,
          textTitleCategory: "You Might Also Like",
        ),
      ],
    );
  }
}
