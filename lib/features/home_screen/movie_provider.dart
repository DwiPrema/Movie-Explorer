import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/models/movie_model.dart';
import 'package:movie_omdbid_api/services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];
  final List<MovieModel> _moviesLatest = [];
  bool _isLoading = false;
  bool _isLatestLoading = false;

  List<MovieModel> get movies => _movies;
  List<MovieModel> get moviesLatest => _moviesLatest;
  bool get isLoading => _isLoading;
  bool get isLatestLoading => _isLatestLoading;

  // random movie
  Future<void> load(String keyword) async {
    _isLoading = true;
    notifyListeners();

    final result = await MovieService.searchMovie(keyword);

    if (result.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    final movie = result.firstWhere(
      (m) => m.poster.isNotEmpty,
      orElse: () => result.first,
    );

    _movies.add(movie);

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _movies.clear();
    notifyListeners();
  }

  // latest releases
  Future<void> loadKeywords(List<String> keywords) async {
    _isLatestLoading = true;
    notifyListeners();

    _moviesLatest.clear();

    for (final keyword in keywords) {
      final searchResult = await MovieService.searchMovie(keyword);

      for (final movie in searchResult.take(3)) {
        final released = await MovieService.fetchReleased(movie.imdbID);

        _moviesLatest.add(movie.copyWith(released: released));
      }
    }

    _moviesLatest.removeWhere((m) => m.released == null);

    _moviesLatest.sort((a, b) => b.released!.compareTo(a.released!));

    _isLatestLoading = false;
    notifyListeners();
  }

  List<MovieModel> getLatest10() => _moviesLatest.take(10).toList();
}
