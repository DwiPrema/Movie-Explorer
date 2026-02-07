import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/models/movie_model.dart';
import 'package:movie_omdbid_api/services/movie_service.dart';


class MovieProvider extends ChangeNotifier {
  final List<MovieModel> _movies = [];
  bool _isLoading = false;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> loadMany(List<String> keywords) async {
    try {
      _isLoading = true;
      notifyListeners();

      _movies.clear();

      for (final keyword in keywords) {
        final result = await MovieService.searchMovie(keyword);

        if (result.isEmpty) continue;

        final movie = result.firstWhere(
          (m) => m.poster.isNotEmpty,
          orElse: () => result.first,
        );

        _movies.add(movie);
      }
    } catch (e) {
      print('Error loading movies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
