import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/services/service.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _service = MovieService();

  final Map<MovieCategory, List<MovieModel>> _cache = {};
  final Map<MovieCategory, DateRange?> _cacheDatesRange = {};

  MovieBloc() : super(MovieInitial()) {
    on<LoadMovie>((event, emit) async {
      emit(MovieLoading());

      try {
        List<MovieModel> movies = [];
        DateRange? dateRange;

        switch (event.category) {
          case MovieCategory.upComing:
            final result = await _service.upComingMovies();
            movies = result.results.take(5).toList();
            dateRange = result.dates;
            break;
          case MovieCategory.nowPlaying:
            final result = await _service.nowPlaying();
            movies = result.results.take(10).toList();
            dateRange = result.dates;
            break;
        }

        _cache[event.category] = movies;
        _cacheDatesRange[event.category] = dateRange;

        emit(
          MovieLoaded(
            movies: Map.unmodifiable(_cache),
            dates: Map.unmodifiable(_cacheDatesRange),
          ),
        );
      } on SocketException {
        emit(
          MovieError(
            err:
                "Connection lost. Make sure your data or Wi-Fi is active, okay?",
          ),
        );
      } on HttpException {
        emit(
          MovieError(
            err:
                "An error occurred while contacting the server. Please try again later.",
          ),
        );
      } on TimeoutException {
        emit(
          MovieError(
            err: "The server took too long to respond. Please try again later.",
          ),
        );
      } catch (e) {
        emit(MovieError(err: "Something went wrong : $e"));
      }
    });
  }
}
