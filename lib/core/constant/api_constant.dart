import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String baseUrl = dotenv.get('BASE_URL', fallback: '');
  static String apiKey = dotenv.get('API_KEY', fallback: '');
}
