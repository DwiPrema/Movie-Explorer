import 'package:dio/dio.dart';
import 'package:movie_omdbid_api/core/constant/api_constant.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final params = queryParams ?? {};
      params['apikey'] = ApiConstant.apiKey;

      final response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw Exception("Ada kesalahan : $e");
    }
  }
}
