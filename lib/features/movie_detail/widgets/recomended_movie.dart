import 'package:flutter/material.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/widgets/carousel_card_test.dart';

class RecommendedMovieSection extends StatelessWidget {
  final List<MovieModel> movies;

  const RecommendedMovieSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselCardTest(
      errorMessage: null,
      movies: movies,
    );
  }
}
