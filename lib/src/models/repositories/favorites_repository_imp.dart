import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick/src/models/dtos/character_dto.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/favorites_repository.dart';

class FavoritesRepositoryImp implements FavoritesRepository {
  final Box<CharacterDto> box;
  FavoritesRepositoryImp({required this.box});

  @override
  Future<List<Character>> getFavorites() async {
    return box.values.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> addFavorite({required Character character}) async {
    final dto = CharacterDto.fromEntity(character);
    await box.put(character.id, dto);
  }

  @override
  Future<void> removeFavorite({required Character character}) async {
    await box.delete(character.id);
  }

  @override
  Future<void> clearFavorites() async {
    await box.clear();
  }
}
