import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String get baseUrl => dotenv.get('BASE_URL', fallback: '');
  static String get apiKey => dotenv.get('API_KEY', fallback: '');
  static String get bearerToken => dotenv.get('BEARER_TOKEN', fallback: '');

  //for image
  static String get imageBaseUrl => dotenv.get('IMAGE_BASE_URL', fallback: '');
}
