class GameModel {
  final int id;
  final String name;
  final String description;
  final String releaseDate;
  final int metacriticScore;
  final String backgroundImage;

  GameModel({
    required this.id,
    required this.name,
    required this.description,
    required this.releaseDate,
    required this.metacriticScore,
    required this.backgroundImage,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      releaseDate: json['released'] ?? 'No date',
      metacriticScore: json['metacritic'] ?? 0,
      backgroundImage: json['background_image'] ?? '',
    );
  }
}
