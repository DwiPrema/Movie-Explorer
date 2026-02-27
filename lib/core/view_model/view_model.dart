import 'package:movie_explorer/features/movie_detail/data/models/movie_detail_model.dart';

class MovieDetailViewModel {
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

  final int movieId;
  final List<int> genreIds;
  final List<String> genreNames;

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
    required this.genreNames,
    required this.hasGenres,
    required this.hasTagline,
  });

  factory MovieDetailViewModel.fromModel(
    MovieDetailModel model, {
    List<String> genreNames = const [],
  }) {

    final names = genreNames.isNotEmpty
    ? genreNames
    : model.genres.map((g) => g.name).toList();

    final genreIds = model.genres.map((g) => g.id).toList();

    return 
    MovieDetailViewModel(
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
      genresText: names.join(", "),
      productionCountriesText: model.productionCountries,
      genreIds: genreIds,
      genreNames: names,
      hasGenres: names.isNotEmpty,
      hasTagline: (model.tagline).isNotEmpty,
    );
  }
}
