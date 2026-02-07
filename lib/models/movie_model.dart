class MovieModel {
  final String title;
  final String year;
  final String poster;

  MovieModel({
    required this.title,
    required this.year,
    required this.poster,
  });

  factory MovieModel.createObject(Map<String, dynamic> movie) {
    final posterValue = movie["Poster"];
    final poster = posterValue != null && posterValue != "N/A" ? posterValue : "";
    
    return MovieModel(
      title: movie["Title"] ?? "Unknown",
      year: movie["Year"] ?? "-",
      poster: poster,
    );
  }
}
