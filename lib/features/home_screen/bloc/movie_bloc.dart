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
        final result = await _service.upComingMovies();

        final movies = result.take(5).toList();

        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(err: "Something went wrong : $e"));
      }
    });
  }
}
