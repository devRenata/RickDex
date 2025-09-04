import 'package:go_router/go_router.dart';
import 'package:rick/src/ui/pages/characters_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'characters',
      builder: (context, state) => const CharactersPage(),
    )
  ],
);