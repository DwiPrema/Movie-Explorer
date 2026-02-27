import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_bloc.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_state.dart';
import 'package:movie_explorer/core/view_model/view_model.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_event.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_state.dart';
import 'package:movie_explorer/features/search_screen/data/services/search_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService service = SearchService();
  final GenreBloc genreBloc;

  SearchBloc({
    required this.genreBloc,
  }) : super(SearchInitial()) {
    on<DisplaySearchedMovie>(_onSearchMovie);
  }

  Future<void> _onSearchMovie(
    DisplaySearchedMovie event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final movies = await service.searchMovie(event.query);

      final genreState = genreBloc.state;

      if (genreState is! GenreLoaded) {
        emit(SearchError(errMsg: 'Genre data not loaded'));
        return;
      }

      final results = movies.where((m) => m.isValid)
      .map((movie) {
        final genreNames = genreBloc.mapGenreIdsToNames(
          movie.genreIds,
          genreState.genres,
        );

        return MovieDetailViewModel.fromModel(
          movie,
          genreNames: genreNames,
        );
      }).toList();

      emit(SearchLoaded(searchResults: results));
    } catch (e) {
      emit(SearchError(errMsg: 'Something went wrong'));
    }
  }
}
