class Platform {
  final int id;
  final String name;
  final String slug;
  final String imageBackground;

  Platform({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageBackground,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['platform']['id'],
      name: json['platform']['name'],
      slug: json['platform']['slug'],
      imageBackground: json['platform']['image_background'],
    );
  }
}

class Genre {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      gamesCount: json['games_count'],
      imageBackground: json['image_background'],
    );
  }
}

class Publisher {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;

  Publisher({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      gamesCount: json['games_count'],
      imageBackground: json['image_background'],
    );
  }
}

class Developer {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;

  Developer({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      gamesCount: json['games_count'],
      imageBackground: json['image_background'],
    );
  }
}

class GameDetails {
  final String description;
  final List<Platform> platforms;
  final List<Genre> genres;
  final List<Developer> developers;
  final List<Publisher> publishers;
  final String? screenshots;

  GameDetails({
    required this.description,
    required this.platforms,
    required this.genres,
    required this.developers,
    required this.publishers,
    this.screenshots,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    final List<dynamic> platformsJson = json['platforms'];
    final List<Platform> platforms = platformsJson
        .map((platformJson) => Platform.fromJson(platformJson))
        .toList();

    final List<dynamic> genresJson = json['genres'];
    final List<Genre> genres =
        genresJson.map((genreJson) => Genre.fromJson(genreJson)).toList();

    final List<dynamic> publishersJson = json['publishers'];
    final List<Publisher> publishers = publishersJson
        .map((publisherJson) => Publisher.fromJson(publisherJson))
        .toList();

    final List<dynamic> developersJson = json['developers'];
    final List<Developer> developers = developersJson
        .map((developerJson) => Developer.fromJson(developerJson))
        .toList();

    return GameDetails(
      description: json['description'],
      platforms: platforms,
      genres: genres,
      developers: developers,
      publishers: publishers,
      screenshots: json['background_image_additional'],
    );
  }
  bool isTherePS() {
    bool hasPs = false;
    var result = platforms.any(
        (element) => element.id == 18 || element.id == 187 || element.id == 16);

    if (!hasPs && result) {
      return true;
    }
    return false;
  }

  bool isThereXbox() {
    bool hasXbox = false;
    var result = platforms.any(
        (element) => element.id == 14 || element.id == 186 || element.id == 1);

    if (!hasXbox && result) {
      return true;
    }
    return false;
  }

  bool isTherePC() {
    bool hasPC = false;
    var result = platforms.any((element) => element.id == 4);

    if (!hasPC && result) {
      return true;
    }
    return false;
  }

  bool isThereMacOS() {
    bool hasMac = false;
    var result = platforms.any((element) => element.id == 5);

    if (!hasMac && result) {
      return true;
    }
    return false;
  }

  bool isThereLinux() {
    bool hasLinux = false;
    var result = platforms.any((element) => element.id == 6);

    if (!hasLinux && result) {
      return true;
    }
    return false;
  }

  bool isThereAndroid() {
    bool hasAndroid = false;
    var result = platforms.any((element) => element.id == 21);

    if (!hasAndroid && result) {
      return true;
    }
    return false;
  }

  bool isThereIOS() {
    bool hasIOS = false;
    var result = platforms.any((element) => element.id == 3);

    if (!hasIOS && result) {
      return true;
    }
    return false;
  }

  bool isThereSwitch() {
    bool hasSwitch = false;
    var result = platforms.any((element) => element.id == 7);

    if (!hasSwitch && result) {
      return true;
    }
    return false;
  }

  bool isThereWeb() {
    bool hasWeb = false;
    var result = platforms.any((element) => element.id == 171);

    if (!hasWeb && result) {
      return true;
    }
    return false;
  }

  Map<int, String> getPlatformMap() =>
      {for (var platform in platforms) platform.id: platform.name};

  Map<int, String> getPublisherMap() =>
      {for (var publisher in publishers) publisher.id: publisher.name};

  Map<int, String> getDeveloperMap() =>
      {for (var developer in developers) developer.id: developer.name};
}
