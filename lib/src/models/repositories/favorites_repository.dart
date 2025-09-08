import 'package:rick/src/models/entities/character.dart';

abstract class FavoritesRepository {
  Future<List<Character>> getFavorites();
  Future<void> addFavorite({required Character character});
  Future<void> removeFavorite({required Character character});
  Future<void> clearFavorites();
}