import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  String errMsg;

  SearchError({required this.errMsg});
}

class SearchLoaded extends SearchState {
  List<MovieDetailModel> searchResults;

  SearchLoaded({required this.searchResults});
}
