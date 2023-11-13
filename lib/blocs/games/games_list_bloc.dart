import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_events.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_states.dart';
import 'package:ps5_games_browser_app/models/game_list_model.dart';

class GamesListBloc extends Bloc<GamesListEvent, GamesState> {
  GamesListBloc() : super(GamesListInitial()) {
    on<LoadGameListEvent>((event, emit) {
      emit(GamesListLoading());
      try {
        List<GameModel> loadedGames = [
          GameModel(
            name: "Subnautica: Below Zero",
            releaseDate: "2021-05-14",
            backgroundImage:
                "https://media.rawg.io/media/games/437/4377bf00ded8a2ba781aa74d8bff9220.jpg",
            metacriticScore: 80,
          ),
          GameModel(
            name: "Grand Theft Auto V",
            releaseDate: "2013-09-17",
            backgroundImage:
                "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
            metacriticScore: 92,
          ),
        ];

        emit(GamesListLoaded(loadedGames));
      } catch (e) {
        emit(GamesListErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
