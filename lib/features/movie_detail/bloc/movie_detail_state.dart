part of 'movie_detail_bloc.dart';

sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  final MovieDetailViewModel detail;
  final List<MovieModel> movies;

  MovieDetailSuccess({required this.detail, required this.movies});
}
