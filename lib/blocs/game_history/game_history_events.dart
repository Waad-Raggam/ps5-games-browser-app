abstract class GameHistoryEvent {
  const GameHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadGameHistoryEvent extends GameHistoryEvent {
  final int gameId;

  LoadGameHistoryEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
