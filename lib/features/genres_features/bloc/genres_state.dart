import 'package:movie_explorer/features/genres_features/data/model/genre_model.dart';

abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<GenreModel> genres;

  GenreLoaded(this.genres);
}

class GenreError extends GenreState {}