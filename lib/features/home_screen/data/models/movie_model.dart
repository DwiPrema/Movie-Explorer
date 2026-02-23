import 'package:movie_explorer/core/constant/api_constant.dart';

class MovieModel {
  int movieId;
  String title;
  String year;
  String? poster;
  String? backdropPath;

  MovieModel({required this.movieId, required this.title, required this.year, required this.poster, required this.backdropPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json["id"],
      title: json["title"],
      year: json["release_date"],
      poster: json["poster_path"],
      backdropPath: json["backdrop_path"],
    );
  }

  bool get hasValidPoster => poster != null && poster!.isNotEmpty;

  bool get isValid => hasValidPoster && title.isNotEmpty && year.isNotEmpty;

  String posterUrl({String size = "w500"}) {
    if (poster == null || poster!.isEmpty) {
      return "";
    }

    return "${ApiConstant.imageBaseUrl}$size$poster";
  }

  String backdropUrl({String size = "w500"}) {
    if (backdropPath == null || backdropPath!.isEmpty) {
      return "";
    }

    return "${ApiConstant.imageBaseUrl}$size$backdropPath";
  }
}
