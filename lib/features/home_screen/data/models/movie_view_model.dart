import 'package:movie_explorer/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_explorer/core/models/movie_model.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_status.dart';

class MovieCategoryViewData {
  final List<MovieModel> movies;
  final MovieStatus status;
  final DateRange? dates;
  final String? errorMessage;

  MovieCategoryViewData({
    required this.movies,
    required this.status,
    required this.errorMessage,
    this.dates,
  });

  factory MovieCategoryViewData.loading() {
    return MovieCategoryViewData(
      movies: [],
      status: MovieStatus.loading,
      errorMessage: null,
      dates: null,
    );
  }
}
