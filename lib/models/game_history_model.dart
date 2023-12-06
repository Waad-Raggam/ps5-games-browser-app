class GameHistoryModel {
  final int id;
  final String name;
  final String releaseDate;
  final int metacriticScore;
  final String backgroundImage;

  GameHistoryModel({
    required this.id,
    required this.name,
    required this.releaseDate,
    required this.metacriticScore,
    required this.backgroundImage,
  });

  factory GameHistoryModel.fromJson(Map<String, dynamic> json) {
    return GameHistoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      releaseDate: json['released'] ?? 'No date',
      metacriticScore: json['metacritic'] ?? 0,
      backgroundImage: json['background_image'] ?? '',
    );
  }
}
