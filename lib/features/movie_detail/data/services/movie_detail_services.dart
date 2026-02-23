import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class MovieDetailServices {
  final ApiClient _apiClient = ApiClient();

  Future<MovieDetailModel> detailMovie(int id) async {
    try {
      final detail = await _apiClient.getRequest("/movie/$id");

      print("detail : $id");

      return MovieDetailModel.fromJson(detail.data);
    } catch (e) {
      rethrow;
    }
  }
}
