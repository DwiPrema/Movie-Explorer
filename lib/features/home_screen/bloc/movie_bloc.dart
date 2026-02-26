import 'package:bloc/bloc.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_explorer/core/models/movie_model.dart';
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

      if (state is! MovieStateData) return;
      final currentState = state as MovieStateData;

      emit(
        currentState.copyWith(
          status: {...currentState.status, category: MovieStatus.loading},
        ),
      );

      try {
        final result = await _service.fetchMovieByCategory(category);

        emit(
          currentState.copyWith(
            movies: {
              ...currentState.movies,
              category: result.results.take(10).toList(),
            },
            status: {...currentState.status, category: MovieStatus.success},
            dates: {...currentState.dates, category: result.dates},
            errorMessage: {...currentState.errorMessage, category: null},
          ),
        );
      } on NetworkException catch (e) {
        emit(
          currentState.copyWith(
            status: {...currentState.status, category: MovieStatus.error},
            errorMessage: {...currentState.errorMessage, category: e.message},
          ),
        );
      } on NotFoundException {
        emit(
          currentState.copyWith(
            status: {...currentState.status, category: MovieStatus.error},
            errorMessage: {
              ...currentState.errorMessage,
              category: "Data Not Found !!!",
            },
          ),
        );
      } catch (e) {
        emit(
          currentState.copyWith(
            status: {...currentState.status, category: MovieStatus.error},
            errorMessage: {
              ...currentState.errorMessage,
              category: "Sorry! Unexpected Error",
            },
          ),
        );
      }
    });

    on<LoadHomeScreen>((event, emit) async {
      if (state is! MovieStateData) return;
      final currentState = state as MovieStateData;

      emit(
        currentState.copyWith(
          status: {
            for (final c in MovieCategory.values) c: MovieStatus.loading,
          },
        ),
      );

      try {
        final results = await Future.wait([
          _service.fetchMovieByCategory(MovieCategory.upComing),
          _service.fetchMovieByCategory(MovieCategory.nowPlaying),
          _service.fetchMovieByCategory(MovieCategory.popular),
          _service.fetchMovieByCategory(MovieCategory.topRated),
        ]);

        emit(
          currentState.copyWith(
            movies: {
              ...currentState.movies,
              MovieCategory.upComing: results[0].results.take(10).toList(),
              MovieCategory.nowPlaying: results[1].results.take(10).toList(),
              MovieCategory.popular: results[2].results.take(10).toList(),
              MovieCategory.topRated: results[3].results.take(10).toList(),
            },
            dates: {
              ...currentState.dates,
              MovieCategory.upComing: results[0].dates,
              MovieCategory.nowPlaying: results[1].dates,
              MovieCategory.popular: results[2].dates,
              MovieCategory.topRated: results[3].dates,
            },
            status: {
              ...currentState.status,
              for (final c in MovieCategory.values) c: MovieStatus.success,
            },
            errorMessage: {
              ...currentState.errorMessage,
              for (final c in MovieCategory.values) c: null,
            },
          ),
        );
      } on NetworkException {
        emit(
          currentState.copyWith(
            status: {
              ...currentState.status,
              for (final c in MovieCategory.values) c: MovieStatus.error,
            },
            errorMessage: {
              ...currentState.errorMessage,
              for (final c in MovieCategory.values)
                c: "Please check your connection !",
            },
          ),
        );
      } on NotFoundException {
        emit(
          currentState.copyWith(
            status: {
              ...currentState.status,
              for (final c in MovieCategory.values) c: MovieStatus.error,
            },
            errorMessage: {
              ...currentState.errorMessage,
              for (final c in MovieCategory.values) c: "Page Not Found !",
            },
          ),
        );
      } catch (e) {
        emit(
          currentState.copyWith(
            status: {
              ...currentState.status,
              for (final c in MovieCategory.values) c: MovieStatus.error,
            },
            errorMessage: {
              ...currentState.errorMessage,
              for (final c in MovieCategory.values) c: "Something Went Wrong !",
            },
          ),
        );
      }
    });
  }
}
