import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_bloc.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_state.dart';
import 'package:movie_explorer/core/view_model/view_model.dart';
import 'package:movie_explorer/features/search_screen/bloc/bloc_transformer.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_event.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_state.dart';
import 'package:movie_explorer/features/search_screen/data/services/search_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService service = SearchService();
  final GenreBloc genreBloc;

  String _latestQuery = '';
  late final Map<int, String> _genreMap;
  late final StreamSubscription _genreSub;

  SearchBloc({required this.genreBloc}) : super(SearchInitial()) {
    on<DisplaySearchedMovie>(
      _onSearchMovie,
      transformer: debounce(const Duration(milliseconds: 800)),
    );

    _genreSub = genreBloc.stream.listen((state) {
      if (state is GenreLoaded) {
        _genreMap = {for (final g in state.genres) g.id: g.name};
      }
    });
  }

  @override
  Future<void> close() {
    _genreSub.cancel();
    return super.close();
  }

  Future<void> _onSearchMovie(
    DisplaySearchedMovie event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query == _latestQuery) return;
    _latestQuery = query;

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    if (state is! SearchLoading) {
      emit(SearchLoading());
    }

    try {
      final movies = await service.searchMovie(event.query);

      if (_latestQuery != query) return;

      if (_genreMap.isEmpty) {
        emit(SearchError(errMsg: 'Genre data not ready'));
        return;
      }

      final results = movies.where((m) => m.isValid).map((movie) {
        final genreNames = movie.genreIds
            .map((id) => _genreMap[id])
            .whereType<String>()
            .toList();

        return MovieDetailViewModel.fromModel(movie, genreNames: genreNames);
      }).toList();

      emit(SearchLoaded(searchResults: results));
    } catch (e) {
      emit(SearchError(errMsg: 'Something went wrong'));
    }
  }
}
