part of 'movie_detail_bloc.dart';

sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  final MovieDetailModel detail;

  MovieDetailSuccess({required this.detail});
}
