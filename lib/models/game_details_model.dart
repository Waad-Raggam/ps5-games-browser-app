class GameDetails {
  final String description;
  final String otherPlatform;
  final String genres;
  final String developers;
  final String publishers;
  final String? screenshots;

  GameDetails({
    required this.description,
    required this.otherPlatform,
    required this.genres,
    required this.developers,
    required this.publishers,
    this.screenshots,
  });
}
