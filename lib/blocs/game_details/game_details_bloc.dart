import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_events.dart';
import 'package:ps5_games_browser_app/blocs/game_details/game_details_states.dart';
import 'package:ps5_games_browser_app/models/game_details_model.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  GameDetailsBloc() : super(GameDetailsInitial()) {
    on<LoadGameDetailsEvent>((event, emit) {
      emit(GameDetailsLoading());
      try {
        GameDetails loadedGameDetails = GameDetails(
            description:
                "Below Zero is an underwater adventure game set on an alien ocean world. It is a new chapter in the Subnautica universe, and is currently in development by Unknown Worlds.Watch out!<br />\nBelow Zero is not finished! It is in active development: Full of bugs, missing features, and performance issues. If you would like to play Below Zero when it is finished, follow our development progress. We&#39;ll keep you informed as updates improve the game.Return to planet 4546B<br />\nDive into a freezing underwater adventure. Below Zero is set in an arctic region of planet 4546B. As a scientist posted to a research station on the planet&#39;s surface, you are tasked with studying alien artefacts...<br />\nThe Vesper space station orbits high above you, sending supplies, instructions, and receiving samples you launch from the surface.When disaster strikes the research station, you must improvise to survive: Construct habitats, scavenge for resources, hunt for food, and craft equipment.Explore new biomes<br />\nSwim beneath the blue-lit, arching growth of Twisty Bridges. Navigate treacherous ice floes on the ocean surface. Clamber up snow covered peaks, and venture into icy caves. Maneuver between steaming Thermal Vents. Below Zero presents entirely new environments for you to survive, study, and explore.<br />\nDiscover new lifeforms in the icy depths of 4546B. Swim through the giant Titan Holefish, escape from the aggressive Brute Shark, and visit the adorable Pengwings. Some residents of the frozen ocean will help you, and some might try to harm you.An ocean of intrigue<br />\nWho were the aliens who came here before? Why were they on this planet? Can you trust your commanders? Below Zero extends the story of the Subnautica universe, diving deep into the mystery introduced in the original game. Open up new story elements with every Early Access update.About the development team<br />\nBelow Zero is being created by Unknown Worlds, a small studio that traces its roots back to the 2002 Half-Life mod Natural Selection. It is the same team that created the original Subnautica. The team is scattered around the globe, from the United States to the United Kingdom, France, Russia, Austria, Australia, Germany, New Zealand, Taiwan, and many more places.",
            otherPlatform: "Xbox Series S/X",
            genres: "Adventure",
            developers: "Unknown Worlds Entertainment",
            publishers: "Unknown Worlds Entertainment",
            screenshots:
                "https://media.rawg.io/media/screenshots/848/848253347dc93c762bfd51c7e4989b8f.jpg");
        emit(GameDetailsLoaded(loadedGameDetails));
      } catch (e) {
        emit(GameDetailsErrorState('Failed to fetch games list: $e'));
      }
    });
  }
}
