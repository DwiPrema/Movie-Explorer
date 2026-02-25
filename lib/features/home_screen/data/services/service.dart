import 'package:dio/dio.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/home_screen/data/models/movie_list_response.dart';
import 'package:movie_explorer/features/home_screen/domain/movie_category.dart';

class MovieService {
  final ApiClient _apiClient;

  final Map<MovieCategory, MovieListResponse> _cache = {};

  MovieService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  String _endpointOf(MovieCategory category) {
    switch (category) {
      case MovieCategory.upComing:
        return '/movie/upcoming';
      case MovieCategory.nowPlaying:
        return '/movie/now_playing';
      case MovieCategory.popular:
        return '/movie/popular';
      case MovieCategory.topRated:
        return '/movie/top_rated';
    }
  }

  Future<MovieListResponse> fetchMovieByCategory(MovieCategory category) async {
    try {
      if (_cache.containsKey(category)) {
        return _cache[category]!;
      }

      final endpoint = _endpointOf(category);
      final response = await _apiClient.getRequest(
        endpoint,
        queryParams: {"page": 1},
      );

      final result = MovieListResponse.fromJson(response.data);

      _cache[category] = result;

      return result;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException("Please check your connection !");
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ServerException("Sorry!, Something Went Wrong !!!");
      }
    }
  }

  void clearCache([MovieCategory? category]) {
    if (category != null) {
      _cache.remove(category);
    } else {
      _cache.clear();
    }
  }
}
