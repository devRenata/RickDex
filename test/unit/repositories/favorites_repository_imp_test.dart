import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick/src/models/dtos/character_dto.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/favorites_repository.dart';
import 'package:rick/src/models/repositories/favorites_repository_imp.dart';

class BoxMock extends Mock implements Box<CharacterDto> {}

void main() {
  late FavoritesRepository repository;
  late BoxMock box;

  final character = Character(
    id: 1,
    name: 'Rick',
    status: CharacterStatus.alive,
    species: 'Human',
    type: "Human",
    gender: "Male",
    origin: "Earth",
    location: "Citadel Of Ricks",
    image: "",
    created: DateTime.now(),
  );

  final dto = CharacterDto.fromEntity(character);

  setUpAll(() {
    registerFallbackValue(dto);
  });

  setUp(() {
    box = BoxMock();
    repository = FavoritesRepositoryImp(box: box);
  });

  group("Favorites Repository | ", () {
    test("Deve salvar um personagem favorito", () async {
      when(() => box.put(character.id, any())).thenAnswer((_) async {});

      await repository.addFavorite(character: character);

      verify(() => box.put(character.id, any(that: isA<CharacterDto>()))).called(1);
    });

    test("Deve remover um personagem favorito", () async {
      when(() => box.delete(character.id)).thenAnswer((_) async {});

      await repository.removeFavorite(character: character);

      verify(() => box.delete(character.id)).called(1);
    });

    test("Deve retornar uma lista de personagens favoritos", () async {
      when(() => box.values).thenReturn([dto]);

      final result = await repository.getFavorites();

      expect(result.first.id, character.id);
      verify(() => box.values).called(1);
    });

    test("Deve limpar a Box", () async {
      when(() => box.clear()).thenAnswer((_) async => 0);

      await repository.clearFavorites();

      verify(() => box.clear()).called(1);
    });
  });
}
