import 'package:movie_explorer/core/constant/api_constant.dart';
import 'package:movie_explorer/features/genres_features/data/model/genre_model.dart';

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
  List<int> genreIds;
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
    required this.genreIds,
    required this.productionCountries,
    required this.status,
    required this.tagline,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    List<GenreModel> parseGenres() {
      final genresData = json["genres"];
      if (genresData == null) return [];

      return (genresData as List)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    List<int> parseGenreIds() {
      return List<int>.from(json["genre_ids"] ?? []);
    }

    String parseProductionCountries() {
      final countriesData = json["production_countries"];
      if (countriesData == null) return "";
      try {
        return (countriesData as List)
            .map((e) => "${e["iso_3166_1"]}-${e["name"]}")
            .join(", ");
      } catch (e) {
        return "";
      }
    }

    return MovieDetailModel(
      movieId: json["id"] ?? 0,
      adult: json["adult"] ?? false,
      title: json["title"] ?? "Unknown",
      originalTitle: json["original_title"] ?? "",
      releaseDate: json["release_date"] ?? "",
      overview: json["overview"] ?? "",
      oriLanguage: json["original_language"] ?? "en",
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      popularity: (json["popularity"] ?? 0),
      genres: parseGenres(),
      genreIds: parseGenreIds(),
      productionCountries: parseProductionCountries(),
      status: json["status"] ?? "Unknown",
      tagline: json["tagline"] ?? "",
    );
  }

  bool get hasValidPoster => posterPath != null && posterPath!.isNotEmpty;

  bool get isValid =>
      hasValidPoster && title.isNotEmpty && releaseDate.isNotEmpty;

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
}
