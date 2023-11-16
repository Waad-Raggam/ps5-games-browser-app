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
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedGameId.toString()),
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

                  // Build a list of platform names
                  final List<String> platformNames =
                      gameDetails.platforms.map((platform) {
                    return platform.name;
                  }).toList();

                  final List<String> publisherNames =
                      gameDetails.publishers.map((publisher) {
                    return publisher.name;
                  }).toList();

                  final List<String> developerNames =
                      gameDetails.developers.map((developer) {
                    return developer.name;
                  }).toList();

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
                      Text(gameDetails.description),
                      const Text('Genres:'),
                      Wrap(
                        children: gameDetails.genres
                            .map((genre) => Chip(
                                  label: Text(genre.name),
                                ))
                            .toList(),
                      ),
                      const Text(
                        'Available Platforms:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      for (String platformName in platformNames)
                        Text(platformName),
                      const Text(
                        'Publisher:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      for (String publisherName in publisherNames)
                        Text(publisherName),
                      const Text(
                        'Developers:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      for (String developerName in developerNames)
                        Text(developerName),
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
