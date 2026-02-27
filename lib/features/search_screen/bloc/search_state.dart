import 'package:movie_explorer/core/view_model/view_model.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  String errMsg;

  SearchError({required this.errMsg});
}

class SearchLoaded extends SearchState {
  List<MovieDetailViewModel> searchResults;

  SearchLoaded({required this.searchResults});
}
