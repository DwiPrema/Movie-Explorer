import 'package:bloc/bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _service = MovieService();

  MovieBloc() : super(MovieInitial()) {
    on<LoadMovie>((event, emit) async {
      emit(MovieLoading());

      try {
        final List<MovieModel> loadedMovie = [];

        for (final keyword in event.keywords) {
          final result = await _service.getMovie(keyword);

          if (result.isEmpty) continue;

          final movie = result.firstWhere(
            (m) => m.poster.isNotEmpty,
            orElse: () => result.first,
          );

          loadedMovie.add(movie);
        }

        emit(MovieLoaded(movies: loadedMovie));
      } catch (e) {
        emit(MovieError(err: "Something went wrong : $e"));
      }
    });
  }
}
