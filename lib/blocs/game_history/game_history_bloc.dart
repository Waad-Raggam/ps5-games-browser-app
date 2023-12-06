import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ps5_games_browser_app/blocs/game_history/game_history_events.dart';
import 'package:ps5_games_browser_app/blocs/game_history/game_history_states.dart';
import 'package:ps5_games_browser_app/models/game_history_model.dart';

class GameHistoryListBloc extends Bloc<GameHistoryEvent, GameHistoryState> {
  Map<int, GameHistoryModel> gameDetailsMap = {};

  GameHistoryListBloc() : super(GameHistoryInitial()) {
    on<LoadGameHistoryEvent>((event, emit) async {
      emit(GameHistoryLoading());
      try {
        if (!gameDetailsMap.containsKey(event.gameId)) {
          final response = await http.get(Uri.parse(
              'https://api.rawg.io/api/games/${event.gameId}?key=6eaf82e6cd264cbd9ea5950dd863e5dc'));
          if (response.statusCode == 200) {
            final Map<String, dynamic> responseData = jsonDecode(response.body);
            final GameHistoryModel game =
                GameHistoryModel.fromJson(responseData);
            gameDetailsMap[event.gameId] = game;
          }
        }
        emit(GameHistoryLoaded(gameDetailsMap.values.toList()));
      } catch (e) {
        emit(GameHistoryErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
