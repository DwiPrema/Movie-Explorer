part of 'movie_bloc.dart';

sealed class MovieState {}

final class MovieStateData extends MovieState {
  Map<MovieCategory, List<MovieModel>> movies;
  Map<MovieCategory, MovieStatus> status;
  Map<MovieCategory, String?> errorMessage;
  Map<MovieCategory, DateRange?> dates;

  MovieStateData({
    required this.movies,
    required this.status,
    required this.errorMessage,
    required this.dates,
  });

  factory MovieStateData.initial() {
    return MovieStateData(
      movies: {},
      status: {
        MovieCategory.upComing: MovieStatus.initial,
        MovieCategory.nowPlaying: MovieStatus.initial,
        MovieCategory.popular: MovieStatus.initial,
      },
      errorMessage: {},
      dates: {},
    );
  }

  MovieStateData copyWith({
    Map<MovieCategory, List<MovieModel>>? movies,
    Map<MovieCategory, MovieStatus>? status,
    Map<MovieCategory, String?>? errorMessage,
    Map<MovieCategory, DateRange?>? dates,
  }) {
    return MovieStateData(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      dates: dates ?? this.dates,
    );
  }
}
