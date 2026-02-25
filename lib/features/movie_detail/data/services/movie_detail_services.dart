import 'package:dio/dio.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class MovieDetailServices {
  final ApiClient _apiClient = ApiClient();

  Future<MovieDetailModel> detailMovie(int id) async {
    try {
      final detail = await _apiClient.getRequest("/movie/$id");

      return MovieDetailModel.fromJson(detail.data);
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
