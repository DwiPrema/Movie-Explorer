import 'package:movie_omdbid_api/features/home_screen/data/models/date_range_model.dart';
import 'package:movie_omdbid_api/features/home_screen/data/models/movie_model.dart';

class MovieListResponse {
  final DateRange? dates;
  final List<MovieModel> results;

  MovieListResponse({this.dates, required this.results});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      results: (json['results'] as List).map((m) => MovieModel.fromJson(m)).toList(),
      dates: json["dates"] != null ? DateRange.fromJson(json["dates"]) : null,
    );
  }
}
