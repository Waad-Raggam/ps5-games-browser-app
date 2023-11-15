import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_states.dart';

class GameDetailsScreen extends StatelessWidget {
  final String name;

  const GameDetailsScreen({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocProvider(
        create: (_) => GameDetailsBloc(),
        child: BlocBuilder<GameDetailsBloc, GameDetailsState>(
          builder: (context, state) {
            if (state is GameDetailsInitial) {
              BlocProvider.of<GameDetailsBloc>(context)
                  .add(LoadGameDetailsEvent());
            }
            if (state is GameDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameDetailsLoaded) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final comment = state.gameInfo;
                  return ListTile(
                    title: Text(comment.description),
                    subtitle: Text(comment.developers),
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
