import 'package:bloc/bloc.dart';
import 'package:movie_explorer/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_model.dart';
import 'package:movie_explorer/features/home_screen/data/services/service.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_status.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _service = MovieService();

  MovieBloc() : super(MovieStateData.initial()) {
    on<LoadMovie>((event, emit) async {
      final category = event.category;

      final currentState = state as MovieStateData;

      emit(
        currentState.copyWith(
          status: {...currentState.status, category: MovieStatus.loading},
        ),
      );

      try {
        final result = await _service.fetchMovieByCategory(category);

        final latestState = state as MovieStateData;
        emit(
          latestState.copyWith(
            movies: {
              ...latestState.movies,
              category: result.results.take(10).toList()
              },
            status: {
              ...latestState.status,
              category: MovieStatus.success
              },
            dates: {
              ...latestState.dates,
              category: result.dates
              },
            errorMessage: {
              ...latestState.errorMessage,
              category: null
              },
          ),
        );
      } catch (e) {
        final latestState = state as MovieStateData;
        emit(
          latestState.copyWith(
            status: {
              ...latestState.status,
              category: MovieStatus.error},
            errorMessage: {
              ...latestState.errorMessage,
              category: e.toString()},
          ),
        );
      }
    });
  }
}
