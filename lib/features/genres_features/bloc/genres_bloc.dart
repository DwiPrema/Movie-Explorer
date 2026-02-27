import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_event.dart';
import 'package:movie_explorer/features/genres_features/bloc/genres_state.dart';
import 'package:movie_explorer/features/genres_features/data/model/genre_model.dart';
import 'package:movie_explorer/features/genres_features/data/services/genre_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreService service = GenreService();

  GenreBloc() : super(GenreInitial()) {
    on<LoadGenres>(_onLoadGenres);
  }


///Mapping genre IDs to their corresponding names using the list of genres
  List<String> mapGenreIdsToNames(List<int> genreIds, List<GenreModel> genres) {
    final genreMap = {for (final genre in genres) genre.id: genre.name};

    return genreIds.map((id) => genreMap[id]).whereType<String>().toList();
  }

  Future<void> _onLoadGenres(LoadGenres event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    try {
      final genres = await service.fetchGenres();
      emit(GenreLoaded(genres));
    } catch (_) {
      emit(GenreError());
    }
  }
}
