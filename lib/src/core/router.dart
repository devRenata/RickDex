import 'package:go_router/go_router.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/ui/pages/character_details_page.dart';
import 'package:rick/src/ui/pages/characters_page.dart';
import 'package:rick/src/ui/pages/favorites_page.dart';

final router = GoRouter(
  initialLocation: '/characters',
  routes: [
    GoRoute(
      path: '/characters',
      name: 'characters',
      builder: (context, state) => const CharactersPage(),
    ),
    GoRoute(
      path: '/character_details',
      name: 'character_details',
      builder: (context, state) {
        final character = state.extra as Character;
        return CharacterDetailsPage(character: character);
      },
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);
