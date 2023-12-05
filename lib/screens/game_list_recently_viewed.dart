import 'package:flutter/material.dart';
import 'package:ps5_games_browser_app/models/game_list_model.dart';
import 'package:ps5_games_browser_app/screens/game_details_screen.dart';
import 'package:ps5_games_browser_app/utils/local_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GameListHistoryScreen extends StatefulWidget {
  final List<int> gameIds;

  const GameListHistoryScreen(this.gameIds, {super.key});

  @override
  State<GameListHistoryScreen> createState() => _GameListHistoryScreenState();
}

class _GameListHistoryScreenState extends State<GameListHistoryScreen> {
  List<int> numbers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Viewed'),
        backgroundColor: const Color(0xFF332F43),
      ),
      body: FutureBuilder<List<int>>(
          future: LocalStorageUtil.getRecentlyViewed(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No recently viewed games.'));
            } else {
              // Display the recently viewed games
              return ListView.builder(
                itemCount: widget.gameIds.length,
                itemBuilder: (context, index) {
                  final recentlyViewedGameId = snapshot.data![index];
                  final game = widget.gameIds[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image.network(
                        //   game.backgroundImage,
                        //   width: double.infinity,
                        //   height: 250.0,
                        //   fit: BoxFit.cover,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                // game.name,
                                widget.gameIds[index].toString(),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Row(
                              //   children: [
                              //     Text(
                              //       game.releaseDate,
                              //       style: const TextStyle(fontSize: 16.0),
                              //     ),
                              //     const Spacer(),
                              //     Chip(
                              //       backgroundColor:
                              //           backgroundColor(game.metacriticScore),
                              //       label: Text(
                              //         game.metacriticScore.toString(),
                              //         style: const TextStyle(
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.w300,
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => GameDetailsScreen(
                                    //       name: game.name,
                                    //       selectedGameId: game.id,
                                    //     ),
                                    //   ),
                                    // );
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
            }
          }
          // child: ListView.builder(
          //   itemCount: widget.gameIds.length,
          //   itemBuilder: (context, index) {
          //      final recentlyViewedGameId = snapshot.data[index];
          //     final game = widget.gameIds[index];
          //     return Card(
          //       elevation: 4.0,
          //       margin: const EdgeInsets.all(16.0),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           // Image.network(
          //           //   game.backgroundImage,
          //           //   width: double.infinity,
          //           //   height: 250.0,
          //           //   fit: BoxFit.cover,
          //           // ),
          //           Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text(
          //                   // game.name,
          //                   widget.gameIds[index],
          //                   style: const TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 8.0),
          //                 // Row(
          //                 //   children: [
          //                 //     Text(
          //                 //       game.releaseDate,
          //                 //       style: const TextStyle(fontSize: 16.0),
          //                 //     ),
          //                 //     const Spacer(),
          //                 //     Chip(
          //                 //       backgroundColor:
          //                 //           backgroundColor(game.metacriticScore),
          //                 //       label: Text(
          //                 //         game.metacriticScore.toString(),
          //                 //         style: const TextStyle(
          //                 //           color: Colors.black,
          //                 //           fontWeight: FontWeight.w300,
          //                 //         ),
          //                 //       ),
          //                 //     )
          //                 //   ],
          //                 // ),
          //                 SizedBox(
          //                   width: double.infinity,
          //                   child: ElevatedButton(
          //                     onPressed: () async {
          //                       // Navigator.push(
          //                       //   context,
          //                       //   MaterialPageRoute(
          //                       //     builder: (context) => GameDetailsScreen(
          //                       //       name: game.name,
          //                       //       selectedGameId: game.id,
          //                       //     ),
          //                       //   ),
          //                       // );
          //                     },
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor: Colors.white,
          //                       side: const BorderSide(
          //                         color: Color(0xFF343540),
          //                       ),
          //                     ),
          //                     child: const Text(
          //                       'More details',
          //                       style: TextStyle(color: Colors.black),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          ),
    );
  }
}
