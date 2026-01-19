import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/models/movie_model.dart';
import 'package:movie_omdbid_api/services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> _movies = [];
  bool _isLoading = false;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> load(String keyword) async {
    _isLoading = true;
    notifyListeners();

    _movies = await MovieService.searchMovie(keyword);

    _isLoading = false;
    notifyListeners();
  }
}