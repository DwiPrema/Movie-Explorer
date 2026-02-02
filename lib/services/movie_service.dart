import "dart:convert";
import "package:http/http.dart" as http;
import "package:movie_omdbid_api/models/movie_model.dart";

class MovieService {
  //main service api
  static Future<List<MovieModel>> searchMovie(String query) async {
    String apiUrl = "http://www.omdbapi.com/?apikey=f2662f18&s=$query";
    final response = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(response.body);

    if (data['Response'] == 'True' && data['Search'] != null) {
      return (data['Search'] as List)
          .map((json) => MovieModel.createObject(json))
          .toList();
    }

    return <MovieModel>[];
  }

  //latestMovie service
  static Future<DateTime?> fetchReleased(String imdbId) async {
    String apiUrl = "http://www.omdbapi.com/?apikey=f2662f18&i=$imdbId";
    final res = await http.get(Uri.parse(apiUrl));

    final data = jsonDecode(res.body);

    if (data["Released"] == 'N/A' && data["Released"] != null) {
      return DateTime.tryParse(data["Released"].split(" ").reversed.join("-"));
    }

    return null;
  }
}
