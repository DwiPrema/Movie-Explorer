import 'package:dio/dio.dart';
import 'package:movie_explorer/core/constant/api_constant.dart';
import 'package:movie_explorer/core/error/exceptions.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
      contentType: "application/json",
      headers: {"Authorization": "Bearer ${ApiConstant.bearerToken}"},
    ),
  );

  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException("Please check your connection !");
      }

      if (e.type == DioExceptionType.badResponse) {
        final status = e.response?.statusCode;

        if (status == 404) throw NotFoundException();
        if (status == 401 || status == 403) {
          throw ServerException("Unauthorized");
        }

        throw ServerException("Server Error ($status)");
      }

      throw ServerException("Unexpected Error");
    }
  }
}
