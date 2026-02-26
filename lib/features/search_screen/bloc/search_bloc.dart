import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_event.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_state.dart';
import 'package:movie_explorer/features/search_screen/data/services/search_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService _searchService = SearchService();
  Timer? _debounce;

  SearchBloc() : super(SearchInitial()) {
    on<DisplaySearchedMovie>(_onSearch);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> _onSearch(
    DisplaySearchedMovie event,
    Emitter<SearchState> emit,
  ) async {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      final query = event.query.trim();
      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final result = await _searchService.searchMovie(event.query);
        emit(SearchLoaded(searchResults: result));
      } on NetworkException {
        emit(SearchError(errMsg: "Please check your connection !"));
      } on NotFoundException {
        emit(SearchError(errMsg: "Sorry Page Not Found !"));
      } on ServerException {
        emit(SearchError(errMsg: "Sorry Server Exception !"));
      } catch (e) {
        emit(SearchError(errMsg: "Something Went Wrong !"));
      }
    });
  }
}
