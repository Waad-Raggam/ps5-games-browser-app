import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_states.dart';

class GameDetailsScreen extends StatelessWidget {
  final String name;
  final int selectedGameId;

  const GameDetailsScreen(
      {Key? key, required this.name, required this.selectedGameId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color?> genreColors = [
      Colors.blue[400],
      Colors.green[400],
      Colors.red[400],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFF332F43),
      ),
      body: BlocProvider(
        create: (_) => GameDetailsBloc(),
        child: BlocBuilder<GameDetailsBloc, GameDetailsState>(
          builder: (context, state) {
            if (state is GameDetailsInitial) {
              BlocProvider.of<GameDetailsBloc>(context)
                  .add(LoadGameDetailsEvent(selectedGameId));
            }
            if (state is GameDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameDetailsLoaded) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final gameDetails = state.gameInfo[index];

                  final Map<int, String> platformMap =
                      gameDetails.getPlatformMap();

                  final Map<int, String> publisherMap =
                      gameDetails.getPublisherMap();

                  final Map<int, String> developerMap =
                      gameDetails.getDeveloperMap();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (gameDetails.screenshots != null &&
                          gameDetails.screenshots!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              gameDetails.screenshots!,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      Wrap(
                        spacing: 8.0,
                        children: gameDetails.genres
                            .map((genre) => Chip(
                                  label: Text(
                                    genre.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  backgroundColor: genreColors[
                                      genre.id % genreColors.length],
                                ))
                            .toList(),
                      ),
                      Text(
                        gameDetails.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Available Platforms:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      for (int platformId in gameDetails.platforms
                          .map((platform) => platform.id))
                        Text(
                          platformMap[platformId] ?? 'Unknown Platform',
                          style: const TextStyle(color: Colors.white),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Publishers:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      for (int publisherId in gameDetails.publishers
                          .map((publisher) => publisher.id))
                        Text(
                          publisherMap[publisherId] ?? 'Unknown Publisher',
                          style: const TextStyle(color: Colors.white),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Developers:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      for (int developerId in gameDetails.developers
                          .map((developer) => developer.id))
                        Text(
                          developerMap[developerId] ?? 'Unknown Developer',
                          style: const TextStyle(color: Colors.white),
                        ),
                    ],
                  );
                },
              );
            } else if (state is GameDetailsErrorState) {
              return Center(
                child: Text('Error: ${state.errorMessage}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
