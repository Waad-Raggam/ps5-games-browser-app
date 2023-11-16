abstract class GameDetailsEvent {}

class LoadGameDetailsEvent extends GameDetailsEvent {
  final int gameId;

  LoadGameDetailsEvent(this.gameId);
}
