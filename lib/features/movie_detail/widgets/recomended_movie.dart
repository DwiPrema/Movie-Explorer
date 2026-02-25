import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_explorer/widgets/reusable_widget/carousel_card.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

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

class RecomendedMovie extends StatelessWidget {
  const RecomendedMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailSuccess) {
          return RecommendedMovieSection(movies: state.movies);
        } else if (state is MovieDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailError) {
          return title("Sorry! Error");
        } else {
          return title("Sorry! Something Went Wrong !!!");
        }
      },
    );
  }
}
