import 'package:movie_omdbid_api/core/network/api_client.dart';
import 'package:movie_omdbid_api/features/home_screen/data/model.dart';

class MovieService {
  final ApiClient _apiClient = ApiClient();

  Future<List<MovieModel>> getMovie(String query) async {
    try {
      final response = await _apiClient.getRequest(
        "",
        queryParams: {'s': query},
      );

      if (response.data["Response"] == 'True' && response.data != null) {
        return (response.data["Search"] as List)
            .map((movie) => MovieModel.create(movie))
            .toList();
      } else {
        throw response.data["Error"];
      }
    } catch (e) {
      rethrow;
    }
  }
}
