import "dart:convert";
import "package:http/http.dart" as http;
import "package:movie_omdbid_api/models/movie_model.dart";

class MovieService {
  //main service api
  static Future<List<MovieModel>> searchMovie(String query) async {
    try {
      String apiUrl = "http://www.omdbapi.com/?apikey=f2662f18&s=$query";
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (data['Response'] == 'True' && data['Search'] != null) {
        return (data['Search'] as List)
            .map((json) => MovieModel.createObject(json))
            .toList();
      }

      return <MovieModel>[];
    } catch (e) {
      print('Error searching movie: $e');
      return <MovieModel>[];
    }
  }
}
