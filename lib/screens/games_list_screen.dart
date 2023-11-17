import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_states.dart';
import 'package:ps5_games_browser_app/screens/game_details_screen.dart';

class GameListScreen extends StatefulWidget {
  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayStation 5 Games'),
        backgroundColor: const Color(0xFF332F43),
      ),
      body: BlocBuilder<GamesListBloc, GamesState>(
        builder: (context, state) {
          if (state is GamesListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GamesListLoaded) {
            return ListView.builder(
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                final game = state.games[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        game.backgroundImage,
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
                              game.name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  game.releaseDate,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const Spacer(),
                                Chip(
                                  label: Text(
                                    game.metacriticScore.toString(),
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameDetailsScreen(
                                        name: game.name,
                                        selectedGameId: game.id,
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
          } else if (state is GamesListErrorState) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            // Default case in case of unexpected state
            return Center(
              child: Text('Unexpected state: $state'),
            );
          }
        },
      ),
    );
  }
}
