import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/routes/app_routes.dart';
import 'package:movie_explorer/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_view_model.dart';
import 'package:movie_explorer/features/home_screen/data/models/selector_category.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_status.dart';
import 'package:movie_explorer/widgets/reusable_widget/carousel_card.dart';

class CarouselCardCategory extends StatelessWidget {
  final String textTitleCategory;
  final MovieCategory category;
  final bool isDates;

  const CarouselCardCategory({
    super.key,
    this.isDates = false,
    required this.textTitleCategory,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MovieBloc, MovieState, MovieCategoryViewData>(
      selector: (state) => selectMovieCategory(state, category),
      builder: (context, state) {
        final status = state.status;
        switch (status) {
          case MovieStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case MovieStatus.loading:
            return CarouselCard(
              onMovieTap: (movie) {},
              isDates: isDates,
              movies: state.movies,
              textTitleCategory: textTitleCategory,
            );
          case MovieStatus.success:
            return CarouselCard(
              onMovieTap: (movie) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.toDetail,
                  arguments: {
                    'movieId': movie.movieId,
                    'genreId': movie.genres.isNotEmpty
                        ? movie.genres.first
                        : 28,
                  },
                );
              },
              isDates: isDates,
              dates: "${state.dates?.minimum} - ${state.dates?.maximum}",
              movies: state.movies,
              textTitleCategory: textTitleCategory,
            );
          case MovieStatus.error:
            return Text(state.errorMessage ?? "Something went wrong :(");
        }
      },
    );
  }
}
