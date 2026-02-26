import 'package:bloc/bloc.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/models/movie_model.dart';
import 'package:movie_explorer/features/home_screen/data/services/service.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';
import 'package:movie_explorer/features/movie_detail/data/services/movie_detail_services.dart';
import 'package:movie_explorer/features/movie_detail/presentation/view_model.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailServices _service = MovieDetailServices();
  final MovieService _serviceCategory = MovieService();

  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<LoadDetail>((event, emit) async {
      final movieId = event.movieId;

      emit(MovieDetailLoading());

      try {
        final detail = await _service.detailMovie(movieId);
        final viewModel = MovieDetailViewModel.fromModel(detail);

        final recByTopRated = await _serviceCategory.fetchMovieByCategory(
          MovieCategory.topRated,
        );
        final recByPopular = await _serviceCategory.fetchMovieByCategory(
          MovieCategory.popular,
        );

        final recommended = [...recByPopular.results, ...recByTopRated.results]
            .where((movie) {
              return movie.genres.any((id) => movie.genres.contains(id));
            })
            .take(15)
            .toList();

        // final recommended = responseRec.results.where((movie) { // return movie.genres.contains(event.genreId); // }).toList();

        emit(MovieDetailSuccess(detail: viewModel, movies: recommended));
      } on NetworkException {
        emit(MovieDetailError(errMsg: "Please check your connection !"));
      } on NotFoundException {
        emit(MovieDetailError(errMsg: "Sorry Page Not Found !"));
      } on ServerException {
        emit(MovieDetailError(errMsg: "Sorry Server Exception !"));
      } catch (e) {
        emit(MovieDetailError(errMsg: "Something Went Wrong !"));
      }
    });
  }
}
