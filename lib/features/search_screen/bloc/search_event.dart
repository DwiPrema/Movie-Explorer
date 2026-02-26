abstract class SearchEvent {}

final class DisplaySearchedMovie extends SearchEvent {
  final String query;

  DisplaySearchedMovie({required this.query});
}
