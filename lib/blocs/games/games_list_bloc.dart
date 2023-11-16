import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_events.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_states.dart';
import 'package:ps5_games_browser_app/models/game_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GamesListBloc extends Bloc<GamesListEvent, GamesState> {
  GamesListBloc() : super(GamesListInitial()) {
    on<LoadGameListEvent>((event, emit) async {
      emit(GamesListLoading());
      try {
        final response = await http.get(Uri.parse(
            'https://api.rawg.io/api/games?key=6eaf82e6cd264cbd9ea5950dd863e5dc'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final List<dynamic> results = responseData['results'];
          final List<GameModel> games =
              results.map((gameJson) => GameModel.fromJson(gameJson)).toList();
          emit(GamesListLoaded(games));
        }
      } catch (e) {
        emit(GamesListErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
