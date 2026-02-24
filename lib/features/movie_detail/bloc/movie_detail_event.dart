part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {}

final class LoadDetail extends MovieDetailEvent {
  final int movieId;
  final int genreId;

  LoadDetail({required this.movieId, required this.genreId});
}
