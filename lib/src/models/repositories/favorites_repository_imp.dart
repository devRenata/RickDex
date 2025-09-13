import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/models/dtos/character_dto.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/favorites_repository.dart';

class FavoritesRepositoryImp implements FavoritesRepository {
  final Box<CharacterDto> box;
  FavoritesRepositoryImp({required this.box});

  @override
  Future<List<Character>> getFavorites() async {
    try {
      return box.values.map((dto) => dto.toEntity()).toList();
    } on HiveError catch (e) {
      throw DataParsingException(originalException: e.toString());
    } catch (e) {
      throw UnknownException(originalException: e.toString());
    }
  }

  @override
  Future<void> addFavorite({required Character character}) async {
    try {
      if (box.containsKey(character.id)) return;

      final dto = CharacterDto.fromEntity(character);
      await box.put(character.id, dto);
    } on HiveError catch (e) {
      throw DataParsingException(originalException: e.toString());
    } catch (e) {
      throw UnknownException(originalException: e.toString());
    }
  }

  @override
  Future<void> removeFavorite({required Character character}) async {
    try {
      if (!box.containsKey(character.id)) return;
      await box.delete(character.id);
    } on HiveError catch (e) {
      throw DataParsingException(originalException: e.toString());
    } catch (e) {
      throw UnknownException(originalException: e.toString());
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      await box.clear();
    } on HiveError catch (e) {
      throw DataParsingException(originalException: e.toString());
    } catch (e) {
      throw UnknownException(originalException: e.toString());
    }
  }
}
