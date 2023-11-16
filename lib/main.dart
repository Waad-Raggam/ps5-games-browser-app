import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_events.dart';
import 'package:ps5_games_browser_app/screens/games_list_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GameDetailsBloc>(
          create: (_) => GameDetailsBloc()..add(LoadGameDetailsEvent(0)),
        ),
        BlocProvider<GamesListBloc>(
          create: (_) => GamesListBloc()..add(LoadGameListEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MultiblocProvider',
      home: GameListScreen(),
    );
  }
}
