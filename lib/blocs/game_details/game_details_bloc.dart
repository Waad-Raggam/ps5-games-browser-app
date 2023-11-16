import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_states.dart';
import 'package:ps5_games_browser_app/models/game_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  GameDetailsBloc() : super(GameDetailsInitial()) {
    on<LoadGameDetailsEvent>((event, emit) async {
      emit(GameDetailsLoading());
      try {
        final response = await http.get(Uri.parse(
            'https://api.rawg.io/api/games/${event.gameId}?key=6eaf82e6cd264cbd9ea5950dd863e5dc'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final GameDetails game = GameDetails.fromJson(responseData);
          emit(GameDetailsLoaded([game]));
        }
      } catch (e) {
        emit(GameDetailsErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
