import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_bloc.dart';
import 'package:ps5_games_browser_app/screens/games_list_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (_) => GamesListBloc(),
        child: GameListScreen(),
      ),
    ),
  );
}
