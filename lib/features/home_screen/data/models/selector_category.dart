import 'package:movie_omdbid_api/features/home_screen/bloc/movie_bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_view_model.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_status.dart';

MovieCategoryViewData selectMovieCategory(
  MovieState state,
  MovieCategory category,
) {
  if (state is! MovieStateData) {
    return MovieCategoryViewData.loading();
  }

  return MovieCategoryViewData(
    movies: state.movies[category] ?? const [],
    status: state.status[category] ?? MovieStatus.initial,
    errorMessage: state.errorMessage[category],
    dates: state.dates[category],
  );
}
