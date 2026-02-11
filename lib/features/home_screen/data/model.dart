class MovieModel {
  String omdbId;
  String title;
  String year;
  String poster;

  MovieModel({
    required this.omdbId,
    required this.title,
    required this.year,
    required this.poster,
  });

  factory MovieModel.create(Map<String, dynamic> json) {
    return MovieModel(
      omdbId: json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      poster: json["Poster"],
    );
  }
}
