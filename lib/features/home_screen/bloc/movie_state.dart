part of 'movie_bloc.dart';

sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieError extends MovieState {
  String err;

  MovieError({required this.err});
}

final class MovieLoaded extends MovieState {
  List<MovieModel> movies;

  MovieLoaded({required this.movies});
}
