import 'package:movie_omdbid_api/core/network/api_client.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_list_response.dart';
import 'package:movie_omdbid_api/features/home_screen/domain/movie_category.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient();

  Future<MovieListResponse> fetchByCategory(MovieCategory category) async {
    switch (category) {
      case MovieCategory.upComing:
        return upComingMovies();
      case MovieCategory.nowPlaying:
        return nowPlaying();
      case MovieCategory.popular:
        return popular();
      case MovieCategory.topRated:
        return topRated();
    }
  }

  Future<MovieListResponse> upComingMovies() async {
    try {
      final response = await _apiClient.getRequest(
        "/movie/upcoming",
        queryParams: {"page": 1},
      );

      return MovieListResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieListResponse> nowPlaying() async {
    try {
      final response = await _apiClient.getRequest(
        "/movie/now_playing",
        queryParams: {"page": 1},
      );

      return MovieListResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieListResponse> popular() async {
    try {
      final response = await _apiClient.getRequest(
        "/movie/popular",
        queryParams: {"page": 1},
      );

      return MovieListResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieListResponse> topRated() async {
    try {
      final response = await _apiClient.getRequest(
        "/movie/top_rated",
        queryParams: {"page": 1},
      );

      return MovieListResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
