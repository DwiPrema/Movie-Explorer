import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movie_omdbid_api/features/movie_detail/data/models/movie_detail_model.dart';
import 'package:movie_omdbid_api/features/movie_detail/data/services/movie_detail_services.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailServices _service = MovieDetailServices();

  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<LoadDetail>((event, emit) async {
      final movieId = event.movieId;

      emit(MovieDetailLoading());

      try {
        final detail = await _service.detailMovie(movieId);

        print(detail);

        emit(MovieDetailSuccess(detail: detail));
      } on SocketException {
        print("socket");
      } on FormatException {
        print("format");
      } on TypeError {
        print("Type err");
      }
       catch (e) {
        emit(MovieDetailError());
      }
    });
  }
}
