part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {}

final class LoadDetail extends MovieDetailEvent {
  final int movieId;

  LoadDetail({required this.movieId});
}
