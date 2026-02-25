part of 'movie_bloc.dart';

sealed class MovieEvent {}

class LoadMovie extends MovieEvent {
  final MovieCategory category;

  LoadMovie({required this.category});
}

class LoadHomeScreen extends MovieEvent {
}
