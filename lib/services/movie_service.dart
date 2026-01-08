import "dart:convert";
import "package:http/http.dart" as http;
import "package:movie_omdbid_api/models/movie_model.dart";

class MovieService {
  static Future<List<MovieModel>> searchMovie(String query) async {
    String apiUrl = "http://www.omdbapi.com/?apikey=f2662f18&s= $query";
    final response = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(response.body);

    final List list = data["Search"];

    return list
        .map<MovieModel>((movie) => MovieModel.createObject(movie))
        .toList();
  }
}
