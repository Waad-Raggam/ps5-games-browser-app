import 'package:ps5_games_browser_app/models/game_details_model.dart';

abstract class GameDetailsState {}

class GameDetailsInitial extends GameDetailsState {}

class GameDetailsLoading extends GameDetailsState {}

class GameDetailsLoaded extends GameDetailsState {
  final List<GameDetails> gameInfo;
  final List<Screenshot> gameScreenshot;
  final int gameScreenshotCount;

  GameDetailsLoaded(
      this.gameInfo, this.gameScreenshot, this.gameScreenshotCount);
}

class GameDetailsErrorState extends GameDetailsState {
  final String errorMessage;

  GameDetailsErrorState(this.errorMessage);
}
