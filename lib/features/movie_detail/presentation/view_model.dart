import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class MovieDetailViewModel {
  // ====== UI DISPLAY (String only) ======
  final String title;
  final String originalTitle;
  final String releaseDate;
  final String originalLanguage;
  final String status;
  final String tagline;
  final String overview;
  final String posterUrl;
  final String popularity;
  final String backdropUrl;
  final String genresText;
  final String productionCountriesText;

  // ====== LOGIC SUPPORT (not for direct UI) ======
  final int movieId;
  final List<int> genreIds;

  // ====== UI HELPERS ======
  final bool hasGenres;
  final bool hasTagline;

  MovieDetailViewModel({
    required this.movieId,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.originalLanguage,
    required this.status,
    required this.tagline,
    required this.overview,
    required this.posterUrl,
    required this.popularity,
    required this.backdropUrl,
    required this.genresText,
    required this.productionCountriesText,
    required this.genreIds,
    required this.hasGenres,
    required this.hasTagline,
  });

  /// ====== FACTORY: Model -> ViewModel ======
  factory MovieDetailViewModel.fromModel(MovieDetailModel model) {
    final genreNames = model.genres.map((g) => g.name).toList();
    final genreIds = model.genres.map((g) => g.id).toList();

    return MovieDetailViewModel(
      movieId: model.movieId,
      title: model.title,
      originalTitle: model.originalTitle,
      releaseDate: model.releaseDate,
      originalLanguage: model.oriLanguage.toUpperCase(),
      status: model.status,
      tagline: model.tagline,
      overview: model.overview,
      posterUrl: model.posterUrl(),
      popularity: model.popularity.toString(),
      backdropUrl: model.backdropUrl(),
      genresText: genreNames.join(", "),
      productionCountriesText: model.productionCountries,
      genreIds: genreIds,
      hasGenres: genreNames.isNotEmpty,
      hasTagline: (model.tagline).isNotEmpty,
    );
  }
}
