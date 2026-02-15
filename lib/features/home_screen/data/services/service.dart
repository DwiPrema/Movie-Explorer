import 'package:movie_omdbid_api/core/network/api_client.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_list_response.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient();

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
}
