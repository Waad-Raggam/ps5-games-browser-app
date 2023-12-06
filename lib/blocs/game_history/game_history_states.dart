import 'package:ps5_games_browser_app/models/game_history_model.dart';

abstract class GameHistoryState {
  const GameHistoryState();

  @override
  List<Object?> get props => [];
}

class GameHistoryInitial extends GameHistoryState {}

class GameHistoryLoading extends GameHistoryState {}

class GameHistoryLoaded extends GameHistoryState {
  final List<GameHistoryModel> gameHistoryList;

  GameHistoryLoaded(this.gameHistoryList);

  @override
  List<Object?> get props => [gameHistoryList];
}

class GameHistoryErrorState extends GameHistoryState {
  final String errorMessage;

  GameHistoryErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
