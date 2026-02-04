class MovieModel {
  final String imdbID;
  final String title;
  final String year;
  final String poster;

  MovieModel({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
  });

  factory MovieModel.createObject(Map<String, dynamic> movie) {
    return MovieModel(
      imdbID: movie["imdbId"],
      title: movie["Title"] ?? "Unknown",
      year: movie["Year"] ?? "-",
      poster: movie["Poster"] != null && movie["Poster"] != "N/A"
          ? movie["Poster"]
          : "",
    );
  }
}
