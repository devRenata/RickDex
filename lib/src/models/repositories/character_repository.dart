import 'package:rick/src/models/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({required int page});
}