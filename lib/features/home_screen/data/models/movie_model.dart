import 'package:movie_omdbid_api/core/constant/api_constant.dart';

class MovieModel {
  String title;
  String year;
  String? poster;

  MovieModel({required this.title, required this.year, required this.poster});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["title"],
      year: json["release_date"],
      poster: json["poster_path"]
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
}
