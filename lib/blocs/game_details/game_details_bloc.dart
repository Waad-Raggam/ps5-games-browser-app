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
        final responseScreenshots = await http.get(Uri.parse(
            'https://api.rawg.io/api/games/${event.gameId}/screenshots?key=6eaf82e6cd264cbd9ea5950dd863e5dc'));

        if (response.statusCode == 200 &&
            responseScreenshots.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final Map<String, dynamic> responseScreenshotData =
              jsonDecode(responseScreenshots.body);

          final GameDetails game = GameDetails.fromJson(responseData);

          final int screenshoutCount = responseScreenshotData['count'];

          final List<dynamic> screenshotResults =
              responseScreenshotData['results'];

          // Convert the list of screenshots to a List<Screenshot>
          final List<Screenshot> gameScreenshots =
              screenshotResults.map((result) {
            return Screenshot.fromJson(result);
          }).toList();

          emit(GameDetailsLoaded([game], gameScreenshots, screenshoutCount));
        }
      } catch (e) {
        emit(GameDetailsErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
