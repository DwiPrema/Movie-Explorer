import 'package:movie_explorer/core/network/api_client.dart';
import 'package:movie_explorer/features/genres_features/data/model/genre_model.dart';

class GenreService {
  final ApiClient dio = ApiClient();

  GenreService();

  Future<List<GenreModel>> fetchGenres() async {
    final response = await dio.getRequest('/genre/movie/list');

    return (response.data['genres'] as List)
        .map((e) => GenreModel.fromJson(e))
        .toList();
  }
}