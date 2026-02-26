import 'package:dio/dio.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class SearchService {
  final ApiClient _apiClient = ApiClient();

  Future<List<MovieDetailModel>> searchMovie(String query) async {
    try {
      final result = await _apiClient.getRequest(
        "/search/movie",
        queryParams: {"query": query},
      );

      return (result.data['results'] as List)
          .map((e) => MovieDetailModel.fromJson(e))
          .toList();
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
}
