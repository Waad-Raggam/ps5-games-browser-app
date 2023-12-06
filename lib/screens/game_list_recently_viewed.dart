import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_history/game_history_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_history/game_history_events.dart';
import 'package:ps5_games_browser_app/blocs/game_history/game_history_states.dart';
import 'package:ps5_games_browser_app/models/game_history_model.dart';
import 'package:ps5_games_browser_app/screens/game_details_screen.dart';
import 'package:ps5_games_browser_app/utils/chip_background_color.dart';

class GameListHistoryScreen extends StatefulWidget {
  final List<int> gameIds;

  const GameListHistoryScreen(this.gameIds, {Key? key}) : super(key: key);

  @override
  State<GameListHistoryScreen> createState() => _GameListHistoryScreenState();
}

class _GameListHistoryScreenState extends State<GameListHistoryScreen> {
  late GameHistoryListBloc gameHistoryBloc;

  @override
  void initState() {
    super.initState();
    gameHistoryBloc = GameHistoryListBloc();
    for (final gameId in widget.gameIds) {
      gameHistoryBloc.add(LoadGameHistoryEvent(gameId));
    }
  }

  @override
  void dispose() {
    gameHistoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Viewed'),
        backgroundColor: const Color(0xFF332F43),
      ),
      body: BlocBuilder<GameHistoryListBloc, GameHistoryState>(
        bloc: gameHistoryBloc,
        builder: (context, state) {
          if (state is GameHistoryLoading) {
            return const CircularProgressIndicator();
          } else if (state is GameHistoryLoaded) {
            final List<GameHistoryModel> gameDetailsList =
                state.gameHistoryList;
            return ListView.builder(
              itemCount: widget.gameIds.length,
              itemBuilder: (context, index) {
                final gameId = widget.gameIds[index];
                final gameDetails = gameDetailsList.firstWhere(
                  (g) => g.id == gameId,
                  orElse: () => GameHistoryModel(
                      id: 0,
                      name: '',
                      backgroundImage:
                          'https://depositphotos.com/vector/missing-picture-page-for-website-design-or-mobile-app-design-no-image-available-icon-vector-318221368.html',
                      releaseDate: '',
                      metacriticScore: 0),
                );
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        gameDetails.backgroundImage,
                        width: double.infinity,
                        height: 250.0,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              gameDetails.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  gameDetails.releaseDate,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const Spacer(),
                                Chip(
                                  backgroundColor: backgroundColor(
                                      gameDetails.metacriticScore),
                                  label: Text(
                                    gameDetails.metacriticScore.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameDetailsScreen(
                                        name: gameDetails.name,
                                        selectedGameId: gameDetails.id,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color(0xFF343540),
                                  ),
                                ),
                                child: const Text(
                                  'More details',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GameHistoryErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
