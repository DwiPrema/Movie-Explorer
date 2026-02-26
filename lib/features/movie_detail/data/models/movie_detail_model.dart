import 'package:movie_explorer/core/constant/api_constant.dart';
import 'package:movie_explorer/core/models/genre_model.dart';

class MovieDetailModel {
  int movieId;
  bool adult;
  String title;
  String originalTitle;
  String releaseDate;
  String overview;
  String oriLanguage;
  String? posterPath;
  String? backdropPath;
  double popularity;
  List<GenreModel> genres;
  String productionCountries;
  String status;
  String tagline;

  MovieDetailModel({
    required this.movieId,
    required this.adult,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.overview,
    required this.oriLanguage,
    required this.posterPath,
    required this.backdropPath,
    required this.popularity,
    required this.genres,
    required this.productionCountries,
    required this.status,
    required this.tagline,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      movieId: json["id"],
      adult: json["adult"],
      title: json["title"],
      originalTitle: json["original_title"],
      releaseDate: json["release_date"],
      overview: json["overview"],
      oriLanguage: json["original_language"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      popularity: json["popularity"],
      genres: (json["genres"] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
      productionCountries: (json["production_countries"] as List)
          .map((e) => "${e["iso_3166_1"]}-${e["name"]}")
          .join(", "),
      status: json["status"],
      tagline: json["tagline"],
    );
  }

  String posterUrl({String size = "w500"}) {
    if (posterPath == null || posterPath!.isEmpty) {
      return "";
    }

    return "${ApiConstant.imageBaseUrl}$size$posterPath";
  }

  String backdropUrl({String size = "w500"}) {
    if (backdropPath == null || backdropPath!.isEmpty) {
      return "";
    }

    return "${ApiConstant.imageBaseUrl}$size$backdropPath";
  }

  List<String> genreNames() {
    return genres.map((e) => e.name).toList();
  }
}
