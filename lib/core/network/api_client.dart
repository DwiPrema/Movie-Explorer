import 'package:dio/dio.dart';
import 'package:movie_explorer/core/constant/api_constant.dart';

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
      final response = await _dio.get(path, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      throw Exception("Ada kesalahan : $e");
    }
  }
}
