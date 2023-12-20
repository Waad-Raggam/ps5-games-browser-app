import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_bloc.dart';
import 'package:ps5_games_browser_app/models/game_details_model.dart';

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
                  final gameScreenshots = state.gameScreenshot;
                  Screenshot myScreenshot = Screenshot(
                    id: 1,
                    imageBackground: gameDetails.screenshots!,
                    width: 800,
                    height: 600,
                    isDeleted: false,
                  );

                  gameScreenshots.add(myScreenshot);
                  final countScreenshots = state.gameScreenshotCount;

                  final Map<int, String> platformMap =
                      gameDetails.getPlatformMap();

                  final Map<int, String> publisherMap =
                      gameDetails.getPublisherMap();

                  final Map<int, String> developerMap =
                      gameDetails.getDeveloperMap();

                  final bool doesPS = gameDetails.isTherePS();
                  final bool doesXBOX = gameDetails.isThereXbox();
                  final bool doesPC = gameDetails.isTherePC();
                  final bool doesMac = gameDetails.isThereMacOS();
                  final bool doesLinux = gameDetails.isThereLinux();
                  final bool doesAndroid = gameDetails.isThereAndroid();
                  final bool doesSwitch = gameDetails.isThereSwitch();
                  final bool doesIOS = gameDetails.isThereIOS();
                  final bool doesWeb = gameDetails.isThereWeb();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: countScreenshots,
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          initialPage: 0,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Image.network(
                          gameScreenshots[itemIndex].imageBackground,
                          fit: BoxFit.fill,
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !doesPS
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/playstation.png',
                                  color: Colors.white,
                                  height: 40,
                                ),
                          !doesXBOX
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/xbox.png',
                                  color: Colors.white,
                                  height: 30,
                                ),
                          !doesPC
                              ? const SizedBox()
                              : const Icon(
                                  Icons.desktop_windows_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                          !doesMac
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/macos.png',
                                  color: Colors.white,
                                  height: 40,
                                ),
                          !doesLinux
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/linux.png',
                                  color: Colors.white,
                                  height: 30,
                                ),
                          !doesAndroid
                              ? const SizedBox()
                              : const Icon(
                                  Icons.android,
                                  color: Colors.white,
                                  size: 30,
                                ),
                          !doesIOS
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/ios.png',
                                  color: Colors.white,
                                  height: 30,
                                ),
                          !doesSwitch
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/nintendo-switch.png',
                                  color: Colors.white,
                                  height: 30,
                                ),
                          !doesWeb
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/images/web.png',
                                  color: Colors.white,
                                  height: 30,
                                ),
                        ].where((widget) => widget != null).toList(),
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
