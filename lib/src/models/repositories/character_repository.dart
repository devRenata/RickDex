import 'package:rick/src/data/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({required int page});
}