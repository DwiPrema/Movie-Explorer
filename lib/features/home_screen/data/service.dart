import 'package:movie_omdbid_api/core/network/api_client.dart';
import 'package:movie_omdbid_api/features/home_screen/data/model.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient();

  Future<List<MovieModel>> upComingMovies() async {
    try {
      final response = await _apiClient.getRequest(
        "/movie/upcoming",
        queryParams: {"page": 1},
      );

      return (response.data["results"] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
