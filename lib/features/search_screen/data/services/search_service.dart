import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class SearchService {
  final ApiClient _apiClient = ApiClient();

  Future<List<MovieDetailModel>> searchMovie(String query) async {
    final result = await _apiClient.getRequest(
      "/search/movie",
      queryParams: {"query": query},
    );

    final data = result.data;

    if (data == null || data['results'] == null) {
      return [];
    }

    return (data['results'] as List)
        .map((e) => MovieDetailModel.fromJson(e))
        .toList();
  }
}
