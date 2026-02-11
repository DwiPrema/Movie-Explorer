part of 'movie_bloc.dart';

sealed class MovieEvent {}

class LoadMovie extends MovieEvent {
  List<String> keywords;

  LoadMovie({required this.keywords});
}
